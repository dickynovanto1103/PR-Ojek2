<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>NGEEENG! - A Solution for Your Transportation</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="container green-box">
    <div class="title">
        <span>LOGIN</span>
    </div>
    <div class="row">
        <form class="form-center login-form" method="post" action="Login">
            <div class="input-set">
                <div class="label">Username</div>
                <div class="field"><input type="text" name="username"
                                          placeholder="Username"></div>
            </div>
            <div class="input-set">
                <div class="label">Password</div>
                <div class="field"><input type="password" name="password"
                                          placeholder="Password"></div>
            </div>
            <div class="login-button-set input-set">
                <div class="register-section"><a href="signup.jsp">Don't have an
                    account?</a></div>
                <div class="button-section"><input class="button-green"
                                                   type="submit" VALUE="Log In">
                </div>
            </div>
        </form>

    </div>
    <%
        if (session.getAttribute("errorMessageTokenExpired") != null) {
            out.println("<p style=\"color:red;\">Token expired, please login again.<p>");
        }
        if (session.getAttribute("errorMessageTokenInvalid") != null) {
            out.println("<p style=\"color:red;\">Token invalid, please login again.<p>");
        }
        if (session.getAttribute("errorMessage") != null) {
            out.println("<p style=\"color:red;\">Invalid login, please try again.<p>");
        }
    %>
</div>

</body>
</html>
