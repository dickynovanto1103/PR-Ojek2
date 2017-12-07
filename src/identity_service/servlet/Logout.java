package identity_service.servlet;

import identity_service.AccessToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        AccessToken.removeAccessToken((AccessToken) session.getAttribute
                ("accessToken"));

        session.invalidate();

        session = request.getSession();
        if (request.getParameter("token_expired") != null) {
            session.setAttribute("errorMessageTokenExpired", true);
        } else if (request.getParameter("token_invalid") != null) {
            session.setAttribute("errorMessageTokenInvalid", true);
        }

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
