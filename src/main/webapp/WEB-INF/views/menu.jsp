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
  <link rel="stylesheet" href="style_1.css" /> <%-- Your external CSS file --%>
  <style>
    /* Basic styling for image to prevent huge images from breaking layout */
    .products-container .card img {
      width: 100%; /* Make image fill the card width */
      height: 200px; /* Fixed height for consistency */
      object-fit: cover; /* Crop image to fit without distortion */
      border-radius: 8px; /* Match card border-radius */
      margin-bottom: 10px;
    }
  </style>
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
      <h2>Shop by Category</h2>

      <div class="category-bar">
        <%
            // Retrieve the current filter from the model, default to "all"
            String currentFilter = (String) request.getAttribute("currentCategoryFilter");
            if (currentFilter == null) {
                currentFilter = "all";
            }
        %>
        <a href="/menu?category=all" class="button <%= "all".equals(currentFilter) ? "active" : "" %>">All Items</a>
        <a href="/menu?category=maincourse" class="button <%= "maincourse".equals(currentFilter) ? "active" : "" %>">Main Course</a>
        <a href="/menu?category=beverage" class="button <%= "beverage".equals(currentFilter) ? "active" : "" %>">Beverage</a>
        <a href="/menu?category=dessert" class="button <%= "dessert".equals(currentFilter) ? "active" : "" %>">Dessert</a>
        </div>

      <div class="products-container">
        <%
        // Retrieve the list of menu items from the request attribute (already filtered by controller)
        List<menuModel> allMenuItems = (List<menuModel>) request.getAttribute("allMenuItems");

        if (allMenuItems != null && !allMenuItems.isEmpty()) {
            for (menuModel item : allMenuItems) {
        %>
            <div class="card">
              <%-- Changed the src to use item.getItem_image() --%>
              <img src="<%= item.getItem_image() != null && !item.getItem_image().isEmpty() ? item.getItem_image() : "/images/placeholder.jpg" %>"
                   alt="<%= item.getItem_name() != null ? item.getItem_name() : "Dish Image" %>" />
              <h4><%= item.getItem_name() != null ? item.getItem_name() : "Untitled Item" %></h4>
              <p><%= item.getItem_desc() != null ? item.getItem_desc() : "No description available" %></p>
              <p class="price">₹<%= String.format("%.2f", item.getPrice()) %></p>
              <div class="card-buttons">
                <form action="/cart/add" method="post" style="display:inline;">
                  <input type="hidden" name="itemId" value="<%= item.getItem_id() %>">
                  <input type="hidden" name="quantity" value="1">
                  <button type="submit" class="add-cart">Add to Cart</button>
                </form>

                <form action="/payment" method="post" style="display:inline;">
                  <input type="hidden" name="itemId" value="<%= item.getItem_id() %>">
                  <input type="hidden" name="itemQuantity" value="1">
                  <button type="submit" class="buy-now">Buy Now</button>
                </form>
              </div>
            </div>
        <%
            }
        } else {
        %>
            <p>No menu items available for this category.</p>
        <%
        }
        %>
      </div>
    </main>
  </div>

  <script>
    // No significant JavaScript needed for filtering anymore.
    // The active button class is handled by JSP, and filtering is server-side.
    // You can remove this script block entirely if you don't need it for other purposes.
  </script>
</body>
</html>