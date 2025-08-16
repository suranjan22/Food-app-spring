package com.example.foodWinter.dao;

import com.example.foodWinter.model.menuModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface modelDao extends JpaRepository<menuModel, String> {

    // Add this method for server-side filtering by category
    // The name MUST match the field name in menuModel: "findByCategory" (not findByCatagory)
    List<menuModel> findByCategory(String category);
}