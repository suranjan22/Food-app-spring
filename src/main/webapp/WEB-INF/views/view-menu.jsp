<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.foodWinter.model.menuModel" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Menu</title>
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
    <h1>Menu Items</h1>
    <div class="table-wrapper">
      <table>
        <thead>
          <tr>
            <th>Item ID</th>
            <th>Name</th>
            <th>Restaurant</th> <%-- Added Restaurant column --%>
            <th>Description</th> <%-- Added Description column --%>
            <th>Price</th>
            <th>Food Type</th> <%-- Changed from "Type" to "Food Type" for clarity --%>
            <th>Category</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
<%
// Retrieve the list of menu items from the request attribute
List<menuModel> menuList = (List<menuModel>) request.getAttribute("menu");

if (menuList != null && !menuList.isEmpty()) {
    for (menuModel item : menuList) { // Changed loop variable from 'menu' to 'item' to avoid conflict
%>
    <tr>
        <td><%= item.getItem_id() %></td>
        <td><%= item.getItem_name() %></td>
        <td><%= item.getRestro_name() %></td> <%-- Display Restaurant Name --%>
        <td><%= item.getItem_desc() %></td> <%-- Display Item Description --%>
        <td>₹<%= String.format("%.2f", item.getPrice()) %></td> <%-- Format price for currency --%>
        <td><%= item.getFood_type() %></td>
        <td><%= item.getCategory() %></td>
        <td>
               <a href="/updateMenu?itemId=<%= item.getItem_id() %>" class="btn btn-update">Update</a>
                <a href="/deleteMenu/<%= item.getItem_id()%>"
   onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
            </td>
    </tr>
<%
    }
} else {
%>
    <tr><td colspan="8">No menu items to display</td></tr> <%-- Colspan updated for 8 columns --%>
<%
}
%>
          <%--
          <tr>
            <td>101</td>
            <td>Paneer Tikka</td>
            <td>₹150</td>
            <td>Appetizer</td>
            <td>Veg</td>
            <td>
              <button class="action-btn update-btn">Update</button>
              <button class="action-btn delete-btn">Delete</button>
            </td>
          </tr>
          --%>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>