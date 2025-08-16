<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.foodWinter.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Orders - GharKaZaiqa</title>
  <link rel="stylesheet" href="style_1.css">
</head>
<body>
  <div class="container">
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
      <h2>Your Approved Orders</h2>
      <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
            for (Order order : orders) {
      %>
        <div class="card" style="margin-bottom: 15px;">
          <h4>Order #<%= order.getOrderId() %></h4>
          <p><strong>Item:</strong> <%= order.getItemName() %></p>
          <p><strong>Quantity:</strong> <%= order.getQuantity() %></p>
          <p><strong>Total:</strong> ₹<%= String.format("%.2f", order.getTotalAmount()) %></p>
          <p><strong>Status:</strong> <%= order.getStatus() %></p>
        </div>
      <%
          }
        } else {
      %>
        <p>You have no approved orders yet.</p>
      <%
        }
      %>
    </main>
  </div>
</body>
</html>
