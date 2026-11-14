<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="container" style="padding-top: 50px; padding-bottom: 80px;">
        <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

        <div style="max-width: 820px; margin: 0 auto;">
            <span class="hero-tag">★ Our Heritage & Vision</span>
            <h1 style="font-size: 2.8rem; margin: 12px 0 20px;">Redefining the Luxury Car Rental Standard</h1>

            <p style="font-size: 1.15rem; color: var(--text-secondary); line-height: 1.8; margin-bottom: 28px;">
                Founded with a mission to deliver peerless driving excitement, Apex Drive pairs the world's most sought-after supercars, luxury saloons, and performance SUVs with an effortless, digital-first reservation experience.
            </p>

            <div style="border-radius: var(--radius-lg); overflow: hidden; margin-bottom: 40px; height: 380px;">
                <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80" alt="Apex Drive Fleet" style="width: 100%; height: 100%; object-fit: cover;">
            </div>

            <div class="features-grid" style="margin-bottom: 40px;">
                <div class="feature-box">
                    <h3 class="feature-title">50+ Pristine Vehicles</h3>
                    <p class="feature-desc">From Mercedes-Maybach to Porsche 911 GTS, our collection represents top-tier engineering.</p>
                </div>
                <div class="feature-box">
                    <h3 class="feature-title">99.8% On-Time Delivery</h3>
                    <p class="feature-desc">Airport runway handoffs and doorstep deliveries executed with strict precision.</p>
                </div>
            </div>

            <h2 style="font-size: 1.8rem; margin-bottom: 16px;">Enterprise Architecture & Reliability</h2>
            <p style="color: var(--text-secondary); line-height: 1.8; margin-bottom: 30px;">
                Apex Drive is built entirely using standard Java Servlets, JSP, and pure XML storage using the W3C Document Object Model (DOM). By eliminating bulky external database dependencies, all vehicle catalogs, booking transactions, and user credentials remain portable, light, and thread-safe.
            </p>

            <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary" style="padding: 14px 32px;">
                Explore Our Fleet
            </a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

