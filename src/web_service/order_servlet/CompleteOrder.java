package web_service.order_servlet;

import identity_service.AccessToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CompleteOrder")
public class CompleteOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse
            response) throws ServletException, IOException {
        if (AccessToken.isTokenExpiredInvalid(request, response)) {
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("driverId", request.getParameter("driverId"));

        response.sendRedirect(request.getContextPath() +
                "/order-complete.jsp");
    }
}
