<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="com.example.foodWinter.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Cart - GharKaZaiqa</title>
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
      <h2>Your Cart</h2>

      <%
          Collection<CartItem> cartItems = (Collection<CartItem>) request.getAttribute("cart");

          if (cartItems == null || cartItems.isEmpty()) {
      %>
          <p>Your cart is empty.</p>
      <%
          } else {
      %>
          <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse; margin-top: 20px;">
              <tr style="background-color: #f2f2f2;">
                  <th>Item Name</th>
                  <th>Quantity</th>
                  <th>Price</th>
                  <th>Total</th>
                  <th>Action</th>
              </tr>
              <%
                  double totalAmount = 0;
                  for (CartItem item : cartItems) {
                      double total = item.getItem().getPrice() * item.getQuantity();
                      totalAmount += total;
              %>
              <tr>
                  <td><%= item.getItem().getItem_name() %></td>
                  <td><%= item.getQuantity() %></td>
                  <td>₹<%= String.format("%.2f", item.getItem().getPrice()) %></td>
                  <td>₹<%= String.format("%.2f", total) %></td>
                  <td>
                    <a href="/cart/remove?itemId=<%= item.getItem().getItem_id() %>" style="color: red;">Remove</a>
                  </td>
              </tr>
              <% } %>
              <tr style="font-weight: bold;">
                  <td colspan="3" style="text-align: right;">Grand Total:</td>
                  <td colspan="2">₹<%= String.format("%.2f", totalAmount) %></td>
              </tr>
          </table>

          <form action="/cart/checkout" method="post" style="margin-top: 20px;">
              <button type="submit" class="buy-now">Proceed to Pay</button>
          </form>
      <%
          }
      %>
    </main>
  </div>
</body>
</html>
