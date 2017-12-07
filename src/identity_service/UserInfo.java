package identity_service;

public class UserInfo {
    private int id;
    private String name;
    private String email;
    private String phoneNumber;
    private boolean isDriver;
    private String profilePic;

    UserInfo() {
        id = 0;
        name = "";
        email = "";
        phoneNumber = "";
        isDriver = false;
        profilePic = "";
    }

    UserInfo(int _id, String _name, String _email, String _phoneNumber, boolean
            _isDriver, String _profilePic) {
        id = _id;
        name = _name;
        email = _email;
        phoneNumber = _phoneNumber;
        isDriver = _isDriver;
        profilePic = _profilePic;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public boolean isDriver() {
        return isDriver;
    }

    public String getProfilePic() {
        return profilePic;
    }
}
