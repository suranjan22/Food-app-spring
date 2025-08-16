<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.foodWinter.model.menuModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Menu - GharKaZaiqa</title>
  <link rel="stylesheet" href="style_1.css" />
  <style>
    /* Add new styles for the container and cards */
    .video-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
    }
    
    .video-container video {
      width: 75%;
      height: 50vh;
      object-fit: cover;
      border-radius: 10px; /* Optional: adds rounded corners to the video */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional: adds a subtle shadow */
    }

    .cards-container {
      display: flex;
      justify-content: center;
      gap: 20px; /* Space between the cards */
      margin-top: 40px;
    }
    
    .card {
      width: 300px;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
      background-color: #f9f9f9;
    }
    
    .card h3 {
      margin-bottom: 15px;
    }

    .card input[type="file"] {
      display: block;
      margin: 0 auto;
    }
  </style>
</head>
<body>
  <aside class="sidebar" id="sidebar">
    <h2 class="logo">PlatePanda</h2>
    <ul>
      <li><a href="\home">Home</a></li>
      <li><a href="\menu">Menu</a></li>
      <li><a href="\cart"> Cart</a></li>
      <li><a href="\contact">Contact Us</a></li>
      <li><a href="\yourorders">Your Orders</a></li>
      <li><a href="\restrosignup">Business</a></li>
    </ul>
    <a href="\login" class="logout">Logout</a>
  </aside>

  <main class="main-content">
   <div class="tagline">
        <h1 style="text-align: center;"><i>Fresh Food, Fast!!</i></h1>
    </div>
    <div class="video-container">
    
      <video src="/videos/1111421-hd_1920_1080_30fps.mp4" class="poster" autoplay loop muted></video>
    </div>

    <div class="cards-container">
      <div class="card">
        <h3>Sale upto 80% off!!</h3>
        <img src="/homeImg/beryani-img.png" alt="beryani-sale" width="500" height="600">
      </div>
      <div class="card">
        <h3>Sale upto 50% off!!</h3>
        <img src="/homeImg/chowmin-img.png" alt="chowmin-sale" width="500" height="600">
      </div>
      <div class="card">
        <h3>Sale upto 25% off!!</h3>
        <img src="/homeImg/pizza-img.png" alt="pizza-sale" width="500" height="600">
      </div>
    </div>
  </main>
</body>
</html>