<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Menu</title>
  <link rel="stylesheet" href="style_3.css">
  <style>
    /* Basic styling for file input if needed */
    .form-group {
      margin-bottom: 15px;
    }
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .form-group input[type="file"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      width: calc(100% - 22px); /* Adjust for padding and border */
      box-sizing: border-box;
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
    
    <a href="\restrologin">Logout</a>
  </div>
  <div class="main-content">
  <h4>${msg}</h4>
    <h1>Add New Menu Item</h1>

    <%-- THIS IS THE CRITICAL CHANGE --%>
    <form action="add_menu" method="post" enctype="multipart/form-data">
      <input type="text" name="itemId" placeholder="Item ID" required>
      <input type="text" name="itemName" placeholder="Item Name" required>
      <input type="text" name="restaurantName" placeholder="Restaurant Name" required>
      <textarea name="itemDescription" placeholder="Item Description" required></textarea>
      <input type="number" name="itemPrice" placeholder="Item Price" required>
      <select name="foodType" required>
        <option disabled selected>Select Food Type</option>
        <option value="veg">Veg</option>
        <option value="nonveg">Non‑Veg</option>
        <option value="vegan">Vegan</option>
      </select>
      <select name="category" required>
        <option disabled selected>Select Category</option>
        <option value="beverage">Beverage</option>
        <option value="salad">Salad</option>
        <option value="maincourse">Main Course</option>
        <option value="snacks">Snacks</option>
        <option value="dessert">Dessert</option>
        <option value="soup">Soup</option>
        <option value="appetizer">Appetizer</option>
        <option value="others">Others</option>
      </select>

      <%-- New section for image upload --%>
      <div class="form-group">
        <label for="itemImage">Item Image:</label>
        <input type="file" id="itemImage" name="itemImage" accept="image/*" required>
      </div>

      <button type="submit">Add Item</button>
    </form>
  </div>
</body>
</html>