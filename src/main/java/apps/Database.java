package apps;

import classes.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Database {
    private static final Database instance = new Database();

    public static Database getInstance() {
        return instance;
    }

    private Database() {
    }

    private static Connection getConnection() {
        Context initialContext;
        Connection connection = null;
        try {
            initialContext = new InitialContext();
            Context envCtx = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/project");
            connection = ds.getConnection();
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public int loginUser(String name, String password) {
        String sql = "SELECT * FROM students WHERE fname='" + name + "' and password='" + password + "'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                rs.close();
                s.close();
                connection.close();
                return 1;
            }
            sql = "SELECT * FROM administrator WHERE adminname='" + name + "' and password='" + password + "'";
            s = connection.createStatement();
            rs = s.executeQuery(sql);
            while (rs.next()) {
                rs.close();
                s.close();
                connection.close();
                return 2;
            }
            rs.close();
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean isModerator(String name, String table) {
        String sql = "select student_id from " + table + " where student_id = (select id from students where fname = '" + name + "')";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                rs.close();
                s.close();
                connection.close();
                return true;
            }
            rs.close();
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Item getItem(int id, String table) {
        Item item = null;
        String sql = "select name, description from " + table + " where id='" + id + "'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                switch (table) {
                    case "news":
                        item = new News(id, rs.getString("name"), rs.getString("description"));
                    case "club":
                        item = new Club(id, rs.getString("name"), rs.getString("description"));
                    case "event":
                        item = new Event(id, rs.getString("name"), rs.getString("description"));
                }
            }
            rs.close();
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    public int insert(String name, String description, String table) {
        String sql = "insert into " + table + "(name, description) values('" + name + "', '" + description + "')";
        return executeQuery(sql);
    }

    public int insertStudent(String fname, String lname, String email, String groupname, String major, int year, String password) {
        String sql = "insert into students (fname, lname, email, groupname, major, year, password) values('" + fname +
                     "', '" + lname + "', '"+email+"', '"+groupname+"', '"+major+"', "+year+", '"+password+"')";
        return executeQuery(sql);
    }

    public int update(int id, String name, String description, String table) {
        String sql = "update " + table + " set name='" + name + "', description='" + description + "' where id='" + id + "'";
        return executeQuery(sql);
    }

    public int delete(int id, String table) {
        String sql = "delete from " + table + " where id='" + id + "'";
        return executeQuery(sql);
    }

    private int executeQuery(String sql) {
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            if (s.executeUpdate(sql) > 0) {
                s.close();
                connection.close();
                return 1;
            }
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Student> getStudents(String search) {
        ArrayList<Student> students = new ArrayList<>();
        String sql = "select * from students where fname like '%" + search + "%' or lname like '%" + search +
                "%' or email like '%" + search + "%'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            if (rs.next()) {
                students.add(new Student(rs.getInt("id"), rs.getString("fname"), rs.getString("lname"),
                        rs.getString("email"), rs.getString("groupname"),
                        rs.getString("major"), rs.getInt("year")));
            } else {
                sql = "select * from students where groupname like '%" + search + "%' or major like '%" + search +
                        "%' or year like '%" + search + "%'";
                rs = s.executeQuery(sql);
                while (rs.next()) {
                    students.add(new Student(rs.getInt("id"), rs.getString("fname"), rs.getString("lname"),
                            rs.getString("email"), rs.getString("groupname"),
                            rs.getString("major"), rs.getInt("year")));
                }
            }
            rs.close();
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}
