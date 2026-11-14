<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create an Account | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="auth-wrapper">
        <div class="auth-card auth-card-wide">
            <div class="auth-header">
                <span class="hero-tag" style="margin-bottom: 12px;">★ Membership Registration</span>
                <h1>Join Apex Drive</h1>
                <p>Register in seconds to unlock luxury car reservations and member rates.</p>
            </div>

            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <form action="${pageContext.request.contextPath}/register" method="POST" class="auth-form">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label for="name">Full Name *</label>
                        <input type="text" id="name" name="name" class="form-control" required
                               value="${name}" placeholder="e.g. John Anderson">
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address *</label>
                        <input type="email" id="email" name="email" class="form-control" required
                               value="${email}" placeholder="john@example.com">
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label for="password">Password (min 6 chars) *</label>
                        <input type="password" id="password" name="password" class="form-control" required minlength="6"
                               placeholder="••••••••">
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required minlength="6"
                               placeholder="••••••••">
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control"
                               value="${phone}" placeholder="+1 (555) 000-0000">
                    </div>

                    <div class="form-group">
                        <label for="address">Residential City / Address</label>
                        <input type="text" id="address" name="address" class="form-control"
                               value="${address}" placeholder="New York, NY">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="padding: 14px; margin-top: 10px;">
                    Create Account & Continue
                </button>
            </form>

            <div class="auth-footer">
                Already registered with Apex Drive?
                <a href="${pageContext.request.contextPath}/login">Sign In</a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

