package com.carrental.dao;

import com.carrental.model.Booking;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * Data Access Object for Rental Bookings with overlap detection,
 * date validation, and revenue statistics.
 */
public class BookingDAO {

    private static final String FILE_NAME = "bookings.xml";
    private static final DateTimeFormatter TIMESTAMP_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public synchronized List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList nodeList = doc.getElementsByTagName("booking");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    bookings.add(mapElementToBooking((Element) node));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Return reverse sorted so newest bookings appear first
        bookings.sort((b1, b2) -> {
            String d1 = b1.getBookingDate() != null ? b1.getBookingDate() : "";
            String d2 = b2.getBookingDate() != null ? b2.getBookingDate() : "";
            return d2.compareTo(d1);
        });
        return bookings;
    }

    public synchronized List<Booking> getBookingsByUserId(String userId) {
        List<Booking> userBookings = new ArrayList<>();
        if (userId == null) return userBookings;
        for (Booking booking : getAllBookings()) {
            if (userId.equalsIgnoreCase(booking.getUserId())) {
                userBookings.add(booking);
            }
        }
        return userBookings;
    }

    public synchronized Booking getBookingById(String id) {
        if (id == null) return null;
        for (Booking booking : getAllBookings()) {
            if (id.equalsIgnoreCase(booking.getId()) || id.equalsIgnoreCase(booking.getBookingReference())) {
                return booking;
            }
        }
        return null;
    }

    /**
     * Checks if a car is available for the given date range, preventing double booking.
     * Overlap occurs when: requestedStart <= existingEnd AND existingStart <= requestedEnd
     * for any booking with status PENDING or APPROVED.
     */
    public synchronized boolean isCarAvailableForDates(String carId, String pickupDateStr, String returnDateStr, String excludeBookingId) {
        if (carId == null || pickupDateStr == null || returnDateStr == null) return false;
        try {
            LocalDate requestedPickup = LocalDate.parse(pickupDateStr);
            LocalDate requestedReturn = LocalDate.parse(returnDateStr);

            if (requestedReturn.isBefore(requestedPickup)) {
                return false;
            }

            for (Booking booking : getAllBookings()) {
                if (excludeBookingId != null && excludeBookingId.equalsIgnoreCase(booking.getId())) {
                    continue;
                }
                if (carId.equalsIgnoreCase(booking.getCarId())) {
                    String status = booking.getStatus();
                    // Overlap is only blocked by active/confirmed bookings
                    if (Booking.STATUS_PENDING.equalsIgnoreCase(status) || Booking.STATUS_APPROVED.equalsIgnoreCase(status)) {
                        LocalDate existingPickup = LocalDate.parse(booking.getPickupDate());
                        LocalDate existingReturn = LocalDate.parse(booking.getReturnDate());

                        // Overlap condition
                        if (!requestedPickup.isAfter(existingReturn) && !requestedReturn.isBefore(existingPickup)) {
                            return false; // Collision detected
                        }
                    }
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public synchronized boolean addBooking(Booking booking) {
        if (booking == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            Element root = doc.getDocumentElement();
            if (root == null) {
                root = doc.createElement("bookings");
                doc.appendChild(root);
            }

            if (booking.getId() == null || booking.getId().trim().isEmpty()) {
                booking.setId("BK-" + (1000 + getAllBookings().size() + 1));
            }
            if (booking.getBookingReference() == null || booking.getBookingReference().trim().isEmpty()) {
                int randomNum = 1000 + new Random().nextInt(9000);
                booking.setBookingReference("CR-" + LocalDate.now().getYear() + "-" + randomNum);
            }
            if (booking.getBookingDate() == null || booking.getBookingDate().trim().isEmpty()) {
                booking.setBookingDate(LocalDateTime.now().format(TIMESTAMP_FORMATTER));
            }
            if (booking.getStatus() == null || booking.getStatus().trim().isEmpty()) {
                booking.setStatus(Booking.STATUS_PENDING);
            }

            Element el = doc.createElement("booking");
            XmlUtil.createChildElement(doc, el, "id", booking.getId());
            XmlUtil.createChildElement(doc, el, "bookingReference", booking.getBookingReference());
            XmlUtil.createChildElement(doc, el, "userId", booking.getUserId());
            XmlUtil.createChildElement(doc, el, "carId", booking.getCarId());
            XmlUtil.createChildElement(doc, el, "userFullName", booking.getUserFullName());
            XmlUtil.createChildElement(doc, el, "userEmail", booking.getUserEmail());
            XmlUtil.createChildElement(doc, el, "carTitle", booking.getCarTitle());
            XmlUtil.createChildElement(doc, el, "carImageUrl", booking.getCarImageUrl());
            XmlUtil.createChildElement(doc, el, "pickupDate", booking.getPickupDate());
            XmlUtil.createChildElement(doc, el, "returnDate", booking.getReturnDate());
            XmlUtil.createChildElement(doc, el, "pickupLocation", booking.getPickupLocation());
            XmlUtil.createChildElement(doc, el, "returnLocation", booking.getReturnLocation());
            XmlUtil.createChildElement(doc, el, "totalDays", String.valueOf(booking.getTotalDays()));
            XmlUtil.createChildElement(doc, el, "pricePerDay", String.valueOf(booking.getPricePerDay()));
            XmlUtil.createChildElement(doc, el, "totalPrice", String.valueOf(booking.getTotalPrice()));
            XmlUtil.createChildElement(doc, el, "status", booking.getStatus());
            XmlUtil.createChildElement(doc, el, "bookingDate", booking.getBookingDate());
            XmlUtil.createChildElement(doc, el, "specialRequests", booking.getSpecialRequests());

            root.appendChild(el);
            XmlUtil.saveDocument(doc, FILE_NAME);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public synchronized boolean updateBookingStatus(String bookingId, String newStatus) {
        if (bookingId == null || newStatus == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("booking");
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element el = (Element) node;
                    String id = XmlUtil.getChildText(el, "id", "");
                    if (id.equalsIgnoreCase(bookingId)) {
                        setElementText(el, "status", newStatus);
                        XmlUtil.saveDocument(doc, FILE_NAME);
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public synchronized boolean cancelBooking(String bookingId, String userId, boolean isAdmin) {
        Booking booking = getBookingById(bookingId);
        if (booking == null) return false;
        if (!isAdmin && (userId == null || !userId.equalsIgnoreCase(booking.getUserId()))) {
            return false; // Unauthorized
        }
        if (booking.canBeCancelled()) {
            return updateBookingStatus(bookingId, Booking.STATUS_CANCELLED);
        }
        return false;
    }

    // --- Statistics Helper Methods for Admin Dashboard ---

    public synchronized int getActiveBookingsCount() {
        int count = 0;
        for (Booking booking : getAllBookings()) {
            if (Booking.STATUS_PENDING.equalsIgnoreCase(booking.getStatus()) ||
                Booking.STATUS_APPROVED.equalsIgnoreCase(booking.getStatus())) {
                count++;
            }
        }
        return count;
    }

    public synchronized double getTotalRevenue() {
        double revenue = 0.0;
        for (Booking booking : getAllBookings()) {
            // Count approved or completed bookings in revenue
            if (Booking.STATUS_APPROVED.equalsIgnoreCase(booking.getStatus()) ||
                Booking.STATUS_COMPLETED.equalsIgnoreCase(booking.getStatus())) {
                revenue += booking.getTotalPrice();
            }
        }
        return revenue;
    }

    public synchronized Map<String, Integer> getBookingStatusCounts() {
        Map<String, Integer> counts = new HashMap<>();
        counts.put(Booking.STATUS_PENDING, 0);
        counts.put(Booking.STATUS_APPROVED, 0);
        counts.put(Booking.STATUS_REJECTED, 0);
        counts.put(Booking.STATUS_CANCELLED, 0);
        counts.put(Booking.STATUS_COMPLETED, 0);

        for (Booking b : getAllBookings()) {
            String status = b.getStatus();
            counts.put(status, counts.getOrDefault(status, 0) + 1);
        }
        return counts;
    }

    private void setElementText(Element parent, String tagName, String value) {
        NodeList nl = parent.getElementsByTagName(tagName);
        if (nl != null && nl.getLength() > 0) {
            nl.item(0).setTextContent(value != null ? value : "");
        } else {
            XmlUtil.createChildElement(parent.getOwnerDocument(), parent, tagName, value);
        }
    }

    private Booking mapElementToBooking(Element el) {
        Booking booking = new Booking();
        booking.setId(XmlUtil.getChildText(el, "id", ""));
        booking.setBookingReference(XmlUtil.getChildText(el, "bookingReference", ""));
        booking.setUserId(XmlUtil.getChildText(el, "userId", ""));
        booking.setCarId(XmlUtil.getChildText(el, "carId", ""));
        booking.setUserFullName(XmlUtil.getChildText(el, "userFullName", ""));
        booking.setUserEmail(XmlUtil.getChildText(el, "userEmail", ""));
        booking.setCarTitle(XmlUtil.getChildText(el, "carTitle", ""));
        booking.setCarImageUrl(XmlUtil.getChildText(el, "carImageUrl", ""));
        booking.setPickupDate(XmlUtil.getChildText(el, "pickupDate", ""));
        booking.setReturnDate(XmlUtil.getChildText(el, "returnDate", ""));
        booking.setPickupLocation(XmlUtil.getChildText(el, "pickupLocation", ""));
        booking.setReturnLocation(XmlUtil.getChildText(el, "returnLocation", ""));
        try {
            booking.setTotalDays(Integer.parseInt(XmlUtil.getChildText(el, "totalDays", "1")));
        } catch (NumberFormatException e) {
            booking.setTotalDays(1);
        }
        try {
            booking.setPricePerDay(Double.parseDouble(XmlUtil.getChildText(el, "pricePerDay", "0.0")));
        } catch (NumberFormatException e) {
            booking.setPricePerDay(0.0);
        }
        try {
            booking.setTotalPrice(Double.parseDouble(XmlUtil.getChildText(el, "totalPrice", "0.0")));
        } catch (NumberFormatException e) {
            booking.setTotalPrice(0.0);
        }
        booking.setStatus(XmlUtil.getChildText(el, "status", Booking.STATUS_PENDING));
        booking.setBookingDate(XmlUtil.getChildText(el, "bookingDate", ""));
        booking.setSpecialRequests(XmlUtil.getChildText(el, "specialRequests", ""));
        return booking;
    }
}

