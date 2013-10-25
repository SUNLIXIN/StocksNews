package servlet;

import java.io.IOException;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserInterface;
import entity.User;

public class Leaders extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();

		try {
			InitialContext context = new InitialContext();
			UserInterface userDAO = (UserInterface)context.lookup("UserDAO/local");
			List<User> leaders = userDAO.getLeaders();
			session.setAttribute("leaders", leaders);
			response.sendRedirect("leaders.jsp");
			return;
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
