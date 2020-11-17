<%@ page import="apps.Database" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Main page</title>
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

<div class="container">
    <div class="row">
        <div class="col">
            <div id="all_clubs" class="p-2">
                <h1 class="h1 w-25 mx-auto mb-5">Clubs</h1>
                <%boolean isClubModerator = Database.getInstance().isModerator(name, "clubconnection");
                    if (isClubModerator || type.equals("admin")) {%>
                <div class="mb-4 px-5 py-2 bg-dark text-white rounded">
                    <input id="club_id" type="hidden" value="">
                    <div class="form-group">
                        <label for="club_name">Club title</label>
                        <input type="text" class="form-control" id="club_name">
                    </div>
                    <div class="form-group">
                        <label for="club_description">Club body</label>
                        <textarea class="form-control" id="club_description" rows="3" style="resize: none"></textarea>
                    </div>
                    <p id="add_club_feedback" class="d-none alert"></p>
                    <button id="btn_add_club" class="btn btn-info p-2">Add club</button>
                    <button id="btn_edit_club" class="btn btn-info p-2">Update club</button>
                </div>
                <%}%>

                <sql:query var="all_clubs" dataSource="jdbc/project">
                    SELECT * FROM club
                </sql:query>
                <c:forEach var="club" items="${all_clubs.rows}">
                    <div class="clubs">
                        <div class="jumbotron p-2">
                            <h1 class="display-4"><c:out value="${club.name}"/></h1>
                            <hr class="my-4">
                            <p><c:out value="${club.description}"/></p>
                            <%if (isClubModerator || type.equals("admin")) {%>
                            <div class="d-flex justify-content-end mb-2">
                                <button class="edit_club btn btn-info p-2 ml-2"
                                        data-id="<c:out value="${club.id}"/>"
                                        data-toggle="modal"
                                        data-target="#add_club_modal">
                                    <i class="far fa-edit"></i></button>
                                <button class="delete_club btn btn-danger p-2 ml-2"
                                        data-id="<c:out value="${club.id}"/>">
                                    <i class="far fa-trash-alt"></i></button>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="js/crud_club.js"></script>
<script>
    $(document).ready(function () {
        $('#btn_logout').click(function () {
            $.ajax({
                url: 'login_servlet',
                type: 'post',
                data: {action: 'logout'},
                success: function (data) {
                    if (data === 'True') {
                        location.href = 'login.jsp'
                    }
                }
            })
        });
    })
</script>
</body>
</html>
