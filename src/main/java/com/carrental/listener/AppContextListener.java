package com.carrental.listener;

import com.carrental.dao.DataInitializer;
import com.carrental.dao.XmlUtil;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.File;

/**
 * Lifecycle listener that bootstraps XML data directory and sample records
 * when the web application deploys.
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        System.out.println("[CarRentalSystem] Application initializing...");

        String realPath = context.getRealPath("/WEB-INF/data");
        if (realPath != null) {
            File dataDir = new File(realPath);
            if (!dataDir.exists()) {
                dataDir.mkdirs();
            }
            XmlUtil.setDataDirectory(dataDir.getAbsolutePath());
            System.out.println("[CarRentalSystem] Using data directory: " + dataDir.getAbsolutePath());
        } else {
            // In case of non-exploded WAR, use user.dir/data
            String fallbackPath = System.getProperty("user.home") + File.separator + ".carrental" + File.separator + "data";
            File fallbackDir = new File(fallbackPath);
            if (!fallbackDir.exists()) {
                fallbackDir.mkdirs();
            }
            XmlUtil.setDataDirectory(fallbackPath);
            System.out.println("[CarRentalSystem] Using fallback data directory: " + fallbackPath);
        }

        // Initialize and seed sample XML records if missing
        DataInitializer.initialize();

        context.setAttribute("appName", "Apex Drive Car Rental");
        System.out.println("[CarRentalSystem] Application initialized successfully.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[CarRentalSystem] Application shutting down.");
    }
}

