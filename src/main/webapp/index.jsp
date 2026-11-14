<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Forward directly to the HomeServlet controller
    response.sendRedirect(request.getContextPath() + "/home");
%>

