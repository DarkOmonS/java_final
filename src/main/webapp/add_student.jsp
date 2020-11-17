<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
    <div class="row">
        <div class="col">
            <div class="w-50 mx-auto p-3 bg-dark text-white rounded">
                <div class="form-group">
                    <label for="fname">First name</label>
                    <input type="text" class="form-control" id="fname">
                </div>
                <div class="form-group">
                    <label for="lname">Last name</label>
                    <input type="text" class="form-control" id="lname">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" class="form-control" id="email">
                </div>
                <div class="form-group">
                    <label for="groupname">Group name</label>
                    <input type="text" class="form-control" id="groupname">
                </div>
                <div class="form-group">
                    <label for="major">Major</label>
                    <input type="text" class="form-control" id="major">
                </div>
                <div class="form-group">
                    <label for="year">Year</label>
                    <input type="number" class="form-control" id="year">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" class="form-control" id="password">
                </div>
                <p id="add_student_feedback" class="d-none alert"></p>
                <button id="btn_add_student" class="btn btn-info p-2">Add student</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#btn_add_student').click(function () {
            let fname = $('#fname').val()
            let lname = $('#lname').val()
            let email = $('#email').val()
            let groupname = $('#groupname').val()
            let major = $('#major').val()
            let year = $('#year').val()
            let password = $('#password').val()
            if (fname.length===0||lname.length===0||email.length===0||groupname.length===0||major.length===0||
                year.length===0||password.length===0) {
                $('#add_student_feedback').removeClass('d-none alert-success').addClass('alert-danger').text('Please fill all fields')
            }

            $.ajax({
                url: 'students_servlet',
                type: 'post',
                data: {action: 'add', fname:fname, lname:lname, email:email, groupname:groupname, major:major,
                        year:year, password:password},
                success: function (data) {
                    if (data === 'True') {
                        location.reload()
                        $('#add_student_feedback').removeClass('d-none alert-danger').addClass('alert-success').text('Student added')
                    }
                }
            })
        })
    })
</script>
</body>
</html>
