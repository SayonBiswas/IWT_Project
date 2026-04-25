<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .navbar {
        background-color: #333;
        width: 100%;
        overflow: hidden;
        font-family: Arial, sans-serif;
    }
    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
    }
    .navbar a:hover { background-color: #555; }
    .navbar-right { float: right; }
</style>
</head>
<body>
<div class="navbar">
    <a href="dashboard.jsp">Home/Dashboard</a>
    <a href="setup.jsp">Take Test</a>
    
    <div class="navbar-right">
        <%-- Only show user info if they are logged in --%>
        <% if (session.getAttribute("username") != null) { %>
            <a href="#" style="background-color: #444;">User: <%= session.getAttribute("username") %></a>
            <a href="logout.jsp" style="color: #ff4d4d;">Logout</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
        <% } %>
    </div>
</div>
</body>
</html>