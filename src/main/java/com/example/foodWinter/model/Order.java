package com.example.foodWinter.model;

import jakarta.persistence.Entity; // Use jakarta.persistence for Spring Boot 3+
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime; // For order timestamp

@Entity
@Table(name = "customer_orders") // Name of your table in MySQL
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-incrementing primary key
    private Long id; // Unique ID for each order record

    private String orderId; // A user-friendly order ID (e.g., generated UUID)
    private String userName; // Dummy user name for now
    private String userEmail; // Dummy user email for now

    private String itemId; // ID of the ordered menu item
    private String itemName; // Name of the ordered menu item
    private Double itemPrice; // Price of the single item at the time of order
    private int quantity; // Quantity ordered
    private Double totalAmount; // totalAmount = itemPrice * quantity

    private LocalDateTime orderDate; // Timestamp of when the order was placed
    private String status; // e.g., "Pending", "Approved", "Declined", "Delivered"

    // Default constructor (required by JPA)
    public Order() {
        this.orderDate = LocalDateTime.now(); // Set current time on creation
        this.status = "Pending"; // Default status
    }

    // Constructor for creating an order
    public Order(String orderId, String userName, String userEmail, String itemId, String itemName, Double itemPrice, int quantity, Double totalAmount) {
        this.orderId = orderId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.itemId = itemId;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.orderDate = LocalDateTime.now(); // Set current time on creation
        this.status = "Pending"; // Default status
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public Double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" +
               "id=" + id +
               ", orderId='" + orderId + '\'' +
               ", userName='" + userName + '\'' +
               ", userEmail='" + userEmail + '\'' +
               ", itemId='" + itemId + '\'' +
               ", itemName='" + itemName + '\'' +
               ", itemPrice=" + itemPrice +
               ", quantity=" + quantity +
               ", totalAmount=" + totalAmount +
               ", orderDate=" + orderDate +
               ", status='" + status + '\'' +
               '}';
    }
}