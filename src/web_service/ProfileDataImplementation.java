package web_service;

import pojo.PojoList;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

@javax.jws.WebService(endpointInterface = "web_service.ProfileData")
public class ProfileDataImplementation implements ProfileData {
    @Override
    public PojoList getPreferredLocations(int id) {
        WebServiceDbConnection webServiceDbConnection = new
                WebServiceDbConnection();
        Connection connection = webServiceDbConnection.getConnection();

        ArrayList<String> locationData = new ArrayList<>();

        try {
            String query = "SELECT place FROM preferred_loc WHERE id=\"" + id
                    + "\"";

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                String place = resultSet.getString("place");
                locationData.add(place);
            }

            resultSet.close();
            statement.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }

        return new PojoList(locationData);
    }
}
