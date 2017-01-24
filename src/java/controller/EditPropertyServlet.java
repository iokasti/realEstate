package controller;

import entities.Property;
import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.PropertyIO;
import service.UserIO;

public class EditPropertyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String pid = request.getParameter("pid");
        User user = (User) UserIO.getUser(username);
        Property property = (Property) PropertyIO.getProperty(user, user.getUserId(), pid);
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

        String heatingSystem = request.getParameter("heatingSystem");
        boolean airConditioner = request.getParameter("airConditioner") != null;
        boolean parking = request.getParameter("parking") != null;
        boolean elevator = request.getParameter("elevator") != null;
        String description = request.getParameter("description");

        property.setAddress1(address1);
        property.setAddress2(address2);
        property.setAddress3(address3);
        property.setAirConditioner(airConditioner);
        property.setBuildDate(buildDate);
        property.setCity(city);
        property.setCountry(country);
        property.setDescription(description);
        property.setDescription(description);
        property.setElevator(elevator);
        property.setForRent(forRent);
        property.setForSale(forSale);
        property.setHeatingSystem(heatingSystem);
        property.setIsApartment(isApartment);
        property.setIsHouse(isHouse);
        property.setLatitude(latitude);
        property.setLongitude(longitude);
        property.setMaintenanceCharges(maintenanceCharges);
        property.setParking(parking);
        property.setPostalCode(postalCode);
        property.setPrice(price);
        property.setRegion(region);
        property.setRenovationDate(renovationDate);
        property.setRoomsNo(roomsNo);
        property.setSqMeters(sqMeters);

        Integer apFloor = null, HFloors = null;
        if (isApartment) {
            apFloor = Integer.parseInt(request.getParameter("floor"));
        } else {
            HFloors = Integer.parseInt(request.getParameter("floor"));
        }
        property.setApFloor(apFloor);
        property.setHFloors(HFloors);

        /**
         * *****************************************************
         */
        boolean result = PropertyIO.edit(property);
        if (result) {
            request.getSession().setAttribute("uid", String.valueOf(property.getId().getOwnerUserId()));
            request.getSession().setAttribute("pid", String.valueOf(property.getId().getPropertyId()));
            response.sendRedirect("editproperty.jsp?userid=" + user.getUserId() + "&pid=" + pid);
        } else {
            response.sendRedirect("propertyerror.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EditPropertyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EditPropertyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
