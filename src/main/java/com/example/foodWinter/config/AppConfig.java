package com.example.foodWinter.config;

import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; // Import BCrypt

@Configuration // Marks this class as a source of bean definitions
public class AppConfig {

    @Bean // This method's return value will be a Spring bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
