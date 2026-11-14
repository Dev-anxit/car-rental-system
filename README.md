# Apex Drive - Car Rental Management System

A complete, enterprise-grade, fully functional Car Rental Management System built using **Pure Java Servlets (Java EE / Jakarta)**, **JSP**, **HTML5**, **CSS3**, **JavaScript**, and **XML** for data persistence (utilizing the W3C DOM API).

Designed following the strict **MVC (Model-View-Controller)** architectural pattern without external heavyweight frameworks like Spring Boot or Node.js.

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Technology Stack](#2-technology-stack)
3. [Key Features](#3-key-features)
4. [Architecture & Concurrency Model](#4-architecture--concurrency-model)
5. [Complete Project Folder Structure](#5-complete-project-folder-structure)
6. [XML Data Store Design](#6-xml-data-store-design)
7. [Step-by-Step Setup & Execution](#7-step-by-step-setup--execution)
   - [Method A: Standalone Maven & Tomcat Deploy](#method-a-standalone-maven--tomcat-deploy)
   - [Method B: Running in IntelliJ IDEA](#method-b-running-in-intellij-idea)
   - [Method C: Running in Eclipse IDE](#method-c-running-in-eclipse-ide)
8. [Sample Credentials](#8-sample-credentials)
9. [Interaction Flow (Servlets, JSP, and XML)](#9-interaction-flow-servlets-jsp-and-xml)
10. [Testing Instructions](#10-testing-instructions)

---

## 1. Project Overview
Apex Drive is a web application designed for car rental agencies. It provides an intuitive, high-performance customer experience for browsing, filtering, inspecting, and reserving vehicles, while offering an administrative command center for managing fleet assets, processing rental requests, monitoring customer metrics, and reviewing revenue statistics.

---

## 2. Technology Stack
- **Backend:** Core Java (JDK 17 or compatible version like JDK 21/25), Java Servlets 4.0 (MVC Architecture)
- **Frontend:** JSP (JavaServer Pages), JSTL 1.2, HTML5, CSS3, Vanilla ES6 JavaScript
- **Data Persistence:** XML Documents (`users.xml`, `cars.xml`, `bookings.xml`) manipulated via Java W3C DOM API (`DocumentBuilder`, `Transformer`)
- **Server:** Apache Tomcat 9.x (also compatible with Tomcat 10+ via standard migration tool)
- **Build Tool:** Apache Maven (with integrated Maven Wrapper `./mvnw`)
- **Testing:** JUnit 5 (Surefire test runner)

---

## 3. Key Features

### Customer Features
1. **User Registration & Login:** Form validation, duplicate email protection, and secure SHA-256 password hashing.
2. **Session Management:** Secure HTTP session authentication with automatic redirection to requested pages upon sign-in.
3. **Browse Available Fleet:** Visual vehicle cards featuring brand, model, daily rental rate, specifications, and availability badges.
4. **Search & Multi-Criteria Filtering:** Filter cars simultaneously by search keyword, body category (Sedan, SUV, Luxury, Sports, Electric), transmission, fuel type, and maximum price slider.
5. **Detailed Vehicle Specifications:** High-resolution image view, passenger capacity, engine/fuel type, transmission, warranty highlights, and category-based recommendations.
6. **Date Range Validation & Conflict Prevention:** Real-time date calculator prevents picking past dates or invalid return dates.
7. **Overlapping Booking Prevention (Double-Booking Prevention):** Atomic checks verify that no existing active booking overlaps with the requested rental schedule (`requestedStart <= existingEnd && existingStart <= requestedEnd`).
8. **Dynamic Pricing Engine:** Calculates total duration (in days) and multiplies by the vehicle's daily rate with full itemized invoice breakdown.
9. **Personal Customer Dashboard ("My Bookings"):** Tracks pending, approved, completed, and cancelled reservations.
10. **Cancellation & Receipts:** Instant cancellation of pending/approved rentals, plus a printable official invoice/receipt with a print-optimized CSS layout.

### Administrator Features
1. **Executive Analytics Dashboard:**
   - Total Fleet Count (Available vs. In-Maintenance)
   - Total Registered Customer Accounts
   - Active & Pending Reservations
   - Total Realized Lifetime Revenue ($)
   - Recent Reservation Feed with quick-action approvals
2. **Fleet Management (CRUD):**
   - **Add Vehicle:** Input manufacturer, model, category, year, daily rate, seating capacity, fuel type, transmission, photo URL, description, and key features.
   - **Edit Vehicle:** Modify specifications, adjust pricing, or update photos.
   - **Delete Vehicle:** Protected deletion (verifies whether active bookings exist before allowing deletion).
   - **Toggle Availability:** Quickly mark vehicles as `AVAILABLE` or `MAINTENANCE`.
3. **Rental Booking Management:**
   - Filter bookings by status: `ALL`, `PENDING`, `APPROVED`, `COMPLETED`, `REJECTED`, `CANCELLED`.
   - Action controls: One-click Approve, Reject, Complete, or Cancel.
4. **Customer Directory:**
   - Inspect all registered customer profiles.
   - Tracks total bookings made and total revenue generated per customer.
5. **Role-Based Access Control (RBAC):**
   - Protected through `AuthFilter`. Regular customers attempting to access `/admin/*` are rejected with `403 Access Denied`.

---

## 4. Architecture & Concurrency Model

The application follows the classic Model-View-Controller (MVC) architectural pattern:

```
[ Browser / Client ]
        │  ▲
        │  │ HTTP Request / Response (HTML/CSS/JS)
        ▼  │
  [ Controller ]  (Java Servlets: AuthServlet, CarServlet, BookingServlet, AdminServlets)
        │  ▲
        │  │ Invokes business logic / returns domain models
        ▼  │
    [ Service ]   (AuthService, CarService, BookingService - validation, conflict check, pricing)
        │  ▲
        │  │ Data queries & persistence commands
        ▼  │
      [ DAO ]     (UserDAO, CarDAO, BookingDAO)
        │  ▲
        │  │ W3C DOM Builder & Transformer with ReentrantReadWriteLock
        ▼  │
 [ XML Data Files ] (users.xml, cars.xml, bookings.xml)
```

### Thread Safety & Concurrency
- `XmlUtil.java` uses a `java.util.concurrent.locks.ReentrantReadWriteLock`.
- Read operations (`loadDocument`) acquire a **Read Lock**, allowing concurrent reads.
- Mutative operations (`saveDocument`) acquire a **Write Lock**, guaranteeing exclusive thread access during XML file writes.
- File writes are executed with UTF-8 encoding and indented output (`indent-amount: 4`).

---

## 5. Complete Project Folder Structure

```
Car Rental System/
├── pom.xml                               # Maven project configuration & dependencies
├── README.md                             # Comprehensive project documentation
├── mvnw                                  # Maven Wrapper executable (macOS/Linux)
├── mvnw.cmd                              # Maven Wrapper executable (Windows)
├── .mvn/
│   └── wrapper/
│       └── maven-wrapper.properties      # Maven Wrapper distribution settings
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── carrental/
│   │   │           ├── model/
│   │   │           │   ├── User.java              # Customer & Admin user model
│   │   │           │   ├── Car.java               # Fleet vehicle model
│   │   │           │   └── Booking.java           # Rental reservation model
│   │   │           ├── dao/
│   │   │           │   ├── XmlUtil.java           # Thread-safe XML DOM parser & Transformer
│   │   │           │   ├── DataInitializer.java   # Auto-seeds default XML files if empty
│   │   │           │   ├── UserDAO.java           # User XML CRUD & authentication
│   │   │           │   ├── CarDAO.java            # Car XML CRUD, search & filtering
│   │   │           │   └── BookingDAO.java        # Booking XML CRUD & conflict overlap checks
│   │   │           ├── service/
│   │   │           │   ├── AuthService.java       # User authentication, SHA-256 hashing
│   │   │           │   ├── CarService.java        # Fleet inventory & delete validation
│   │   │           │   └── BookingService.java    # Reservation lifecycle & statistics
│   │   │           ├── filter/
│   │   │           │   └── AuthFilter.java        # RBAC & Session security filter
│   │   │           ├── listener/
│   │   │           │   └── AppContextListener.java# ServletContext lifecycle bootstrap
│   │   │           └── controller/
│   │   │               ├── HomeServlet.java       # Public homepage controller
│   │   │               ├── CarServlet.java        # Public fleet catalog & details controller
│   │   │               ├── BookingServlet.java    # Booking creation & customer history
│   │   │               ├── AuthServlet.java       # Sign in, registration, logout
│   │   │               ├── AdminDashboardServlet.java # Admin KPI stats overview
│   │   │               ├── AdminCarServlet.java   # Admin car add/edit/delete/toggle
│   │   │               ├── AdminBookingServlet.java # Admin booking approval workflow
│   │   │               ├── AdminCustomerServlet.java# Admin customer directory
│   │   │               └── StaticPageServlet.java # About Us & Contact pages
│   │   └── webapp/
│   │       ├── index.jsp                          # Forwarder to /home
│   │       ├── WEB-INF/
│   │       │   ├── web.xml                        # Servlet & Filter mappings, error pages
│   │       │   ├── data/                          # XML Data Store
│   │       │   │   ├── users.xml                  # Registered customers & admins
│   │       │   │   ├── cars.xml                   # Fleet vehicle catalog
│   │       │   │   └── bookings.xml               # Active & historical reservations
│   │       │   └── views/
│   │       │       ├── common/
│   │       │       │   ├── navbar.jsp             # Responsive navigation bar
│   │       │       │   ├── footer.jsp             # Universal automotive footer
│   │       │       │   └── alerts.jsp             # Flash success/error message banners
│   │       │       ├── customer/
│   │       │       │   ├── index.jsp              # Modern hero & featured fleet landing
│   │       │       │   ├── cars.jsp               # Search, multi-filter & catalog page
│   │       │       │   ├── car-details.jsp        # Vehicle specs & booking trigger
│   │       │       │   ├── book.jsp               # Date selection & price breakdown
│   │       │       │   ├── my-bookings.jsp        # Customer reservation history
│   │       │       │   ├── booking-confirmation.jsp # Printable invoice & receipt
│   │       │       │   ├── about.jsp              # About Us page
│   │       │       │   └── contact.jsp            # Contact & concierge inquiry form
│   │       │       ├── admin/
│   │       │       │   ├── dashboard.jsp          # Analytics & recent reservations
│   │       │       │   ├── cars-manage.jsp        # Fleet inventory management table
│   │       │       │   ├── car-form.jsp           # Add/Edit vehicle form
│   │       │       │   ├── bookings-manage.jsp    # Booking approval/rejection panel
│   │       │       │   └── customers-manage.jsp   # Customer directory table
│   │       │       ├── auth/
│   │       │       │   ├── login.jsp              # Member & Admin sign-in
│   │       │       │   └── register.jsp           # Customer registration form
│   │       │       └── error/
│   │       │           ├── 404.jsp                # Custom 404 Not Found error page
│   │       │           └── 500.jsp                # Custom 500 Server Error page
│   │       └── assets/
│   │           ├── css/
│   │           │   ├── style.css                  # Core customer styles & variables
│   │           │   ├── admin.css                  # Admin layout, sidebar, tables & KPIs
│   │           │   └── auth.css                   # Login & registration styling
│   │           └── js/
│   │               ├── main.js                    # Mobile menu & auto-dismiss alerts
│   │               ├── booking.js                 # Real-time pricing calculator
│   │               └── admin.js                   # Instant table filter & confirm modals
│   └── test/
│       └── java/
│           └── com/
│               └── carrental/
│                   └── CarRentalSystemTest.java   # Automated JUnit 5 integration tests
```

---

## 6. XML Data Store Design

### 1. `users.xml`
```xml
<users>
    <user>
        <id>USR-ADMIN-1</id>
        <name>System Administrator</name>
        <email>admin@carrental.com</email>
        <password>admin123</password>
        <phone>+1 (555) 019-2834</phone>
        <address>Fleet HQ, 100 Auto Boulevard, Suite 500, New York, NY</address>
        <role>ADMIN</role>
        <createdAt>2024-01-01 09:00:00</createdAt>
    </user>
</users>
```

### 2. `cars.xml`
```xml
<cars>
    <car>
        <id>CAR-101</id>
        <brand>Mercedes-Benz</brand>
        <model>S-Class Maybach S580</model>
        <category>Luxury</category>
        <year>2024</year>
        <pricePerDay>280.0</pricePerDay>
        <seats>5</seats>
        <fuelType>Petrol</fuelType>
        <transmission>Automatic</transmission>
        <imageUrl>https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&amp;fit=crop&amp;w=1200&amp;q=80</imageUrl>
        <description>The pinnacle of automotive luxury with executive rear seating, Burmester 4D surround sound, and silky V8 twin-turbo performance.</description>
        <features>Executive Seating, MBUX Infotainment, Burmester 4D Sound, Soft-Close Doors, Heated Massage Seats</features>
        <status>AVAILABLE</status>
    </car>
</cars>
```

### 3. `bookings.xml`
```xml
<bookings>
    <booking>
        <id>BK-1001</id>
        <bookingReference>CR-2024-8841</bookingReference>
        <userId>USR-1001</userId>
        <carId>CAR-101</carId>
        <userFullName>John Anderson</userFullName>
        <userEmail>john@example.com</userEmail>
        <carTitle>Mercedes-Benz S-Class Maybach S580 (2024)</carTitle>
        <carImageUrl>https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&amp;fit=crop&amp;w=1200&amp;q=80</carImageUrl>
        <pickupDate>2024-12-01</pickupDate>
        <returnDate>2024-12-05</returnDate>
        <pickupLocation>JFK International Airport (JFK)</pickupLocation>
        <returnLocation>Manhattan Downtown Flagship (5th Ave)</returnLocation>
        <totalDays>4</totalDays>
        <pricePerDay>280.0</pricePerDay>
        <totalPrice>1120.0</totalPrice>
        <status>APPROVED</status>
        <bookingDate>2024-11-20 10:15:30</bookingDate>
        <specialRequests>Child safety seat requested in rear right seat.</specialRequests>
    </booking>
</bookings>
```

---

## 7. Step-by-Step Setup & Execution

### Prerequisites
- **JDK 17** or later (JDK 17, 21, or 25)
- **Apache Tomcat 9.x** (or 10.x with migration / javax compatibility)
- (Optional) Git, IntelliJ IDEA Ultimate/Community, or Eclipse IDE for Enterprise Java

---

### Method A: Standalone Maven & Tomcat Deploy

1. **Build and Package the Web Application:**
   Open a terminal in the project root directory and run:
   ```bash
   ./mvnw clean package
   ```
   *(On Windows Command Prompt, run `mvnw.cmd clean package`)*

   This compiles all Java classes, executes the automated JUnit 5 test suite, and outputs the deployable WAR file to:
   ```
   target/CarRentalSystem.war
   ```

2. **Deploy to Apache Tomcat:**
   - Copy `target/CarRentalSystem.war` into your Apache Tomcat installation's `webapps/` folder:
     ```bash
     cp target/CarRentalSystem.war /path/to/apache-tomcat-9.0.x/webapps/
     ```
   - Start Tomcat:
     ```bash
     /path/to/apache-tomcat-9.0.x/bin/startup.sh    # macOS/Linux
     # or
     \path\to\apache-tomcat-9.0.x\bin\startup.bat   # Windows
     ```

3. **Open the Application in Browser:**
   Navigate to:
   ```
   http://localhost:8080/CarRentalSystem/
   ```

---

### Method B: Running in IntelliJ IDEA

1. Launch **IntelliJ IDEA**.
2. Select **File &rarr; Open** and select the `Car Rental System` folder.
3. IntelliJ will detect `pom.xml` and automatically import dependencies.
4. Set Project SDK:
   - Go to **File &rarr; Project Structure &rarr; Project**.
   - Select **Java 17** (or compatible JDK).
5. Configure Tomcat Run Configuration:
   - Click **Run &rarr; Edit Configurations...**
   - Click `+` and choose **Tomcat Server &rarr; Local**.
   - Click **Configure...** and select your Apache Tomcat folder.
   - Go to the **Deployment** tab, click `+` &rarr; **Artifact...** &rarr; Select `CarRentalSystem:war exploded`.
   - Set Application Context to `/CarRentalSystem` (or `/`).
6. Click **Run** or **Debug**. The browser will open automatically at `http://localhost:8080/CarRentalSystem/`.

---

### Method C: Running in Eclipse IDE

1. Launch **Eclipse IDE for Enterprise Java and Web Developers**.
2. Select **File &rarr; Import... &rarr; Existing Maven Projects**.
3. Choose the `Car Rental System` directory and click **Finish**.
4. In the **Servers** tab:
   - Right-click &rarr; **New &rarr; Server**.
   - Select **Apache &rarr; Tomcat v9.0 Server** &rarr; click **Next**.
   - Browse to your Tomcat installation directory.
   - In the **Add and Remove...** dialog, add `CarRentalSystem` to configured projects.
5. Click **Finish**, then right-click the Tomcat server and select **Start**.
6. Access the site at `http://localhost:8080/CarRentalSystem/`.

---

## 8. Sample Credentials

The application is pre-populated with default customer and administrator accounts:

| Role | Email Address | Password | Privileges |
| :--- | :--- | :--- | :--- |
| **System Administrator** | `admin@carrental.com` | `admin123` | Full access to Admin Portal, fleet management, booking approval, customer directory, revenue metrics. |
| **Sample Customer 1** | `john@example.com` | `customer123` | Public browsing, vehicle booking, my bookings, reservation cancellation, printable invoices. |
| **Sample Customer 2** | `sarah@example.com` | `customer123` | Secondary customer account for multi-user booking testing. |

*You can also register new accounts instantly using the public **Register** page.*

---

## 9. Interaction Flow (Servlets, JSP, and XML)

### 1. Booking Reservation Flow
```
1. Customer visits /car-details?id=CAR-102
   └── CarServlet loads Car model from CarDAO (reads cars.xml)
   └── Forwards to car-details.jsp

2. Customer clicks "Reserve This Vehicle Now"
   └── AuthFilter verifies session:
       ├── If not logged in: Redirects to /login?redirect=/book?carId=CAR-102
       └── If logged in: Forwards to BookingServlet -> book.jsp

3. Customer selects Pickup & Return dates and submits form
   └── JavaScript (booking.js) updates total days & price in real time
   └── Form POSTs to /book
   └── BookingServlet calls BookingService.createBooking(...)
       ├── 1. Validates dates (pickup is not in past, return >= pickup)
       ├── 2. Calls BookingDAO.isCarAvailableForDates(...)
       │      └── Reads bookings.xml: checks for overlapping PENDING/APPROVED bookings
       │      └── If collision detected: Throws Exception ("Vehicle already booked")
       ├── 3. Calculates totalDays and totalPrice = totalDays * pricePerDay
       └── 4. Calls BookingDAO.addBooking(...)
              └── Acquires Write Lock in XmlUtil
              └── Appends <booking> to bookings.xml
              └── Transformer writes pretty-printed XML to disk

4. Customer is redirected to /booking-details?id=BK-1003
   └── Shows confirmation badge and itemized printable receipt
```

### 2. Admin Approval Flow
```
1. Admin visits /admin/dashboard or /admin/bookings
   └── AuthFilter verifies currentUser.isAdmin() == true
   └── AdminBookingServlet queries all bookings via BookingDAO
   └── Forwards to bookings-manage.jsp

2. Admin clicks "Approve" on a Pending Booking
   └── POST to /admin/bookings/action with action=approve&bookingId=BK-1003
   └── BookingService updates <status>APPROVED</status> in bookings.xml
   └── Admin page reloads with updated badge and recalculated revenue metrics
```

---

## 10. Testing Instructions

### Automated Testing
Execute the JUnit 5 test suite:
```bash
./mvnw test
```
**Tests Covered:**
- `testUserRegistrationAndAuthentication`: Validates account creation, SHA-256 hash validation, and duplicate email prevention.
- `testCarCatalogAndXmlPersistence`: Validates XML element addition, DOM parsing, and attribute updates.
- `testBookingCreationAndDurationPricing`: Verifies duration days logic and total price computation.
- `testOverlappingBookingPrevention`: Verifies collision detection algorithms that prevent double-booking on overlapping dates.
- `testAdminBookingStatusWorkflow`: Validates status transitions (`PENDING` &rarr; `APPROVED` &rarr; `COMPLETED`).

### Manual Functional Testing Scenarios

1. **Authentication & Role Protection:**
   - Attempt to open `http://localhost:8080/CarRentalSystem/admin/dashboard` while logged out.
   - *Expected:* Automatically redirected to `/login` with an informative warning banner.
   - Log in as customer (`john@example.com` / `customer123`).
   - Attempt to open `/admin/dashboard`.
   - *Expected:* Access denied; redirected safely with `Access Denied` error.
   - Log in as admin (`admin@carrental.com` / `admin123`).
   - *Expected:* Directly routed to the executive dashboard.

2. **Catalog Search & Filtering:**
   - Go to `/cars`.
   - Search `BMW` or select `Category: Sports`.
   - Adjust `Max Price` slider to `250`.
   - *Expected:* Fleet updates immediately with matching vehicles.

3. **Booking with Real-Time Calculation:**
   - Select any available vehicle (e.g. Mercedes-Benz S-Class).
   - Change pickup date and return date (e.g. 5 days apart).
   - *Expected:* Live duration shows `5 Days`, and total updates dynamically (`5 * $280 = $1400.00`).
   - Submit booking.
   - *Expected:* Redirects to printable invoice with reference `CR-2024-XXXX`.

4. **Double Booking Prevention:**
   - Note the dates chosen above (e.g., Dec 1 to Dec 5 for CAR-101).
   - Sign in as another user (`sarah@example.com` / `customer123`).
   - Attempt to book the same vehicle for overlapping dates (e.g., Dec 3 to Dec 7).
   - *Expected:* System blocks the booking with message: *"Vehicle is already booked for the selected date range. Please select different dates or another vehicle."*

5. **Fleet Administration:**
   - In Admin portal, click **+ Add New Vehicle**.
   - Fill in details (e.g., Ferrari Roma, $400/day).
   - Submit form.
   - *Expected:* Vehicle is instantly written to `cars.xml` and appears on the public fleet page.
   - Toggle status to `Maintenance`.
   - *Expected:* Car is marked as unavailable and cannot be reserved by customers.

