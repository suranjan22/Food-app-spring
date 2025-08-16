<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="style_3.css">
  <style>
    /* Add some basic styling for the new cards */
    .dashboard-card {
      background-color: #f0f0f0;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    .dashboard-card h3 {
      color: #333;
      margin-bottom: 10px;
    }
    .dashboard-card p {
      font-size: 1.5em;
      font-weight: bold;
      color: #007bff; /* A nice blue color */
    }
    .card-group {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
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
    <h1>Dashboard Overview</h1>

    <div class="card-group">
      <div class="stat-card">
        <h3>Today's</h3>
        <p>Sales: 120</p>
        <p>Revenue: ₹12,500</p>
      </div>
      <div class="stat-card">
        <h3>Monthly</h3>
        <p>Sales: 900</p>
        <p>Revenue: ₹92,000</p>
      </div>
      <div class="stat-card">
        <h3>Quarterly</h3>
        <p>Sales: 2300</p>
        <p>Revenue: ₹2,45,000</p>
      </div>
      <div class="stat-card">
        <h3>Yearly</h3>
        <p>Sales: 10,800</p>
        <p>Revenue: ₹11,25,000</p>
      </div>

      <%-- New cards for Total Orders and Total Menu Items --%>
      <div class="dashboard-card">
        <h3>Total Orders</h3>
        <p>${totalOrders}</p>
      </div>
      <div class="dashboard-card">
        <h3>Total Menu Items</h3>
        <p>${totalMenuItems}</p>
      </div>
    </div>

    <h2 style="margin-top: 50px;">Sales Graph (Dummy)</h2>
    <div class="graph-container">
      <div class="bar" style="--height: 70%"></div>
      <div class="bar" style="--height: 90%"></div>
      <div class="bar" style="--height: 60%"></div>
      <div class="bar" style="--height: 85%"></div>
    </div>
  </div>
</body>
</html>