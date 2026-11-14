package com.carrental.model;

import java.io.Serializable;

/**
 * Model representing a Rental Car in the fleet.
 */
public class Car implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String STATUS_AVAILABLE = "AVAILABLE";
    public static final String STATUS_MAINTENANCE = "MAINTENANCE";
    public static final String STATUS_RENTED = "RENTED";

    private String id;
    private String brand;
    private String model;
    private String category;
    private int year;
    private double pricePerDay;
    private int seats;
    private String fuelType;
    private String transmission;
    private String imageUrl;
    private String description;
    private String features;
    private String status;

    public Car() {
        this.status = STATUS_AVAILABLE;
    }

    public Car(String id, String brand, String model, String category, int year, double pricePerDay,
               int seats, String fuelType, String transmission, String imageUrl,
               String description, String features, String status) {
        this.id = id;
        this.brand = brand;
        this.model = model;
        this.category = category;
        this.year = year;
        this.pricePerDay = pricePerDay;
        this.seats = seats;
        this.fuelType = fuelType;
        this.transmission = transmission;
        this.imageUrl = imageUrl;
        this.description = description;
        this.features = features;
        this.status = status != null ? status : STATUS_AVAILABLE;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFullName() {
        return brand + " " + model + " (" + year + ")";
    }

    public boolean isAvailable() {
        return STATUS_AVAILABLE.equalsIgnoreCase(this.status);
    }

    @Override
    public String toString() {
        return "Car{" +
                "id='" + id + '\'' +
                ", brand='" + brand + '\'' +
                ", model='" + model + '\'' +
                ", pricePerDay=" + pricePerDay +
                ", status='" + status + '\'' +
                '}';
    }
}

