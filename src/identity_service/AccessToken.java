package identity_service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

public class AccessToken {
    private String token;
    private Date expiryTime;

    public AccessToken() {
        token = UUID.randomUUID().toString();

        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.SECOND, 120);
        expiryTime = cal.getTime();
    }

    public AccessToken(String _token, Date _expiryTime) {
        token = _token;
        expiryTime = _expiryTime;
    }

    public static boolean isTokenValid(AccessToken accessToken, int userId) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        boolean exist = false;

        try {
            String query = "SELECT id, token, expiry_date FROM user_with_token WHERE id='" + userId + "' AND token='" + accessToken.getToken() + "'";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);


            if (resultSet.isBeforeFirst()) {
                exist = true;
            }

            resultSet.close();

        } catch (SQLException se) {
            se.printStackTrace();
        }

        return exist;
    }

    public static boolean isTokenExpired(AccessToken accessToken, Date
            currentTime) {
        return (accessToken.getExpiryTime().compareTo(currentTime) < 0);
    }

    public static boolean isTokenExpiredInvalid(HttpServletRequest request,
                                                HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        AccessToken accessToken = (AccessToken) session.getAttribute
                ("accessToken");
        Date currentTime = new Date();
        int id = (int) session.getAttribute("id");

        if (!AccessToken.isTokenValid(accessToken, id)) {
            response.sendRedirect(request.getContextPath() +
                    "/Logout?token_invalid=true");

            return true;
        } else if (AccessToken.isTokenExpired(accessToken, currentTime)) {
            response.sendRedirect(request.getContextPath() +
                    "/Logout?token_expired=true");

            return true;
        }

        return false;
    }

    public static void updateAccessToken(int id, AccessToken
            accessToken) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection
                .getConnection();

        try {
            String query = "REPLACE INTO user_with_token (id, token," +
                    " expiry_date) VALUES (?, ?, ?)";

            PreparedStatement preparedStatement = connection
                    .prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, accessToken.getToken());
            preparedStatement.setTimestamp(3, new java.sql.Timestamp(accessToken
                    .getExpiryTime().getTime()));

            preparedStatement.execute();

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void removeAccessToken(AccessToken accessToken) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection
                .getConnection();

        try {
            String query = "DELETE FROM user_with_token WHERE token='" +
                    accessToken.getToken() + "'";

            PreparedStatement preparedStatement;
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.execute();

            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getToken() {
        return token;
    }

    public Date getExpiryTime() {
        return expiryTime;
    }
}
