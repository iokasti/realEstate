package controller;

import entities.Property;
import entities.PropertyPhotos;
import entities.PropertyPhotosId;
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
import service.IdsIO;
import service.PropertyIO;
import service.UserIO;

@MultipartConfig
public class SetPropertyPicturesServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String pid = request.getParameter("pid");
        User user = (User) UserIO.getUser(username);
        Property property = (Property) PropertyIO.getProperty(user, user.getUserId(), pid);
        String type2 = request.getParameter("type2");
        String path;
        Part filePart = null;
        InputStream filecontent;
        File uploads;

        PropertyPhotos photo;
        PropertyPhotosId photoid;
        filePart = request.getPart("picture1");
        if (filePart.getSize() != 0) {
            filecontent = filePart.getInputStream();
            path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\propertiespictures\\property_picture1_us" + user.getUserId() + "_pr" + pid + ".jpg";
            uploads = new File(path);
            Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);
            photoid = new PropertyPhotosId(IdsIO.getPhotoId(), Integer.parseInt(pid), user.getUserId());
            photo = new PropertyPhotos(photoid, property, path);
            PropertyIO.add(photo);
            filePart = null;
        }

        filePart = request.getPart("picture2");
        if (filePart.getSize() != 0) {
            filecontent = filePart.getInputStream();
            path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\propertiespictures\\property_picture2_us" + user.getUserId() + "_pr" + pid + ".jpg";
            uploads = new File(path);
            Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);
            photoid = new PropertyPhotosId(IdsIO.getPhotoId(), Integer.parseInt(pid), user.getUserId());
            photo = new PropertyPhotos(photoid, property, path);
            PropertyIO.add(photo);
            filePart = null;
        }

        filePart = request.getPart("picture3");
        if (filePart.getSize() != 0) {
            filecontent = filePart.getInputStream();
            path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\propertiespictures\\property_picture3_us" + user.getUserId() + "_pr" + pid + ".jpg";
            uploads = new File(path);
            Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);
            photoid = new PropertyPhotosId(IdsIO.getPhotoId(), Integer.parseInt(pid), user.getUserId());
            photo = new PropertyPhotos(photoid, property, path);
            PropertyIO.add(photo);
            filePart = null;
        }
        filePart = request.getPart("picture4");
        if (filePart.getSize() != 0) {
            filecontent = filePart.getInputStream();
            path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\propertiespictures\\property_picture4_us" + user.getUserId() + "_pr" + pid + ".jpg";
            uploads = new File(path);
            Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);
            photoid = new PropertyPhotosId(IdsIO.getPhotoId(), Integer.parseInt(pid), user.getUserId());
            photo = new PropertyPhotos(photoid, property, path);
            PropertyIO.add(photo);
            filePart = null;
        }

        filePart = request.getPart("picture5");
        if (filePart.getSize() != 0) {
            filecontent = filePart.getInputStream();
            path = "C:\\Users\\Konstantinos\\Documents\\NetBeansProjects\\FAR\\web\\images\\propertiespictures\\property_picture5_us" + user.getUserId() + "_pr" + pid + ".jpg";
            uploads = new File(path);
            Files.copy(filecontent, uploads.toPath(), REPLACE_EXISTING);
            photoid = new PropertyPhotosId(IdsIO.getPhotoId(), Integer.parseInt(pid), user.getUserId());
            photo = new PropertyPhotos(photoid, property, path);
            PropertyIO.add(photo);
        }

        System.out.println("A" + type2);
        if (type2.equals("set")) {
            response.sendRedirect("setpropertypictures.jsp?uid=" + user.getUserId() + "&pid=" + pid);
        } else {
            response.sendRedirect("propertysuccess.jsp");
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
