<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="db_config.jsp" %>
<%
    // 1. Session Security Check
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String topic = (String) session.getAttribute("currentTopic");
    Integer totalRequested = (Integer) session.getAttribute("totalQuestions");

    // Redirect if session expired or setup was skipped
    if (topic == null) {
        response.sendRedirect("setup.jsp");
        return;
    }

    int score = 0;
    int questionsCounted = 0;

    try (Connection conn = DriverManager.getConnection(dbUrl, user, pass)) {
        // 2. Optimized Query: Join questions and topics to get the correct answers
        // This matches the logic from your Test.java file
        String sql = "SELECT q.qid, q.qans FROM questions q " +
                     "JOIN topics t ON q.tid = t.tid " +
                     "WHERE t.tname ILIKE ?";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, topic);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int qId = rs.getInt("qid");
            String correctAnswer = rs.getString("qans"); // Field name from your Test.java
            
            // 3. Get the answer the user selected in exam.jsp
            String userResponse = request.getParameter("q" + qId);
            
            if (userResponse != null) {
                questionsCounted++;
                if (userResponse.trim().equalsIgnoreCase(correctAnswer.trim())) {
                    score++;
                }
            }
        }
    } catch (Exception e) {
        out.print("<div style='color:red;'>Error calculating score: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam Result - <%= topic %></title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .result-container { background: white; padding: 50px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); text-align: center; width: 450px; }
        .score-circle { width: 150px; height: 150px; border-radius: 50%; background: #6c5ce7; color: white; display: flex; flex-direction: column; justify-content: center; align-items: center; margin: 20px auto; font-size: 40px; font-weight: bold; }
        .score-label { font-size: 16px; font-weight: normal; margin-top: -5px; }
        h1 { color: #2d3436; margin-bottom: 10px; }
        p { color: #636e72; margin-bottom: 30px; }
        .btn-home { background: #6c5ce7; color: white; padding: 12px 30px; border: none; border-radius: 8px; text-decoration: none; font-weight: bold; transition: 0.3s; }
        .btn-home:hover { background: #a29bfe; }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
</head>
<body>

    <div class="result-container">
        <h1>Examination Complete!</h1>
        <p>Topic: <strong><%= topic %></strong></p>
        
        <div class="score-circle">
            <%= score %> / <%= totalRequested %>
            <div class="score-label">Correct</div>
        </div>

        <p>Congratulations, <strong><%= session.getAttribute("username") %></strong>! Your results have been recorded.</p>
        
        <br><br>
        <a href="setup.jsp" class="btn-home">Take Another Exam</a>
    </div>

    <script>
        // Trigger confetti if they got at least 50% correct
        <% if (score >= (totalRequested / 2.0)) { %>
            confetti({
                particleCount: 150,
                spread: 70,
                origin: { y: 0.6 }
            });
        <% } %>
    </script>

</body>
</html>