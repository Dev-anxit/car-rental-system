<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; min-height: 100vh; text-align: center; padding: 20px;">
    <div style="max-width: 500px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 48px;">
        <div style="font-size: 5rem; font-weight: 800; color: var(--primary); line-height: 1; margin-bottom: 12px;">404</div>
        <h1 style="font-size: 1.8rem; margin-bottom: 14px;">Destination Not Found</h1>
        <p style="color: var(--text-secondary); margin-bottom: 28px;">
            The roadway you are looking for does not exist or has been relocated to another route.
        </p>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
            Return to Homepage
        </a>
    </div>
</body>
</html>

