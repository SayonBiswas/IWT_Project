<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Setup Exam</title>
    <style>
        body { font-family: sans-serif; background: #f4f7f6; display: flex; justify-content: center; padding-top: 50px; }
        .setup-card { background: white; padding: 30px; border-radius: 10px; shadow: 0 4px 10px rgba(0,0,0,0.1); width: 400px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; }
        input[type="text"], input[type="number"], select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .radio-group { display: flex; gap: 20px; margin-top: 5px; }
        button { width: 100%; padding: 12px; background: #1a73e8; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        button:hover { background: #1557b0; }
    </style>
</head>
<body>
    <div class="setup-card">
        <h2>Exam Configuration</h2>
        <form action="generateQuestion.jsp" method="POST">
            <div class="form-group">
                <label>Enter Topic:</label>
                <input type="text" name="topic" placeholder="e.g. Java, Python, History" required>
            </div>
            
            <div class="form-group">
                <label>Number of Questions:</label>
                <input type="number" name="qCount" value="5" min="1" max="10">
            </div>

            <div class="form-group">
                <label>Question Source:</label>
                <div class="radio-group">
                    <label style="font-weight: normal;">
                        <input type="radio" name="source" value="old" checked> Use Existing
                    </label>
                    <label style="font-weight: normal;">
                        <input type="radio" name="source" value="new"> Generate New (AI)
                    </label>
                </div>
            </div>

            <button type="submit">Start Preparation</button>
        </form>
    </div>
</body>
</html>