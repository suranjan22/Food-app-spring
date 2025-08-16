package com.example.foodWinter.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption; // Added for robust file copying
import java.util.List;
import java.util.Optional;
import java.util.UUID; // For generating unique file names
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile; // Important for file uploads
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.foodWinter.dao.modelDao;
import com.example.foodWinter.model.menuModel;

@Controller
public class menuController {
    @Autowired
    modelDao mi;

    // Define the directory where images will be stored
    // For simplicity, using a relative path here (inside src/main/resources/static).
    // In production, strongly consider an absolute path outside the WAR/JAR
    // (e.g., /opt/app/uploads/images/menu_items/ or C:/appdata/uploads/images/menu_items/)
    // and configure a ResourceHandler to serve static content from that location.
    private static final String UPLOAD_DIR = "src/main/resources/static/images/menu_items/";

    @RequestMapping("/add_menu")
    public String addItems(
            @RequestParam("itemId") String Itmid,
            @RequestParam("itemName") String itemname,
            @RequestParam("restaurantName") String restroname,
            @RequestParam("itemDescription") String itemdescription,
            @RequestParam("itemPrice") String price,
            @RequestParam("foodType") String foodtype,
            @RequestParam("category") String category,
            @RequestParam("itemImage") MultipartFile itemImage, // New parameter for the image file
            ModelMap model) {

        // FIX 1: Add a check for null or empty string for 'price' before parsing.
        double itemPrice = 0.0;
        if (price != null && !price.trim().isEmpty()) {
            try {
                itemPrice = Double.parseDouble(price);
            } catch (NumberFormatException e) {
                model.put("msg", "Invalid price format. Please enter a valid number.");
                return "add-menu";
            }
        } else {
            model.put("msg", "Item price is required.");
            return "add-menu";
        }


        menuModel menu = new menuModel();
        menu.setItem_id(Itmid);
        menu.setItem_name(itemname);
        menu.setRestro_name(restroname);
        menu.setItem_desc(itemdescription);
        menu.setPrice(itemPrice); // Use the parsed price
        menu.setFood_type(foodtype);
        menu.setCategory(category);

        // Handle image upload for add_menu
        if (itemImage != null && !itemImage.isEmpty()) { // Check if file is provided
            try {
                // Ensure the upload directory exists
                Path uploadPath = Paths.get(UPLOAD_DIR);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                    System.out.println("Created directory: " + uploadPath.toAbsolutePath()); // For debugging
                }

                // Generate a unique file name to prevent conflicts
                String originalFilename = itemImage.getOriginalFilename();
                // FIX 3: Check if originalFilename is null or empty before getting substring
                String fileExtension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                Path filePath = uploadPath.resolve(uniqueFileName);

                // Save the file to the server, overwriting if a file with the same name exists (though uniqueFileName should prevent this)
                Files.copy(itemImage.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                // Store the relative path to the image in the database
                // This path should be relative to your static content root configured in Spring
                menu.setItem_image("/images/menu_items/" + uniqueFileName);

            } catch (IOException e) {
                e.printStackTrace();
                // FIX 4: Provide more specific error message in logs for IOException
                System.err.println("Error saving image file during add menu: " + e.getMessage());
                model.put("msg", "Failed to upload image. Please check server logs for details.");
                return "add-menu"; // Stay on the add-menu page with an error
            }
        } else {
            // FIX 5: If an image is mandatory for new items, handle it here.
            // If the field is 'required=false' on the JSP, this block will be hit if no file selected.
            // If you want to allow items without images, remove this else block or set a default.
            model.put("msg", "Please select an image for the menu item.");
            return "add-menu"; // Stay on the add-menu page if no image
        }

        mi.save(menu);
        model.put("msg", "Item Added!");
        return "add-menu";
    }

    @RequestMapping("/viewmenu")
    public String getAllProduct(Model model) {
        List<menuModel> menu = mi.findAll();
        model.addAttribute("menu", menu);
        return "view-menu";
    }

    // UPDATED METHOD FOR THE PUBLIC MENU PAGE WITH SERVER-SIDE FILTERING
    @GetMapping("/menu")
    public String displayMenu(
            @RequestParam(name = "category", required = false) String categoryFilter, // Optional category parameter
            Model model) {

        List<menuModel> allMenuItems = mi.findAll(); // Fetch all items

        // If a category filter is provided and it's not "all" (case-insensitive)
        if (categoryFilter != null && !categoryFilter.trim().equalsIgnoreCase("all")) {
            String normalizedFilter = categoryFilter.trim().toLowerCase(); // Normalize filter string

            // Filter the list based on the category
            List<menuModel> filteredMenuItems = allMenuItems.stream()
                    .filter(item -> item.getCategory() != null && item.getCategory().trim().toLowerCase().equals(normalizedFilter))
                    .collect(Collectors.toList());
            model.addAttribute("allMenuItems", filteredMenuItems);
        } else {
            // If no filter or "all" is requested, display all items
            model.addAttribute("allMenuItems", allMenuItems);
        }

        // Add the current filter to the model so JSP can mark the active button
        model.addAttribute("currentCategoryFilter", categoryFilter != null ? categoryFilter.trim().toLowerCase() : "all");

        return "menu"; // Returns the menu.jsp page
    }

    // --- Update Operations ---

