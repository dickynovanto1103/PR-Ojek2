<%@ include file="include/common.jsp" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>NGEEENG! - A Solution for Your Transportation</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="container">
    <div class="section">
        <div class="section-header">
            <div class="section-title">
                EDIT PROFILE INFORMATION
            </div>
        </div>
        <form class="edit" action="UpdateProfile" name="profileedit"
              method="post">
            <input type="hidden" name="id" value="${sessionScope.id}">
            <div class="edit-profilepic">
                <div>
                    <%
                        printProfile((String) session.getAttribute("profilePic"),
                                (Boolean) session.getAttribute("isDriver"),
                                "profilepic-big");
                    %>
                </div>
                <div class="field"><input type="file" name="profpic"
                                          onchange="fileGet()"></div>
            </div>
            <div class="input-set">
                <div class="label">Your Name</div>
                <div class="field">
                    <input type="text" name="name"
                           value="${sessionScope.name}">
                </div>
            </div>
            <div class="input-set">
                <div class="label">Phone</div>
                <div class="field">
                    <input type="text" name="phone"
                           value="${sessionScope.phoneNumber}">
                </div>
            </div>
            <div class="input-set">
                <div class="label">Status Driver</div>
                <div class="status field">
                    <div class="slider-check">
                        <input type="checkbox" id="status" name="status"
                            <%
                                if ((Boolean) session.getAttribute("isDriver")) {
                                    out.println("checked");
                                }
                            %>
                        >
                        <label for="status" class="slider"></label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="align-left">
                    <a href="profile.jsp">
                        <button type="button" class="button-red">BACK</button>
                    </a>
                </div>
                <div class="align-right"><input type="submit" name="submit"
                                                value="SAVE"
                                                class="button-green"></div>
            </div>
        </form>
    </div>
    <%
        if (session.getAttribute("errorMessage") != null) {
            out.println("<p style=\"color:red;\">Data invalid, please try again.<p>");
        }
    %>
</div>

<script src="js/updatePic.js"></script>

</body>
</html>
