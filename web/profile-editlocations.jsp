<%@ page import="pojo.PojoList" %>
<%@ page import="web_service.ProfileData" %>
<%@ page import="web_service.WebService" %>
<%@ page import="javax.xml.ws.Service" %>
<%@ page import="java.util.ArrayList" %>
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
                EDIT PREFERRED LOCATIONS
            </div>
        </div>
        <div class="row">
            <div class="section-table">
                <table class="location-table">
                    <tr>
                        <th>No</th>
                        <th>Location</th>
                        <th>Actions</th>
                    </tr>
                    <%
                        Service service = WebService.getService("8080", "ProfileData");
                        ProfileData profileData = service.getPort(ProfileData.class);

                        int id = (Integer) session.getAttribute("id");

                        PojoList pojoList = profileData.getPreferredLocations(id);
                        ArrayList<String> locations = pojoList.getList();

                        for (int i = 0; i < locations.size(); i++) {
                            out.println("<tr>");
                            out.println("   <td>" + (i + 1) + "</td>");
                            out.println("   <td id=\"location-" + i + "\">");
                            out.println("       <form name=\"location-form-" + i + "\" method=\"post\">");
                            out.println("           <input type=\"hidden\" name=\"id\" value=\"" + session.getAttribute("id") + "\">");
                            out.println("           <input type=\"hidden\" name=\"oldlocation\" id=\"location-oldvalue-" + i + "\" value=\"" + locations.get(i) + "\">");
                            out.println("           <input type=\"hidden\" name=\"newlocation\" id=\"location-newvalue-" + i + "\" value=\"" + locations.get(i) + "\">");
                            out.println("       </form>");
                            out.println("       <div id=\"location-value-" + i + "\">" + locations.get(i) + "</div>");
                            out.println("   </td>");
                            out.println("   <td class=\"section-actions-column\">");
                            out.println("       <div class=\"section-edit-button-set\">");
                            out.println("           <div class=\"actions-save\" id=\"location-save-" + i + "\" onclick=\"saveloc(" + i + ")\">&#10004;</div>");
                            out.println("           <div class=\"actions-edit\" id=\"location-edit-" + i + "\" onclick=\"editloc(" + i + ")\">&#x270E;</div>");
                            out.println("           <div class=\"actions-delete\" onclick=\"deleteloc(" + i + ")\">&#10060;</div>");
                            out.println("       </div>");
                            out.println("   </td>");
                            out.println("</tr>");
                        }
                    %>
                </table>
            </div>
        </div>
        <div class="section-subheader">
            <div class="section-title">
                ADD NEW LOCATION
            </div>
        </div>
        <form action="AddLocation" class="edit" method="post">
            <div class="input-set">
                <input type="hidden" name="id" value="${sessionScope.id}">
                <div class="field"><input type="text" name="newlocation"></div>
                <input type="submit" value="ADD" class="button-green"
                       name="button">
            </div>
        </form>
        <div class="button-red">
            <a href="profile.jsp">
                <button type="button" class="button-red">BACK</button>
            </a>
        </div>
    </div>
</div>

<script src="js/updateLoc.js"></script>

</body>
</html>
