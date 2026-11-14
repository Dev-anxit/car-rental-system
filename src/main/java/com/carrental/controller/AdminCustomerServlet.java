package com.carrental.controller;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.UserDAO;
import com.carrental.model.Booking;
import com.carrental.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller for Administrative Customer Directory and Rental Profiles.
 */
@WebServlet(name = "AdminCustomerServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomerServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> customers = userDAO.getAllCustomers();
        List<Booking> allBookings = bookingDAO.getAllBookings();

        // Compute metrics per customer
        Map<String, Integer> customerBookingCounts = new HashMap<>();
        Map<String, Double> customerTotalSpent = new HashMap<>();

        for (Booking b : allBookings) {
            String uid = b.getUserId();
            customerBookingCounts.put(uid, customerBookingCounts.getOrDefault(uid, 0) + 1);
            if (Booking.STATUS_APPROVED.equalsIgnoreCase(b.getStatus()) ||
                Booking.STATUS_COMPLETED.equalsIgnoreCase(b.getStatus())) {
                customerTotalSpent.put(uid, customerTotalSpent.getOrDefault(uid, 0.0) + b.getTotalPrice());
            }
        }

        request.setAttribute("customers", customers);
        request.setAttribute("bookingCounts", customerBookingCounts);
        request.setAttribute("totalSpent", customerTotalSpent);

        request.getRequestDispatcher("/WEB-INF/views/admin/customers-manage.jsp").forward(request, response);
    }
}

