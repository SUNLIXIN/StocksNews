package servlet;

import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserInterface;
import entity.User;

public class UserPage extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("id");
		
		HttpSession session = request.getSession();
		
		try {
			InitialContext context = new InitialContext();
			UserInterface userDAO = (UserInterface)context.lookup("UserDAO/local");
			User user = userDAO.queryByName(username);
			if (user == null) {
				session.setAttribute("error", "No such user!");
				response.sendRedirect("index.jsp");
				return;
			}
			if (session.getAttribute("user") == null) {
				session.setAttribute("isHimSelf", false);
				session.setAttribute("userShowed", user);
				response.sendRedirect("user.jsp");
				return;
			} else if (((User)session.getAttribute("user")).getName().equals(user.getName())) {
				session.setAttribute("isHimSelf", true);
				response.sendRedirect("user.jsp");
				return;
			} else {
				session.setAttribute("isHimSelf", false);
				response.sendRedirect("user.jsp");
				return;
			}
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
