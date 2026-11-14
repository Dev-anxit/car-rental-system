package com.carrental.dao;

import com.carrental.model.User;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Data Access Object for User operations using DOM XML parsing.
 */
public class UserDAO {

    private static final String FILE_NAME = "users.xml";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public synchronized List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList nodeList = doc.getElementsByTagName("user");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    users.add(mapElementToUser((Element) node));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public synchronized List<User> getAllCustomers() {
        List<User> customers = new ArrayList<>();
        for (User user : getAllUsers()) {
            if (!user.isAdmin()) {
                customers.add(user);
            }
        }
        return customers;
    }

    public synchronized User getUserById(String id) {
        if (id == null) return null;
        for (User user : getAllUsers()) {
            if (id.equalsIgnoreCase(user.getId())) {
                return user;
            }
        }
        return null;
    }

    public synchronized User getUserByEmail(String email) {
        if (email == null) return null;
        for (User user : getAllUsers()) {
            if (email.equalsIgnoreCase(user.getEmail())) {
                return user;
            }
        }
        return null;
    }

    public synchronized User authenticate(String email, String password) {
        if (email == null || password == null) return null;
        User user = getUserByEmail(email.trim());
        if (user != null && user.getPassword() != null && user.getPassword().equals(password.trim())) {
            return user;
        }
        return null;
    }

    public synchronized boolean emailExists(String email) {
        return getUserByEmail(email) != null;
    }

    public synchronized boolean addUser(User user) {
        if (user == null || emailExists(user.getEmail())) {
            return false;
        }
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            Element root = doc.getDocumentElement();
            if (root == null) {
                root = doc.createElement("users");
                doc.appendChild(root);
            }

            if (user.getId() == null || user.getId().trim().isEmpty()) {
                user.setId("USR-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
            }
            if (user.getCreatedAt() == null || user.getCreatedAt().trim().isEmpty()) {
                user.setCreatedAt(LocalDateTime.now().format(DATE_FORMATTER));
            }
            if (user.getRole() == null || user.getRole().trim().isEmpty()) {
                user.setRole(User.ROLE_CUSTOMER);
            }

            Element userEl = doc.createElement("user");
            XmlUtil.createChildElement(doc, userEl, "id", user.getId());
            XmlUtil.createChildElement(doc, userEl, "name", user.getName());
            XmlUtil.createChildElement(doc, userEl, "email", user.getEmail());
            XmlUtil.createChildElement(doc, userEl, "password", user.getPassword());
            XmlUtil.createChildElement(doc, userEl, "phone", user.getPhone());
            XmlUtil.createChildElement(doc, userEl, "address", user.getAddress());
            XmlUtil.createChildElement(doc, userEl, "role", user.getRole());
            XmlUtil.createChildElement(doc, userEl, "createdAt", user.getCreatedAt());

            root.appendChild(userEl);
            XmlUtil.saveDocument(doc, FILE_NAME);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public synchronized boolean updateUser(User user) {
        if (user == null || user.getId() == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("user");
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element el = (Element) node;
                    String id = XmlUtil.getChildText(el, "id", "");
                    if (id.equalsIgnoreCase(user.getId())) {
                        setElementText(el, "name", user.getName());
                        setElementText(el, "email", user.getEmail());
                        if (user.getPassword() != null && !user.getPassword().trim().isEmpty()) {
                            setElementText(el, "password", user.getPassword());
                        }
                        setElementText(el, "phone", user.getPhone());
                        setElementText(el, "address", user.getAddress());
                        setElementText(el, "role", user.getRole());
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

    public synchronized boolean deleteUser(String id) {
        if (id == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("user");
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element el = (Element) node;
                    String elId = XmlUtil.getChildText(el, "id", "");
                    if (elId.equalsIgnoreCase(id)) {
                        el.getParentNode().removeChild(el);
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

    private void setElementText(Element parent, String tagName, String value) {
        NodeList nl = parent.getElementsByTagName(tagName);
        if (nl != null && nl.getLength() > 0) {
            nl.item(0).setTextContent(value != null ? value : "");
        } else {
            XmlUtil.createChildElement(parent.getOwnerDocument(), parent, tagName, value);
        }
    }

    private User mapElementToUser(Element el) {
        User user = new User();
        user.setId(XmlUtil.getChildText(el, "id", ""));
        user.setName(XmlUtil.getChildText(el, "name", ""));
        user.setEmail(XmlUtil.getChildText(el, "email", ""));
        user.setPassword(XmlUtil.getChildText(el, "password", ""));
        user.setPhone(XmlUtil.getChildText(el, "phone", ""));
        user.setAddress(XmlUtil.getChildText(el, "address", ""));
        user.setRole(XmlUtil.getChildText(el, "role", User.ROLE_CUSTOMER));
        user.setCreatedAt(XmlUtil.getChildText(el, "createdAt", ""));
        return user;
    }
}

