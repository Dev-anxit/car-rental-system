<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Fleet | Apex Drive Car Rental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        .catalog-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 36px;
            margin: 40px 0 80px;
        }
        .filter-sidebar {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 24px;
            height: fit-content;
            position: sticky;
            top: 90px;
        }
        .filter-sidebar h3 {
            font-size: 1.15rem;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--border-light);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .filter-sidebar .form-group {
            margin-bottom: 18px;
        }
        .catalog-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }
        @media (max-width: 900px) {
            .catalog-layout {
                grid-template-columns: 1fr;
            }
            .filter-sidebar {
                position: static;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div class="catalog-layout">
            <!-- Filter Sidebar -->
            <aside class="filter-sidebar">
                <form action="${pageContext.request.contextPath}/cars" method="GET">
                    <h3>
                        <span>Filter Fleet</span>
                        <a href="${pageContext.request.contextPath}/cars" style="font-size: 0.8rem; color: var(--text-muted); font-weight: normal;">Reset</a>
                    </h3>

                    <div class="form-group">
                        <label for="keyword">Search Model / Brand</label>
                        <input type="text" id="keyword" name="keyword" class="form-control" value="${paramKeyword}" placeholder="e.g. BMW, Tesla, Audi">
                    </div>

                    <div class="form-group">
                        <label for="category">Vehicle Category</label>
                        <select id="category" name="category" class="form-control">
                            <option value="ALL">All Categories</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat}" ${cat eq paramCategory ? 'selected' : ''}>${cat}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="transmission">Transmission</label>
                        <select id="transmission" name="transmission" class="form-control">
                            <option value="ALL">All Transmissions</option>
                            <option value="Automatic" ${'Automatic' eq paramTransmission ? 'selected' : ''}>Automatic</option>
                            <option value="Manual" ${'Manual' eq paramTransmission ? 'selected' : ''}>Manual</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="fuelType">Fuel Type</label>
                        <select id="fuelType" name="fuelType" class="form-control">
                            <option value="ALL">All Fuel Types</option>
                            <option value="Petrol" ${'Petrol' eq paramFuelType ? 'selected' : ''}>Petrol</option>
                            <option value="Diesel" ${'Diesel' eq paramFuelType ? 'selected' : ''}>Diesel</option>
                            <option value="Electric" ${'Electric' eq paramFuelType ? 'selected' : ''}>Electric</option>
                            <option value="Hybrid" ${'Hybrid' eq paramFuelType ? 'selected' : ''}>Hybrid</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="maxPrice">Max Price Per Day ($)</label>
                        <input type="number" id="maxPrice" name="maxPrice" class="form-control" placeholder="e.g. 300" value="${paramMaxPrice}" min="50" max="1000">
                    </div>

                    <div class="form-group">
                        <label for="sort">Sort By</label>
                        <select id="sort" name="sort" class="form-control">
                            <option value="default">Recommended</option>
                            <option value="price_asc" ${'price_asc' eq paramSort ? 'selected' : ''}>Price: Low to High</option>
                            <option value="price_desc" ${'price_desc' eq paramSort ? 'selected' : ''}>Price: High to Low</option>
                            <option value="year_desc" ${'year_desc' eq paramSort ? 'selected' : ''}>Model: Newest First</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">Apply Filters</button>
                </form>
            </aside>

            <!-- Main Fleet List -->
            <main>
                <div class="catalog-topbar">
                    <div>
                        <h1 style="font-size: 1.8rem;">Available Fleet</h1>
                        <p class="text-secondary" style="font-size: 0.9rem;">Showing <strong>${cars.size()}</strong> high performance and luxury vehicles</p>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty cars}">
                        <div class="cars-grid" style="margin-bottom: 0;">
                            <c:forEach var="car" items="${cars}">
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
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                <span>${car.year}</span>
                                            </div>
                                            <div class="car-spec-item" title="Transmission">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                                                <span>${car.transmission}</span>
                                            </div>
                                            <div class="car-spec-item" title="Fuel">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 2v6h6V2H3zM14 2v6h7V2h-7zM3 13v9h6v-9H3zM14 13v9h7v-9h-7z"></path></svg>
                                                <span>${car.fuelType}</span>
                                            </div>
                                            <div class="car-spec-item" title="Seats">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle></svg>
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
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 60px 20px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg);">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="color: var(--text-muted); margin-bottom: 16px;">
                                <circle cx="11" cy="11" r="8"></circle>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                            </svg>
                            <h3>No Vehicles Found</h3>
                            <p class="text-secondary" style="margin: 8px 0 20px;">We couldn't find any vehicles matching your filter criteria.</p>
                            <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">Clear All Filters</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

