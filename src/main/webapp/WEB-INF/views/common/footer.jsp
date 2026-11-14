<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-brand">
                <div class="brand-logo" style="margin-bottom: 12px;">
                    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                        <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/>
                        <circle cx="7" cy="17" r="2"/>
                        <path d="M9 17h6"/>
                        <circle cx="17" cy="17" r="2"/>
                    </svg>
                    <span>APEX</span>DRIVE
                </div>
                <p>The premier luxury and performance car rental platform. Experience unmatched automotive engineering with effortless online reservations.</p>
            </div>

            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/cars">Browse Fleet</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact & Locations</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Customer Service</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/my-bookings">Manage Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/login">Account Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">Create Account</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Support Desk</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Fleet Headquarters</h4>
                <p style="color: var(--text-secondary); font-size: 0.9rem; line-height: 1.7; margin-bottom: 12px;">
                    100 Auto Boulevard, Suite 500<br>
                    New York, NY 10001<br>
                    <strong>Phone:</strong> +1 (800) 555-APEX<br>
                    <strong>Email:</strong> support@apexdrive.com
                </p>
            </div>
        </div>

        <div class="footer-bottom">
            <div>&copy; 2024-2026 Apex Drive Car Rental Management System. All rights reserved.</div>
            <div style="color: var(--text-muted); font-size: 0.8rem;">
                Built with Java Servlets, JSP & XML DOM Storage &bull; MVC Architecture
            </div>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

