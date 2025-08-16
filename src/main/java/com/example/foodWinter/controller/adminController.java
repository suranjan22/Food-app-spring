package com.example.foodWinter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class adminController {
	 @RequestMapping("/dashboard")
	    public String dashboard()
	    {
	        return "DSH_index";
	        
	       
	    }
	 @RequestMapping("/addmenu")
	    public String addmenu()
	    {
	        return "add-menu";
	        
	       
	    }
	 
	 /* @RequestMapping("/viewmenu")
	    public String viewmenu()
	    {
	        return "view-menu";
	        
	       
	    }*/
	 
	 @RequestMapping("/vieworder")
	    public String vieworder()
	    {
	        return "view-order";
	        
	       
	    }
	/* @RequestMapping("/viewfeedback")
	    public String viewfeedback()
	    {
	        return "view-feedback";
	        */
	       
	    
	 @RequestMapping("/restrologin")
	    public String restrologin()
	    {
	        return "restro_login";
	        
	       
	    }
	 @RequestMapping("/restrosignup")
	    public String restrosignup()
	    {
	        return "restro_signup";
	        
	       
	    }

}