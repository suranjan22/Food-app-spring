package com.example.foodWinter.dao;

import com.example.foodWinter.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Custom method to find a user by their email for login
    Optional<User> findByEmail(String email);
}