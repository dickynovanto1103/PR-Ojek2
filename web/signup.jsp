<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>NGEEENG! - A Solution for Your Transportation</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div class="container green-box">
    <div class="title">
        <span>SIGNUP</span>
    </div>
    <div class="row">
        <form class="login-form register" method="post" action="SignUp"
              name="registration">
            <div class="input-set">
                <div class="label">Your Name</div>
                <div class="field"><input type="text" name="name" id="name"
                                          placeholder="Yourname"></div>
            </div>
            <div class="input-set">
                <div class="label">Username</div>
                <div class="field diminished"><input type="text" name="username"
                                                     id="username"
                                                     placeholder="Username">
                </div>

            </div>
            <div class="input-set">
                <div class="label">Email</div>
                <div class="field diminished"><input type="text" name="email"
                                                     id="email"
                                                     placeholder="Email">
                </div>

            </div>
            <div class="input-set">
                <div class="label">Password</div>
                <div class="field"><input type="password" name="password"
                                          id="password" placeholder="Password">
                </div>
            </div>
            <div class="input-set">
                <div class="label">Confirm Password</div>
                <div class="field"><input type="password"
                                          name="confirm_password"
                                          id="confirm_password"
                                          placeholder="Confirm Password"></div>
            </div>
            <div class="input-set">
                <div class="label">Phone Number</div>
                <div class="field"><input type="text" name="phone" id="phone"
                                          placeholder="Phone Number"></div>
            </div>
            <div class="input-set">
                <input type="checkbox" name="isDriver" value="driver">
                <label>Also sign me up as driver</label>
            </div>
            <div class="login-button-set input-set">
                <div class="register-section"><a href="login.jsp">Already have
                    an account?</a></div>
                <div class="button-section align-right"><input type="submit"
                                                               class="button-green"
                                                               value="Sign Up">
                </div>
            </div>
        </form>
    </div>
    <%
        if (session.getAttribute("errorMessage") != null) {
            if (session.getAttribute("errorMessageType") == "1") {
                out.println("<p style=\"color:red;\">Sign up data invalid, please try again.<p>");
            } else if (session.getAttribute("errorMessageType") == "2") {
                out.println("<p style=\"color:red;\">Username or email already exists.<p>");
            }
        }
    %>
</div>

</body>
</html>
