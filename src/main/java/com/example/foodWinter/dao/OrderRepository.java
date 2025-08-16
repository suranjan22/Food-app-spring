package com.example.foodWinter.dao;

import com.example.foodWinter.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    
    // Custom query method to find orders by their status
    List<Order> findByStatus(String status);
}
