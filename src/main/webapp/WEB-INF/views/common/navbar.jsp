<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar">
    <div class="container nav-container">
        <a href="${pageContext.request.contextPath}/home" class="brand-logo">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/>
                <circle cx="7" cy="17" r="2"/>
                <path d="M9 17h6"/>
                <circle cx="17" cy="17" r="2"/>
            </svg>
            <span>APEX</span>DRIVE
        </a>

        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/cars">Fleet / Cars</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <c:if test="${not empty sessionScope.currentUser}">
                <li><a href="${pageContext.request.contextPath}/my-bookings">My Bookings</a></li>
                <c:if test="${sessionScope.currentUser.admin}">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" style="color: var(--primary); font-weight: 700;">★ Admin Portal</a></li>
                </c:if>
            </c:if>
        </ul>

        <div class="nav-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="user-badge">
                        <span style="color: var(--primary); font-weight: 600;">${sessionScope.currentUser.name}</span>
                        <c:if test="${sessionScope.currentUser.admin}">
                            <span class="badge badge-approved" style="font-size: 0.65rem; padding: 2px 6px;">ADMIN</span>
                        </c:if>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary btn-sm">Sign In</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">Register</a>
                </c:otherwise>
            </c:choose>

            <button class="mobile-toggle" aria-label="Toggle navigation">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="3" y1="12" x2="21" y2="12"></line>
                    <line x1="3" y1="6" x2="21" y2="6"></line>
                    <line x1="3" y1="18" x2="21" y2="18"></line>
                </svg>
            </button>
        </div>
    </div>
</nav>

