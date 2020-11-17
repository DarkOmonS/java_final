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
            <div id="all_news" class="p-2">
                <h1 class="h1 w-100 text-center mb-5">News</h1>
                <%boolean isNewsModerator = Database.getInstance().isModerator(name, "newsconnection");
                  if (isNewsModerator || type.equals("admin")) {%>
                <div class="mb-4 px-5 py-2 bg-dark text-white rounded">
                    <input id="news_id" type="hidden" value="">
                    <div class="form-group">
                        <label for="news_name">News title</label>
                        <input type="text" class="form-control" id="news_name">
                    </div>
                    <div class="form-group">
                        <label for="news_description">News body</label>
                        <textarea class="form-control" id="news_description" rows="3" style="resize: none"></textarea>
                    </div>
                    <p id="add_news_feedback" class="d-none alert"></p>
                    <button id="btn_add_news" class="btn btn-info p-2">Add news</button>
                    <button id="btn_edit_news" class="btn btn-info p-2">Update news</button>
                </div>
                <%}%>
                <p id="news_delete_feedback" class="d-none alert alert-success"></p>

                <sql:query var="all_news" dataSource="jdbc/project">
                    SELECT * FROM news
                </sql:query>
                <c:forEach var="news" items="${all_news.rows}">
                    <div class="news">
                        <div class="jumbotron p-2">
                            <h1 class="display-4"><c:out value="${news.name}"/></h1>
                            <hr class="my-4">
                            <p><c:out value="${news.description}"/></p>
                            <%if (isNewsModerator || type.equals("admin")) {%>
                            <div class="d-flex justify-content-end mb-2">
                                <button class="edit_news btn btn-info p-2 ml-2"
                                        data-id="<c:out value="${news.id}"/>"
                                        data-toggle="modal"
                                        data-target="#add_news_modal">
                                    <i class="far fa-edit"></i></button>
                                <button class="delete_news btn btn-danger p-2 ml-2"
                                        data-id="<c:out value="${news.id}"/>">
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

<script src="js/crud_news.js"></script>
</body>
</html>
