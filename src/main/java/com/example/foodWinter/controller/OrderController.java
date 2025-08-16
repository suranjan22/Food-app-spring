package com.example.foodWinter.controller;

import com.example.foodWinter.dao.OrderRepository;
import com.example.foodWinter.model.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
public class OrderController {

    @Autowired
    private OrderRepository orderRepository;

    // ✅ Admin View All Orders
    @GetMapping("/vieworder")
    public String viewAllOrders(Model model) {
        List<Order> allOrders = orderRepository.findAll();
        model.addAttribute("orders", allOrders);
        return "view-order";
    }

    // ✅ User View Approved Orders (Your Orders Page)
    @GetMapping("/yourorders")
    public String getUserApprovedOrders(Model model) {
        List<Order> approvedOrders = orderRepository.findByStatus("Approved");
        model.addAttribute("orders", approvedOrders);
        return "yourorders"; // yourorders.jsp
    }

    // ✅ Update Order Status (Approve or Decline)
    @PostMapping("/updateOrderStatus/{id}")
    public String updateOrderStatus(@PathVariable("id") Long id,
                                    @RequestParam("action") String action,
                                    RedirectAttributes redirectAttributes) {
        Optional<Order> optionalOrder = orderRepository.findById(id);

        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();

            if ("approve".equalsIgnoreCase(action)) {
                order.setStatus("Approved");
                redirectAttributes.addFlashAttribute("success", "Order #" + order.getOrderId() + " approved successfully!");
            } else if ("decline".equalsIgnoreCase(action)) {
                order.setStatus("Declined");
                redirectAttributes.addFlashAttribute("success", "Order #" + order.getOrderId() + " declined.");
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid action for order #" + order.getOrderId());
            }

            orderRepository.save(order);
        } else {
            redirectAttributes.addFlashAttribute("error", "Order not found with ID: " + id);
        }

        return "redirect:/vieworder";
    }

    // ✅ Delete Order
    @PostMapping("/deleteOrder/{id}")
    public String deleteOrder(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (orderRepository.existsById(id)) {
            orderRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Order with ID " + id + " deleted successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Order not found with ID: " + id);
        }

        return "redirect:/vieworder";
    }

    // New method to get total order count
    public long getTotalOrders() {
        return orderRepository.count();
    }
}