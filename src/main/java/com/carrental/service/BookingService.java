package com.carrental.service;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.dao.UserDAO;
import com.carrental.model.Booking;
import com.carrental.model.Car;
import com.carrental.model.User;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service orchestrating car reservations, schedule conflicts, pricing,
 * and reservation lifecycles.
 */
public class BookingService {

    private final BookingDAO bookingDAO;
    private final CarDAO carDAO;
    private final UserDAO userDAO;

    public BookingService() {
        this.bookingDAO = new BookingDAO();
        this.carDAO = new CarDAO();
        this.userDAO = new UserDAO();
    }

    public BookingService(BookingDAO bookingDAO, CarDAO carDAO, UserDAO userDAO) {
        this.bookingDAO = bookingDAO;
        this.carDAO = carDAO;
        this.userDAO = userDAO;
    }

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    public List<Booking> getUserBookings(String userId) {
        return bookingDAO.getBookingsByUserId(userId);
    }

    public Booking getBookingById(String id) {
        return bookingDAO.getBookingById(id);
    }

    /**
     * Creates a new booking after strictly validating date logic,
     * car availability, and conflict overlaps.
     */
    public Booking createBooking(String userId, String carId, String pickupDateStr, String returnDateStr,
                                 String pickupLocation, String returnLocation, String specialRequests) throws Exception {

        if (userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("User must be logged in to book a vehicle.");
        }
        User user = userDAO.getUserById(userId);
        if (user == null) {
            throw new IllegalArgumentException("Invalid user account.");
        }

        if (carId == null || carId.trim().isEmpty()) {
            throw new IllegalArgumentException("Selected vehicle is not found.");
        }
        Car car = carDAO.getCarById(carId);
        if (car == null) {
            throw new IllegalArgumentException("Vehicle does not exist.");
        }

        if (!Car.STATUS_AVAILABLE.equalsIgnoreCase(car.getStatus())) {
            throw new IllegalStateException("Selected car is currently marked as " + car.getStatus() + " and unavailable for booking.");
        }

        // Validate Dates
        if (pickupDateStr == null || pickupDateStr.trim().isEmpty() ||
            returnDateStr == null || returnDateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Please select valid pickup and return dates.");
        }

        LocalDate pickupDate = LocalDate.parse(pickupDateStr.trim());
        LocalDate returnDate = LocalDate.parse(returnDateStr.trim());
        LocalDate today = LocalDate.now();

        if (pickupDate.isBefore(today)) {
            throw new IllegalArgumentException("Pickup date cannot be in the past.");
        }
        if (returnDate.isBefore(pickupDate)) {
            throw new IllegalArgumentException("Return date cannot be earlier than pickup date.");
        }

        // Check for date collision / overlapping booking
        boolean available = bookingDAO.isCarAvailableForDates(carId, pickupDateStr.trim(), returnDateStr.trim(), null);
        if (!available) {
            throw new IllegalStateException("Vehicle is already booked for the selected date range. Please select different dates or another vehicle.");
        }

        // Calculate rental days (minimum 1 day)
        long days = ChronoUnit.DAYS.between(pickupDate, returnDate);
        int totalDays = (int) (days == 0 ? 1 : days);

        double totalPrice = totalDays * car.getPricePerDay();

        Booking booking = new Booking();
        booking.setUserId(user.getId());
        booking.setUserFullName(user.getName());
        booking.setUserEmail(user.getEmail());
        booking.setCarId(car.getId());
        booking.setCarTitle(car.getFullName());
        booking.setCarImageUrl(car.getImageUrl());
        booking.setPickupDate(pickupDateStr.trim());
        booking.setReturnDate(returnDateStr.trim());
        booking.setPickupLocation((pickupLocation != null && !pickupLocation.trim().isEmpty()) ? pickupLocation.trim() : "Main Office");
        booking.setReturnLocation((returnLocation != null && !returnLocation.trim().isEmpty()) ? returnLocation.trim() : "Main Office");
        booking.setTotalDays(totalDays);
        booking.setPricePerDay(car.getPricePerDay());
        booking.setTotalPrice(totalPrice);
        booking.setSpecialRequests(specialRequests != null ? specialRequests.trim() : "");
        booking.setStatus(Booking.STATUS_PENDING);

        boolean saved = bookingDAO.addBooking(booking);
        if (!saved) {
            throw new RuntimeException("Failed to persist booking record. Please try again.");
        }

        return booking;
    }

    public boolean approveBooking(String bookingId) {
        return bookingDAO.updateBookingStatus(bookingId, Booking.STATUS_APPROVED);
    }

    public boolean rejectBooking(String bookingId) {
        return bookingDAO.updateBookingStatus(bookingId, Booking.STATUS_REJECTED);
    }

    public boolean cancelBooking(String bookingId, String userId, boolean isAdmin) {
        return bookingDAO.cancelBooking(bookingId, userId, isAdmin);
    }

    public boolean completeBooking(String bookingId) {
        return bookingDAO.updateBookingStatus(bookingId, Booking.STATUS_COMPLETED);
    }

    /**
     * Aggregates key business statistics for the admin overview dashboard.
     */
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        List<Car> allCars = carDAO.getAllCars();
        List<User> customers = userDAO.getAllCustomers();
        List<Booking> allBookings = bookingDAO.getAllBookings();

        int availableCarsCount = 0;
        for (Car c : allCars) {
            if (c.isAvailable()) availableCarsCount++;
        }

        stats.put("totalCars", allCars.size());
        stats.put("availableCars", availableCarsCount);
        stats.put("totalCustomers", customers.size());
        stats.put("totalBookings", allBookings.size());
        stats.put("activeBookings", bookingDAO.getActiveBookingsCount());
        stats.put("totalRevenue", bookingDAO.getTotalRevenue());
        stats.put("statusCounts", bookingDAO.getBookingStatusCounts());
        stats.put("recentBookings", allBookings.subList(0, Math.min(5, allBookings.size())));

        return stats;
    }
}

