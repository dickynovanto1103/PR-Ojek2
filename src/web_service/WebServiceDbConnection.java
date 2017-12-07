package web_service;

import java.sql.Connection;
import java.sql.DriverManager;

public class WebServiceDbConnection {
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/db_OJEK_SERVICE";

    private static final String USER = "cisco";
    private static final String PASS = "systems";

    private Connection connection = null;

    public WebServiceDbConnection() {
        try {
            Class.forName(JDBC_DRIVER);

            connection = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }
}
