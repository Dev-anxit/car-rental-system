package com.carrental;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.dao.UserDAO;
import com.carrental.dao.XmlUtil;
import com.carrental.model.Booking;
import com.carrental.model.Car;
import com.carrental.model.User;
import com.carrental.service.AuthService;
import com.carrental.service.BookingService;
import org.junit.jupiter.api.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CarRentalSystemTest {

    private static Path tempDir;
    private static UserDAO userDAO;
    private static CarDAO carDAO;
    private static BookingDAO bookingDAO;
    private static BookingService bookingService;
    private static AuthService authService;

    @BeforeAll
    public static void setUp() throws IOException {
        tempDir = Files.createTempDirectory("carrental_test_data");
        XmlUtil.setDataDirectory(tempDir.toString());

        userDAO = new UserDAO();
        carDAO = new CarDAO();
        bookingDAO = new BookingDAO();
        bookingService = new BookingService(bookingDAO, carDAO, userDAO);
        authService = new AuthService(userDAO);
    }

    @AfterAll
    public static void tearDown() throws IOException {
        if (tempDir != null && Files.exists(tempDir)) {
            Files.walk(tempDir)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        }
    }

    @Test
    @Order(1)
    public void testUserRegistrationAndAuthentication() {
        boolean registered = authService.register("Alice Smith", "alice@test.com", "secure123", "+1234567890", "123 Elm St");
        assertTrue(registered, "User should register successfully");

        User user = authService.login("alice@test.com", "secure123");
        assertNotNull(user, "User should be able to log in");
        assertEquals("Alice Smith", user.getName());
        assertEquals(User.ROLE_CUSTOMER, user.getRole());

        // Test duplicate email rejection
        assertThrows(IllegalArgumentException.class, () -> {
            authService.register("Alice Duplicate", "alice@test.com", "differentpass", "", "");
        });
    }

    @Test
    @Order(2)
    public void testCarCatalogAndXmlPersistence() {
        Car car = new Car();
        car.setId("CAR-TEST-1");
        car.setBrand("Ferrari");
        car.setModel("F8 Tributo");
        car.setCategory("Sports");
        car.setYear(2024);
        car.setPricePerDay(450.0);
        car.setSeats(2);
        car.setFuelType("Petrol");
        car.setTransmission("Automatic");
        car.setImageUrl("https://example.com/f8.jpg");
        car.setDescription("V8 Supercar");
        car.setStatus(Car.STATUS_AVAILABLE);

        boolean added = carDAO.addCar(car);
        assertTrue(added, "Car should be persisted into XML");

        Car retrieved = carDAO.getCarById("CAR-TEST-1");
        assertNotNull(retrieved);
        assertEquals("Ferrari", retrieved.getBrand());
        assertEquals(450.0, retrieved.getPricePerDay());

        // Update Car
        retrieved.setPricePerDay(490.0);
        boolean updated = carDAO.updateCar(retrieved);
        assertTrue(updated);
        assertEquals(490.0, carDAO.getCarById("CAR-TEST-1").getPricePerDay());
    }

    @Test
    @Order(3)
    public void testBookingCreationAndDurationPricing() throws Exception {
        User user = userDAO.getUserByEmail("alice@test.com");
        assertNotNull(user);

        // 3 days rental starting 10 days in the future
        java.time.LocalDate start = java.time.LocalDate.now().plusDays(10);
        java.time.LocalDate end = start.plusDays(3);

        Booking booking = bookingService.createBooking(
                user.getId(),
                "CAR-TEST-1",
                start.toString(),
                end.toString(),
                "JFK Airport",
                "JFK Airport",
                "Clean car"
        );

        assertNotNull(booking);
        assertEquals(3, booking.getTotalDays(), "Should calculate exactly 3 days");
        assertEquals(3 * 490.0, booking.getTotalPrice(), 0.01, "Pricing must equal totalDays * pricePerDay");
        assertEquals(Booking.STATUS_PENDING, booking.getStatus());
    }

    @Test
    @Order(4)
    public void testOverlappingBookingPrevention() {
        User user = userDAO.getUserByEmail("alice@test.com");
        assertNotNull(user);

        // Try to book overlapping dates: start + 1 day to start + 4 days
        java.time.LocalDate start = java.time.LocalDate.now().plusDays(11);
        java.time.LocalDate end = start.plusDays(3);

        assertThrows(IllegalStateException.class, () -> {
            bookingService.createBooking(
                    user.getId(),
                    "CAR-TEST-1",
                    start.toString(),
                    end.toString(),
                    "Downtown",
                    "Downtown",
                    ""
            );
        }, "Should strictly block double booking for overlapping schedule");

        // Non-overlapping future dates should succeed
        java.time.LocalDate futureStart = java.time.LocalDate.now().plusDays(25);
        java.time.LocalDate futureEnd = futureStart.plusDays(5);

        assertDoesNotThrow(() -> {
            bookingService.createBooking(
                    user.getId(),
                    "CAR-TEST-1",
                    futureStart.toString(),
                    futureEnd.toString(),
                    "Downtown",
                    "Downtown",
                    ""
            );
        });
    }

    @Test
    @Order(5)
    public void testAdminBookingStatusWorkflow() {
        List<Booking> bookings = bookingDAO.getAllBookings();
        assertFalse(bookings.isEmpty());

        Booking firstBooking = bookings.get(0);
        String id = firstBooking.getId();

        // Admin approves
        boolean approved = bookingService.approveBooking(id);
        assertTrue(approved);
        assertEquals(Booking.STATUS_APPROVED, bookingDAO.getBookingById(id).getStatus());

        // Complete booking
        boolean completed = bookingService.completeBooking(id);
        assertTrue(completed);
        assertEquals(Booking.STATUS_COMPLETED, bookingDAO.getBookingById(id).getStatus());
    }
}
