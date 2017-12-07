package web_service;

import identity_service.IdentityServiceDbConnection;
import org.json.JSONObject;
import pojo.PojoList;

import java.sql.*;
import java.util.ArrayList;

@javax.jws.WebService(endpointInterface = "web_service.HistoryData")
public class HistoryDataImplementation implements HistoryData {
    @Override
    public PojoList getPastOrders(String who, int id) {
        WebServiceDbConnection webServiceDbConnection = new
                WebServiceDbConnection();
        Connection connection = webServiceDbConnection.getConnection();

        ArrayList<String> orders = new ArrayList<>();

        try {
            String query = "SELECT order_id, date, origin, destination, " +
                    "order_rating, comment, id_user, id_driver, " +
                    "hidden_driver, hidden_user FROM orders WHERE " + who +
                    "= " + id;

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                int order_id = resultSet.getInt("order_id");
                Date date = resultSet.getDate("date");
                String origin = resultSet.getString("origin");
                String destination = resultSet.getString("destination");
                int order_rating = resultSet.getInt("order_rating");
                String comment = resultSet.getString("comment");
                int id_user = resultSet.getInt("id_user");
                int id_driver = resultSet.getInt("id_driver");
                int hidden_driver = resultSet.getInt("hidden_driver");
                int hidden_user = resultSet.getInt("hidden_user");

                JSONObject order = new JSONObject();

                try {
                    order.put("order_id", order_id);
                    order.put("date", date);
                    order.put("origin", origin);
                    order.put("destination", destination);
                    order.put("order_rating", order_rating);
                    order.put("comment", comment);
                    order.put("id_user", id_user);
                    order.put("id_driver", id_driver);
                    order.put("hidden_driver", hidden_driver);
                    order.put("hidden_user", hidden_user);
                } catch (org.json.JSONException je) {
                    je.printStackTrace();
                }

                orders.add(order.toString());
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }

        return new PojoList(orders);
    }

    @Override
    public String getNameById(int id) {
        IdentityServiceDbConnection identityServiceDbConnection = new
                IdentityServiceDbConnection();
        Connection connection = identityServiceDbConnection.getConnection();

        String name = "";

        try {
            String query = "SELECT name FROM user WHERE id='" + id + "'";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                name = resultSet.getString("name");
            }

            resultSet.close();
            statement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
        return name;
    }
}
