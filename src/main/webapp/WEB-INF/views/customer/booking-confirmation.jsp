<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation ${booking.bookingReference} | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        .invoice-box {
            max-width: 860px;
            margin: 40px auto 80px;
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 44px;
            box-shadow: var(--shadow-lg);
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 28px;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        .invoice-grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin: 24px 0;
        }
        .invoice-table th {
            text-align: left;
            padding: 12px 16px;
            background: var(--bg-card);
            border-bottom: 1px solid var(--border-color);
            font-size: 0.85rem;
            color: var(--text-secondary);
        }
        .invoice-table td {
            padding: 14px 16px;
            border-bottom: 1px solid var(--border-light);
        }
        @media print {
            .navbar, .footer, .btn, .no-print {
                display: none !important;
            }
            body {
                background: #fff !important;
                color: #000 !important;
            }
            .invoice-box {
                border: none !important;
                box-shadow: none !important;
                padding: 0 !important;
                margin: 0 !important;
                max-width: 100% !important;
            }
            .invoice-table th {
                background: #eee !important;
                color: #000 !important;
            }
            .invoice-table td {
                color: #000 !important;
            }
            h1, h2, h3, h4, span, div, p {
                color: #000 !important;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div class="no-print" style="margin-top: 24px; display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/my-bookings" class="text-secondary" style="font-size: 0.9rem;">
                &larr; Back to My Bookings
            </a>
            <div style="display: flex; gap: 10px;">
                <button onclick="window.print();" class="btn btn-secondary btn-sm">
                    🖨 Print Invoice
                </button>
            </div>
        </div>

        <div class="invoice-box">
            <div class="invoice-header">
                <div>
                    <div class="brand-logo" style="margin-bottom: 8px;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2"/><circle cx="7" cy="17" r="2"/><path d="M9 17h6"/><circle cx="17" cy="17" r="2"/></svg>
                        <span>APEX</span>DRIVE
                    </div>
                    <p style="color: var(--text-secondary); font-size: 0.85rem;">Official Rental Reservation & Receipt</p>
                </div>
                <div style="text-align: right;">
                    <div style="font-size: 1.3rem; font-weight: 800; color: var(--primary);">${booking.bookingReference}</div>
                    <div style="color: var(--text-muted); font-size: 0.85rem; margin-top: 4px;">Issued: ${booking.bookingDate}</div>
                    <div style="margin-top: 8px;">
                        <c:choose>
                            <c:when test="${booking.status eq 'APPROVED'}">
                                <span class="badge badge-approved">Confirmed / Approved</span>
                            </c:when>
                            <c:when test="${booking.status eq 'PENDING'}">
                                <span class="badge badge-pending">Pending Admin Approval</span>
                            </c:when>
                            <c:when test="${booking.status eq 'REJECTED'}">
                                <span class="badge badge-rejected">Rejected</span>
                            </c:when>
                            <c:when test="${booking.status eq 'CANCELLED'}">
                                <span class="badge badge-cancelled">Cancelled</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-completed">${booking.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="invoice-grid-2">
                <div>
                    <h4 style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 8px;">Renter Details</h4>
                    <div style="font-weight: 700; font-size: 1.05rem;">${booking.userFullName}</div>
                    <div style="color: var(--text-secondary); font-size: 0.9rem; margin-top: 2px;">${booking.userEmail}</div>
                    <div style="color: var(--text-secondary); font-size: 0.9rem;">Customer Account ID: ${booking.userId}</div>
                </div>

                <div>
                    <h4 style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; margin-bottom: 8px;">Rental Schedule & Pickup</h4>
                    <div style="font-size: 0.92rem; color: var(--text-secondary);">
                        <strong>Pickup Date:</strong> ${booking.pickupDate}<br>
                        <strong>Return Date:</strong> ${booking.returnDate}<br>
                        <strong>Pickup Hub:</strong> ${booking.pickupLocation}<br>
                        <strong>Dropoff Hub:</strong> ${booking.returnLocation}
                    </div>
                </div>
            </div>

            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Vehicle Description</th>
                        <th>Duration</th>
                        <th>Rate / Day</th>
                        <th style="text-align: right;">Total Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <strong>${booking.carTitle}</strong>
                            <div style="color: var(--text-muted); font-size: 0.8rem; margin-top: 2px;">Asset ID: ${booking.carId}</div>
                        </td>
                        <td>${booking.totalDays} Day(s)</td>
                        <td>$${booking.pricePerDay}</td>
                        <td style="text-align: right; font-weight: 700; color: var(--text-primary);">$${booking.totalPrice}</td>
                    </tr>
                </tbody>
            </table>

            <div style="display: flex; justify-content: flex-end; margin-top: 20px;">
                <div style="width: 280px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; color: var(--text-secondary);">
                        <span>Subtotal:</span>
                        <span>$${booking.totalPrice}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 8px; color: var(--text-secondary);">
                        <span>Taxes & Fees:</span>
                        <span>$0.00 (Inclusive)</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; padding-top: 10px; border-top: 1px solid var(--border-color); font-size: 1.25rem; font-weight: 800; color: var(--primary);">
                        <span>Total Paid:</span>
                        <span>$${booking.totalPrice}</span>
                    </div>
                </div>
            </div>

            <c:if test="${not empty booking.specialRequests}">
                <div style="margin-top: 30px; padding: 16px; background: var(--bg-card); border-radius: var(--radius-md); font-size: 0.9rem;">
                    <strong>Special Requests:</strong> ${booking.specialRequests}
                </div>
            </c:if>

            <div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid var(--border-light); font-size: 0.8rem; color: var(--text-muted); text-align: center;">
                Apex Drive Luxury Fleet Management &bull; 100 Auto Boulevard, Suite 500, New York, NY &bull; Tel: +1 (800) 555-APEX
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

