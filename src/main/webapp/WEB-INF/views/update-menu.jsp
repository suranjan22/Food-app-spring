<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Menu Item</title>
  <link rel="stylesheet" href="style_3.css"> <%-- Ensure your CSS path is correct relative to your project --%>
  <style>
    /* Basic styling for the form for better readability */
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group textarea,
    .form-group input[type="file"] { /* Added input[type="file"] */
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box; /* Include padding in width */
    }
    .form-group textarea {
      resize: vertical; /* Allow vertical resizing */
      min-height: 80px;
    }
    .btn {
      padding: 10px 20px;
      background-color: #007bff;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
    .btn:hover {
      background-color: #0056b3;
    }
    .message {
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 4px;
    }
    .message.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .message.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    /* Style for image preview */
    .current-image {
        margin-top: 10px;
        margin-bottom: 10px;
        text-align: center;
    }
    .current-image img {
        max-width: 200px;
        height: auto;
        border: 1px solid #ddd;
        padding: 5px;
        border-radius: 4px;
    }
  </style>
</head>
<body>
  <div class="sidebar">
    <h2>GharKaZaiqa</h2>
    <a href="\dashboard">Home</a>
    <a href="\addmenu">Add Menu</a>
    <a href="\viewmenu">View Menu</a>
    <a href="\vieworder">View Order</a>
    <a href="\viewfeedback">View Feedback</a>
    <a href="\restrologin">Logout</a>
  </div>
  <div class="main-content">
    <h1>Update Menu Item</h1>

    <%-- Display success/error messages if redirected from controller --%>
    <% if (request.getAttribute("success") != null) { %>
        <p class="message success"><%= request.getAttribute("success") %></p>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <p class="message error"><%= request.getAttribute("error") %></p>
    <% } %>

    <%--
        The 'modelAttribute="menu"' in <form:form> is crucial.
        It tells Spring to look for an object named "menu" in the model
        (which your @GetMapping("/updateMenu") controller method puts there)
        and pre-fill the form fields based on its properties.

        Ensure the 'path' attributes in form:input/textarea match the exact
        property names (and their case) in your menuModel.

        CRITICAL: added enctype="multipart/form-data" for file uploads.
    --%>
    <form:form action="/updateMenu" method="post" modelAttribute="menu" enctype="multipart/form-data">
      <div class="form-group">
        <label for="itemId">Item ID:</label>
        <%-- item_id should be read-only as it's the primary key --%>
        <form:input path="item_id" id="itemId" type="text" readonly="true"/>
      </div>
      <div class="form-group">
        <label for="itemName">Item Name:</label>
        <form:input path="item_name" id="itemName" type="text" required="true"/>
      </div>
      <div class="form-group">
        <label for="restaurantName">Restaurant Name:</label>
        <form:input path="restro_name" id="restaurantName" type="text" required="true"/>
      </div>
      <div class="form-group">
        <label for="itemDescription">Description:</label>
        <form:textarea path="item_desc" id="itemDescription" required="true"/>
      </div>
      <div class="form-group">
        <label for="itemPrice">Price:</label>
        <%-- Use type="number" for price with step for decimals --%>
        <form:input path="price" id="itemPrice" type="number" step="0.01" required="true"/>
      </div>
      <div class="form-group">
        <label for="foodType">Food Type:</label>
        <form:input path="food_type" id="foodType" type="text" required="true"/>
      </div>
      <div class="form-group">
        <label for="category">Category:</label>
        <form:input path="category" id="category" type="text" required="true"/>
      </div>

      <%-- New section for image upload --%>
      <div class="form-group">
        <label for="itemImage">Item Image:</label>
        <%-- Display current image if available --%>
        <%--
            FIXED: Replaced 'com.example.yourproject.model.Menu' with
            'com.example.foodWinter.model.menuModel' based on your controller.
            This is critical for correct type casting.
        --%>
        <%
            // This scriptlet block checks if the 'menu' attribute exists in the request scope
            // and if its 'item_image' property (from menuModel) is not null or empty.
            // If true, it displays the current image.
            Object menuAttribute = request.getAttribute("menu");
            if (menuAttribute != null && menuAttribute instanceof com.example.foodWinter.model.menuModel) {
                com.example.foodWinter.model.menuModel currentMenu = (com.example.foodWinter.model.menuModel) menuAttribute;
                if (currentMenu.getItem_image() != null && !currentMenu.getItem_image().isEmpty()) {
        %>
                    <div class="current-image">
                        <p>Current Image:</p>
                        <%-- Assuming 'menu.item_image' holds the web-accessible path --%>
                        <img src="${menu.item_image}" alt="Current Item Image">
                    </div>
        <%
                }
            }
        %>
        <input type="file" id="itemImage" name="item_image_file" accept="image/*"/>
        <small>Leave blank to keep the current image, or choose a new one to update.</small>
      </div>

      <button type="submit" class="btn">Update Item</button>
    </form:form>
  </div>
</body>
</html>