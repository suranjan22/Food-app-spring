package com.example.foodWinter.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.Table;

@Entity
@Table(name = "restaurants") // Name of your restaurant table in MySQL
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String restaurantName; // Corresponds to "resturant Name" in JSP

    @Column(nullable = false, unique = true) // Email should be unique
    private String email; // Corresponds to "Resturant Email Address"

    @Column(nullable = false)
    private String mobileNumber; // Corresponds to "Resturant Mobile Number"

    @Column(nullable = false)
    private String password; // Will store the hashed password

    // Default constructor (required by JPA)
    public Restaurant() {
    }

    // Constructor for creating a new restaurant (without ID)
    public Restaurant(String restaurantName, String email, String mobileNumber, String password) {
        this.restaurantName = restaurantName;
        this.email = email;
        this.mobileNumber = mobileNumber;
        this.password = password;
    }

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Restaurant{" +
               "id=" + id +
               ", restaurantName='" + restaurantName + '\'' +
               ", email='" + email + '\'' +
               ", mobileNumber='" + mobileNumber + '\'' +
               '}';
    }
}
