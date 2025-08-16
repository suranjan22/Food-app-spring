<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.foodWinter.model.CartItem" %>
<%@ page import="com.example.foodWinter.model.menuModel" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Payment - GharKaZaiqa</title>
  <link rel="stylesheet" href="style_1.css" />
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
    <h2>Payment Summary</h2>

    <%
      String orderMessage = (String) request.getAttribute("orderMessage");
      String errorMessage = (String) request.getAttribute("error");
      String message = (String) request.getAttribute("message");

      if (orderMessage != null) {
    %>
        <p style="color: green; font-weight: bold;"><%= orderMessage %></p>
    <% } %>

    <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
    <% } %>

    <% if (message != null) { %>
        <p style="color: orange;"><%= message %></p>
    <% } %>

    <div class="products">
      <%
        // Check if it's a direct purchase
        menuModel purchasedItem = (menuModel) request.getAttribute("purchasedItem");
        Integer purchasedQuantity = (Integer) request.getAttribute("purchasedQuantity");
        Double totalAmount = (Double) request.getAttribute("totalAmount");

        if (purchasedItem != null) {
      %>
          <div class="card">
            <h4>Order Summary for: <%= purchasedItem.getItem_name() %></h4>
            <p><strong>Item:</strong> <%= purchasedItem.getItem_name() %></p>
            <p><strong>Description:</strong> <%= purchasedItem.getItem_desc() %></p>
            <p><strong>Unit Price:</strong> ₹<%= String.format("%.2f", purchasedItem.getPrice()) %></p>
            <p><strong>Quantity:</strong> <%= purchasedQuantity %></p>
            <p class="price"><strong>Total Amount:</strong> ₹<%= String.format("%.2f", totalAmount) %></p>

            <form action="/placeOrder" method="post">
              <input type="hidden" name="itemId" value="<%= purchasedItem.getItem_id() %>">
              <input type="hidden" name="itemQuantity" value="<%= purchasedQuantity %>">
              <button type="submit" class="buy-now">Proceed to Pay</button>
            </form>
          </div>
      <%
        } else {
          // Else, show cart checkout items if present
          List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
          if (cart != null && !cart.isEmpty()) {
            double total = (Double) request.getAttribute("totalAmount");
      %>
            <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; margin-top: 10px;">
              <tr style="background-color: #f2f2f2;">
                <th>Item</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total</th>
              </tr>
              <%
                for (CartItem item : cart) {
                  double itemTotal = item.getItem().getPrice() * item.getQuantity();
              %>
                <tr>
                  <td><%= item.getItem().getItem_name() %></td>
                  <td><%= item.getQuantity() %></td>
                  <td>₹<%= String.format("%.2f", item.getItem().getPrice()) %></td>
                  <td>₹<%= String.format("%.2f", itemTotal) %></td>
                </tr>
              <% } %>
              <tr style="font-weight: bold;">
                <td colspan="3" style="text-align: right;">Grand Total:</td>
                <td>₹<%= String.format("%.2f", total) %></td>
              </tr>
            </table>

            <form action="/placeOrderFromCart" method="post" style="margin-top: 20px;">
              <button type="submit" class="buy-now">Proceed to Pay for All</button>
            </form>
      <%
          } else {
      %>
          <p>No item selected for payment directly. Please select an item from the <a href="/menu">menu</a>.</p>
      <%
          }
        }
      %>
    </div>
  </main>
</div>
</body>
</html>
