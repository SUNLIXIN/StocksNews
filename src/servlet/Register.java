package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.Encrypt;

import dao.UserInterface;
import entity.User;

public class Register extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("register.jsp");
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String passwordTemp = request.getParameter("password");
		String passwordRepeatTemp = request.getParameter("password-repeat");
		String password = Encrypt.generatePassword(passwordTemp);
		
		HttpSession session = request.getSession();
		
		if (email.equals("") || username.equals("") || passwordTemp.equals("")) {
			session.setAttribute("error", "All blanks should be filled!");
			response.sendRedirect("register.jsp");
			return;
		}
		if (!passwordTemp.equals(passwordRepeatTemp)) {
			session.setAttribute("error", "Password and Repeat Password are different!");
			response.sendRedirect("register.jsp");
			return;
		}
		
		try {
			InitialContext context = new InitialContext();
			UserInterface userDAO = (UserInterface)context.lookup("UserDAO/local");
			User user1 = userDAO.queryByName(username);
			if (user1 != null) {
				session.setAttribute("error", "User name already exsits!");
				response.sendRedirect("register.jsp");
				return;
			}
			User user2 = userDAO.queryByEmail(email);
			if (user2 != null) {
				session.setAttribute("error", "Email Address already registered!");
				response.sendRedirect("register.jsp");
				return;
			}
			User user = new User();
			user.setName(username);
			user.setEmail(email);
			user.setPassword(password);
//			user.setCreatedTime(new Date(new java.util.Date().getTime()));
			userDAO.insert(user);
			session.setAttribute("success", "Register successfully!");
			response.sendRedirect("login.jsp");
			return;
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
}
