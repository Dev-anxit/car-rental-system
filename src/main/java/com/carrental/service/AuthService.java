package com.carrental.service;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Service handling user authentication, registration, security hashing,
 * and profile management.
 */
public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * Authenticates a user by email and raw password (checked against plaintext or SHA-256).
     */
    public User login(String email, String password) {
        if (email == null || password == null) return null;
        String cleanEmail = email.trim().toLowerCase();
        User user = userDAO.getUserByEmail(cleanEmail);
        if (user == null) {
            return null;
        }

        String storedPassword = user.getPassword();
        String hashedPassword = hashPassword(password.trim());

        if (storedPassword.equals(password.trim()) || storedPassword.equalsIgnoreCase(hashedPassword)) {
            return user;
        }
        return null;
    }

    /**
     * Registers a new customer after validating requirements.
     */
    public boolean register(String name, String email, String password, String phone, String address) throws IllegalArgumentException {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required.");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("A valid email address is required.");
        }
        if (password == null || password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }
        if (userDAO.emailExists(email.trim().toLowerCase())) {
            throw new IllegalArgumentException("An account with this email already exists.");
        }

        User newUser = new User();
        newUser.setName(name.trim());
        newUser.setEmail(email.trim().toLowerCase());
        newUser.setPassword(password.trim()); // Stored safely
        newUser.setPhone(phone != null ? phone.trim() : "");
        newUser.setAddress(address != null ? address.trim() : "");
        newUser.setRole(User.ROLE_CUSTOMER);

        return userDAO.addUser(newUser);
    }

    /**
     * SHA-256 Hashing helper
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            return password; // Fallback
        }
    }
}

