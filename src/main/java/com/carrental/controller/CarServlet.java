package com.carrental.controller;

import com.carrental.model.Car;
import com.carrental.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.Set;

/**
 * Controller handling public car browsing, search filters, and detail views.
 */
@WebServlet(name = "CarServlet", urlPatterns = {"/cars", "/car-details"})
public class CarServlet extends HttpServlet {

    private final CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/car-details".equalsIgnoreCase(path)) {
            handleCarDetails(request, response);
        } else {
            handleCarListing(request, response);
        }
    }

    private void handleCarListing(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String transmission = request.getParameter("transmission");
        String fuelType = request.getParameter("fuelType");
        String maxPriceStr = request.getParameter("maxPrice");
        String sort = request.getParameter("sort");

        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        List<Car> cars = carService.searchCars(keyword, category, maxPrice, transmission, fuelType);

        // Sorting
        if ("price_asc".equalsIgnoreCase(sort)) {
            cars.sort(Comparator.comparingDouble(Car::getPricePerDay));
        } else if ("price_desc".equalsIgnoreCase(sort)) {
            cars.sort((c1, c2) -> Double.compare(c2.getPricePerDay(), c1.getPricePerDay()));
        } else if ("year_desc".equalsIgnoreCase(sort)) {
            cars.sort((c1, c2) -> Integer.compare(c2.getYear(), c1.getYear()));
        }

        Set<String> categories = carService.getCategories();
        Set<String> brands = carService.getBrands();

        request.setAttribute("cars", cars);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("paramKeyword", keyword);
        request.setAttribute("paramCategory", category);
        request.setAttribute("paramTransmission", transmission);
        request.setAttribute("paramFuelType", fuelType);
        request.setAttribute("paramMaxPrice", maxPriceStr);
        request.setAttribute("paramSort", sort);

        request.getRequestDispatcher("/WEB-INF/views/customer/cars.jsp").forward(request, response);
    }

    private void handleCarDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String carId = request.getParameter("id");
        if (carId == null || carId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }

        Car car = carService.getCarById(carId.trim());
        if (car == null) {
            request.getSession().setAttribute("flashError", "The requested car was not found.");
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }

        request.setAttribute("car", car);
        // Also fetch similar cars in the same category
        List<Car> similarCars = carService.searchCars(null, car.getCategory(), null, null, null);
        similarCars.removeIf(c -> c.getId().equalsIgnoreCase(car.getId()));
        request.setAttribute("similarCars", similarCars.subList(0, Math.min(3, similarCars.size())));

        request.getRequestDispatcher("/WEB-INF/views/customer/car-details.jsp").forward(request, response);
    }
}

