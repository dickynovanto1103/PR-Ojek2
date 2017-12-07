package identity_service.servlet;

import identity_service.AccessToken;
import identity_service.User;
import identity_service.UserInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String phoneNumber = request.getParameter("phone");
        boolean isDriver = request.getParameter("phone") != null;

        if (!User.isSignUpDataValid(name, username, email, password,
                confirmPassword, phoneNumber)) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", true);
            session.setAttribute("errorMessageType", "1");

            response.sendRedirect(request.getContextPath() + "/signup.jsp");
        } else if (User.isUserAlreadyExists(username, email)) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", true);
            session.setAttribute("errorMessageType", "2");

            response.sendRedirect(request.getContextPath() + "/signup.jsp");
        } else {
            User.signUp(name, username, email, password, phoneNumber, isDriver);

            UserInfo userInfo = User.getUserInfo(username);
            AccessToken accessToken = new AccessToken();
            AccessToken.updateAccessToken(userInfo.getId(), accessToken);

            HttpSession session = request.getSession();
            session.setAttribute("id", userInfo.getId());
            session.setAttribute("name", name);
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("password", password);
            session.setAttribute("phoneNumber", phoneNumber);
            session.setAttribute("isDriver", isDriver);
            session.setAttribute("profilePic", userInfo.getProfilePic());
            session.setAttribute("accessToken", accessToken);

            response.sendRedirect(request.getContextPath() + "/profile.jsp");
        }
    }
}
