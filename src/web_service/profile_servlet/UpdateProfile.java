package web_service.profile_servlet;

import identity_service.AccessToken;
import identity_service.IdentityServiceDbConnection;
import identity_service.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        if (AccessToken.isTokenExpiredInvalid(request, response)) {
            return;
        }

        HttpSession session = request.getSession();

        if (!User.isUpdateDataValid(request.getParameter("name"), request
                .getParameter("phone"))) {
            session.setAttribute("errorMessage", true);

            response.sendRedirect(request.getContextPath() +
                    "/profile-editprofile.jsp");

            return;
        }

        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection
                .getConnection();

        boolean isDriver = false;
        if (request.getParameter("status") != null) {
            isDriver = true;
        }

        try {
            String query = "UPDATE user SET name=?, phone=?, isDriver=? WHERE" +
                    " id=?";

            PreparedStatement preparedStatement = connection
                    .prepareStatement(query);
            preparedStatement.setString(1, request.getParameter("name"));
            preparedStatement.setString(2, request.getParameter("phone"));
            preparedStatement.setBoolean(3, isDriver);
            preparedStatement.setString(4, request.getParameter("id"));

            preparedStatement.execute();

            preparedStatement.close();

            session.setAttribute("name", request.getParameter("name"));
            session.setAttribute("phoneNumber", request.getParameter("phone"));
            session.setAttribute("isDriver", isDriver);

            session.removeAttribute("errorMessage");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() +
                "/profile.jsp");
    }
}
