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
import java.util.Set;

/**
 * Controller handling the homepage, showcasing featured cars,
 * quick search widget, and service highlights.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private final CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Car> availableCars = carService.getAvailableCars();
        // Featured cars (top 6)
        List<Car> featuredCars = availableCars.subList(0, Math.min(6, availableCars.size()));

        Set<String> categories = carService.getCategories();
        Set<String> brands = carService.getBrands();

        request.setAttribute("featuredCars", featuredCars);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("totalCarsCount", carService.getAllCars().size());

        request.getRequestDispatcher("/WEB-INF/views/customer/index.jsp").forward(request, response);
    }
}

