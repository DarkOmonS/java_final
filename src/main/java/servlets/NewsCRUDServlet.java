package servlets;

import apps.Database;
import classes.Item;
import classes.News;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/news_CRUD_servlet")
public class NewsCRUDServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        if (request.getParameter("news_crud_type") != null) {
            if (request.getParameter("news_crud_type").equals("add")) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                if (Database.getInstance().insert(name, description, "news") == 1) {
                    response.getWriter().write("True");
                }
            }
            if (request.getParameter("news_crud_type").equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                if (Database.getInstance().update(id, name, description,"news") == 1) {
                    response.getWriter().write("True");
                }
            }
            if (request.getParameter("news_crud_type").equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (Database.getInstance().delete(id,"news") == 1) {
                    response.getWriter().write("True");
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        int id = Integer.parseInt(request.getParameter("id"));
        Item news = Database.getInstance().getItem(id, "news");
        String json = new Gson().toJson(news);
        response.getWriter().write(json);
    }
}
