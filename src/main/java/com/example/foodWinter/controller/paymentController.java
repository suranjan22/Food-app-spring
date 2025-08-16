package com.example.foodWinter.controller;

import com.example.foodWinter.dao.modelDao;
import com.example.foodWinter.dao.OrderRepository;
import com.example.foodWinter.model.CartItem;
import com.example.foodWinter.model.Order;
import com.example.foodWinter.model.menuModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.UUID;

@Controller
public class paymentController {

    @Autowired
    private modelDao menuDao;

    @Autowired
    private OrderRepository orderRepository;

    @PostMapping("/payment")
    public String initiatePayment(@RequestParam("itemId") String itemId,
                                  @RequestParam(name = "itemQuantity", defaultValue = "1") int itemQuantity,
                                  Model model,
                                  RedirectAttributes redirectAttributes) {

        if (itemId == null || itemId.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Invalid item selected for purchase.");
            return "redirect:/menu";
        }

        Optional<menuModel> optionalItem = menuDao.findById(itemId);

        if (optionalItem.isPresent()) {
            menuModel purchasedItem = optionalItem.get();

            model.addAttribute("purchasedItem", purchasedItem);
            model.addAttribute("purchasedQuantity", itemQuantity);
            model.addAttribute("totalAmount", purchasedItem.getPrice() * itemQuantity);

            return "payment";
        } else {
            redirectAttributes.addFlashAttribute("error", "The selected item could not be found.");
            return "redirect:/menu";
        }
    }

    @GetMapping("/payment")
    public String showPaymentPage(Model model, HttpSession session) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("checkoutCart");

        if (cart == null || cart.isEmpty()) {
            model.addAttribute("message", "Please select an item from the menu to proceed with payment.");
            return "payment";
        }

        model.addAttribute("cart", new ArrayList<>(cart.values()));

        double totalAmount = 0;
        for (CartItem item : cart.values()) {
            totalAmount += item.getItem().getPrice() * item.getQuantity();
        }

        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("isCartCheckout", true);
        return "payment";
    }

    @PostMapping("/placeOrder")
    public String placeOrder(@RequestParam("itemId") String itemId,
                             @RequestParam(name = "itemQuantity", defaultValue = "1") int itemQuantity,
                             RedirectAttributes redirectAttributes) {

        Optional<menuModel> optionalItem = menuDao.findById(itemId);

        if (!optionalItem.isPresent()) {
            redirectAttributes.addFlashAttribute("error", "Error: Ordered item not found in menu.");
            return "redirect:/payment";
        }

        menuModel orderedMenuItem = optionalItem.get();

        String newOrderId = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        String dummyUserName = "Customer_" + newOrderId;
        String dummyUserEmail = "user_" + newOrderId.toLowerCase() + "@gharKaZaiqa.com";

        double totalAmount = orderedMenuItem.getPrice() * itemQuantity;

        Order newOrder = new Order(
            newOrderId,
            dummyUserName,
            dummyUserEmail,
            orderedMenuItem.getItem_id(),
            orderedMenuItem.getItem_name(),
            orderedMenuItem.getPrice(),
            itemQuantity,
            totalAmount
        );

        try {
            orderRepository.save(newOrder);
            redirectAttributes.addFlashAttribute("orderMessage", "Your order #" + newOrderId + " has been placed successfully!");
        } catch (Exception e) {
            System.err.println("Error saving order: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "There was an error placing your order. Please try again.");
            return "redirect:/payment";
        }

        return "redirect:/payment";
    }

    @PostMapping("/placeOrderFromCart")
    public String placeOrderFromCart(HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("checkoutCart");

        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Cart is empty. Cannot place order.");
            return "redirect:/cart";
        }

        for (CartItem item : cart.values()) {
            String newOrderId = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            String dummyUser = "CartUser_" + newOrderId;
            String dummyEmail = "user_" + newOrderId.toLowerCase() + "@cart.com";

            Order newOrder = new Order(
                newOrderId,
                dummyUser,
                dummyEmail,
                item.getItem().getItem_id(),
                item.getItem().getItem_name(),
                item.getItem().getPrice(),
                item.getQuantity(),
                item.getItem().getPrice() * item.getQuantity()
            );

            orderRepository.save(newOrder);
        }

        session.removeAttribute("checkoutCart");
        session.removeAttribute("cart");
        redirectAttributes.addFlashAttribute("orderMessage", "Your cart order has been placed!");
        return "redirect:/payment";
    }
}
