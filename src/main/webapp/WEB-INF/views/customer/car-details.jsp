<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${car.fullName} | Apex Drive Fleet</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        .details-grid {
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 40px;
            margin: 40px 0 60px;
        }
        .car-hero-img-wrap {
            border-radius: var(--radius-lg);
            overflow: hidden;
            border: 1px solid var(--border-color);
            background: #000;
            height: 440px;
        }
        .car-hero-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .details-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 32px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .specs-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin: 24px 0;
        }
        .spec-box {
            background: var(--bg-card);
            border: 1px solid var(--border-light);
            border-radius: var(--radius-md);
            padding: 14px 18px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .spec-box-label {
            font-size: 0.78rem;
            color: var(--text-muted);
            text-transform: uppercase;
        }
        .spec-box-val {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--text-primary);
        }
        .features-pill-wrap {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 14px;
        }
        .feature-pill {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 6px 14px;
            border-radius: var(--radius-full);
            font-size: 0.85rem;
            color: var(--text-secondary);
        }
        @media (max-width: 900px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
            .car-hero-img-wrap {
                height: 300px;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div style="margin-top: 24px;">
            <a href="${pageContext.request.contextPath}/cars" class="text-secondary" style="font-size: 0.9rem;">
                &larr; Back to Fleet Catalog
            </a>
        </div>

        <div class="details-grid">
            <!-- Left: Image & Description -->
            <div>
                <div class="car-hero-img-wrap">
                    <img src="${car.imageUrl}" alt="${car.fullName}" class="car-hero-img">
                </div>

                <div style="margin-top: 32px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 30px;">
                    <h2 style="font-size: 1.4rem; margin-bottom: 14px;">Vehicle Description</h2>
                    <p style="color: var(--text-secondary); line-height: 1.8;">${car.description}</p>

                    <h3 style="font-size: 1.15rem; margin-top: 24px; margin-bottom: 8px;">Key Standard Features</h3>
                    <div class="features-pill-wrap">
                        <c:forTokens items="${car.features}" delims="," var="feature">
                            <span class="feature-pill">✓ ${feature.trim()}</span>
                        </c:forTokens>
                    </div>
                </div>
            </div>

            <!-- Right: Specs & Reservation Summary Card -->
            <div class="details-card">
                <div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                        <span class="car-badge-category" style="position: static;">${car.category}</span>
                        <c:choose>
                            <c:when test="${car.available}">
                                <span class="badge badge-approved">Ready for Rental</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-rejected">${car.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <span class="car-card-brand">${car.brand}</span>
                    <h1 style="font-size: 2.1rem; margin: 6px 0 16px;">${car.model}</h1>

                    <div style="display: flex; align-items: baseline; gap: 8px; margin-bottom: 24px;">
                        <span style="font-size: 2.4rem; font-weight: 800; color: var(--primary);">$${car.pricePerDay}</span>
                        <span class="text-muted" style="font-size: 1rem;">/ day (USD)</span>
                    </div>

                    <div class="specs-grid">
                        <div class="spec-box">
                            <div>
                                <div class="spec-box-label">Production Year</div>
                                <div class="spec-box-val">${car.year}</div>
                            </div>
                        </div>
                        <div class="spec-box">
                            <div>
                                <div class="spec-box-label">Transmission</div>
                                <div class="spec-box-val">${car.transmission}</div>
                            </div>
                        </div>
                        <div class="spec-box">
                            <div>
                                <div class="spec-box-label">Fuel Type</div>
                                <div class="spec-box-val">${car.fuelType}</div>
                            </div>
                        </div>
                        <div class="spec-box">
                            <div>
                                <div class="spec-box-label">Seating Capacity</div>
                                <div class="spec-box-val">${car.seats} Passengers</div>
                            </div>
                        </div>
                    </div>

                    <div style="margin: 20px 0; padding: 16px; background: rgba(59, 130, 246, 0.08); border: 1px solid rgba(59, 130, 246, 0.2); border-radius: var(--radius-md); font-size: 0.88rem; color: #93c5fd;">
                        <strong>🛡 Comprehensive Insurance:</strong> Included with 24/7 Roadside Concierge. Free cancellation up to 24 hours prior.
                    </div>
                </div>

                <div style="margin-top: 24px;">
                    <c:choose>
                        <c:when test="${car.available}">
                            <a href="${pageContext.request.contextPath}/book?carId=${car.id}" class="btn btn-primary btn-block" style="padding: 16px; font-size: 1.1rem;">
                                Reserve This Vehicle Now
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-secondary btn-block" disabled style="opacity: 0.6; cursor: not-allowed; padding: 16px;">
                                Currently Unavailable (${car.status})
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Similar Vehicles Section -->
        <c:if test="${not empty similarCars}">
            <div style="margin-top: 60px; margin-bottom: 80px;">
                <h2 style="font-size: 1.6rem; margin-bottom: 24px;">Similar ${car.category} Vehicles</h2>
                <div class="cars-grid" style="margin-bottom: 0;">
                    <c:forEach var="sim" items="${similarCars}">
                        <div class="car-card">
                            <div class="car-card-img-wrap">
                                <img src="${sim.imageUrl}" alt="${sim.fullName}" class="car-card-img">
                                <span class="car-badge-category">${sim.category}</span>
                            </div>
                            <div class="car-card-body">
                                <span class="car-card-brand">${sim.brand}</span>
                                <h3 class="car-card-title">${sim.model}</h3>
                                <div class="car-card-footer">
                                    <div class="car-price-block">
                                        <span class="car-price-val">$${sim.pricePerDay}</span>
                                        <span class="car-price-unit">per day</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/car-details?id=${sim.id}" class="btn btn-secondary btn-sm">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

