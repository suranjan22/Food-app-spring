<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sign Up</title>
  <link rel="stylesheet" href="style_2.css">
</head>
<body>
   <!--   <div class="video-container">
    <video width="320" height="240"  autoplay muted loop id="bg-video">
     <source src="resources/3296402-uhd_4096_2160_25fps.mp4" type="video/mp4">
      Your browser does not support HTML5 video.
    </video>-->
  <div class="container">
    <h2>Sign Up</h2>

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

    <form action="/signup" method="post">
      <div class="form-group">
        <label for="username">Full Name</label>
        <input type="text" id="username" name="username" placeholder="Enter your full name" required>
      </div>

      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
      </div>

       <div class="form-group">
        <label for="mobileno"> Mobile Number</label>
        <input type="text" id="mobileno" name="mobileno" placeholder="Enter your Mobile Number" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Create password" required>
      </div>

      <button type="submit">Sign Up</button>

      <div class="link">
        Already have an account? <a href="\login">Login</a>
      </div>
    </form>
  </div>
</body>
</html>