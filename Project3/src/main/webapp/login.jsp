<%@ include file="db_config.jsp" %>
<html>
<head>
    <title>Login - Online Exam</title>
    <style>
        body { font-family: 'Segoe UI', Arial; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { color: #333; margin-bottom: 25px; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #007bff; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; transition: 0.3s; }
        button:hover { background: #0056b3; }
        .error { color: #d9534f; font-size: 14px; margin-top: 10px; }
        .reg-link { margin-top: 20px; font-size: 14px; color: #666; }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>Exam Login</h2>
        <form method="POST">
            <input type="text" name="user" placeholder="Username" required>
            <input type="password" name="pass" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        
        <div class="reg-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>

        <%
            // Logic to handle Login
            if(request.getMethod().equalsIgnoreCase("POST")) {
                String u = request.getParameter("user");
                String p = request.getParameter("pass");
                
                try (Connection conn = DriverManager.getConnection(dbUrl, user, pass)) {
                    String query = "SELECT username FROM users WHERE username=? AND password=?";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setString(1, u);
                    ps.setString(2, p);
                    
                    ResultSet rs = ps.executeQuery();
                    
                    if(rs.next()) {
                        // Create a session for the user
                        session.setAttribute("username", u);
                        // Redirect to the exam page
                        response.sendRedirect("exam.jsp");
                    } else {
                        out.print("<p class='error'>Invalid Username or Password!</p>");
                    }
                } catch(Exception e) {
                    out.print("<p class='error'>Database Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>