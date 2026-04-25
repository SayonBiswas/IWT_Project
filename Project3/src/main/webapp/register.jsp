<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="db_config.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<style>
        body { font-family: Arial; background: #f4f7f6; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .card { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 300px; }
        input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
	<div class="card">
        <h2>Register</h2>
        <form method="POST">
            <input type="text" name="user" placeholder="Username" required>
            <input type="password" name="pass" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <button type="submit">Create Account</button>
        </form>
        <p><a href="login.jsp">Already have an account? Login</a></p>

        <%
            if(request.getMethod().equalsIgnoreCase("POST")) {
                try (Connection conn = DriverManager.getConnection(dbUrl, user, pass)) {
                    PreparedStatement ps = conn.prepareStatement("INSERT INTO users(username, password, email) VALUES(?,?,?)");
                    ps.setString(1, request.getParameter("user"));
                    ps.setString(2, request.getParameter("pass"));
                    ps.setString(3, request.getParameter("email"));
                    ps.executeUpdate();
                    out.print("<script>alert('Registered!'); window.location='login.jsp';</script>");
                } catch(Exception e) { out.print("Error: " + e.getMessage()); }
            }
        %>
    </div>
</body>
</html>