<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Dashboard | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="admin-layout">
        <!-- Sidebar Navigation -->
        <aside class="admin-sidebar">
            <ul class="admin-nav">
                <li class="admin-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                        Dashboard
                    </a>
                </li>
                <li class="admin-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/cars">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/><circle cx="7" cy="17" r="2"/><path d="M9 17h6"/><circle cx="17" cy="17" r="2"/></svg>
                        Fleet Management
                    </a>
                </li>
                <li class="admin-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/bookings">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                        Rental Bookings
                    </a>
                </li>
                <li class="admin-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/customers">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                        Customers
                    </a>
                </li>
                <li class="admin-nav-item" style="margin-top: 24px; padding-top: 16px; border-top: 1px solid var(--border-color);">
                    <a href="${pageContext.request.contextPath}/cars" target="_blank">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                        View Public Site &rarr;
                    </a>
                </li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="admin-main">
            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <div class="admin-header">
                <div class="admin-header-title">
                    <h1>Executive Command Center</h1>
                    <p>Real-time analytics, fleet status, and reservation lifecycle overview.</p>
                </div>
                <div style="display: flex; gap: 12px;">
                    <a href="${pageContext.request.contextPath}/admin/cars/new" class="btn btn-primary btn-sm">
                        + Add New Vehicle
                    </a>
                </div>
            </div>

            <!-- Stats KPI Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon stat-icon-gold">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/><circle cx="7" cy="17" r="2"/><path d="M9 17h6"/><circle cx="17" cy="17" r="2"/></svg>
                    </div>
                    <div class="stat-info">
                        <div class="stat-val">${stats.totalCars}</div>
                        <div class="stat-label">Total Fleet (${stats.availableCars} Available)</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon stat-icon-blue">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                    </div>
                    <div class="stat-info">
                        <div class="stat-val">${stats.totalCustomers}</div>
                        <div class="stat-label">Registered Customers</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon stat-icon-purple">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                    </div>
                    <div class="stat-info">
                        <div class="stat-val">${stats.activeBookings}</div>
                        <div class="stat-label">Active / Pending Bookings</div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon stat-icon-green">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                    </div>
                    <div class="stat-info">
                        <div class="stat-val">$${stats.totalRevenue}</div>
                        <div class="stat-label">Total Realized Revenue</div>
                    </div>
                </div>
            </div>

            <!-- Recent Bookings Table -->
            <div class="table-card">
                <div class="table-header">
                    <div class="table-title">Recent Reservations</div>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-secondary btn-sm">
                        View All Bookings &rarr;
                    </a>
                </div>

                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Reference</th>
                                <th>Vehicle</th>
                                <th>Customer</th>
                                <th>Schedule</th>
                                <th>Total ($)</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${stats.recentBookings}">
                                <tr>
                                    <td><strong>${b.bookingReference}</strong></td>
                                    <td>${b.carTitle}</td>
                                    <td>
                                        <div>${b.userFullName}</div>
                                        <div style="font-size: 0.75rem; color: var(--text-muted);">${b.userEmail}</div>
                                    </td>
                                    <td>${b.pickupDate} &rarr; ${b.returnDate}</td>
                                    <td style="font-weight: 700; color: var(--primary);">$${b.totalPrice}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status eq 'APPROVED'}"><span class="badge badge-approved">Approved</span></c:when>
                                            <c:when test="${b.status eq 'PENDING'}"><span class="badge badge-pending">Pending</span></c:when>
                                            <c:when test="${b.status eq 'REJECTED'}"><span class="badge badge-rejected">Rejected</span></c:when>
                                            <c:when test="${b.status eq 'CANCELLED'}"><span class="badge badge-cancelled">Cancelled</span></c:when>
                                            <c:otherwise><span class="badge badge-completed">${b.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <c:if test="${b.status eq 'PENDING'}">
                                                <form action="${pageContext.request.contextPath}/admin/bookings/action" method="POST" style="margin: 0;">
                                                    <input type="hidden" name="bookingId" value="${b.id}">
                                                    <input type="hidden" name="action" value="approve">
                                                    <button type="submit" class="btn btn-primary btn-sm" style="padding: 4px 10px;">Approve</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/bookings/action" method="POST" style="margin: 0;">
                                                    <input type="hidden" name="bookingId" value="${b.id}">
                                                    <input type="hidden" name="action" value="reject">
                                                    <button type="submit" class="btn btn-danger btn-sm" style="padding: 4px 10px;">Reject</button>
                                                </form>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/booking-details?id=${b.id}" class="btn btn-secondary btn-sm" style="padding: 4px 8px;">View</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

</body>
</html>

