package com.example.foodWinter.model;

import jakarta.persistence.Entity;

import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="menues")
public class menuModel {
    @Id
    private String item_id;
    private String item_name;
    private String restro_name;
    private String item_desc;
    private double price;
    private String food_type;
    private String category;
    private String item_image; // New field for image URL/path

    public String getItem_id() {
        return item_id;
    }
    public void setItem_id(String item_id) {
        this.item_id = item_id;
    }
    public String getItem_name() {
        return item_name;
    }
    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }
    public String getRestro_name() {
        return restro_name;
    }
    public void setRestro_name(String restro_name) {
        this.restro_name = restro_name;
    }
    public String getItem_desc() {
        return item_desc;
    }
    public void setItem_desc(String item_desc) {
        this.item_desc = item_desc;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getFood_type() {
        return food_type;
    }
    public void setFood_type(String food_type) {
        this.food_type = food_type;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public String getItem_image() { // Getter for item_image
        return item_image;
    }
    public void setItem_image(String item_image) { // Setter for item_image
        this.item_image = item_image;
    }
}