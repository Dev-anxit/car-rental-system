<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />

    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-header">
                <span class="hero-tag" style="margin-bottom: 12px;">★ Member Access</span>
                <h1>Welcome Back</h1>
                <p>Sign in to manage your bookings and fleet reservations.</p>
            </div>

            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <form action="${pageContext.request.contextPath}/login" method="POST" class="auth-form">
                <input type="hidden" name="redirect" value="${redirectUrl}">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" required
                           value="${enteredEmail}" placeholder="name@domain.com" autocomplete="email">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required
                           placeholder="••••••••" autocomplete="current-password">
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="padding: 14px; margin-top: 8px;">
                    Sign In
                </button>
            </form>

            <!-- Quick Demo Credentials helper box for evaluation -->
            <div class="auth-demo-credentials">
                <div style="font-weight: 700; margin-bottom: 6px; color: var(--primary);">Quick Demo Accounts:</div>
                <div style="margin-bottom: 4px;">
                    <strong>Admin:</strong> <code>admin@carrental.com</code> / <code>admin123</code>
                </div>
                <div>
                    <strong>Customer:</strong> <code>john@example.com</code> / <code>customer123</code>
                </div>
            </div>

            <div class="auth-footer">
                Don't have an account yet?
                <a href="${pageContext.request.contextPath}/register">Create an account</a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>

