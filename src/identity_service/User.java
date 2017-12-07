package identity_service;

import java.sql.*;
import java.util.regex.Pattern;

public class User {
    public static boolean isUserCredentialValid(String username, String
            password) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        boolean exist = false;

        try {
            String query = "SELECT username, password FROM user WHERE " +
                    "username='" + username + "' AND password='" + password +
                    "'";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            if (resultSet.isBeforeFirst()) {
                exist = true;
            }

            resultSet.close();
            statement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        return exist;
    }

    public static boolean isSignUpDataValid(String name, String username,
                                            String email, String
                                                    password, String
                                                    confirmPassword, String
                                                    phoneNumber) {
        final Pattern VALID_EMAIL_ADDRESS_REGEX =
                Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
                        Pattern.CASE_INSENSITIVE);

        final Pattern VALID_PHONE_NUMBER_REGEX = Pattern.compile("^([0-9]+)$");

        return (!name.isEmpty() && !username.isEmpty() && !password.isEmpty() &&
                !phoneNumber.isEmpty()) &&
                (VALID_EMAIL_ADDRESS_REGEX.matcher
                        (email).find() && VALID_PHONE_NUMBER_REGEX.matcher
                        (phoneNumber).find()) &&
                password.equals(confirmPassword);
    }

    public static boolean isUpdateDataValid(String name, String phoneNumber) {
        final Pattern VALID_PHONE_NUMBER_REGEX = Pattern.compile("^([0-9]+)$");

        return !name.isEmpty() && VALID_PHONE_NUMBER_REGEX.matcher
                (phoneNumber).find();
    }

    public static boolean isUserAlreadyExists(String username, String email) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        boolean exist = false;

        try {
            String query = "SELECT username, email FROM user WHERE " +
                    "username='" + username + "' OR email='" + email + "'";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            if (resultSet.isBeforeFirst()) {
                exist = true;
            }

            resultSet.close();
            statement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        return exist;
    }

    public static void signUp(String name, String username, String email, String
            password, String phoneNumber, boolean isDriver) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        try {
            String query = "INSERT INTO user (username, name, phone, email, "
                    + "password, isDriver, profilePicture) VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement preparedStatement = connection.prepareStatement
                    (query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, phoneNumber);
            preparedStatement.setString(4, email);
            preparedStatement.setString(5, password);
            preparedStatement.setBoolean(6, isDriver);
            preparedStatement.setString(7, "default_profpic.png");

            preparedStatement.execute();

            preparedStatement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    public static UserInfo getUserInfo(String username) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        UserInfo userInfo = new UserInfo();

        try {
            String query = "SELECT id, name, email, phone, isDriver, " +
                    "profilePicture FROM user " +
                    "WHERE " +
                    "username='" + username + "'";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                userInfo = new UserInfo(resultSet.getInt("id"), resultSet
                        .getString("name"), resultSet
                        .getString("email"), resultSet.getString("phone"),
                        resultSet.getBoolean("isDriver"), resultSet.getString
                        ("profilePicture"));
            }

            resultSet.close();
            statement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        return userInfo;
    }
}
