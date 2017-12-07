package web_service.order_servlet;

import identity_service.AccessToken;
import web_service.WebServiceDbConnection;

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

@WebServlet("/SaveOrder")
public class SaveOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        if (AccessToken.isTokenExpiredInvalid(request, response)) {
            return;
        }

        HttpSession session = request.getSession();

        session.setAttribute("order_rating", request.getParameter("rating"));
        session.setAttribute("comment", request.getParameter("comment"));

        WebServiceDbConnection webServiceDbConnection = new
                WebServiceDbConnection();
        Connection connection = webServiceDbConnection.getConnection();

        try {
            String query = "INSERT into orders (date, origin, destination, " +
                    "order_rating, comment, id_driver, id_user) VALUES (?, ?," +
                    " ?, ?, ?, ?, ?)";

            java.util.Date date = new java.util.Date();
            String origin = (String) session.getAttribute("origin");
            String destination = (String) session.getAttribute("destination");
            int order_rating = Integer.parseInt((String) session.getAttribute
                    ("order_rating"));
            String comment = (String) session.getAttribute("comment");
            int id_driver = Integer.parseInt((String) session.getAttribute
                    ("driverId"));
            int id_user = Integer.parseInt((String) session.getAttribute
                    ("userId"));

            PreparedStatement preparedStatement = connection.prepareStatement
                    (query);
            preparedStatement.setDate(1, new java.sql.Date(date.getTime()));
            preparedStatement.setString(2, origin);
            preparedStatement.setString(3, destination);
            preparedStatement.setInt(4, order_rating);
            preparedStatement.setString(5, comment);
            preparedStatement.setInt(6, id_driver);
            preparedStatement.setInt(7, id_user);

            preparedStatement.execute();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() +
                "/profile.jsp");
    }
}
