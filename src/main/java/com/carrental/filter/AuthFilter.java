package com.carrental.filter;

import com.carrental.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter providing session-based authentication and role-based access control (RBAC).
 * Ensures customers cannot access admin operations and guests are redirected to login.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*", "/book", "/my-bookings", "/cancel-booking", "/booking-details"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        String path = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = path.substring(contextPath.length());

        // Check Admin Paths
        if (relativePath.startsWith("/admin")) {
            if (currentUser == null) {
                // Not logged in -> Redirect to login
                session = httpRequest.getSession(true);
                session.setAttribute("flashError", "Please sign in with administrator credentials to access the admin portal.");
                httpResponse.sendRedirect(contextPath + "/login?redirect=" + relativePath);
                return;
            } else if (!currentUser.isAdmin()) {
                // Logged in as regular customer -> 403 Access Denied
                session.setAttribute("flashError", "Access Denied: You do not have administrator permissions.");
                httpResponse.sendRedirect(contextPath + "/");
                return;
            }
        }

        // Check Customer Protected Paths
        if (relativePath.startsWith("/book") ||
            relativePath.startsWith("/my-bookings") ||
            relativePath.startsWith("/cancel-booking") ||
            relativePath.startsWith("/booking-details")) {

            if (currentUser == null) {
                session = httpRequest.getSession(true);
                session.setAttribute("flashInfo", "Please log in or create an account to proceed with your booking.");
                httpResponse.sendRedirect(contextPath + "/login?redirect=" + relativePath +
                        (httpRequest.getQueryString() != null ? "?" + httpRequest.getQueryString() : ""));
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}

