<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apex Drive | Premium Car Rental Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />
    </div>

    <!-- Hero Section -->
    <header class="hero">
        <div class="container">
            <div class="hero-content">
                <span class="hero-tag">★ Ultimate Driving Experience</span>
                <h1 class="hero-title">Rent The Exceptional. Drive The Extraordinary.</h1>
                <p class="hero-desc">
                    Experience world-class luxury sedans, high-performance supercars, and premium SUVs. Instant reservation, transparent pricing, and seamless pickup.
                </p>
                <div class="hero-btns">
                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">Browse Fleet</a>
                    <a href="${pageContext.request.contextPath}/about" class="btn btn-secondary">Learn More</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Floating Quick Search Widget -->
    <section class="container search-widget-wrap">
        <div class="search-widget">
            <form action="${pageContext.request.contextPath}/cars" method="GET" class="search-form-grid">
                <div class="form-group">
                    <label for="keyword">Search Model or Brand</label>
                    <input type="text" id="keyword" name="keyword" class="form-control" placeholder="e.g. Mercedes, Tesla, Porsche">
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control">
                        <option value="ALL">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}">${cat}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="transmission">Transmission</label>
                    <select id="transmission" name="transmission" class="form-control">
                        <option value="ALL">All Types</option>
                        <option value="Automatic">Automatic</option>
                        <option value="Manual">Manual</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="fuelType">Fuel Type</label>
                    <select id="fuelType" name="fuelType" class="form-control">
                        <option value="ALL">All Fuel Types</option>
                        <option value="Petrol">Petrol</option>
                        <option value="Diesel">Diesel</option>
                        <option value="Electric">Electric</option>
                        <option value="Hybrid">Hybrid</option>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary" style="height: 44px; padding: 0 28px;">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                            <circle cx="11" cy="11" r="8"></circle>
                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                        </svg>
                        Find Cars
                    </button>
                </div>
            </form>
        </div>
    </section>

    <!-- Featured Fleet Section -->
    <section class="container" style="padding-bottom: 70px;">
        <div class="section-header">
            <span class="section-subtitle">Premium Selection</span>
            <h2 class="section-title">Featured Fleet Vehicles</h2>
            <p class="section-lead">Hand-picked, immaculate vehicles maintained to pristine factory condition.</p>
        </div>

        <div class="cars-grid">
            <c:forEach var="car" items="${featuredCars}">
                <div class="car-card">
                    <div class="car-card-img-wrap">
                        <img src="${car.imageUrl}" alt="${car.fullName}" class="car-card-img">
                        <span class="car-badge-category">${car.category}</span>
                        <c:choose>
                            <c:when test="${car.available}">
                                <span class="car-badge car-badge-available">Available</span>
                            </c:when>
                            <c:otherwise>
                                <span class="car-badge car-badge-maintenance">${car.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="car-card-body">
                        <span class="car-card-brand">${car.brand}</span>
                        <h3 class="car-card-title">${car.model}</h3>

                        <div class="car-specs-row">
                            <div class="car-spec-item" title="Year">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                <span>${car.year}</span>
                            </div>
                            <div class="car-spec-item" title="Transmission">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                                <span>${car.transmission}</span>
                            </div>
                            <div class="car-spec-item" title="Fuel">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 2v6h6V2H3zM14 2v6h7V2h-7zM3 13v9h6v-9H3zM14 13v9h7v-9h-7z"></path></svg>
                                <span>${car.fuelType}</span>
                            </div>
                            <div class="car-spec-item" title="Seats">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
                                <span>${car.seats} Seats</span>
                            </div>
                        </div>

                        <div class="car-card-footer">
                            <div class="car-price-block">
                                <span class="car-price-val">$${car.pricePerDay}</span>
                                <span class="car-price-unit">per day</span>
                            </div>
                            <div style="display: flex; gap: 8px;">
                                <a href="${pageContext.request.contextPath}/car-details?id=${car.id}" class="btn btn-secondary btn-sm">Details</a>
                                <c:if test="${car.available}">
                                    <a href="${pageContext.request.contextPath}/book?carId=${car.id}" class="btn btn-primary btn-sm">Rent</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div style="text-align: center;">
            <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline" style="padding: 14px 36px; font-size: 1rem;">
                Explore All Fleet Models &rarr;
            </a>
        </div>
    </section>

    <!-- Why Choose Us Features -->
    <section class="features-section">
        <div class="container">
            <div class="section-header">
                <span class="section-subtitle">Excellence Guaranteed</span>
                <h2 class="section-title">Why Rent With Apex Drive?</h2>
                <p class="section-lead">We redefine automotive rental with unmatched convenience and concierge service.</p>
            </div>

            <div class="features-grid">
                <div class="feature-box">
                    <div class="feature-icon">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    </div>
                    <h3 class="feature-title">Pristine & Inspected</h3>
                    <p class="feature-desc">Every vehicle undergoes a thorough 50-point safety and cleanliness audit before delivery.</p>
                </div>

                <div class="feature-box">
                    <div class="feature-icon">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><line x1="12" y1="1" x2="12" y2="23"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                    </div>
                    <h3 class="feature-title">Transparent Pricing</h3>
                    <p class="feature-desc">Zero hidden charges. What you see is what you pay, including mandatory insurance coverage.</p>
                </div>

                <div class="feature-box">
                    <div class="feature-icon">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    </div>
                    <h3 class="feature-title">Instant Booking</h3>
                    <p class="feature-desc">Real-time availability checking prevents overlaps and confirms your reservation instantly.</p>
                </div>

                <div class="feature-box">
                    <div class="feature-icon">
                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                    </div>
                    <h3 class="feature-title">Flexible Pickups</h3>
                    <p class="feature-desc">Airport delivery, hotel concierge drops, or city center pickup points at your convenience.</p>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

