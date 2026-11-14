package com.carrental.controller;

import com.carrental.model.Booking;
import com.carrental.service.BookingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for Administrative Booking Management:
 * Review, Approve, Reject, and Complete rental bookings.
 */
@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/admin/bookings", "/admin/bookings/action"})
public class AdminBookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filterStatus = request.getParameter("status");
        List<Booking> allBookings = bookingService.getAllBookings();
        List<Booking> filteredBookings;

        if (filterStatus != null && !filterStatus.trim().isEmpty() && !"ALL".equalsIgnoreCase(filterStatus)) {
            filteredBookings = new ArrayList<>();
            for (Booking b : allBookings) {
                if (filterStatus.equalsIgnoreCase(b.getStatus())) {
                    filteredBookings.add(b);
                }
            }
        } else {
            filteredBookings = allBookings;
            filterStatus = "ALL";
        }

        request.setAttribute("bookings", filteredBookings);
        request.setAttribute("activeFilter", filterStatus);
        request.setAttribute("statusCounts", bookingService.getDashboardStats().get("statusCounts"));

        request.getRequestDispatcher("/WEB-INF/views/admin/bookings-manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingId = request.getParameter("bookingId");
        String action = request.getParameter("action");

        if (bookingId != null && action != null) {
            boolean success = false;
            String message = "";

            switch (action.toLowerCase()) {
                case "approve":
                    success = bookingService.approveBooking(bookingId);
                    message = "Booking approved successfully.";
                    break;
                case "reject":
                    success = bookingService.rejectBooking(bookingId);
                    message = "Booking rejected.";
                    break;
                case "cancel":
                    success = bookingService.cancelBooking(bookingId, null, true);
                    message = "Booking cancelled by admin.";
                    break;
                case "complete":
                    success = bookingService.completeBooking(bookingId);
                    message = "Booking marked as completed.";
                    break;
                default:
                    message = "Unknown action.";
                    break;
            }

            if (success) {
                request.getSession().setAttribute("flashSuccess", message);
            } else {
                request.getSession().setAttribute("flashError", "Failed to update booking status.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }
}

