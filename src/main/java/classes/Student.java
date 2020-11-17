package classes;

public class Student {
    public int id;
    public String fname;
    public String lname;
    public String email;
    public String group;
    public String major;
    public int year;

    public Student(int id, String fname, String lname, String email, String group, String major, int year) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.group = group;
        this.major = major;
        this.year = year;
    }

    public int getId() {
        return id;
    }

    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

    public String getEmail() {
        return email;
    }

    public String getGroupname() {
        return group;
    }

    public String getMajor() {
        return major;
    }

    public int getYear() {
        return year;
    }
}
