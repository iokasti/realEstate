package controller;

import entities.Messages;
import entities.Property;
import entities.PropertyId;
import entities.PropertyPhotos;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.util.Date;
import java.util.HashSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.IdsIO;
import service.PropertyIO;

public class AddPropertyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        /**
         * ************** GET ADDRESS PARAMETERS ***************
         */
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String address3 = request.getParameter("address3");
        String city = request.getParameter("city");
        String region = request.getParameter("region");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        double latitude = Double.parseDouble(request.getParameter("lat"));
        double longitude = Double.parseDouble(request.getParameter("lng"));
        /**
         * *****************************************************
         */

        /**
         * **************** GET USER PARAMETERS ****************
         */
        boolean forSale, forRent;
        String forSale_forRent = request.getParameter("forSale_forRent");
        if (forSale_forRent.equals("forSale")) {
            forSale = true;
            forRent = false;
        } else {
            forSale = false;
            forRent = true;
        }
        boolean isApartment, isHouse;
        String isApartment_isHouse = request.getParameter("isApartment_isHouse");
        if (isApartment_isHouse.equals("isApartment")) {
            isApartment = true;
            isHouse = false;
        } else {
            isApartment = false;
            isHouse = true;
        }

        int buildDate = Integer.parseInt(request.getParameter("buildDate"));

        String srenovationDate = request.getParameter("renovationDate");
        Integer renovationDate = null;
        if (!srenovationDate.equals("")) {
            renovationDate = Integer.parseInt(srenovationDate);
        }

        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        symbols.setDecimalSeparator(',');
        String pattern = "#,##0.0#";
        DecimalFormat decimalFormat = new DecimalFormat(pattern, symbols);
        decimalFormat.setParseBigDecimal(true);

        String sprice = request.getParameter("price");
        BigDecimal price = (BigDecimal) decimalFormat.parse(sprice);

        String smaintenanceCharges = request.getParameter("maintenanceCharges");
        BigDecimal maintenanceCharges = (BigDecimal) decimalFormat.parse(smaintenanceCharges);

        Float sqMeters = Float.parseFloat(request.getParameter("sqMeters"));
        int roomsNo = Integer.parseInt(request.getParameter("roomsNo"));

        Integer apFloor = null, HFloors = null;
        if (isApartment) {
            apFloor = Integer.parseInt(request.getParameter("floor"));
        } else {
            HFloors = Integer.parseInt(request.getParameter("floor"));
        }

        String heatingSystem = request.getParameter("heatingSystem");
        boolean airConditioner = request.getParameter("airConditioner") != null;
        boolean parking = request.getParameter("parking") != null;
        boolean elevator = request.getParameter("elevator") != null;
        String description = request.getParameter("description");
        /**
         * *****************************************************
         */

        /**
         * ****************** GET CURRENT DATE *****************
         */
        java.util.Calendar cal = java.util.Calendar.getInstance();
        java.util.Date utilDate = cal.getTime();
        Date dateAdded = new Date(utilDate.getTime());
        /**
         * *****************************************************
         */

        /**
         * *********** CREATE PROEPERTY/PROPERTYADDRESS *********
         */
        User user = (User) request.getSession().getAttribute("user");
        PropertyId propertyId;
        Property property = null;
        if (user != null) {
            propertyId = new PropertyId(IdsIO.getPropertyId(), user.getUserId());
            property = new Property(propertyId, user, dateAdded, forSale, forRent, isApartment, isHouse, buildDate, renovationDate, price, maintenanceCharges, sqMeters, roomsNo, null, null, heatingSystem, airConditioner, parking, elevator, 0, description, address1, address2, address3, city, region, postalCode, country, latitude, longitude, new HashSet<PropertyPhotos>(0), new HashSet<Messages>(0));
            if (isApartment) {
                property.setApFloor(apFloor);
            } else {
                property.setHFloors(HFloors);
            }
            //user.getProperties().add(property);
        }

        /**
         * *****************************************************
         */
        boolean result = PropertyIO.add(property, user);
        if (result) {
            request.getSession().setAttribute("uid", String.valueOf(property.getId().getOwnerUserId()));
            request.getSession().setAttribute("pid", String.valueOf(property.getId().getPropertyId()));
            response.sendRedirect("setpropertypictures.jsp");
        } else {
            response.sendRedirect("propertyerror.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(AddPropertyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(AddPropertyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    public static String getClientIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}
