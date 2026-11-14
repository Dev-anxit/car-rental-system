<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="alerts-wrapper">
    <%-- Flash Success from session --%>
    <c:if test="${not empty sessionScope.flashSuccess}">
        <div class="alert alert-success">
            <span>${sessionScope.flashSuccess}</span>
            <button class="close-btn" aria-label="Close">&times;</button>
        </div>
        <c:remove var="flashSuccess" scope="session"/>
    </c:if>

    <%-- Flash Error from session --%>
    <c:if test="${not empty sessionScope.flashError}">
        <div class="alert alert-danger">
            <span>${sessionScope.flashError}</span>
            <button class="close-btn" aria-label="Close">&times;</button>
        </div>
        <c:remove var="flashError" scope="session"/>
    </c:if>

    <%-- Flash Info from session --%>
    <c:if test="${not empty sessionScope.flashInfo}">
        <div class="alert alert-info">
            <span>${sessionScope.flashInfo}</span>
            <button class="close-btn" aria-label="Close">&times;</button>
        </div>
        <c:remove var="flashInfo" scope="session"/>
    </c:if>

    <%-- Request-scoped error --%>
    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-danger">
            <span>${requestScope.error}</span>
            <button class="close-btn" aria-label="Close">&times;</button>
        </div>
    </c:if>
</div>

