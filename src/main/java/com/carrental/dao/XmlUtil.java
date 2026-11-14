package com.carrental.dao;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * Utility class providing thread-safe XML DOM operations, file synchronization,
 * and automatic schema/sample data seeding.
 */
public class XmlUtil {

    private static String dataDirectory = null;
    private static final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();

    /**
     * Configures the directory where XML files are stored.
     */
    public static void setDataDirectory(String path) {
        if (path != null && !path.trim().isEmpty()) {
            dataDirectory = path;
            File dir = new File(dataDirectory);
            if (!dir.exists()) {
                dir.mkdirs();
            }
        }
    }

    public static String getDataDirectory() {
        if (dataDirectory == null) {
            // Default fallback
            String customProp = System.getProperty("carrental.data.dir");
            if (customProp != null && !customProp.trim().isEmpty()) {
                dataDirectory = customProp;
            } else {
                dataDirectory = System.getProperty("user.dir") + File.separator + "data";
            }
            File dir = new File(dataDirectory);
            if (!dir.exists()) {
                dir.mkdirs();
            }
        }
        return dataDirectory;
    }

    public static File getFile(String fileName) {
        return new File(getDataDirectory(), fileName);
    }

    /**
     * Loads and parses an XML file into a DOM Document.
     */
    public static Document loadDocument(String fileName) {
        lock.readLock().lock();
        try {
            File file = getFile(fileName);
            if (!file.exists() || file.length() == 0) {
                // Return empty document
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                return builder.newDocument();
            }

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            // Secure XML parsing configurations
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
            factory.setXIncludeAware(false);
            factory.setExpandEntityReferences(false);

            DocumentBuilder builder = factory.newDocumentBuilder();
            return builder.parse(file);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading XML file: " + fileName + " - " + e.getMessage(), e);
        } finally {
            lock.readLock().unlock();
        }
    }

    /**
     * Saves a DOM Document back to the XML file with pretty printing.
     */
    public static void saveDocument(Document doc, String fileName) {
        lock.writeLock().lock();
        try {
            File file = getFile(fileName);
            File parentDir = file.getParentFile();
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs();
            }

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
            transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
            transformer.setOutputProperty(OutputKeys.STANDALONE, "yes");

            DOMSource source = new DOMSource(doc);
            try (FileOutputStream fos = new FileOutputStream(file);
                 OutputStreamWriter writer = new OutputStreamWriter(fos, StandardCharsets.UTF_8)) {
                StreamResult result = new StreamResult(writer);
                transformer.transform(source, result);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error saving XML file: " + fileName + " - " + e.getMessage(), e);
        } finally {
            lock.writeLock().unlock();
        }
    }

    public static String getChildText(Element parent, String tagName, String defaultValue) {
        if (parent == null) return defaultValue;
        NodeList list = parent.getElementsByTagName(tagName);
        if (list != null && list.getLength() > 0) {
            Node node = list.item(0);
            if (node != null && node.getTextContent() != null) {
                return node.getTextContent().trim();
            }
        }
        return defaultValue;
    }

    public static void createChildElement(Document doc, Element parent, String tagName, String text) {
        Element child = doc.createElement(tagName);
        child.setTextContent(text != null ? text : "");
        parent.appendChild(child);
    }
}

