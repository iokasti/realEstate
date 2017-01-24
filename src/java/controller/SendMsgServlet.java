package controller;

import entities.Messages;
import entities.MessagesId;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.IdsIO;
import service.PropertyIO;
import service.UserIO;

public class SendMsgServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String sender_id = request.getParameter("sender_id");
        String sender_email = request.getParameter("sendermail");
        String owner_id = request.getParameter("owner_id");
        String pid = request.getParameter("pid");
        String msg = request.getParameter("msg");
        msg = "Αποστολέας: " + sender_email + "\nΜήνυμα: " + msg;
        MessagesId msgid = new MessagesId(IdsIO.getMessageId(), Integer.parseInt(owner_id), Integer.parseInt(pid));
        Messages msge = new Messages(msgid, UserIO.getUser(sender_id), PropertyIO.getProperty(UserIO.getUser(owner_id), Integer.parseInt(owner_id), pid), msg);
        PropertyIO.add(msge, sender_id);
        response.sendRedirect("propertyinfo.jsp?userid=" + owner_id + "&pid=" + pid);
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
