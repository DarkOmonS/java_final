<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
<head>
    <title>Students</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
            integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
            crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/bf20fcd267.js" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="header.jsp"%>

<div class="container-fluid">
    <h1 class="h1 w-100 text-center">Students</h1>
    <div class="row mb-4">
        <div class="col">
            <form class="form-inline my-2 my-lg-0">
                <input id="search_text" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button id="search" class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <sql:query var="all_students" dataSource="jdbc/project">
                SELECT * FROM students
            </sql:query>
            <table class="table table-striped table-dark">
                <thead>
                <tr>
                    <th scope="col">First name</th>
                    <th scope="col">Last name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Group</th>
                    <th scope="col">Major</th>
                    <th scope="col">Year</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="student" items="${all_students.rows}">
                    <tr>
                        <th><c:out value="${student.fname}"/></th>
                        <td><c:out value="${student.lname}"/></td>
                        <td><c:out value="${student.email}"/></td>
                        <td><c:out value="${student.groupname}"/></td>
                        <td><c:out value="${student.major}"/></td>
                        <td><c:out value="${student.year}"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="col-6">
            <c:if test="${!empty sessionScope.students}" >
                <c:set var="students" value="${sessionScope.students}" />
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">First name</th>
                        <th scope="col">Last name</th>
                        <th scope="col">Email</th>
                        <th scope="col">Group</th>
                        <th scope="col">Major</th>
                        <th scope="col">Year</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <th scope="row"><c:out value="${student.fname}"/></th>
                            <td><c:out value="${student.lname}"/></td>
                            <td><c:out value="${student.email}"/></td>
                            <td><c:out value="${student.groupname}"/></td>
                            <td><c:out value="${student.major}"/></td>
                            <td><c:out value="${student.year}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>

<script>
$(document).ready(function () {
    $('#search').click(function () {
        let search = $('#search_text').val()
        $.ajax({
            url: 'students_servlet',
            type: 'post',
            data: {action: 'search', search: search},
            success: function (data) {
                if (data === 'True') {
                    location.reload()
                }
            }
        })
    })
})
</script>
</body>
</html>
