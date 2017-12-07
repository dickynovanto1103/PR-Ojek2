<%@ page import="web_service.OrderData" %>
<%@ page import="web_service.WebService" %>
<%@ page import="javax.xml.ws.Service" %>

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
        out.println(printNavbar(0));
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
            <div class="step">
                <div class="step-no">2</div>
                <div class="step-guide">Select A Driver</div>
            </div>
            <div class="step active">
                <div class="step-no">3</div>
                <div class="step-guide active">Complete your orders</div>
            </div>
        </div>
        <div class="section-header">
            <div class="section-title">
                HOW WAS IT?
            </div>
        </div>
        <!-- form begins here -->
        <form action="SaveOrder" method="post">
            <!--filled variable-->
            <input type="hidden" name="origin"
                   value="${sessionScope.origin}">
            <input type="hidden" name="destination"
                   value="${sessionScope.destination}">
            <input type="hidden" name="driverId"
                   value="${sessionScope.driverId}">
            <input type="hidden" name="userId"
                   value="${sessionScope.userId}">

            <div class="driver-review">
                <div class="driver-profile">
                    <div class="section-profilepic">
                        <%
                            Service service = WebService.getService("8080", "OrderData");
                            OrderData orderData = service.getPort(OrderData.class);

                            String profilePic = orderData.getProfilePicById(Integer.parseInt((String) session.getAttribute("driverId")));
                            out.println(printProfile(profilePic, true, "profilepic-big-round"));
                        %>
                    </div>
                    <div class="driver-label">
                        <div class="driver-label-id">
                            <div class='driver-eval-username'>
                                <%
                                    String username = orderData.getUsernameById(Integer.parseInt((String) session.getAttribute("driverId")));
                                    out.println(username);
                                %>
                            </div>
                            <div class="driver-eval-name">
                                <%
                                    String name = orderData.getNameById(Integer.parseInt((String) session.getAttribute("driverId")));
                                    out.println(name);
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="input-grading">
                    <div class="driver-star-rating">
                        <div class="driver-rate">
                            <input type="radio" id="rating1" name="rating"
                                   value=1>
                            <label for="rating1"> ★ </label>
                            <input type="radio" id="rating2" name="rating"
                                   value=2>
                            <label for="rating2"> ★ </label>
                            <input type="radio" id="rating3" name="rating"
                                   value=3 checked>
                            <label for="rating3"> ★ </label>
                            <input type="radio" id="rating4" name="rating"
                                   value=4>
                            <label for="rating4"> ★ </label>
                            <input type="radio" id="rating5" name="rating"
                                   value=5>
                            <label for="rating5"> ★ </label>
                        </div>
                    </div>
                    <div class="driver-eval-comment">
                        <div class="field  wide">
                            <input type="text" name="comment"
                                   placeholder="Your comment...">
                        </div>
                        <div class="row align-right"><input type="submit"
                                                            class="button-green"
                                                            value="Complete Order">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>