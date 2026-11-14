<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Vehicle' : 'Add New Vehicle'} | Apex Drive Admin</title>
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
            </ul>
        </aside>

        <!-- Main Content Area -->
        <main class="admin-main">
            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <div class="admin-header">
                <div class="admin-header-title">
                    <h1>${isEdit ? 'Update Vehicle Details' : 'Add New Vehicle to Fleet'}</h1>
                    <p>${isEdit ? 'Modify specifications and pricing for '.concat(car.fullName) : 'Provide technical specifications and pricing for the new vehicle asset.'}</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/cars" class="btn btn-secondary btn-sm">
                        &larr; Back to Fleet List
                    </a>
                </div>
            </div>

            <div class="admin-form-card">
                <form action="${pageContext.request.contextPath}/admin/cars/save" method="POST">
                    <input type="hidden" name="id" value="${car.id}">

                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="brand">Manufacturer / Brand *</label>
                            <input type="text" id="brand" name="brand" class="form-control" required value="${car.brand}" placeholder="e.g. Porsche, BMW, Mercedes-Benz">
                        </div>

                        <div class="form-group">
                            <label for="model">Model Name & Trim *</label>
                            <input type="text" id="model" name="model" class="form-control" required value="${car.model}" placeholder="e.g. 911 Carrera GTS, M4 Competition">
                        </div>
                    </div>

                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="category">Category *</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="Sedan" ${'Sedan' eq car.category ? 'selected' : ''}>Sedan</option>
                                <option value="SUV" ${'SUV' eq car.category ? 'selected' : ''}>SUV</option>
                                <option value="Luxury" ${'Luxury' eq car.category ? 'selected' : ''}>Luxury</option>
                                <option value="Sports" ${'Sports' eq car.category ? 'selected' : ''}>Sports</option>
                                <option value="Electric" ${'Electric' eq car.category ? 'selected' : ''}>Electric</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="year">Production Year *</label>
                            <input type="number" id="year" name="year" class="form-control" required min="1990" max="2030" value="${car.year > 0 ? car.year : 2024}">
                        </div>
                    </div>

                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="pricePerDay">Daily Rental Rate ($ USD) *</label>
                            <input type="number" step="0.01" id="pricePerDay" name="pricePerDay" class="form-control" required min="1" value="${car.pricePerDay > 0 ? car.pricePerDay : 150.00}">
                        </div>

                        <div class="form-group">
                            <label for="seats">Seating Capacity *</label>
                            <input type="number" id="seats" name="seats" class="form-control" required min="1" max="15" value="${car.seats > 0 ? car.seats : 5}">
                        </div>
                    </div>

                    <div class="form-grid-2">
                        <div class="form-group">
                            <label for="fuelType">Fuel Type</label>
                            <select id="fuelType" name="fuelType" class="form-control">
                                <option value="Petrol" ${'Petrol' eq car.fuelType ? 'selected' : ''}>Petrol</option>
                                <option value="Diesel" ${'Diesel' eq car.fuelType ? 'selected' : ''}>Diesel</option>
                                <option value="Electric" ${'Electric' eq car.fuelType ? 'selected' : ''}>Electric</option>
                                <option value="Hybrid" ${'Hybrid' eq car.fuelType ? 'selected' : ''}>Hybrid</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="transmission">Transmission</label>
                            <select id="transmission" name="transmission" class="form-control">
                                <option value="Automatic" ${'Automatic' eq car.transmission ? 'selected' : ''}>Automatic</option>
                                <option value="Manual" ${'Manual' eq car.transmission ? 'selected' : ''}>Manual</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom: 20px;">
                        <label for="imageUrl">Photo URL *</label>
                        <input type="url" id="imageUrl" name="imageUrl" class="form-control" required value="${car.imageUrl}" placeholder="https://images.unsplash.com/photo-...">
                    </div>

                    <div class="form-group" style="margin-bottom: 20px;">
                        <label for="description">Detailed Description</label>
                        <textarea id="description" name="description" class="form-control" rows="3" placeholder="Highlight vehicle performance, comfort, and interior finish...">${car.description}</textarea>
                    </div>

                    <div class="form-group" style="margin-bottom: 20px;">
                        <label for="features">Key Features (Comma separated)</label>
                        <input type="text" id="features" name="features" class="form-control" value="${car.features}" placeholder="e.g. Navigation, Leather Seats, Heated Steering, Panoramic Roof">
                    </div>

                    <div class="form-group" style="margin-bottom: 28px;">
                        <label for="status">Initial Operational Status</label>
                        <select id="status" name="status" class="form-control">
                            <option value="AVAILABLE" ${'AVAILABLE' eq car.status ? 'selected' : ''}>Available for Rent</option>
                            <option value="MAINTENANCE" ${'MAINTENANCE' eq car.status ? 'selected' : ''}>In Maintenance</option>
                        </select>
                    </div>

                    <div style="display: flex; gap: 16px;">
                        <button type="submit" class="btn btn-primary" style="padding: 12px 28px;">
                            ${isEdit ? 'Save Changes' : 'Add Vehicle to Fleet'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/cars" class="btn btn-secondary">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </main>
    </div>

</body>
</html>

