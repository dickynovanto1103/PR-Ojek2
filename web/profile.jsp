<%@ include file="include/common.jsp" %>

<%@ page import="pojo.PojoList" %>
<%@ page import="web_service.ProfileData" %>
<%@ page import="web_service.WebService" %>
<%@ page import="javax.xml.ws.Service" %>
<%@ page import="java.util.ArrayList" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>NGEEENG! - A Solution for Your Transportation</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="container">
    <%
        out.println(printHeader((String) session.getAttribute("username")));
        out.println(printNavbar(2));

        session.removeAttribute("errorMessage");
    %>

    <div class="section">
        <div class="section-header">
            <div class="section-title">
                MY PROFILE
            </div>
            <div class="section-edit-button">
                <a href="profile-editprofile.jsp">&#x270E;</a>
            </div>
        </div>
        <div class="section-profile">
            <div>
                <%
                    out.println(printProfile((String) session.getAttribute("profilePic"),
                            (Boolean) session.getAttribute("isDriver"),
                            "profilepic-big-round"));
                %>
            </div>
            <div class="profile-username">@${sessionScope.username}</div>
            <div class="profile-name">${sessionScope.name}</div>
            <div class="profile-status">
                <span class="profile-type">
                    <%
                        if ((Boolean) session.getAttribute("isDriver")) {
                            out.println("Driver");
                        } else {
                            out.println("Non-driver");
                        }
                    %>
				</span>
                <%
                    if (session.getAttribute("driverRating") != null) {
                        out.println("| <span class=\"profile-rating\">  &#9734 " + Math.round((Float) session.getAttribute("driverRating")) + " (" + session.getAttribute("driverVotes") + " votes)</span>");
                    }
                %>
            </div>
            <div class="profile-email">
                &#x2709;${sessionScope.email}
            </div>
            <div class="profile-phone">
                &#x260F;${sessionScope.phoneNumber}
            </div>
        </div>

        <%
            if ((Boolean) session.getAttribute("isDriver")) {
                out.println("<div class=\"section-subheader\">" +
                        "<div class=\"section-title\">Preferred Locations</div>" +
                        "<div class=\"section-edit-button\">" +
                        "<a href=\"profile-editlocations.jsp\">&#x270E;</a>" +
                        "</div></div>");

                Service service = WebService.getService("8080", "ProfileData");
                ProfileData profileData = service.getPort(ProfileData.class);

                int id = (Integer) session.getAttribute("id");

                PojoList pojoList = profileData.getPreferredLocations(id);
                ArrayList<String> locations = pojoList.getList();

                if (locations.size() != 0) {
                    out.println("<div class=\"section-location\">");

                    for (String place : locations) {
                        out.println("<ul><li>" + place + "</li>");
                    }
                    for (String place : locations) {
                        out.println("</ul>");
                    }
                    out.println("</div>");
                } else {
                    out.println("No Preferred Location Yet");
                }
            }
        %>
    </div>
</div>

</body>
</html>
