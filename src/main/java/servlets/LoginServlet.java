package servlets;

import apps.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login_servlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession(true);
        if (request.getParameter("action") != null) {
            //Login
            if (request.getParameter("action").equals("login")) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                int i = Database.getInstance().loginUser(name,password);
                if(i == 1) {
                    session.setAttribute("name",name);
                    session.setAttribute("type","student");
                    response.getWriter().write("True");
                    session.setMaxInactiveInterval(300);
                }
                if(i == 2) {
                    session.setAttribute("name",name);
                    session.setAttribute("type","admin");
                    response.getWriter().write("True");
                    session.setMaxInactiveInterval(300);
                }
            }
            //Logout
            if (request.getParameter("action").equals("logout")) {
                session.invalidate();
                response.getWriter().write("True");
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}
