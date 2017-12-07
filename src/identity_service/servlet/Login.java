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

@WebServlet("/Login")
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (User.isUserCredentialValid(username, password)) {
            UserInfo userInfo = User.getUserInfo(username);

            AccessToken accessToken = new AccessToken();
            AccessToken.updateAccessToken(userInfo.getId(), accessToken);

            HttpSession session = request.getSession();
            session.setAttribute("id", userInfo.getId());
            session.setAttribute("name", userInfo.getName());
            session.setAttribute("username", username);
            session.setAttribute("email", userInfo.getEmail());
            session.setAttribute("password", password);
            session.setAttribute("phoneNumber", userInfo.getPhoneNumber());
            session.setAttribute("isDriver", userInfo.isDriver());
            session.setAttribute("profilePic", userInfo.getProfilePic());
            session.setAttribute("accessToken", accessToken);

            response.sendRedirect(request.getContextPath() + "/profile.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", true);

            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
