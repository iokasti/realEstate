package controller;

import entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.UserIO;

public class EditProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        User user = (User) request.getSession().getAttribute("user");

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

        user.setBuyer(buyer);
        user.setEmail(email);
        user.setFax(fax);
        user.setLessee(lessee);
        user.setLessor(lessor);
        user.setMiddleName(middle_name);
        user.setName(name);
        user.setProfilePicture(profile_picture);
        user.setSeller(seller);
        user.setSurname(surname);
        user.setTelephone(telephone);
        user.setTelephone2(telephone_2);
        user.setAddress1(address1);
        user.setAddress2(address2);
        user.setAddress3(address3);
        user.setCity(city);
        user.setCountry(country);
        user.setPostalCode(postalCode);
        user.setRegion(region);

        UserIO.editUserInfo(user);
        response.sendRedirect("editprofile.jsp");
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
}