    // 1. Display the form with pre-filled data for update
    @GetMapping("/updateMenu")
    public String showUpdateForm(@RequestParam("itemId") String itemId, Model model) {
        Optional<menuModel> optionalMenu = mi.findById(itemId); // Assuming item ID is the primary key and String type
        if (optionalMenu.isPresent()) {
            menuModel menu = optionalMenu.get();
            model.addAttribute("menu", menu); // Add the existing menu item to the model
            return "update-menu"; // This will be your JSP page for updating a menu item
        } else {
            // Handle case where menu item is not found, e.g., redirect with an error message
            model.addAttribute("error", "Menu item not found for ID: " + itemId);
            return "redirect:/viewmenu"; // Redirect back to view menu or an error page
        }
    }


    // 2. Process the form submission for update
    @PostMapping("/updateMenu")
    public String updateItem(@ModelAttribute("menu") menuModel updatedMenu,
                             // This matches the 'name="item_image_file"' from your JSP
                             @RequestParam(value = "item_image_file", required = false) MultipartFile file,
                             RedirectAttributes redirectAttributes) {

        try {
            // Find the existing item by ID to get its current image path
            Optional<menuModel> existingMenuOptional = mi.findById(updatedMenu.getItem_id());

            if (existingMenuOptional.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Menu item with ID " + updatedMenu.getItem_id() + " not found!");
                return "redirect:/viewmenu";
            }

            menuModel existingMenu = existingMenuOptional.get();

            // Handle image update
            if (file != null && !file.isEmpty()) {
                // A new file has been uploaded. Delete the old one if it exists.
                if (existingMenu.getItem_image() != null && !existingMenu.getItem_image().isEmpty()) {
                    try {
                        // Extract filename from the stored path (e.g., /images/menu_items/unique_name.jpg)
                        String oldImageFileName = existingMenu.getItem_image().substring(existingMenu.getItem_image().lastIndexOf("/") + 1);
                        Path oldImagePath = Paths.get(UPLOAD_DIR).resolve(oldImageFileName);
                        if (Files.exists(oldImagePath)) {
                            Files.delete(oldImagePath);
                            System.out.println("Deleted old image: " + oldImagePath.toAbsolutePath());
                        } else {
                            System.out.println("Old image file not found at: " + oldImagePath.toAbsolutePath());
                        }
                    } catch (IOException e) {
                        System.err.println("Warning: Could not delete old image file for item " + updatedMenu.getItem_id() + ": " + e.getMessage());
                        // Log the error but continue with new upload
                    }
                }

                // Save the new image
                Path uploadPath = Paths.get(UPLOAD_DIR);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                    System.out.println("Created directory for update: " + uploadPath.toAbsolutePath());
                }

                String originalFilename = file.getOriginalFilename();
                String fileExtension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                Path filePath = uploadPath.resolve(uniqueFileName);

                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                // Update the image path in the menu model to the new file's path
                updatedMenu.setItem_image("/images/menu_items/" + uniqueFileName);

            } else {
                // No new file uploaded, so retain the existing image path from the database
                updatedMenu.setItem_image(existingMenu.getItem_image());
            }

            // Save the updated menu item. Spring Data JPA's save method will update if ID exists.
            mi.save(updatedMenu);
            redirectAttributes.addFlashAttribute("success", "Menu item updated successfully!");

        } catch (IOException e) {
            e.printStackTrace(); // Log the exception for debugging
            redirectAttributes.addFlashAttribute("error", "Failed to upload new image or update menu item: " + e.getMessage());
            return "redirect:/updateMenu?itemId=" + updatedMenu.getItem_id(); // Use itemId for redirect
        } catch (Exception e) { // Catch any other unexpected exceptions
            e.printStackTrace(); // Log other exceptions
            redirectAttributes.addFlashAttribute("error", "An error occurred while updating menu item: " + e.getMessage());
            return "redirect:/updateMenu?itemId=" + updatedMenu.getItem_id(); // Use itemId for redirect
        }

        return "redirect:/viewmenu"; // Redirect back to the view menu page after update
    }

    // --- Delete Operations ---

    @GetMapping("/deleteMenu/{itemId}") // Using @PathVariable for clean URLs
    public String deleteItem(@PathVariable("itemId") String itemId, RedirectAttributes redirectAttributes) {
        Optional<menuModel> optionalMenu = mi.findById(itemId); // Check if the item exists

        if (optionalMenu.isPresent()) {
            menuModel menuToDelete = optionalMenu.get();

            // Optional: Delete the actual image file from the server when deleting the menu item
            if (menuToDelete.getItem_image() != null && !menuToDelete.getItem_image().isEmpty()) {
                try {
                    // Extract filename from the stored path (e.g., /images/menu_items/unique_name.jpg)
                    String imageFileName = menuToDelete.getItem_image().substring(menuToDelete.getItem_image().lastIndexOf("/") + 1);
                    Path imagePath = Paths.get(UPLOAD_DIR).resolve(imageFileName);
                    if (Files.exists(imagePath)) {
                        Files.delete(imagePath);
                        System.out.println("Deleted image file: " + imagePath.toAbsolutePath()); // For debugging
                    } else {
                        System.out.println("Image file not found at: " + imagePath.toAbsolutePath());
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    // Log the error but don't prevent item deletion from DB
                    System.err.println("Failed to delete image file for item " + itemId + ": " + e.getMessage());
                }
            }

            mi.deleteById(itemId); // Delete by ID from the database
            redirectAttributes.addFlashAttribute("success", "Menu item deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Menu item with ID " + itemId + " not found!");
        }

        return "redirect:/viewmenu"; // Redirect back to the view menu page after deletion
    }

    // New method to get total menu item count (from previous request)
    public long getTotalMenuItems() {
        return mi.count();
    }
}