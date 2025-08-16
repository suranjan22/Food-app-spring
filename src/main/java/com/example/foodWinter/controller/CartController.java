package com.example.foodWinter.controller;

import com.example.foodWinter.dao.modelDao;
import com.example.foodWinter.model.CartItem;
import com.example.foodWinter.model.menuModel;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
public class CartController {

    @Autowired
    private modelDao menuDao;

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("itemId") String itemId,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session,
                            Model model) {

        Optional<menuModel> itemOptional = menuDao.findById(itemId);
        if (itemOptional.isEmpty()) {
            model.addAttribute("error", "Item not found");
            return "redirect:/menu";
        }

        menuModel item = itemOptional.get();

        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new HashMap<>();

        if (cart.containsKey(itemId)) {
            CartItem existing = cart.get(itemId);
            existing.setQuantity(existing.getQuantity() + quantity);
        } else {
            cart.put(itemId, new CartItem(item, quantity));
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String viewCart(Model model, HttpSession session) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        model.addAttribute("cart", cart != null ? cart.values() : null);
        return "cart";
    }

    @GetMapping("/cart/remove")
    public String removeFromCart(@RequestParam("itemId") String itemId, HttpSession session) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart != null) cart.remove(itemId);
        return "redirect:/cart";
    }

    @PostMapping("/cart/checkout")
    public String proceedToPayment(HttpSession session, RedirectAttributes redirectAttributes) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Your cart is empty!");
            return "redirect:/cart";
        }

        session.setAttribute("checkoutCart", new HashMap<>(cart));
        return "redirect:/payment";
    }
}
