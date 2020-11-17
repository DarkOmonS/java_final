<%  String name = (String) session.getAttribute("name");
    String type = (String) session.getAttribute("type");
    if (session.getAttribute("name") == null) { %>
        <c:redirect url="login.jsp"/>
<%}%>

<nav class="navbar navbar-expand-md navbar-dark mb-4 bg-dark">
    <a class="navbar-brand" href="#">Astana IT University</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a href="main_page.jsp" class="nav-link">News</a>
            </li>
            <li class="nav-item">
                <a href="clubs.jsp" class="nav-link">Clubs</a>
            </li>
            <li class="nav-item">
                <a href="events.jsp" class="nav-link">Events</a>
            </li>
            <%if (type.equals("admin")) { %>
                <li class="nav-item">
                    <a href="students.jsp" class="nav-link">Students</a>
                </li>
                <li class="nav-item">
                    <a href="add_student.jsp" class="nav-link">Add students</a>
                </li>
            <%}%>
        </ul>
        <div class="dropdown">
            <button class="btn btn-outline-success dropdown-toggle" style="width: 150px;" type="button"
                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <%out.println(name);%>
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <button class="dropdown-item" id="btn_logout">Log out</button>
            </div>
        </div>
    </div>
</nav>

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