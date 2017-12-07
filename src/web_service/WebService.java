package web_service;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.net.MalformedURLException;
import java.net.URL;

public class WebService {
    public static Service getService(String portNumber, String className) {
        Service service = null;

        try {
            URL url = new URL
                    ("http://localhost:" + portNumber + "/web_war_exploded/"
                            + className + "ImplementationService?wsdl");

            QName serviceName = new QName("http://web_service/",
                    className + "ImplementationService");

            service = Service.create(url, serviceName);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        return service;
    }
}
