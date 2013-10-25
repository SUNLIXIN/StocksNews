package servlet;

import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostInterface;
import dao.UserInterface;
import entity.Post;
import entity.User;

public class Vote extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int postid = Integer.parseInt(request.getParameter("for"));
		String direction = request.getParameter("dir");
		String username = request.getParameter("by");
		String auth = request.getParameter("auth");
		String whence = request.getParameter("whence");
		
		HttpSession session = request.getSession();
		
		try {
			InitialContext context = new InitialContext();
			PostInterface postDAO = (PostInterface) context.lookup("PostDAO/local");
			Post post = postDAO.queryById(postid);
			UserInterface userDAO = (UserInterface) context.lookup("UserDAO/local");
			User user = userDAO.queryByName(username);
			postDAO.savePostByUser(post, user);
			response.sendRedirect("index.jsp");
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
