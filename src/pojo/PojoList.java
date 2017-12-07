package pojo;

import java.util.ArrayList;

public class PojoList {
    private ArrayList<String> list;

    public PojoList() {
        list = new ArrayList<>();
    }

    public PojoList(ArrayList<String> _list) {
        list = _list;
    }

    public ArrayList<String> getList() {
        return list;
    }

    public void setList(ArrayList<String> list) {
        this.list = list;
    }
}
