<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserve ${car.fullName} | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        .booking-layout {
            display: grid;
            grid-template-columns: 1.5fr 1fr;
            gap: 40px;
            margin: 40px 0 80px;
        }
        .booking-card {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 36px;
        }
        .vehicle-summary {
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 28px;
            height: fit-content;
            position: sticky;
            top: 100px;
        }
        .cost-breakdown {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .cost-row {
            display: flex;
            justify-content: space-between;
            color: var(--text-secondary);
            font-size: 0.95rem;
        }
        .cost-row-total {
            margin-top: 10px;
            padding-top: 14px;
            border-top: 1px dashed var(--border-color);
            color: var(--text-primary);
            font-size: 1.3rem;
            font-weight: 800;
        }
        @media (max-width: 900px) {
            .booking-layout {
                grid-template-columns: 1fr;
            }
            .vehicle-summary {
                position: static;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div style="margin-top: 24px;">
            <a href="${pageContext.request.contextPath}/car-details?id=${car.id}" class="text-secondary" style="font-size: 0.9rem;">
                &larr; Back to Vehicle Details
            </a>
        </div>

        <div class="booking-layout">
            <!-- Left: Reservation Form -->
            <div class="booking-card">
                <h1 style="font-size: 1.85rem; margin-bottom: 8px;">Complete Your Reservation</h1>
                <p class="text-secondary" style="margin-bottom: 28px;">Fill in your rental schedule and preferred pickup locations.</p>

                <form action="${pageContext.request.contextPath}/book" method="POST" id="bookingForm">
                    <input type="hidden" name="carId" value="${car.id}">

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label for="pickupDate">Pickup Date *</label>
                            <input type="date" id="pickupDate" name="pickupDate" class="form-control" required value="${param.pickupDate}">
                        </div>

                        <div class="form-group">
                            <label for="returnDate">Return Date *</label>
                            <input type="date" id="returnDate" name="returnDate" class="form-control" required value="${param.returnDate}">
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label for="pickupLocation">Pickup Location</label>
                            <select id="pickupLocation" name="pickupLocation" class="form-control">
                                <option value="JFK International Airport (JFK)">JFK International Airport (Terminal 4)</option>
                                <option value="Manhattan Downtown Flagship (5th Ave)">Manhattan Downtown Flagship (5th Ave)</option>
                                <option value="LaGuardia Airport (LGA)">LaGuardia Airport (LGA)</option>
                                <option value="Brooklyn Heights Concierge Desk">Brooklyn Heights Concierge Desk</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="returnLocation">Return Location</label>
                            <select id="returnLocation" name="returnLocation" class="form-control">
                                <option value="Same as Pickup Location">Same as Pickup Location</option>
                                <option value="JFK International Airport (JFK)">JFK International Airport (JFK)</option>
                                <option value="Manhattan Downtown Flagship (5th Ave)">Manhattan Downtown Flagship (5th Ave)</option>
                                <option value="LaGuardia Airport (LGA)">LaGuardia Airport (LGA)</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom: 24px;">
                        <label for="specialRequests">Special Requests / Notes</label>
                        <textarea id="specialRequests" name="specialRequests" class="form-control" rows="3" placeholder="e.g. Flight number for delayed arrival, extra child safety seat, prepaid tolls package."></textarea>
                    </div>

                    <div style="padding: 16px; background: rgba(16, 185, 129, 0.08); border: 1px solid rgba(16, 185, 129, 0.25); border-radius: var(--radius-md); margin-bottom: 28px; font-size: 0.88rem; color: #6ee7b7;">
                        ✓ <strong>Instant Availability Check:</strong> Overlapping rental check is executed atomically upon submission to guarantee your vehicle.
                    </div>

                    <button type="submit" id="bookSubmitBtn" class="btn btn-primary btn-block" style="padding: 16px; font-size: 1.1rem;">
                        Confirm & Submit Booking
                    </button>
                </form>
            </div>

            <!-- Right: Vehicle Preview & Dynamic Price Calculator -->
            <div class="vehicle-summary">
                <h2 style="font-size: 1.25rem; margin-bottom: 16px; padding-bottom: 12px; border-bottom: 1px solid var(--border-light);">
                    Rental Summary
                </h2>

                <div style="border-radius: var(--radius-md); overflow: hidden; height: 160px; margin-bottom: 16px;">
                    <img src="${car.imageUrl}" alt="${car.fullName}" style="width: 100%; height: 100%; object-fit: cover;">
                </div>

                <span class="car-card-brand">${car.brand}</span>
                <h3 style="font-size: 1.25rem; margin: 4px 0 10px;">${car.model} (${car.year})</h3>

                <div class="car-specs-row" style="margin-bottom: 0;">
                    <span>${car.category}</span>
                    <span>${car.transmission}</span>
                    <span>${car.fuelType}</span>
                </div>

                <!-- Real-time Cost Calculation -->
                <div class="cost-breakdown">
                    <div class="cost-row">
                        <span>Daily Rate</span>
                        <span id="pricePerDayVal" data-price="${car.pricePerDay}">$${car.pricePerDay} / day</span>
                    </div>

                    <div class="cost-row">
                        <span>Rental Duration</span>
                        <span id="calculatedDays">1 Day</span>
                    </div>

                    <div class="cost-row">
                        <span>Insurance & Fees</span>
                        <span style="color: var(--accent-green);">Included (Free)</span>
                    </div>

                    <div class="cost-row cost-row-total">
                        <span>Total Estimated</span>
                        <span id="calculatedTotalPrice" class="text-primary">$${car.pricePerDay}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="${pageContext.request.contextPath}/assets/js/booking.js"></script>
</body>
</html>

