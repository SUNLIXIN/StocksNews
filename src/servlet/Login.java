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

public class Login extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		String name = request.getParameter("name");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		
		if (name.equals("") || password.equals("")) {
			session.setAttribute("error", "All blanks should be filled!");
			response.sendRedirect("login.jsp");
			return;
		} else {
			try {
				InitialContext context = new InitialContext();
				UserInterface userDAO = (UserInterface)context.lookup("UserDAO/local");
				User user = userDAO.queryByName(name);
				if (user == null) {
					session.setAttribute("error", "User doesn't exsit!");
					response.sendRedirect("login.jsp");
					return;
				} else {
					if (password != user.getPassword()) {
						session.setAttribute("error", "Password Wrong!");
						response.sendRedirect("login.jsp");
						return;
					} else {
						session.setAttribute("user", user);
						response.sendRedirect("index.jsp");
						return;
					}
				}
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
