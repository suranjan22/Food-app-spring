package com.example.foodWinter.dao;

import com.example.foodWinter.model.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {

    // Custom method to find a restaurant by their email for login
    Optional<Restaurant> findByEmail(String email);
}