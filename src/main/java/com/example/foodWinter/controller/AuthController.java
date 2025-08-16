package com.example.foodWinter.controller;

import com.example.foodWinter.dao.UserRepository;
import com.example.foodWinter.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; // Re-import BCrypt
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.util.Optional;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder; // Re-inject BCryptPasswordEncoder

    /**
     * Displays the login page.
     */
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Renders login.jsp
    }

    /**
     * Handles user login submission.
     *
     * @param email The user's email or username.
     * @param password The user's password.
     * @param session HttpSession to store user data.
     * @param redirectAttributes For flash messages.
     * @return Redirects to home on success, or back to login with error.
     */
    @PostMapping("/login")
    public String loginUser(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        Optional<User> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Email not found. Please sign up.");
            return "redirect:/login";
        }

        User user = optionalUser.get();

        // SECURE: Compare the provided plain-text password with the hashed password from the database
        if (passwordEncoder.matches(password, user.getPassword())) {
            // Password matches, login successful
            session.setAttribute("loggedInUserEmail", user.getEmail()); // Store email in session
            session.setAttribute("loggedInUserId", user.getId());       // Store ID in session
            session.setAttribute("loggedInUserName", user.getFullName()); // Store name in session

            redirectAttributes.addFlashAttribute("success", "Login successful! Welcome, " + user.getFullName() + "!");
            return "redirect:/home"; // Redirect to your main home page or dashboard
        } else {
            // Password does not match
            redirectAttributes.addFlashAttribute("error", "Incorrect password. Please try again.");
            return "redirect:/login";
        }
    }

    /**
     * Displays the signup page.
     */
    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup"; // Renders signup.jsp
    }

    /**
     * Handles user signup submission.
     *
     * @param fullName The full name of the user.
     * @param email The user's email address.
     * @param mobileNumber The user's mobile number.
     * @param password The user's chosen password.
     * @param redirectAttributes For flash messages.
     * @return Redirects to login on success, or back to signup with error.
     */
    @PostMapping("/signup")
    public String registerUser(@RequestParam("username") String fullName,
                               @RequestParam("email") String email,
                               @RequestParam("mobileno") String mobileNumber,
                               @RequestParam("password") String password,
                               RedirectAttributes redirectAttributes) {

        // Check if email already exists
        if (userRepository.findByEmail(email).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Email already registered. Please login or use a different email.");
            return "redirect:/signup";
        }

        // SECURE: Hash the password before saving
        String hashedPassword = passwordEncoder.encode(password);

        // Create a new User object
        User newUser = new User(fullName, email, mobileNumber, hashedPassword);

        try {
            userRepository.save(newUser);
            redirectAttributes.addFlashAttribute("success", "Account created successfully! Please login.");
            return "redirect:/login"; // Redirect to login page after successful signup
        } catch (Exception e) {
            // Log the error
            System.err.println("Error during user registration: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Registration failed. Please try again.");
            return "redirect:/signup";
        }
    }

    /**
     * Handles user logout.
     * @param session HttpSession to invalidate.
     * @param redirectAttributes For flash messages.
     * @return Redirects to login page after logout.
     */
    @GetMapping("/logout")
    public String logoutUser(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate(); // Invalidate the current session
        redirectAttributes.addFlashAttribute("success", "You have been logged out successfully.");
        return "redirect:/login"; // Redirect to login page
    }
}