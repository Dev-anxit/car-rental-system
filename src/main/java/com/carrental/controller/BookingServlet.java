package com.carrental.controller;

import com.carrental.model.Booking;
import com.carrental.model.Car;
import com.carrental.model.User;
import com.carrental.service.BookingService;
import com.carrental.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller managing customer vehicle reservations, date validation,
 * booking confirmations, cancellations, and user rental history.
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/book", "/my-bookings", "/cancel-booking", "/booking-details"})
public class BookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/book":
                handleBookPage(request, response);
                break;
            case "/my-bookings":
                handleMyBookings(request, response);
                break;
            case "/booking-details":
                handleBookingDetails(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cars");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/book":
                handleSubmitBooking(request, response);
                break;
            case "/cancel-booking":
                handleCancelBooking(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/cars");
                break;
        }
    }

    private void handleBookPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("carId");
        if (carId == null || carId.trim().isEmpty()) {
            request.getSession().setAttribute("flashError", "Please select a vehicle to book.");
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }

        Car car = carService.getCarById(carId.trim());
        if (car == null || !car.isAvailable()) {
            request.getSession().setAttribute("flashError", "The selected vehicle is currently not available for rental.");
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }

        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/views/customer/book.jsp").forward(request, response);
    }

    private void handleSubmitBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            session.setAttribute("flashError", "Please login to complete your booking.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String carId = request.getParameter("carId");
        String pickupDate = request.getParameter("pickupDate");
        String returnDate = request.getParameter("returnDate");
        String pickupLocation = request.getParameter("pickupLocation");
        String returnLocation = request.getParameter("returnLocation");
        String specialRequests = request.getParameter("specialRequests");

        try {
            Booking booking = bookingService.createBooking(
                    currentUser.getId(),
                    carId,
                    pickupDate,
                    returnDate,
                    pickupLocation,
                    returnLocation,
                    specialRequests
            );

            session.setAttribute("flashSuccess", "Congratulations! Your reservation request has been submitted successfully (Ref: " + booking.getBookingReference() + ").");
            response.sendRedirect(request.getContextPath() + "/booking-details?id=" + booking.getId());

        } catch (Exception e) {
            session.setAttribute("flashError", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/book?carId=" + carId +
                    "&pickupDate=" + (pickupDate != null ? pickupDate : "") +
                    "&returnDate=" + (returnDate != null ? returnDate : ""));
        }
    }

    private void handleMyBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        List<Booking> bookings = bookingService.getUserBookings(currentUser.getId());

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/customer/my-bookings.jsp").forward(request, response);
    }

    private void handleCancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        String bookingId = request.getParameter("bookingId");

        boolean success = bookingService.cancelBooking(bookingId, currentUser.getId(), currentUser.isAdmin());
        if (success) {
            request.getSession().setAttribute("flashSuccess", "Booking cancelled successfully.");
        } else {
            request.getSession().setAttribute("flashError", "Could not cancel booking. Only pending or approved bookings can be cancelled.");
        }

        response.sendRedirect(request.getContextPath() + "/my-bookings");
    }

    private void handleBookingDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        Booking booking = bookingService.getBookingById(id.trim());
        if (booking == null) {
            request.getSession().setAttribute("flashError", "Booking details not found.");
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        // Customer can only view their own booking unless they are admin
        if (!currentUser.isAdmin() && !currentUser.getId().equalsIgnoreCase(booking.getUserId())) {
            request.getSession().setAttribute("flashError", "Unauthorized access to booking record.");
            response.sendRedirect(request.getContextPath() + "/my-bookings");
            return;
        }

        Car car = carService.getCarById(booking.getCarId());
        request.setAttribute("booking", booking);
        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/views/customer/booking-confirmation.jsp").forward(request, response);
    }
}

