<%!
    public String printProfile(String profilePic, Boolean isDriver, String type) {
        String markup = "";

        markup += "<img ";
        if (profilePic != null) {
            markup += "src=\"img/" + profilePic + "\"";
        }
        markup += "class=\"" + type + " ";
        markup += (isDriver ? "driver" : "user");
        markup += "\" ></img> ";

        return markup;
    }

    public String printHeader(String username) {
        String markup = "";

        markup += "<div class=\"row header\">";
        markup += "   <div class=\"header-logo\">";
        markup += "       <div class=\"logo-text\">NGEEENG!</div>";
        markup += "           <div class=\"logo-subtext\">A Solution for Your Transportation</div>";
        markup += "   </div>";
        markup += "   <div class=\"header-user\">";
        markup += "       <div class=\"header-username\">Hello! <span class=\"username\">" + username + "</span></div>";
        markup += "       <div class=\"header-logout\"><a href=\"Logout\">Logout!</a></div>";
        markup += "   </div>";
        markup += "</div>";

        return markup;
    }

    public String printNavbar(Integer page) {
        String markup = "";

        if (page == 0) {
            markup += "<div class=\"nav\">";
            markup += "   <a href=\"order-selectdestination.jsp\"><div class=\"nav-item active\">ORDER</div></a>";
            markup += "   <a href=\"history-driverhistory.jsp\"><div class=\"nav-item\">HISTORY</div></a>";
            markup += "   <a href=\"profile.jsp\"><div class=\"nav-item\">MY PROFILE</div></a></div>";
        } else if (page == 1) {
            markup += "<div class=\"nav\">";
            markup += "   <a href=\"order-selectdestination.jsp\"><div class=\"nav-item\">ORDER</div></a>";
            markup += "   <a href=\"history-driverhistory.jsp\"><div class=\"nav-item active\">HISTORY</div></a>";
            markup += "   <a href=\"profile.jsp\"><div class=\"nav-item\">MY PROFILE</div></a></div>";
        } else if (page == 2) {
            markup += "<div class=\"nav\">";
            markup += "   <a href=\"order-selectdestination.jsp\"><div class=\"nav-item\">ORDER</div></a>";
            markup += "   <a href=\"history-driverhistory.jsp\"><div class=\"nav-item\">HISTORY</div></a>";
            markup += "   <a href=\"profile.jsp\"><div class=\"nav-item active\">MY PROFILE</div></a></div>";
        }

        return markup;
    }
%>
