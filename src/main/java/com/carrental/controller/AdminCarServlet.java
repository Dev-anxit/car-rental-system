package com.carrental.controller;

import com.carrental.model.Car;
import com.carrental.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Administrative Car Fleet Management:
 * List, Add, Edit, Delete, and Toggle Availability Status.
 */
@WebServlet(name = "AdminCarServlet", urlPatterns = {"/admin/cars", "/admin/cars/new", "/admin/cars/edit", "/admin/cars/save", "/admin/cars/delete", "/admin/cars/toggle-status"})
public class AdminCarServlet extends HttpServlet {

    private final CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/admin/cars/new":
                showNewCarForm(request, response);
                break;
            case "/admin/cars/edit":
                showEditCarForm(request, response);
                break;
            case "/admin/cars":
            default:
                listCars(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/admin/cars/save":
                handleSaveCar(request, response);
                break;
            case "/admin/cars/delete":
                handleDeleteCar(request, response);
                break;
            case "/admin/cars/toggle-status":
                handleToggleStatus(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/cars");
                break;
        }
    }

    private void listCars(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> cars = carService.getAllCars();
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/WEB-INF/views/admin/cars-manage.jsp").forward(request, response);
    }

    private void showNewCarForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("isEdit", false);
        request.setAttribute("car", new Car());
        request.getRequestDispatcher("/WEB-INF/views/admin/car-form.jsp").forward(request, response);
    }

    private void showEditCarForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/cars");
            return;
        }

        Car car = carService.getCarById(id.trim());
        if (car == null) {
            request.getSession().setAttribute("flashError", "Car not found.");
            response.sendRedirect(request.getContextPath() + "/admin/cars");
            return;
        }

        request.setAttribute("isEdit", true);
        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/views/admin/car-form.jsp").forward(request, response);
    }

    private void handleSaveCar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String id = request.getParameter("id");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String category = request.getParameter("category");
        String yearStr = request.getParameter("year");
        String priceStr = request.getParameter("pricePerDay");
        String seatsStr = request.getParameter("seats");
        String fuelType = request.getParameter("fuelType");
        String transmission = request.getParameter("transmission");
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String features = request.getParameter("features");
        String status = request.getParameter("status");

        try {
            int year = Integer.parseInt(yearStr.trim());
            double pricePerDay = Double.parseDouble(priceStr.trim());
            int seats = Integer.parseInt(seatsStr.trim());

            Car car = new Car(id, brand, model, category, year, pricePerDay, seats,
                    fuelType, transmission, imageUrl, description, features, status);

            boolean isEdit = (id != null && !id.trim().isEmpty());
            boolean success;

            if (isEdit) {
                success = carService.updateCar(car);
                if (success) {
                    request.getSession().setAttribute("flashSuccess", "Car updated successfully: " + car.getFullName());
                } else {
                    request.getSession().setAttribute("flashError", "Failed to update car details.");
                }
            } else {
                success = carService.addCar(car);
                if (success) {
                    request.getSession().setAttribute("flashSuccess", "New car added to inventory: " + car.getFullName());
                } else {
                    request.getSession().setAttribute("flashError", "Failed to add car to inventory.");
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/cars");

        } catch (Exception e) {
            request.getSession().setAttribute("flashError", "Error saving car: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/cars");
        }
    }

    private void handleDeleteCar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String id = request.getParameter("id");
        try {
            boolean deleted = carService.deleteCar(id);
            if (deleted) {
                request.getSession().setAttribute("flashSuccess", "Vehicle successfully removed from fleet.");
            } else {
                request.getSession().setAttribute("flashError", "Failed to delete vehicle.");
            }
        } catch (IllegalStateException e) {
            request.getSession().setAttribute("flashError", e.getMessage());
        } catch (Exception e) {
            request.getSession().setAttribute("flashError", "Unexpected error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/cars");
    }

    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            carService.updateStatus(id, status);
            request.getSession().setAttribute("flashSuccess", "Vehicle status updated to: " + status);
        }

        response.sendRedirect(request.getContextPath() + "/admin/cars");
    }
}

