package controller;

import entities.User;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import service.UserIO;

@MultipartConfig
public class SetProfilePictureServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        Part filePart = request.getPart("picture");
        InputStream filecontent = filePart.getInputStream();

        User user = (User) UserIO.getUser(username);

        String path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\profilepictures\\profile_picture_" + user.getUserId() + ".jpg";
        File uploads = new File(path);
        Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);

        user.setProfilePicture(path);
        UserIO.editUserInfo(user);

        if (!user.isVerified()) {
            response.sendRedirect("pending.jsp");
        } else {
            response.sendRedirect("setprofilepicture.jsp");
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
