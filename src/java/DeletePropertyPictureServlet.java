import entities.PropertyPhotos;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.PropertyIO;

public class DeletePropertyPictureServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int i = Integer.parseInt(request.getParameter("i"));
        int uid = Integer.parseInt(request.getParameter("uid"));
        int pid = Integer.parseInt(request.getParameter("pid"));
        List<PropertyPhotos> photos = PropertyIO.getPropertyPhotos(pid);
        for (PropertyPhotos p : photos) {
            if (p.getPath().contains("picture" + String.valueOf(i))) {
                PropertyIO.delete(p);
                break;
            }
        }
        response.sendRedirect("setpropertypictures.jsp");
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
