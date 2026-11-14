package com.carrental.service;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.model.Booking;
import com.carrental.model.Car;

import java.util.List;
import java.util.Set;

/**
 * Service managing car inventory, searches, filters, availability and catalog updates.
 */
public class CarService {

    private final CarDAO carDAO;
    private final BookingDAO bookingDAO;

    public CarService() {
        this.carDAO = new CarDAO();
        this.bookingDAO = new BookingDAO();
    }

    public CarService(CarDAO carDAO, BookingDAO bookingDAO) {
        this.carDAO = carDAO;
        this.bookingDAO = bookingDAO;
    }

    public List<Car> getAllCars() {
        return carDAO.getAllCars();
    }

    public List<Car> getAvailableCars() {
        return carDAO.getAvailableCars();
    }

    public Car getCarById(String id) {
        return carDAO.getCarById(id);
    }

    public List<Car> searchCars(String keyword, String category, Double maxPrice, String transmission, String fuelType) {
        return carDAO.searchCars(keyword, category, maxPrice, transmission, fuelType);
    }

    public boolean addCar(Car car) throws IllegalArgumentException {
        validateCar(car);
        return carDAO.addCar(car);
    }

    public boolean updateCar(Car car) throws IllegalArgumentException {
        validateCar(car);
        return carDAO.updateCar(car);
    }

    /**
     * Deletes a car only if it does not have active bookings.
     */
    public boolean deleteCar(String carId) throws IllegalStateException {
        if (carId == null) return false;
        // Verify no active bookings exist
        for (Booking b : bookingDAO.getAllBookings()) {
            if (carId.equalsIgnoreCase(b.getCarId())) {
                if (Booking.STATUS_PENDING.equalsIgnoreCase(b.getStatus()) ||
                    Booking.STATUS_APPROVED.equalsIgnoreCase(b.getStatus())) {
                    throw new IllegalStateException("Cannot delete vehicle with active or upcoming bookings. Cancel or complete the bookings first.");
                }
            }
        }
        return carDAO.deleteCar(carId);
    }

    public boolean updateStatus(String carId, String status) {
        return carDAO.updateCarStatus(carId, status);
    }

    public Set<String> getCategories() {
        return carDAO.getCategories();
    }

    public Set<String> getBrands() {
        return carDAO.getBrands();
    }

    private void validateCar(Car car) throws IllegalArgumentException {
        if (car == null) throw new IllegalArgumentException("Car details cannot be empty.");
        if (car.getBrand() == null || car.getBrand().trim().isEmpty()) {
            throw new IllegalArgumentException("Brand is required.");
        }
        if (car.getModel() == null || car.getModel().trim().isEmpty()) {
            throw new IllegalArgumentException("Model name is required.");
        }
        if (car.getPricePerDay() <= 0) {
            throw new IllegalArgumentException("Daily rental rate must be greater than zero.");
        }
        if (car.getYear() < 1990 || car.getYear() > 2030) {
            throw new IllegalArgumentException("Valid model year is required.");
        }
        if (car.getSeats() <= 0) {
            throw new IllegalArgumentException("Car must have at least 1 seat.");
        }
    }
}

