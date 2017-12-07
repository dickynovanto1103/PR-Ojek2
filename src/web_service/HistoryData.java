package web_service;

import pojo.PojoList;

import javax.jws.WebMethod;

@javax.jws.WebService
public interface HistoryData {
    @WebMethod
    public PojoList getPastOrders(String who, int id);

    @WebMethod
    public String getNameById(int id);
}
