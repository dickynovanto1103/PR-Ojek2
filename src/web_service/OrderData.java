package web_service;

import pojo.PojoList;

import javax.jws.WebMethod;

@javax.jws.WebService
public interface OrderData {
    @WebMethod
    public String getPreferredDriver(String origin, String username, int userId);

    @WebMethod
    public PojoList getAvailableDrivers(String origin, int userId);

    @WebMethod
    public String getProfilePicById(int id);

    @WebMethod
    public String getUsernameById(int id);

    @WebMethod
    public String getNameById(int id);

    @WebMethod
    public int getIdByUserName(String username);
}
