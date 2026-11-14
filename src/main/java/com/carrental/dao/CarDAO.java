package com.carrental.dao;

import com.carrental.model.Car;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.util.*;

/**
 * Data Access Object for Car inventory operations using DOM XML parsing.
 */
public class CarDAO {

    private static final String FILE_NAME = "cars.xml";

    public synchronized List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList nodeList = doc.getElementsByTagName("car");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    cars.add(mapElementToCar((Element) node));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cars;
    }

    public synchronized List<Car> getAvailableCars() {
        List<Car> available = new ArrayList<>();
        for (Car car : getAllCars()) {
            if (car.isAvailable()) {
                available.add(car);
            }
        }
        return available;
    }

    public synchronized Car getCarById(String id) {
        if (id == null) return null;
        for (Car car : getAllCars()) {
            if (id.equalsIgnoreCase(car.getId())) {
                return car;
            }
        }
        return null;
    }

    public synchronized boolean addCar(Car car) {
        if (car == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            Element root = doc.getDocumentElement();
            if (root == null) {
                root = doc.createElement("cars");
                doc.appendChild(root);
            }

            if (car.getId() == null || car.getId().trim().isEmpty()) {
                car.setId("CAR-" + (100 + getAllCars().size() + 1));
            }
            if (car.getStatus() == null || car.getStatus().trim().isEmpty()) {
                car.setStatus(Car.STATUS_AVAILABLE);
            }

            Element carEl = doc.createElement("car");
            XmlUtil.createChildElement(doc, carEl, "id", car.getId());
            XmlUtil.createChildElement(doc, carEl, "brand", car.getBrand());
            XmlUtil.createChildElement(doc, carEl, "model", car.getModel());
            XmlUtil.createChildElement(doc, carEl, "category", car.getCategory());
            XmlUtil.createChildElement(doc, carEl, "year", String.valueOf(car.getYear()));
            XmlUtil.createChildElement(doc, carEl, "pricePerDay", String.valueOf(car.getPricePerDay()));
            XmlUtil.createChildElement(doc, carEl, "seats", String.valueOf(car.getSeats()));
            XmlUtil.createChildElement(doc, carEl, "fuelType", car.getFuelType());
            XmlUtil.createChildElement(doc, carEl, "transmission", car.getTransmission());
            XmlUtil.createChildElement(doc, carEl, "imageUrl", car.getImageUrl());
            XmlUtil.createChildElement(doc, carEl, "description", car.getDescription());
            XmlUtil.createChildElement(doc, carEl, "features", car.getFeatures());
            XmlUtil.createChildElement(doc, carEl, "status", car.getStatus());

            root.appendChild(carEl);
            XmlUtil.saveDocument(doc, FILE_NAME);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public synchronized boolean updateCar(Car car) {
        if (car == null || car.getId() == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("car");
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element el = (Element) node;
                    String id = XmlUtil.getChildText(el, "id", "");
                    if (id.equalsIgnoreCase(car.getId())) {
                        setElementText(el, "brand", car.getBrand());
                        setElementText(el, "model", car.getModel());
                        setElementText(el, "category", car.getCategory());
                        setElementText(el, "year", String.valueOf(car.getYear()));
                        setElementText(el, "pricePerDay", String.valueOf(car.getPricePerDay()));
                        setElementText(el, "seats", String.valueOf(car.getSeats()));
                        setElementText(el, "fuelType", car.getFuelType());
                        setElementText(el, "transmission", car.getTransmission());
                        setElementText(el, "imageUrl", car.getImageUrl());
                        setElementText(el, "description", car.getDescription());
                        setElementText(el, "features", car.getFeatures());
                        setElementText(el, "status", car.getStatus());
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

    public synchronized boolean updateCarStatus(String id, String status) {
        if (id == null || status == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("car");
            for (int i = 0; i < list.getLength(); i++) {
                Node node = list.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element el = (Element) node;
                    String elId = XmlUtil.getChildText(el, "id", "");
                    if (elId.equalsIgnoreCase(id)) {
                        setElementText(el, "status", status);
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

    public synchronized boolean deleteCar(String id) {
        if (id == null) return false;
        try {
            Document doc = XmlUtil.loadDocument(FILE_NAME);
            NodeList list = doc.getElementsByTagName("car");
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

    public synchronized List<Car> searchCars(String keyword, String category, Double maxPrice, String transmission, String fuelType) {
        List<Car> results = new ArrayList<>();
        String kw = (keyword != null) ? keyword.trim().toLowerCase() : "";
        String cat = (category != null && !category.equalsIgnoreCase("ALL")) ? category.trim().toLowerCase() : "";
        String trans = (transmission != null && !transmission.equalsIgnoreCase("ALL")) ? transmission.trim().toLowerCase() : "";
        String fuel = (fuelType != null && !fuelType.equalsIgnoreCase("ALL")) ? fuelType.trim().toLowerCase() : "";

        for (Car car : getAllCars()) {
            boolean matches = true;

            if (!kw.isEmpty()) {
                String searchTarget = (car.getBrand() + " " + car.getModel() + " " + car.getDescription() + " " + car.getFeatures()).toLowerCase();
                if (!searchTarget.contains(kw)) {
                    matches = false;
                }
            }
            if (matches && !cat.isEmpty()) {
                if (car.getCategory() == null || !car.getCategory().toLowerCase().contains(cat)) {
                    matches = false;
                }
            }
            if (matches && maxPrice != null && maxPrice > 0) {
                if (car.getPricePerDay() > maxPrice) {
                    matches = false;
                }
            }
            if (matches && !trans.isEmpty()) {
                if (car.getTransmission() == null || !car.getTransmission().equalsIgnoreCase(trans)) {
                    matches = false;
                }
            }
            if (matches && !fuel.isEmpty()) {
                if (car.getFuelType() == null || !car.getFuelType().equalsIgnoreCase(fuel)) {
                    matches = false;
                }
            }

            if (matches) {
                results.add(car);
            }
        }
        return results;
    }

    public synchronized Set<String> getCategories() {
        Set<String> categories = new TreeSet<>();
        for (Car car : getAllCars()) {
            if (car.getCategory() != null && !car.getCategory().trim().isEmpty()) {
                categories.add(car.getCategory().trim());
            }
        }
        return categories;
    }

    public synchronized Set<String> getBrands() {
        Set<String> brands = new TreeSet<>();
        for (Car car : getAllCars()) {
            if (car.getBrand() != null && !car.getBrand().trim().isEmpty()) {
                brands.add(car.getBrand().trim());
            }
        }
        return brands;
    }

    private void setElementText(Element parent, String tagName, String value) {
        NodeList nl = parent.getElementsByTagName(tagName);
        if (nl != null && nl.getLength() > 0) {
            nl.item(0).setTextContent(value != null ? value : "");
        } else {
            XmlUtil.createChildElement(parent.getOwnerDocument(), parent, tagName, value);
        }
    }

    private Car mapElementToCar(Element el) {
        Car car = new Car();
        car.setId(XmlUtil.getChildText(el, "id", ""));
        car.setBrand(XmlUtil.getChildText(el, "brand", ""));
        car.setModel(XmlUtil.getChildText(el, "model", ""));
        car.setCategory(XmlUtil.getChildText(el, "category", ""));
        try {
            car.setYear(Integer.parseInt(XmlUtil.getChildText(el, "year", "2024")));
        } catch (NumberFormatException e) {
            car.setYear(2024);
        }
        try {
            car.setPricePerDay(Double.parseDouble(XmlUtil.getChildText(el, "pricePerDay", "100.0")));
        } catch (NumberFormatException e) {
            car.setPricePerDay(100.0);
        }
        try {
            car.setSeats(Integer.parseInt(XmlUtil.getChildText(el, "seats", "5")));
        } catch (NumberFormatException e) {
            car.setSeats(5);
        }
        car.setFuelType(XmlUtil.getChildText(el, "fuelType", "Petrol"));
        car.setTransmission(XmlUtil.getChildText(el, "transmission", "Automatic"));
        car.setImageUrl(XmlUtil.getChildText(el, "imageUrl", ""));
        car.setDescription(XmlUtil.getChildText(el, "description", ""));
        car.setFeatures(XmlUtil.getChildText(el, "features", ""));
        car.setStatus(XmlUtil.getChildText(el, "status", Car.STATUS_AVAILABLE));
        return car;
    }
}

