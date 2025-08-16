<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login</title>
  <link rel="stylesheet" href="style_2.css">
</head>
<body>
     <!--   <div class="video-container">
    <video width="320" height="240"  autoplay muted loop id="bg-video">
     <source src="resources/3296402-uhd_4096_2160_25fps.mp4" type="video/mp4">
      Your browser does not support HTML5 video.
    </video>-->
  <div class="container">
    <h2>Login</h2>

    <%-- Display success/error messages from flash attributes --%>
    <%
        String successMessage = (String) request.getAttribute("success");
        String errorMessage = (String) request.getAttribute("error");
        if (successMessage != null) {
    %>
        <p style="color: green; font-weight: bold; text-align: center;"><%= successMessage %></p>
    <%
        }
        if (errorMessage != null) {
    %>
        <p style="color: red; font-weight: bold; text-align: center;"><%= errorMessage %></p>
    <%
        }
    %>

    <form action="/login" method="post">
      <div class="form-group">
        <label for="email">Email or Username</label>
        <input type="text" id="email" name="email" placeholder="Enter your email or username" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
      </div>

      <button type="submit"> Login </button>

      <div class="link">
        Don't have an account? <a href="\signup">Sign Up</a>
      </div>
    </form>
  </div>
</body>
</html>