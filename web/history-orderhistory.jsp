<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pojo.PojoList" %>
<%@ page import="web_service.HistoryData" %>
<%@ page import="web_service.WebService" %>
<%@ page import="javax.xml.ws.Service" %>
<%@ page import="identity_service.IdentityServiceDbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="include/common.jsp" %>

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
        out.println(printNavbar(1));
    %>
    <div class="section">
        <div class="section-header">
            <div class="section-title">
                TRANSACTION HISTORY
            </div>
        </div>
        <div class="nav">
            <a href="history-orderhistory.jsp">
                <div class="nav-item-transaction active">MY PREVIOUS ORDERS
                </div>
            </a>
            <a href="history-driverhistory.jsp">
                <div class="nav-item-transaction">DRIVER HISTORY</div>
            </a>
        </div>
        <%
            Service service = WebService.getService("8080", "HistoryData");
            HistoryData historyData = service.getPort(HistoryData.class);

            int userId = (Integer) session.getAttribute("id");
            PojoList pojoList = historyData.getPastOrders("id_user", userId);
            ArrayList<String> orders = pojoList.getList();

            if (!orders.isEmpty()) {
                for (int i = 0; i < orders.size(); i++) {
                    JSONObject order = null;

                    try {
                        order = new JSONObject(orders.get(i));
                    } catch (org.json.JSONException je) {
                        je.printStackTrace();
                    }

                    out.println("<div class=\"row\" id=\"history-" + i + "\">");
        %>
        <div>
            <%
                //query ke database untuk mendapatkan profile picture dari database Identity Service tabel user

                int idDriver = (Integer) order.get("id_driver");
                int idConsumer = (Integer) order.get("id_user");
                String consumerName = historyData.getNameById(idConsumer);
                int hidden_driver = (Integer) order.get("hidden_driver");
                int hidden_user = (Integer) order.get("hidden_user");
                if(hidden_user!=1) {
                    IdentityServiceDbConnection identityServiceDbConnection = new IdentityServiceDbConnection();
                    Connection connection = identityServiceDbConnection.getConnection();

                    int id = (Integer) session.getAttribute("id");
                    try {
                        String query = "SELECT profilePicture FROM user WHERE id='" + idDriver + "'";

                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery(query);

                        while (resultSet.next()) {
                            String profilePic = resultSet.getString("profilePicture");
                            out.println(printProfile(profilePic,
                                    (Boolean) session.getAttribute("isDriver"),
                                    "profilepic-big"));
                        }

                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
        </div>

        <div class="history-label">
            <%

                        String driverName = historyData.getNameById(idDriver);
                        if(hidden_user!=1) {
                            try {

                                out.println("   <div class=\"history-date-label\">" + order.get("date") + "</div>");
                                out.println("   <div class=\"history-driver-name-label\">" + driverName + "</div>");
                                out.println("   <div class=\"history-other-data\">" + order.get("origin") + " &#8594 " + order.get("destination") + "\"");
                                out.println("       <br>gave <span class=\"profile-rating\">" + order.get("order_rating") + "</span> stars to this orders");
                                out.println("       <br>and left comment :");
                                out.println("       <div class=\"history-comment\">" + order.get("comment") + "</div>");
                                out.println("   </div>");
                                out.println("   <div>");
                                out.println("       <form method=\"post\" action=\"HistoryHide\">");
                                out.println("           <input type=\"hidden\" name=\"order_id\" value=\"" + order.get("order_id") + "\">");
                                out.println("           <input type=\"hidden\" name=\"type\" value=\"user\">");
                                out.println("           <button class=\"button-red\">HIDE</input>");
                                out.println("       </form>");
                                out.println("   </div>");
                                out.println("</div>");

                            } catch (org.json.JSONException je) {
                                je.printStackTrace();
                            }
                        }
                    }
                } else {
                    out.println("<div class=\"section\">No History Yet!</div>");
                }

            %>
        </div>
    </div>
</div>

<script src="js/hide.js"></script>

</body>
</html>
