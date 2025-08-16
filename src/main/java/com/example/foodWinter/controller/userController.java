package com.example.foodWinter.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class userController {

    @RequestMapping("/home")
    public String index()
    {
        return "index";
    }
    @RequestMapping("/menu")
    public String menu()
    {
        return "menu";
    }
    
    @RequestMapping("/payment")
    public String payment()
    {
        return "payment";
    }
    
   
   
    
    @RequestMapping("/contact")
    public String contact()
    {
        return "contact";
    }
    
    @RequestMapping("/business")
    public String business()
    {
        return "restro_signup";
        
       
    }
    
    @RequestMapping("/login")
    public String login()
    {
        return "login";
        
       
    }
    
    @RequestMapping("/signup")
    public String signup()
    {
        return "signup";
        
       
    }
    
}


