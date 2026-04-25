<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="db_config.jsp" %>
<%
    // 1. Get objects from session
    Object topicObj = session.getAttribute("currentTopic");
    Object limitObj = session.getAttribute("totalQuestions");

    // 2. SAFETY CHECK: If the user skipped setup, redirect them back
    if (topicObj == null || limitObj == null) {
        response.sendRedirect("setup.jsp");
        return; // Stop processing the rest of the page
    }

    // 3. Now it is safe to cast and unbox
    String topic = (String) topicObj;
    int limit = (Integer) limitObj; 
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam: <%= topic %></title>
    <style>
        /* --- Modern CSS Decoration --- */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #1a73e8;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        #examForm {
            width: 100%;
            max-width: 800px;
        }

        .q-card {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: transform 0.2s ease;
            border-left: 5px solid #1a73e8;
        }

        .q-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }

        h3 {
            margin-top: 0;
            color: #202124;
            font-size: 1.2rem;
            line-height: 1.4;
        }

        .option-container {
            margin: 12px 0;
            padding: 10px;
            border-radius: 8px;
            background: #f8f9fa;
            display: block;
            cursor: pointer;
            transition: background 0.2s;
        }

        .option-container:hover {
            background: #e8f0fe;
        }

        input[type="radio"] {
            margin-right: 15px;
            transform: scale(1.2);
            cursor: pointer;
        }

        button[type="submit"] {
            background-color: #1a73e8;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 30px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            display: block;
            margin: 40px auto;
            box-shadow: 0 4px 15px rgba(26, 115, 232, 0.3);
            transition: all 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #1557b0;
            box-shadow: 0 6px 20px rgba(26, 115, 232, 0.4);
            transform: scale(1.05);
        }

        .header-info {
            text-align: center;
            margin-bottom: 20px;
            color: #5f6368;
        }
    </style>
</head>
<body>

    <h2>Online Examination</h2>
    <div class="header-info">
        Topic: <strong><%= topic %></strong> | Questions: <strong><%= limit %></strong>
    </div>

    <form id="examForm" action="result.jsp" method="POST">
        <%
            try (Connection conn = DriverManager.getConnection(dbUrl, user, pass)) {
                String sql = "SELECT q.* FROM questions q JOIN topics t ON q.tid = t.tid WHERE t.tname ILIKE ? ORDER BY RANDOM() LIMIT ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, topic);
                ps.setInt(2, limit);
                ResultSet rs = ps.executeQuery();
                int count = 1;
                while(rs.next()) {
                    String[] opts = (String[]) rs.getArray("qopts").getArray(); // Handle Array
        %>
                    <div class="q-card">
                        <h3><%= count++ %>. <%= rs.getString("qtext") %></h3>
                        
                        <label class="option-container">
                            <input type="radio" name="q<%= rs.getInt("qid") %>" value="A" required> 
                            <%= opts[0] %>
                        </label>
                        
                        <label class="option-container">
                            <input type="radio" name="q<%= rs.getInt("qid") %>" value="B"> 
                            <%= opts[1] %>
                        </label>
                        
                        <label class="option-container">
                            <input type="radio" name="q<%= rs.getInt("qid") %>" value="C"> 
                            <%= opts[2] %>
                        </label>
                        
                        <label class="option-container">
                            <input type="radio" name="q<%= rs.getInt("qid") %>" value="D"> 
                            <%= opts[3] %>
                        </label>
                    </div>
        <%
                }
            } catch(Exception e) { 
                out.print("<div class='q-card' style='color:red;'>Database Error: " + e.getMessage() + "</div>"); 
            }
        %>
        <button type="submit">Finish &amp; Submit Exam</button>
    </form>

</body>
</html>