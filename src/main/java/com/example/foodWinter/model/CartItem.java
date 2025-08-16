package com.example.foodWinter.model;

public class CartItem {
    private menuModel item;
    private int quantity;

    public CartItem(menuModel item, int quantity) {
        this.item = item;
        this.quantity = quantity;
    }

    public menuModel getItem() {
        return item;
    }

    public void setItem(menuModel item) {
        this.item = item;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
