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
            <div class="step active">
                <div class="step-no-container">
                    <div class="step-no">1</div>
                </div>
                <div class="step-guide">Select Destination</div>
            </div>
            <div class="step">
                <div class="step-no-container">
                    <div class="step-no">2</div>
                </div>
                <div class="step-guide">Select A Driver</div>
            </div>
            <div class="step">
                <div class="step-no-container">
                    <div class="step-no">3</div>
                </div>
                <div class="step-guide">Complete your orders</div>
            </div>
        </div>
        <form action="SelectDriver" name="order" method="post"
              onsubmit="return validateOrder('order')">
            <input type="hidden" name="userId" value="${sessionScope.id}">
            <div class="input-set">
                <div class="label">Picking point</div>
                <div class="field"><input type="text" name="origin"></div>
            </div>
            <div class="input-set">
                <div class="label">Destination</div>
                <div class="field"><input type="text" name="destination"></div>
            </div>
            <div class="input-set">
                <div class="label">Preferred Driver</div>
                <div class="field"><input type="text" name="preferreddriver"
                                          placeholder="(optional)"></div>
            </div>
            <div class="row">
                <div class="align-middle"><input type="submit" value="NEXT"
                                                 class="button-green"></div>
            </div>
        </form>
    </div>
</div>

<script src="js/validate.js"></script>

</body>
</html>