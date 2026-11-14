package com.carrental.model;

import java.io.Serializable;

/**
 * Model representing a Customer's Car Rental Booking.
 */
public class Booking implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String STATUS_PENDING = "PENDING";
    public static final String STATUS_APPROVED = "APPROVED";
    public static final String STATUS_REJECTED = "REJECTED";
    public static final String STATUS_CANCELLED = "CANCELLED";
    public static final String STATUS_COMPLETED = "COMPLETED";

    private String id;
    private String bookingReference;
    private String userId;
    private String carId;
    private String userFullName;
    private String userEmail;
    private String carTitle;
    private String carImageUrl;
    private String pickupDate;
    private String returnDate;
    private String pickupLocation;
    private String returnLocation;
    private int totalDays;
    private double pricePerDay;
    private double totalPrice;
    private String status;
    private String bookingDate;
    private String specialRequests;

    public Booking() {
        this.status = STATUS_PENDING;
    }

    public Booking(String id, String bookingReference, String userId, String carId,
                   String userFullName, String userEmail, String carTitle, String carImageUrl,
                   String pickupDate, String returnDate, String pickupLocation, String returnLocation,
                   int totalDays, double pricePerDay, double totalPrice, String status,
                   String bookingDate, String specialRequests) {
        this.id = id;
        this.bookingReference = bookingReference;
        this.userId = userId;
        this.carId = carId;
        this.userFullName = userFullName;
        this.userEmail = userEmail;
        this.carTitle = carTitle;
        this.carImageUrl = carImageUrl;
        this.pickupDate = pickupDate;
        this.returnDate = returnDate;
        this.pickupLocation = pickupLocation;
        this.returnLocation = returnLocation;
        this.totalDays = totalDays;
        this.pricePerDay = pricePerDay;
        this.totalPrice = totalPrice;
        this.status = status != null ? status : STATUS_PENDING;
        this.bookingDate = bookingDate;
        this.specialRequests = specialRequests;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBookingReference() {
        return bookingReference;
    }

    public void setBookingReference(String bookingReference) {
        this.bookingReference = bookingReference;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getCarTitle() {
        return carTitle;
    }

    public void setCarTitle(String carTitle) {
        this.carTitle = carTitle;
    }

    public String getCarImageUrl() {
        return carImageUrl;
    }

    public void setCarImageUrl(String carImageUrl) {
        this.carImageUrl = carImageUrl;
    }

    public String getPickupDate() {
        return pickupDate;
    }

    public void setPickupDate(String pickupDate) {
        this.pickupDate = pickupDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getReturnLocation() {
        return returnLocation;
    }

    public void setReturnLocation(String returnLocation) {
        this.returnLocation = returnLocation;
    }

    public int getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public boolean canBeCancelled() {
        return STATUS_PENDING.equalsIgnoreCase(this.status) || STATUS_APPROVED.equalsIgnoreCase(this.status);
    }

    @Override
    public String toString() {
        return "Booking{" +
                "id='" + id + '\'' +
                ", bookingReference='" + bookingReference + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", carTitle='" + carTitle + '\'' +
                ", totalPrice=" + totalPrice +
                ", status='" + status + '\'' +
                '}';
    }
}

