package com.example.foodWinter.controller;

import com.example.foodWinter.dao.OrderRepository;
import com.example.foodWinter.dao.modelDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired
    private OrderRepository orderRepository; // Inject OrderRepository

    @Autowired
    private modelDao menuRepository; // Inject modelDao (assuming it's your menu repository)

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        long totalOrders = orderRepository.count();
        long totalMenuItems = menuRepository.count();

        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalMenuItems", totalMenuItems);

        return "DSH_index"; // This should match the name of your JSP file without the .jsp extension
    }
}