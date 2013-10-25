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
import entity.Post;

public class Item extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		
		HttpSession session = request.getSession();

		
		try {
			InitialContext context = new InitialContext();
			PostInterface postDAO = (PostInterface) context.lookup("PostDAO/local");
			
			Post post = postDAO.queryById(id);
			if (post == null) {
				session.setAttribute("error", "No such post!");
				response.sendRedirect("index.jsp");
				return;
			}
			if (post.getType() == 0) {
				response.sendRedirect("index.jsp");
				return;
			}
			session.setAttribute("postShowed", post);
			response.sendRedirect("item.jsp");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
