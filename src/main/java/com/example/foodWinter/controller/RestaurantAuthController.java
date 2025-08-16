package com.example.foodWinter.controller;

import com.example.foodWinter.dao.RestaurantRepository;
import com.example.foodWinter.model.Restaurant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

import java.util.Optional;

@Controller
public class RestaurantAuthController {

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    /**
     * Displays the restaurant login page.
     */
    @GetMapping("/restrologin")
    public String showRestroLoginPage() {
        return "restro_login"; // Renders restro_login.jsp
    }

    /**
     * Handles restaurant login submission.
     *
     * @param email The restaurant's email.
     * @param password The restaurant's password.
     * @param session HttpSession to store restaurant data.
     * @param redirectAttributes For flash messages.
     * @return Redirects to restaurant dashboard on success, or back to login with error.
     */
    @PostMapping("/restrologin")
    public String loginRestaurant(@RequestParam("email") String email,
                                  @RequestParam("password") String password,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {

        Optional<Restaurant> optionalRestaurant = restaurantRepository.findByEmail(email);

        if (optionalRestaurant.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Restaurant email not found. Please sign up.");
            return "redirect:/restrologin";
        }

        Restaurant restaurant = optionalRestaurant.get();

        if (passwordEncoder.matches(password, restaurant.getPassword())) {
            // Password matches, login successful
            session.setAttribute("loggedInRestaurantEmail", restaurant.getEmail());
            session.setAttribute("loggedInRestaurantId", restaurant.getId());
            session.setAttribute("loggedInRestaurantName", restaurant.getRestaurantName());

            redirectAttributes.addFlashAttribute("success", "Login successful! Welcome, " + restaurant.getRestaurantName() + "!");
            return "redirect:/dashboard"; // Redirect to the restaurant's dashboard (e.g., /dashboard)
        } else {
            // Password does not match
            redirectAttributes.addFlashAttribute("error", "Incorrect password. Please try again.");
            return "redirect:/restrologin";
        }
    }

    /**
     * Displays the restaurant signup page.
     */
    @GetMapping("/restrosignup")
    public String showRestroSignupPage() {
        return "restro_signup"; // Renders restro_signup.jsp
    }

    /**
     * Handles restaurant signup submission.
     *
     * @param restaurantName The name of the restaurant.
     * @param email The restaurant's email address.
     * @param mobileNumber The restaurant's mobile number.
     * @param password The chosen password.
     * @param redirectAttributes For flash messages.
     * @return Redirects to restaurant login on success, or back to signup with error.
     */
    @PostMapping("/restrosignup")
    public String registerRestaurant(@RequestParam("username") String restaurantName, // Matches 'name' attribute in JSP
                                     @RequestParam("email") String email,
                                     @RequestParam("mobileno") String mobileNumber,  // Matches 'name' attribute in JSP
                                     @RequestParam("password") String password,
                                     RedirectAttributes redirectAttributes) {

        // Check if email already exists
        if (restaurantRepository.findByEmail(email).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Restaurant email already registered. Please login or use a different email.");
            return "redirect:/restrosignup";
        }

        // Hash the password before saving
        String hashedPassword = passwordEncoder.encode(password);

        // Create a new Restaurant object
        Restaurant newRestaurant = new Restaurant(restaurantName, email, mobileNumber, hashedPassword);

        try {
            restaurantRepository.save(newRestaurant);
            redirectAttributes.addFlashAttribute("success", "Restaurant account created successfully! Please login.");
            return "redirect:/restrologin"; // Redirect to restaurant login page after successful signup
        } catch (Exception e) {
            System.err.println("Error during restaurant registration: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Restaurant registration failed. Please try again.");
            return "redirect:/restrosignup";
        }
    }

    /**
     * Handles restaurant logout.
     * @param session HttpSession to invalidate.
     * @param redirectAttributes For flash messages.
     * @return Redirects to restaurant login page after logout.
     */
    @GetMapping("/restrologout")
    public String logoutRestaurant(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "You have been logged out successfully.");
        return "redirect:/restrologin";
    }
}