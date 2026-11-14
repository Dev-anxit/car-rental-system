<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        .booking-item-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 24px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            flex-wrap: wrap;
            transition: var(--transition);
        }
        .booking-item-card:hover {
            border-color: var(--primary);
        }
        .booking-car-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .booking-thumb {
            width: 140px;
            height: 90px;
            border-radius: var(--radius-md);
            object-fit: cover;
            border: 1px solid var(--border-light);
        }
        .booking-meta-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
            gap: 16px;
            flex-grow: 1;
            margin: 0 20px;
        }
        .booking-meta-label {
            font-size: 0.75rem;
            color: var(--text-muted);
            text-transform: uppercase;
        }
        .booking-meta-val {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        @media (max-width: 900px) {
            .booking-item-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .booking-meta-grid {
                margin: 16px 0;
                width: 100%;
            }
            .booking-actions {
                width: 100%;
                display: flex;
                justify-content: flex-end;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container" style="padding-top: 40px; padding-bottom: 80px;">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; flex-wrap: wrap; gap: 16px;">
            <div>
                <h1 style="font-size: 2rem;">My Rental Bookings</h1>
                <p class="text-secondary">Track, review, and manage your vehicle reservations.</p>
            </div>
            <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">
                + Rent Another Vehicle
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty bookings}">
                <c:forEach var="b" items="${bookings}">
                    <div class="booking-item-card">
                        <div class="booking-car-info">
                            <img src="${b.carImageUrl}" alt="${b.carTitle}" class="booking-thumb">
                            <div>
                                <span style="font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase;">Reference: ${b.bookingReference}</span>
                                <h3 style="font-size: 1.25rem; margin: 4px 0 6px;">${b.carTitle}</h3>
                                <div>
                                    <c:choose>
                                        <c:when test="${b.status eq 'APPROVED'}">
                                            <span class="badge badge-approved">Approved</span>
                                        </c:when>
                                        <c:when test="${b.status eq 'PENDING'}">
                                            <span class="badge badge-pending">Pending Review</span>
                                        </c:when>
                                        <c:when test="${b.status eq 'REJECTED'}">
                                            <span class="badge badge-rejected">Rejected</span>
                                        </c:when>
                                        <c:when test="${b.status eq 'CANCELLED'}">
                                            <span class="badge badge-cancelled">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-completed">${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="booking-meta-grid">
                            <div>
                                <div class="booking-meta-label">Pickup Date</div>
                                <div class="booking-meta-val">${b.pickupDate}</div>
                            </div>
                            <div>
                                <div class="booking-meta-label">Return Date</div>
                                <div class="booking-meta-val">${b.returnDate}</div>
                            </div>
                            <div>
                                <div class="booking-meta-label">Duration</div>
                                <div class="booking-meta-val">${b.totalDays} Day(s)</div>
                            </div>
                            <div>
                                <div class="booking-meta-label">Total Amount</div>
                                <div class="booking-meta-val text-primary">$${b.totalPrice}</div>
                            </div>
                        </div>

                        <div class="booking-actions" style="display: flex; gap: 10px; align-items: center;">
                            <a href="${pageContext.request.contextPath}/booking-details?id=${b.id}" class="btn btn-secondary btn-sm">
                                View Details / Invoice
                            </a>

                            <c:if test="${b.canBeCancelled()}">
                                <form action="${pageContext.request.contextPath}/cancel-booking" method="POST" onsubmit="return confirm('Are you sure you want to cancel this booking (${b.bookingReference})?');" style="margin: 0;">
                                    <input type="hidden" name="bookingId" value="${b.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 70px 20px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg);">
                    <svg width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="color: var(--text-muted); margin-bottom: 16px;">
                        <rect x="2" y="5" width="20" height="14" rx="2"></rect>
                        <line x1="2" y1="10" x2="22" y2="10"></line>
                    </svg>
                    <h2>No Reservations Yet</h2>
                    <p class="text-secondary" style="margin: 10px 0 24px;">You haven't reserved any vehicles with us yet.</p>
                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">Browse Available Fleet</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

