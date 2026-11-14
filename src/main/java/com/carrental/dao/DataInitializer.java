package com.carrental.dao;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.io.File;

/**
 * Initializes and seeds the XML data files (users.xml, cars.xml, bookings.xml)
 * if they do not exist or are empty.
 */
public class DataInitializer {

    public static synchronized void initialize() {
        initUsersFile();
        initCarsFile();
        initBookingsFile();
    }

    private static void initUsersFile() {
        File file = XmlUtil.getFile("users.xml");
        if (!file.exists() || file.length() < 20) {
            try {
                Document doc = XmlUtil.loadDocument("users.xml");
                Element root = doc.createElement("users");
                doc.appendChild(root);

                // Admin Account: admin@carrental.com / admin123
                Element admin = doc.createElement("user");
                XmlUtil.createChildElement(doc, admin, "id", "USR-ADMIN-1");
                XmlUtil.createChildElement(doc, admin, "name", "System Administrator");
                XmlUtil.createChildElement(doc, admin, "email", "admin@carrental.com");
                XmlUtil.createChildElement(doc, admin, "password", "admin123");
                XmlUtil.createChildElement(doc, admin, "phone", "+1 (555) 019-2834");
                XmlUtil.createChildElement(doc, admin, "address", "Fleet HQ, 100 Auto Boulevard, Suite 500, New York, NY");
                XmlUtil.createChildElement(doc, admin, "role", "ADMIN");
                XmlUtil.createChildElement(doc, admin, "createdAt", "2024-01-01 09:00:00");
                root.appendChild(admin);

                // Sample Customer 1: john@example.com / customer123
                Element cust1 = doc.createElement("user");
                XmlUtil.createChildElement(doc, cust1, "id", "USR-1001");
                XmlUtil.createChildElement(doc, cust1, "name", "John Anderson");
                XmlUtil.createChildElement(doc, cust1, "email", "john@example.com");
                XmlUtil.createChildElement(doc, cust1, "password", "customer123");
                XmlUtil.createChildElement(doc, cust1, "phone", "+1 (555) 782-9901");
                XmlUtil.createChildElement(doc, cust1, "address", "452 Lexington Ave, Apt 4B, New York, NY");
                XmlUtil.createChildElement(doc, cust1, "role", "CUSTOMER");
                XmlUtil.createChildElement(doc, cust1, "createdAt", "2024-02-15 14:20:00");
                root.appendChild(cust1);

                // Sample Customer 2: sarah@example.com / customer123
                Element cust2 = doc.createElement("user");
                XmlUtil.createChildElement(doc, cust2, "id", "USR-1002");
                XmlUtil.createChildElement(doc, cust2, "name", "Sarah Connor");
                XmlUtil.createChildElement(doc, cust2, "email", "sarah@example.com");
                XmlUtil.createChildElement(doc, cust2, "password", "customer123");
                XmlUtil.createChildElement(doc, cust2, "phone", "+1 (555) 438-1122");
                XmlUtil.createChildElement(doc, cust2, "address", "784 Sunset Blvd, Los Angeles, CA");
                XmlUtil.createChildElement(doc, cust2, "role", "CUSTOMER");
                XmlUtil.createChildElement(doc, cust2, "createdAt", "2024-03-10 11:45:00");
                root.appendChild(cust2);

                XmlUtil.saveDocument(doc, "users.xml");
                System.out.println("[DataInitializer] users.xml seeded successfully.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static void initCarsFile() {
        File file = XmlUtil.getFile("cars.xml");
        if (!file.exists() || file.length() < 20) {
            try {
                Document doc = XmlUtil.loadDocument("cars.xml");
                Element root = doc.createElement("cars");
                doc.appendChild(root);

                addCarElement(doc, root, "CAR-101", "Mercedes-Benz", "S-Class Maybach S580", "Luxury",
                        2024, 280.0, 5, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=1200&q=80",
                        "The pinnacle of automotive luxury with executive rear seating, Burmester 4D surround sound, and silky V8 twin-turbo performance.",
                        "Executive Seating, MBUX Infotainment, Burmester 4D Sound, Soft-Close Doors, Heated Massage Seats",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-102", "BMW", "M4 Competition Coupe", "Sports",
                        2024, 220.0, 4, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&w=1200&q=80",
                        "503 horsepower twin-turbo inline-6 engineered for motorsport agility and aggressive track-ready styling.",
                        "M Carbon Bucket Seats, Carbon Ceramic Brakes, Head-Up Display, Adaptive M Suspension, Harman Kardon Sound",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-103", "Audi", "RS6 Avant Performance", "Sports",
                        2024, 240.0, 5, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?auto=format&fit=crop&w=1200&q=80",
                        "The super-wagon with an explosive 4.0L twin-turbo V8, quattro all-wheel drive, and generous family cargo space.",
                        "Quattro All-Wheel Drive, Dynamic Ride Control, Panoramic Sunroof, Bang & Olufsen 3D Sound, Virtual Cockpit",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-104", "Porsche", "911 Carrera GTS", "Sports",
                        2024, 320.0, 2, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=1200&q=80",
                        "Iconic rear-engine balance, twin-turbo boxer engine, and unmatched steering feedback for an exhilarating journey.",
                        "Sport Chrono Package, PASM Sport Suspension, PSE Sport Exhaust, Apple CarPlay, Alcantara Interior",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-105", "Tesla", "Model S Plaid", "Electric",
                        2024, 195.0, 5, "Electric", "Automatic",
                        "https://images.unsplash.com/photo-1617788138017-80ad40651399?auto=format&fit=crop&w=1200&q=80",
                        "Tri-motor all-wheel drive generating 1,020 HP with 0-60 mph in 1.99s, premium yoke steering, and cutting-edge Autopilot.",
                        "Tri-Motor AWD, Full Self-Driving Capability, 17-inch Cinematic Display, Gaming Computer, Glass Roof",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-106", "Land Rover", "Range Rover Autobiography", "SUV",
                        2024, 260.0, 7, "Diesel", "Automatic",
                        "https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80",
                        "Supreme off-road mastery blended with bespoke British craftsmanship, floating electronic air suspension, and whisper-quiet cabin.",
                        "Terrain Response 2, Meridian Signature Audio, 360-degree 3D Surround Camera, All-Wheel Steering, Refrigerator Compartment",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-107", "Mercedes-Benz", "G-Class AMG G63", "SUV",
                        2024, 350.0, 5, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1520031441872-265e4ff70366?auto=format&fit=crop&w=1200&q=80",
                        "The legendary G-Wagon featuring a handcrafted 577-hp biturbo V8, triple locking differentials, and unmistakable road presence.",
                        "AMG Performance Exhaust, Nappa Leather Interior, Triple Locking Differentials, Burmester Sound, 22-inch Forged Wheels",
                        "AVAILABLE");

                addCarElement(doc, root, "CAR-108", "BMW", "5 Series 530i M Sport", "Sedan",
                        2024, 140.0, 5, "Petrol", "Automatic",
                        "https://images.unsplash.com/photo-1523983388277-336a66bf9bcd?auto=format&fit=crop&w=1200&q=80",
                        "Elegant executive saloon offering remarkable fuel efficiency, silky smooth cruising, and intuitive voice commands.",
                        "Live Cockpit Professional, Driving Assistant Pro, Ambient Lighting, Wireless Charging, Parking Assistant",
                        "AVAILABLE");

                XmlUtil.saveDocument(doc, "cars.xml");
                System.out.println("[DataInitializer] cars.xml seeded successfully.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static void addCarElement(Document doc, Element root, String id, String brand, String model,
                                      String category, int year, double pricePerDay, int seats,
                                      String fuelType, String transmission, String imageUrl,
                                      String description, String features, String status) {
        Element car = doc.createElement("car");
        XmlUtil.createChildElement(doc, car, "id", id);
        XmlUtil.createChildElement(doc, car, "brand", brand);
        XmlUtil.createChildElement(doc, car, "model", model);
        XmlUtil.createChildElement(doc, car, "category", category);
        XmlUtil.createChildElement(doc, car, "year", String.valueOf(year));
        XmlUtil.createChildElement(doc, car, "pricePerDay", String.valueOf(pricePerDay));
        XmlUtil.createChildElement(doc, car, "seats", String.valueOf(seats));
        XmlUtil.createChildElement(doc, car, "fuelType", fuelType);
        XmlUtil.createChildElement(doc, car, "transmission", transmission);
        XmlUtil.createChildElement(doc, car, "imageUrl", imageUrl);
        XmlUtil.createChildElement(doc, car, "description", description);
        XmlUtil.createChildElement(doc, car, "features", features);
        XmlUtil.createChildElement(doc, car, "status", status);
        root.appendChild(car);
    }

    private static void initBookingsFile() {
        File file = XmlUtil.getFile("bookings.xml");
        if (!file.exists() || file.length() < 20) {
            try {
                Document doc = XmlUtil.loadDocument("bookings.xml");
                Element root = doc.createElement("bookings");
                doc.appendChild(root);

                // Sample Initial Booking for demonstration
                Element booking = doc.createElement("booking");
                XmlUtil.createChildElement(doc, booking, "id", "BK-1001");
                XmlUtil.createChildElement(doc, booking, "bookingReference", "CR-2024-8841");
                XmlUtil.createChildElement(doc, booking, "userId", "USR-1001");
                XmlUtil.createChildElement(doc, booking, "carId", "CAR-101");
                XmlUtil.createChildElement(doc, booking, "userFullName", "John Anderson");
                XmlUtil.createChildElement(doc, booking, "userEmail", "john@example.com");
                XmlUtil.createChildElement(doc, booking, "carTitle", "Mercedes-Benz S-Class Maybach S580");
                XmlUtil.createChildElement(doc, booking, "carImageUrl", "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=1200&q=80");
                XmlUtil.createChildElement(doc, booking, "pickupDate", "2024-12-01");
                XmlUtil.createChildElement(doc, booking, "returnDate", "2024-12-05");
                XmlUtil.createChildElement(doc, booking, "pickupLocation", "JFK International Airport (JFK), New York");
                XmlUtil.createChildElement(doc, booking, "returnLocation", "Manhattan Downtown Center, New York");
                XmlUtil.createChildElement(doc, booking, "totalDays", "4");
                XmlUtil.createChildElement(doc, booking, "pricePerDay", "280.0");
                XmlUtil.createChildElement(doc, booking, "totalPrice", "1120.0");
                XmlUtil.createChildElement(doc, booking, "status", "APPROVED");
                XmlUtil.createChildElement(doc, booking, "bookingDate", "2024-11-20 10:15:30");
                XmlUtil.createChildElement(doc, booking, "specialRequests", "Child safety seat requested in rear right seat.");
                root.appendChild(booking);

                XmlUtil.saveDocument(doc, "bookings.xml");
                System.out.println("[DataInitializer] bookings.xml seeded successfully.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

