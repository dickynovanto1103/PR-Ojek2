function validateOrder(formname) {
    var origin = document.forms[formname]["origin"].value;
    var destination = document.forms[formname]["destination"].value;

    if (origin != "" && destination != "") {
        return true;
    }
    else {
        alert("Origin/Destination tidak boleh kosong")
        return false;
    }
}