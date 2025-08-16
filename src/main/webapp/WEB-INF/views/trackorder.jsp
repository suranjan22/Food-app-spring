<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery Tracking</title>
    <style>
        /* All CSS for trackorder.jsp */

        /* General Layout & Colors */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: #f0f2f5; /* Light background */
            color: #333;
        }

        .container-with-sidebar {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #34495e; /* Darker blue-gray */
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            z-index: 1000; /* Ensure sidebar is above other content */
            position: sticky;
            top: 0;
            height: 100vh; /* Full height */
        }

        .sidebar .logo {
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.8em;
            font-weight: bold;
            color: #ecf0f1; /* Lighter text for logo */
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar ul li {
            margin-bottom: 15px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #2c3e50; /* Slightly darker on hover/active */
        }

        /* Mobile Header and Hamburger */
        .mobile-header {
            display: none; /* Hidden by default on larger screens */
            background-color: #34495e;
            color: white;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .hamburger {
            font-size: 2em;
            cursor: pointer;
        }

        .overlay {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999; /* Below sidebar, above main content */
        }

        .overlay.active {
            display: block;
        }

        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #f0f2f5;
        }


        /* Specific styles for trackorder.jsp */

        /* General layout for track order container */
        .track-order-container {
            max-width: 900px;
            margin: 20px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .track-order-container .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .track-order-container .header h1 {
            font-size: 2.2em;
            color: #333;
            margin-bottom: 10px;
        }

        .track-order-container .header p {
            font-size: 1.1em;
            color: #666;
        }

        #delivery-time {
            font-weight: bold;
            color: #ff5722; /* Accent color */
        }

        .order-info {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #eee;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .order-info .restaurant,
        .order-info .delivery-address {
            display: flex;
            align-items: center;
            gap: 15px;
            flex: 1;
            min-width: 280px; /* Ensure they don't get too small */
        }

        .order-info .icon {
            font-size: 2.5em;
            color: #4CAF50; /* Green for restaurant/address */
            background-color: #e8f5e9;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .order-info .details h3 {
            margin: 0;
            font-size: 1.3em;
            color: #333;
        }

        .order-info .details p {
            margin: 5px 0 0;
            color: #777;
            font-size: 0.95em;
        }

        /* Progress Bar */
        .progress-bar {
            width: 100%;
            height: 10px;
            background-color: #e0e0e0;
            border-radius: 5px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .progress {
            height: 100%;
            width: 0%;
            background-color: #ff5722; /* Accent color for progress */
            border-radius: 5px;
            transition: width 1s ease-in-out;
        }

        .status-text {
            text-align: center;
            font-size: 1.4em;
            font-weight: bold;
            color: #333;
            margin-bottom: 30px;
        }

        /* Live Map - Dummy Implementation */
        .live-map {
            position: relative;
            width: 100%;
            height: 350px;
            background-color: #e6e6e6; /* Base map color */
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 30px;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.05);
            background-image:
                linear-gradient(rgba(0,0,0,0.05) 1px, transparent 1px), /* Grid lines */
                linear-gradient(90deg, rgba(0,0,0,0.05) 1px, transparent 1px);
            background-size: 20px 20px; /* Adjust grid size */
        }

        /* Dummy black path overlay for the map */
        .live-map::before { /* Road-like background lines */
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* Simulate a black path similar to a GPS route */
            background-image:
                linear-gradient(-45deg, transparent 48%, black 48%, black 52%, transparent 52%),
                linear-gradient(45deg, transparent 48%, black 48%, black 52%, transparent 52%),
                linear-gradient(90deg, transparent 48%, black 48%, black 52%, transparent 52%); /* A straight line as fallback */
            background-size: 100% 100%;
            opacity: 0.4; /* Make it slightly transparent */
            z-index: 1; /* Below markers */
        }


        .map-marker {
            position: absolute;
            font-size: 2em;
            padding: 5px;
            background-color: white;
            border: 2px solid;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 45px;
            height: 45px;
            transform: translate(-50%, -50%); /* Center the marker */
            z-index: 10;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .restaurant-marker {
            top: 20%;
            left: 20%;
            border-color: #4CAF50; /* Green */
            color: #4CAF50;
        }

        .home-marker {
            top: 80%;
            left: 80%;
            border-color: #007bff; /* Blue */
            color: #007bff;
        }

        #delivery-marker {
            top: 20%; /* Start at restaurant */
            left: 20%;
            border-color: #ff5722; /* Orange for delivery */
            color: #ff5722;
            transition: all 30s linear; /* Default transition, overridden by animation */
            animation-fill-mode: forwards; /* Keep the last state of animation */
        }

        /* Animation Keyframes for Delivery Partner */
        /* These define the "path" of the dummy marker */
        @keyframes move-to-restaurant {
            from { top: 20%; left: 20%; } /* Restaurant initial position */
            to { top: 20%; left: 20%; } /* No actual movement here, just setting up */
        }

        @keyframes move-from-restaurant {
            from { top: 20%; left: 20%; }
            to { top: 50%; left: 50%; } /* Example mid-point */
        }

        @keyframes move-to-home {
            from { top: 50%; left: 50%; } /* Start from mid-point */
            to { top: 80%; left: 80%; } /* End at home position */
        }

        @keyframes at-home {
            from { top: 80%; left: 80%; }
            to { top: 80%; left: 80%; }
        }

        /* Apply animations dynamically via JS */
        #delivery-marker.move-to-restaurant {
            animation: move-to-restaurant 1s forwards; /* Instant jump to restaurant */
        }
        #delivery-marker.move-from-restaurant {
            animation: move-from-restaurant 8s linear forwards; /* Smooth travel */
        }
        #delivery-marker.move-to-home {
            animation: move-to-home 10s linear forwards; /* Smooth travel to home */
        }
        #delivery-marker.at-home {
            animation: at-home 1s forwards; /* Stay at home */
        }


        /* Map Text */
        #map-text {
            position: relative; /* Changed from absolute to relative to align with map div */
            bottom: 15px; /* Adjust as needed */
            left: 50%;
            transform: translateX(-50%);
            background-color: rgba(255, 255, 255, 0.9);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            color: #555;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            z-index: 10;
            width: fit-content; /* Ensure it wraps nicely */
            white-space: nowrap; /* Prevent breaking line */
            margin-top: -30px; /* Adjust to move it slightly up over the map */
        }


        /* Timeline */
        .timeline {
            position: relative;
            padding: 20px 0;
            margin-bottom: 30px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 50px; /* Adjust to align with icons */
            top: 0;
            bottom: 0;
            width: 4px;
            background-color: #e0e0e0;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
            position: relative;
        }

        .timeline-icon {
            width: 40px;
            height: 40px;
            min-width: 40px; /* Prevent shrinking */
            border-radius: 50%;
            background-color: #ccc;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.1em;
            margin-right: 20px;
            z-index: 1;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .timeline-icon.active {
            background-color: #ff5722; /* Accent color */
            transform: scale(1.1);
        }

        .timeline-icon.delivered {
            background-color: #4CAF50; /* Green for delivered */
        }


        .timeline-content h3 {
            margin: 0;
            font-size: 1.2em;
            color: #333;
        }

        .timeline-content .time {
            font-size: 0.9em;
            color: #888;
            margin-top: 5px;
        }

        .timeline-content p {
            font-size: 0.95em;
            color: #666;
            margin-top: 8px;
        }

        /* Delivery Person Info */
        .delivery-person {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 20px;
            background-color: #f0f8ff; /* Light blue background */
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .delivery-person img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ff5722; /* Accent border */
            flex-shrink: 0;
        }

        .delivery-person .person-info h4 {
            margin: 0;
            font-size: 1.4em;
            color: #333;
        }

        .delivery-person .person-info p {
            margin: 5px 0;
            color: #555;
            font-size: 1em;
        }

        .delivery-person .rating {
            color: #ffc107; /* Gold for stars */
            font-size: 1.1em;
            font-weight: bold;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .order-info {
                flex-direction: column;
                align-items: center;
            }
            .timeline::before {
                left: 20px;
            }
            .timeline-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .timeline-icon {
                margin-left: 0;
                margin-bottom: 10px;
            }
            .delivery-person {
                flex-direction: column;
                text-align: center;
            }
            .sidebar {
                position: fixed;
                left: -250px; /* Hide off-screen */
                height: 100vh;
                transition: left 0.3s ease;
            }

            .sidebar.active {
                left: 0; /* Slide in */
            }

            .mobile-header {
                display: block; /* Show hamburger menu */
            }

            .main-content {
                padding: 15px; /* Reduce padding on small screens */
            }
        }
    </style>
</head>
<body>
    <div class="container-with-sidebar">
        <aside class="sidebar" id="sidebar">
            <h2 class="logo">GharKaZaiqa</h2>
            <ul>
                <li><a href="\home">Home</a></li>
                <li><a href="\menu">Menu</a></li>
                <li><a href="\cart">🛒 Cart</a></li>
                <li><a href="\track">Track order</a></li>
                <li><a href="\contact">Contact Us</a></li>
                <li><a href="\restrosignup">Business</a></li>
            </ul>
        </aside>

        <div class="overlay" id="overlay"></div>

        <div class="main-content">
            <header class="mobile-header">
                <div class="hamburger" id="hamburger">☰</div>
            </header>

            <div class="track-order-container">
                <div class="header">
                    <h1>Track Your Order</h1>
                    <p>Estimated delivery: <span id="delivery-time">Calculating...</span></p>
                </div>

                <div class="order-info">
                    <div class="restaurant">
                        <div class="icon">🍴</div>
                        <div class="details">
                            <h3>The Spice Route</h3>
                            <p>123, Park Street, Kolkata - 700016</p>
                        </div>
                    </div>

                    <div class="delivery-address">
                        <div class="icon">🏠</div>
                        <div class="details">
                            <h3>Delivery Address</h3>
                            <p>45/B, Loudon Street, Kolkata - 700017</p>
                        </div>
                    </div>
                </div>

                <div class="progress-bar">
                    <div class="progress" id="progress-bar-fill"></div>
                </div>

                <div class="status-text" id="status-text">Initializing Tracking...</div>

                <%-- Dummy Live Map Section --%>
                <div class="live-map" id="live-map">
                    <div class="map-marker restaurant-marker" title="Restaurant">🍴</div>
                    <div class="map-marker" id="delivery-marker" title="Delivery Partner">🚴</div>
                    <div class="map-marker home-marker" title="Your Location">🏠</div>
                </div>
                <div id="map-text">Locating delivery partner...</div>


                <div class="timeline">
                    <div class="timeline-item" id="step-0">
                        <div class="timeline-icon">1</div>
                        <div class="timeline-content">
                            <h3>Order Placed</h3>
                            <p class="time" id="time-0"></p>
                            <p>Your order has been received by the restaurant</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-1">
                        <div class="timeline-icon">2</div>
                        <div class="timeline-content">
                            <h3>Order Being Prepared</h3>
                            <p class="time" id="time-1"></p>
                            <p>Restaurant is preparing your food</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-2">
                        <div class="timeline-icon">3</div>
                        <div class="timeline-content">
                            <h3>Order Ready for Pickup</h3>
                            <p class="time" id="time-2"></p>
                            <p>Your order is packed and hot!</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-3">
                        <div class="timeline-icon">4</div>
                        <div class="timeline-content">
                            <h3>Delivery Partner Assigned</h3>
                            <p class="time" id="time-3"></p>
                            <p>Rahul is on his way to the restaurant.</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-4">
                        <div class="timeline-icon">5</div>
                        <div class="timeline-content">
                            <h3>Order Picked Up</h3>
                            <p class="time" id="time-4"></p>
                            <p>Your order is with Rahul!</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-5">
                        <div class="timeline-icon">6</div>
                        <div class="timeline-content">
                            <h3>On the Way</h3>
                            <p class="time" id="time-5"></p>
                            <p>Delivery partner is heading to your location</p>
                        </div>
                    </div>
                    <div class="timeline-item" id="step-6">
                        <div class="timeline-icon">7</div>
                        <div class="timeline-content">
                            <h3>Order Delivered</h3>
                            <p class="time" id="time-6"></p>
                            <p>Enjoy your meal!</p>
                        </div>
                    </div>
                </div>

                <div class="delivery-person">
                    <img src="" alt="Delivery Person">
                    <div class="person-info">
                        <h4>Rahul (Delivery Partner)</h4>
                        <p>+91 XXXXXXX123</p>
                        <div class="rating">★★★★☆ 4.8</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Sidebar Toggle Logic
        const sidebar = document.getElementById('sidebar');
        const hamburger = document.getElementById('hamburger');
        const overlay = document.getElementById('overlay');

        function toggleSidebar() {
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            document.body.classList.toggle('no-scroll');
        }

        if (hamburger) {
            hamburger.addEventListener('click', toggleSidebar);
        }
        if (overlay) {
            overlay.addEventListener('click', toggleSidebar);
        }

        // --- Dummy Order Tracking with Animation ---

        const progressBarFill = document.getElementById('progress-bar-fill');
        const statusText = document.getElementById('status-text');
        const deliveryMarker = document.getElementById('delivery-marker'); // Re-selecting for dummy map
        const mapText = document.getElementById('map-text');
        const deliveryTimeSpan = document.getElementById('delivery-time');

        // Define tracking steps with more details for creative updates
        const trackingSteps = [
            { id: 'step-0', status: 'Order Placed', delay: 0, mapMsg: 'Order received by restaurant.' },
            { id: 'step-1', status: 'Order Being Prepared', delay: 4000, mapMsg: 'Chef cooking up your delicious meal!' },
            { id: 'step-2', status: 'Order Ready for Pickup', delay: 8000, mapMsg: 'Food is packed and hot!' },
            { id: 'step-3', status: 'Delivery Partner Assigned', delay: 12000, mapMsg: 'Rahul is on his way to the restaurant.', markerClass: 'move-to-restaurant' },
            { id: 'step-4', status: 'Order Picked Up', delay: 16000, mapMsg: 'Your order is with Rahul!', markerClass: 'move-from-restaurant' },
            { id: 'step-5', status: 'On the Way', delay: 20000, mapMsg: 'Delivery partner is heading to your location', markerClass: 'move-to-home' },
            { id: 'step-6', status: 'Order Delivered', delay: 30000, mapMsg: 'Enjoy your meal!', markerClass: 'at-home' }
        ];

        let currentStepIndex = 0;
        let startTime = new Date(); // To calculate dynamic times

        function formatTime(date) {
            let hours = date.getHours();
            let minutes = date.getMinutes();
            let ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            return hours + ':' + minutes + ' ' + ampm;
        }

        function updateTracking() {
            if (currentStepIndex < trackingSteps.length) {
                const step = trackingSteps[currentStepIndex];
                const stepElement = document.getElementById(step.id);
                const icon = stepElement.querySelector('.timeline-icon');
                const timeSpan = stepElement.querySelector('.time');

                // Activate current and previous icons
                for (let i = 0; i <= currentStepIndex; i++) {
                    document.getElementById(trackingSteps[i].id).querySelector('.timeline-icon').classList.add('active');
                }

                // Set current status text and map message
                statusText.textContent = step.status;
                mapText.textContent = step.mapMsg;

                // Update time on timeline step
                let stepTime = new Date(startTime.getTime() + step.delay);
                timeSpan.textContent = formatTime(stepTime);

                // Progress bar update
                progressBarFill.style.width = `${(currentStepIndex + 1) * (100 / trackingSteps.length)}%`;

                // Delivery Marker Animation (using CSS classes)
                if (deliveryMarker && step.markerClass) {
                    // Remove all previous animation classes
                    deliveryMarker.classList.remove('move-to-restaurant', 'move-from-restaurant', 'move-to-home', 'at-home');
                    // Add the new animation class for the current step
                    deliveryMarker.classList.add(step.markerClass);
                }

                if (currentStepIndex === trackingSteps.length - 1) {
                    // Final step: Order Delivered
                    icon.classList.remove('active');
                    icon.classList.add('delivered');
                    deliveryTimeSpan.textContent = formatTime(stepTime); // Set final delivery time
                } else {
                    // Update estimated delivery time for future steps
                    let estimatedDelivery = new Date(startTime.getTime() + trackingSteps[trackingSteps.length - 1].delay);
                    deliveryTimeSpan.textContent = formatTime(estimatedDelivery);
                }

                currentStepIndex++;
                // Schedule the next update based on the delay between current and next step
                setTimeout(updateTracking, currentStepIndex < trackingSteps.length ? trackingSteps[currentStepIndex].delay - trackingSteps[currentStepIndex - 1].delay : 0);
            }
        }

        // Start animation after a short delay when the DOM is ready
        document.addEventListener('DOMContentLoaded', () => {
            updateTracking(); // Start the first step immediately
        });
    </script>
</body>
</html>