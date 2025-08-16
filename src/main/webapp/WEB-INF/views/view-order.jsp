<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.foodWinter.model.Order" %> <%-- Import your Order model --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>View Orders</title>
  <link rel="stylesheet" href="style_3.css">
</head>
<body>
  <div class="sidebar">
    <h2>GharKaZaiqa</h2>
    <a href="\dashboard">Home</a>
    <a href="\addmenu">Add Menu</a>
    <a href="\viewmenu">View Menu</a>
    <a href="\vieworder">View Order</a>
   
    <a href="\restrologin">Logout</a>
  </div>
  <div class="main-content">
    <h1>Customer Orders</h1>

    <%-- Display flash attributes (success/error messages) --%>
    <%
        String successMessage = (String) request.getAttribute("success");
        String errorMessage = (String) request.getAttribute("error");
        if (successMessage != null) {
    %>
        <p style="color: green; font-weight: bold;"><%= successMessage %></p>
    <%
        }
        if (errorMessage != null) {
    %>
        <p style="color: red; font-weight: bold;"><%= errorMessage %></p>
    <%
        }
    %>

    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Order ID</th>
            <th>User Name</th>
            <th>Email</th>
            <th>Item</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Total Amount</th>
            <th>Order Date</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
          %>
                  <tr>
                    <td><%= order.getOrderId() != null ? order.getOrderId() : "N/A" %></td>
                    <td><%= order.getUserName() != null ? order.getUserName() : "N/A" %></td>
                    <td><%= order.getUserEmail() != null ? order.getUserEmail() : "N/A" %></td>
                    <td><%= order.getItemName() != null ? order.getItemName() : "N/A" %></td>
                    <td><%= order.getQuantity() %></td>
                    <td>₹<%= String.format("%.2f", order.getItemPrice() != null ? order.getItemPrice() : 0.00) %></td>
                    <td>₹<%= String.format("%.2f", order.getTotalAmount() != null ? order.getTotalAmount() : 0.00) %></td>
                    <td><%= order.getOrderDate() != null ? order.getOrderDate().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) : "N/A" %></td>
                    <td><%= order.getStatus() != null ? order.getStatus() : "N/A" %></td>
                    <td>
                      <%-- Approve and Decline buttons --%>
                      <form action="/updateOrderStatus/<%= order.getId() %>" method="post" style="display:inline-block;">
                          <button type="submit" name="action" value="approve" class="action-btn approve-btn" <%= "Approved".equals(order.getStatus()) || "Declined".equals(order.getStatus()) ? "disabled" : "" %>>Approve</button>
                          <button type="submit" name="action" value="decline" class="action-btn decline-btn" <%= "Approved".equals(order.getStatus()) || "Declined".equals(order.getStatus()) ? "disabled" : "" %>>Decline</button>
                      </form>
                      <%-- Delete button --%>
                      <form action="/deleteOrder/<%= order.getId() %>" method="post" style="display:inline-block;">
                          <button type="submit" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete order <%= order.getOrderId() %>?');">Delete</button>
                      </form>
                    </td>
                  </tr>
          <%
                }
            } else {
          %>
              <tr>
                <td colspan="10">No orders found.</td>
              </tr>
          <%
            }
          %>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>