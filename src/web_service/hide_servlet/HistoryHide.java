package web_service.hide_servlet;

import identity_service.AccessToken;
import web_service.WebServiceDbConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "HistoryHide")
public class HistoryHide extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        if (AccessToken.isTokenExpiredInvalid(request, response)) {
            return;
        }

        String id = request.getParameter("id");
        String order_id = request.getParameter("order_id");
        String type = request.getParameter("type");

        WebServiceDbConnection webServiceDbConnection = new
                WebServiceDbConnection();
        Connection connection = webServiceDbConnection.getConnection();

        if (type.equals("driver")) {
            try {
                String query = "UPDATE orders SET hidden_driver = ? where " +
                        "order_id = ?";
                PreparedStatement preparedStatement = connection
                        .prepareStatement(query);

                preparedStatement.setBoolean(1, true);
                preparedStatement.setString(2, order_id);
                preparedStatement.executeUpdate();

                connection.close();
                response.sendRedirect(request.getContextPath() +
                        "/history-driverhistory.jsp");
            } catch (SQLException se) {
                se.printStackTrace();
            }
        } else {
            try {
                String query = "UPDATE orders SET hidden_user = ? where " +
                        "order_id = ?";
                PreparedStatement preparedStatement = connection
                        .prepareStatement(query);

                preparedStatement.setBoolean(1, true);
                preparedStatement.setString(2, order_id);
                preparedStatement.executeUpdate();

                connection.close();
                response.sendRedirect(request.getContextPath() +
                        "/history-orderhistory.jsp");
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
