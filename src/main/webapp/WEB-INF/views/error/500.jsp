<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internal Server Exception | Apex Drive</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; min-height: 100vh; text-align: center; padding: 20px;">
    <div style="max-width: 540px; background: var(--bg-surface); border: 1px solid var(--border-color); border-radius: var(--radius-lg); padding: 48px;">
        <div style="font-size: 5rem; font-weight: 800; color: var(--accent-red); line-height: 1; margin-bottom: 12px;">500</div>
        <h1 style="font-size: 1.8rem; margin-bottom: 14px;">Engine Mechanical Fault</h1>
        <p style="color: var(--text-secondary); margin-bottom: 24px;">
            An unexpected server issue occurred while processing your request. Please return to safety or try again.
        </p>
        <div style="display: flex; justify-content: center; gap: 16px;">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Return Home</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</body>
</html>

