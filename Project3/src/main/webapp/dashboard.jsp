<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db_config.jsp" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; }
        .container { width: 80%; margin: auto; text-align: center; }
        
        /* The Two Boxes */
        .box-container { display: inline-block; width: 100%; margin-top: 50px; }
        .box {
            width: 40%;
            background-color: white;
            padding: 40px;
            margin: 10px;
            display: inline-block;
            border: 2px solid #333;
            border-radius: 10px;
            vertical-align: top;
        }
        .box h2 { color: #1a73e8; }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 15px;
        }
    </style>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="container">
        <h1>Welcome to Your Dashboard</h1>
        
        <div class="box-container">
            <div class="box">
                <h2>Take a Test</h2>
                <p>Generate fresh questions using AI based on any topic of your choice.</p>
                <a href="setup.jsp" class="btn">Start New Test</a>
            </div>

            <div class="box">
                <h2>Quick Stats</h2>
                <p>Check your latest performance and total exams completed.</p>
                <a href="exam_history.jsp" class="btn">View My Records</a>
            </div>
        </div>
    </div>
</body>
</html>