<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fleet Inventory Management | Apex Drive</title>
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                        Dashboard
                    </a>
                </li>
                <li class="admin-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/cars" class="active">
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

        <!-- Main Content Area -->
        <main class="admin-main">
            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <div class="admin-header">
                <div class="admin-header-title">
                    <h1>Fleet Inventory Management</h1>
                    <p>Add, update specifications, adjust pricing, or change car availability.</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/cars/new" class="btn btn-primary">
                        + Add New Vehicle
                    </a>
                </div>
            </div>

            <div class="table-card">
                <div class="table-header">
                    <div style="display: flex; align-items: center; gap: 16px;">
                        <span class="table-title">All Fleet Vehicles (${cars.size()})</span>
                    </div>
                    <div style="width: 280px;">
                        <input type="text" class="form-control" placeholder="Quick filter vehicles..." data-table-search="carsTable">
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="data-table" id="carsTable">
                        <thead>
                            <tr>
                                <th>Photo</th>
                                <th>Asset ID</th>
                                <th>Brand & Model</th>
                                <th>Category</th>
                                <th>Year</th>
                                <th>Rate / Day</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${cars}">
                                <tr>
                                    <td>
                                        <img src="${c.imageUrl}" alt="${c.fullName}" class="car-thumb">
                                    </td>
                                    <td><code>${c.id}</code></td>
                                    <td>
                                        <strong>${c.brand}</strong> ${c.model}
                                        <div style="font-size: 0.75rem; color: var(--text-muted);">${c.transmission} &bull; ${c.fuelType}</div>
                                    </td>
                                    <td><span class="car-badge-category" style="position: static;">${c.category}</span></td>
                                    <td>${c.year}</td>
                                    <td style="font-weight: 700; color: var(--primary);">$${c.pricePerDay}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.status eq 'AVAILABLE'}">
                                                <span class="badge badge-approved">Available</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-rejected">${c.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions-cell">
                                            <a href="${pageContext.request.contextPath}/admin/cars/edit?id=${c.id}" class="btn btn-secondary btn-sm" style="padding: 4px 8px;">
                                                Edit
                                            </a>

                                            <!-- Toggle Status Form -->
                                            <form action="${pageContext.request.contextPath}/admin/cars/toggle-status" method="POST" style="margin: 0;">
                                                <input type="hidden" name="id" value="${c.id}">
                                                <input type="hidden" name="status" value="${c.status eq 'AVAILABLE' ? 'MAINTENANCE' : 'AVAILABLE'}">
                                                <button type="submit" class="btn btn-secondary btn-sm" style="padding: 4px 8px;" title="Toggle Availability">
                                                    ${c.status eq 'AVAILABLE' ? 'Mark Maintenance' : 'Mark Available'}
                                                </button>
                                            </form>

                                            <!-- Delete Form with Confirmation -->
                                            <form action="${pageContext.request.contextPath}/admin/cars/delete" method="POST" style="margin: 0;" data-confirm="Are you sure you want to delete ${c.fullName} from the fleet inventory? This action cannot be undone.">
                                                <input type="hidden" name="id" value="${c.id}">
                                                <button type="submit" class="btn btn-danger btn-sm" style="padding: 4px 8px;">
                                                    Delete
                                                </button>
                                            </form>
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

    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>

