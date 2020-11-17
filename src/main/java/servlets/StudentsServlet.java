package servlets;

import apps.Database;
import classes.Student;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/students_servlet")
public class StudentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        if (request.getParameter("action") != null) {
            if (request.getParameter("action").equals("search")) {
                String search = request.getParameter("search");
                ArrayList<Student> students = Database.getInstance().getStudents(search);
                session.setAttribute("students", students);
                response.getWriter().write("True");
            } else if (request.getParameter("action").equals("add")) {
                String fname = request.getParameter("fname");
                String lname = request.getParameter("lname");
                String email = request.getParameter("email");
                String groupname = request.getParameter("groupname");
                String major = request.getParameter("major");
                int year = Integer.parseInt(request.getParameter("year"));
                String password = request.getParameter("password");
                if (Database.getInstance().insertStudent(fname, lname, email, groupname, major, year, password) == 1) {
                    response.getWriter().write("True");
                }
            }

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
