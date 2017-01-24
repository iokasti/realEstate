package controller;

import entities.User;
import jBCrypt.BCrypt;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.UserIO;

public class ChangeUserPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        User user = (User) request.getSession().getAttribute("user");
        String password = request.getParameter("newpassword");
        String oldpassword = request.getParameter("oldpassword");
        String hashed_password = BCrypt.hashpw(password, BCrypt.gensalt()); // HASH USER PASSWORD

        if (BCrypt.checkpw(oldpassword, user.getPassword())) {
            user.setPassword(hashed_password);
            UserIO.editUserInfo(user);
            request.setAttribute("status", "success");
            RequestDispatcher reqDispatcher = request.getRequestDispatcher("changepassword.jsp");
            reqDispatcher.forward(request, response);
        } else {
            request.setAttribute("status", "fail");
            RequestDispatcher reqDispatcher = request.getRequestDispatcher("changepassword.jsp");
            reqDispatcher.forward(request, response);
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

}
