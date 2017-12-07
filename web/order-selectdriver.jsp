<%@ page import="org.json.JSONObject" %>
<%@ page import="web_service.OrderData" %>
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
    <%
        out.println(printHeader((String) session.getAttribute("username")));
        out.println(printNavbar(1));
    %>
    <div class="section">
        <div class="section-header">
            <div class="section-title">
                MAKE AN ORDER
            </div>
        </div>
        <div class="section-step row">
            <div class="step">
                <div class="step-no">1</div>
                <div class="step-guide">Select Destination</div>
            </div>
            <div class="step active">
                <div class="step-no">2</div>
                <div class="step-guide">Select A Driver</div>
            </div>
            <div class="step">
                <div class="step-no">3</div>
                <div class="step-guide">Complete your orders</div>
            </div>
        </div>

        <%
            Service service = WebService.getService("8080", "OrderData");
            OrderData orderData = service.getPort(OrderData.class);
        %>

        <div class="section-select-driver">
            PREFERRED DRIVERS:
            <%
                if (session.getAttribute("preferredDriver") != null) {
                    String preferredDriver = (String) session.getAttribute("preferredDriver");

                    String driver = orderData.getPreferredDriver(preferredDriver,
                            (String) session.getAttribute("origin"),
                            (Integer) session.getAttribute("id"));

                    JSONObject driverInfo = null;

                    try {
                        driverInfo = new JSONObject(driver);
                    } catch (org.json.JSONException je) {
                        je.printStackTrace();
                    }

                    if (driverInfo != null) {
                        int driverId = 0;
                        try {
                            driverId = (Integer) driverInfo.get("id");
                        } catch (org.json.JSONException je) {
                            je.printStackTrace();
                        }
            %>
            <form action="CompleteOrder" method="post">
                <div class="section-content">
                    <input type="hidden" name="origin"
                           value="${sessionScope.origin}">
                    <input type="hidden" name="destination"
                           value="${sessionScope.destination}">
                    <input type="hidden" name="userId"
                           value="${sessionScope.userId}">
                    <input type="hidden" name="driverId"
                           value=<% out.println(driverId); %>>

                    <div class="section-profilepic">
                        <%
                            try {
                                printProfile((String) driverInfo.get("profilePic"), true, "profilepic-big");
                            } catch (org.json.JSONException je) {
                                je.printStackTrace();
                            }
                        %>
                    </div>
                    <div class="section-stacked">
                        <div class="history-label align-left">
                            <div class="driver-name-label">
                                <%
                                    try {
                                        out.println(driverInfo.get("name"));
                                    } catch (org.json.JSONException je) {
                                        je.printStackTrace();
                                    }
                                %>
                            </div>
                            <div class="profile-rating"> &#9734
                                <%
                                    try {
                                        out.println(driverInfo.get("rating"));
                                        out.println(" <span class=\"profile-votes\">(" + driverInfo.get("votes") + " votes)</span>");
                                    } catch (org.json.JSONException je) {
                                        je.printStackTrace();
                                    }
                                %>
                            </div>
                        </div>
                        <div class="button-section align-right">
                            <input type="submit"
                                   class="button-green"
                                   value="I choose you">
                        </div>
                    </div>
                </div>
            </form>
            <%
                    } else {
                        out.println("<div class=\"section-no-results\">" +
                                "<br>No Results Found :(" +
                                "<br><br>" +
                                "</div>");
                    }
                } else {
                    out.println("<div class=\"section-no-results\">" +
                            "<br>No Results Found :(" +
                            "<br><br>" +
                            "</div>");
                }
            %>
        </div>
        <br>
        <div class="section-select-driver">
            OTHER DRIVERS:
            <%
                ArrayList<String> drivers = orderData.getAvailableDrivers(
                        (String) session.getAttribute("origin"),
                        (Integer) session.getAttribute("id")).getList();

                if (!drivers.isEmpty()) {
                    for (String driver : drivers) {
                        JSONObject driverInfo = null;

                        try {
                            driverInfo = new JSONObject(driver);
                        } catch (org.json.JSONException je) {
                            je.printStackTrace();
                        }

                        int driverId = 0;
                        try {
                            driverId = (Integer) driverInfo.get("id");
                        } catch (org.json.JSONException je) {
                            je.printStackTrace();
                        }
            %>
            <form action="CompleteOrder" method="post">
                <!-- NAMPILIN USER YANG BISA*/ -->
                <div class="section-content">
                    <input type="hidden" name="origin"
                           value="${sessionScope.origin}">
                    <input type="hidden" name="destination"
                           value="${sessionScope.destination}">
                    <input type="hidden" name="userId"
                           value="${sessionScope.userId}">
                    <input type="hidden" name="driverId"
                           value=<% out.println(driverId); %>>
                    <div class="section-profilepic">
                        <%
                            try {
                                out.println(printProfile((String) driverInfo.get("profilePic"),
                                        true, "profilepic-big"));
                            } catch (org.json.JSONException je) {
                                je.printStackTrace();
                            }
                        %>
                    </div>
                    <div class="section-stacked">
                        <div class="history-label align-left">
                            <div class="driver-name-label">
                                <%
                                    try {
                                        out.println(driverInfo.get("name"));
                                    } catch (org.json.JSONException je) {
                                        je.printStackTrace();
                                    }
                                %>
                            </div>
                            <div class="profile-rating"> &#9734
                                <%
                                    try {
                                        out.println(driverInfo.get("rating"));
                                        out.println("<span class=\"profile-votes\"> (" + driverInfo.get("votes") + " votes)</span>");
                                    } catch (org.json.JSONException je) {
                                        je.printStackTrace();
                                    }
                                %>
                            </div>
                        </div>
                        <div class="button-section align-right">
                            <input type="submit"
                                   class="button-green"
                                   value="I choose you">
                        </div>
                    </div>
                </div>
            </form>
            <%
                    }
                } else {
                    out.println("<div class=\"section-no-results\">" + "<br>No Results Found :(" + "<br><br>" + "</div>");
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
