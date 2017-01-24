package controller;

import entities.Messages;
import entities.Property;
import entities.User;
import jBCrypt.BCrypt;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import misc.IP_Functions;
import service.IdsIO;
import service.UserIO;

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        /**
         * *****************************************************
         */

        /**
         * **************** GET USER PARAMETERS ****************
         */
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String middle_name = request.getParameter("middle_name");
        String telephone = request.getParameter("telephone");
        String telephone_2 = request.getParameter("telephone_2");
        String fax = request.getParameter("fax");
        String profile_picture = request.getParameter("profile_picture");
        boolean lessor = request.getParameter("lessor") != null;
        boolean seller = request.getParameter("seller") != null;
        boolean lessee = request.getParameter("lessee") != null;
        boolean buyer = request.getParameter("buyer") != null;
        /**
         * *****************************************************
         */

        /**
         * ****************** GET CURRENT DATE *****************
         */
        java.util.Calendar cal = java.util.Calendar.getInstance();
        java.util.Date utilDate = cal.getTime();
        Date join_date = new Date(utilDate.getTime());
        /**
         * *****************************************************
         */

        /**
         * ********************* GET USER IP *******************
         */
        String client_ip_string = getClientIpAddress(request);
        int registerIp = IP_Functions.pack(client_ip_string);
        /**
         * *****************************************************
         */

        String hashed_password = BCrypt.hashpw(password, BCrypt.gensalt()); // HASH USER PASSWORD

        /**
         * *************** CREATE USER/USERADDRESS *************
         */
        User user = new User(IdsIO.getUserId(), false, username, hashed_password, email, middle_name, name, surname, telephone, telephone_2, fax, lessor, seller, lessee, buyer, profile_picture, join_date, registerIp, address1, address2, address3, city, region, postalCode, country, new HashSet<Messages>(0), new HashSet<Property>(0));
        /**
         * *****************************************************
         */

        if (UserIO.getUser(username) == null) {
            boolean result = UserIO.add(user);
            if (result) {
                request.setAttribute("username", user.getUsername());
                RequestDispatcher reqDispatcher = request.getRequestDispatcher("setprofilepicture.jsp");
                reqDispatcher.forward(request, response);
            } else {
                response.sendRedirect("registererror.jsp");
            }
        } else {
            response.sendRedirect("alreadyexists.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
