package com.carrental.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controller serving informational pages like About Us and Contact.
 */
@WebServlet(name = "StaticPageServlet", urlPatterns = {"/about", "/contact"})
public class StaticPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        if ("/about".equalsIgnoreCase(path)) {
            request.getRequestDispatcher("/WEB-INF/views/customer/about.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/customer/contact.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        if ("/contact".equalsIgnoreCase(path)) {
            String name = request.getParameter("name");
            request.getSession().setAttribute("flashSuccess", "Thank you " + (name != null ? name : "") + "! Your message has been received. Our team will contact you shortly.");
            response.sendRedirect(request.getContextPath() + "/contact");
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}

