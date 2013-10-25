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
import entity.User;

public class Submit extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("submit.jsp");
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String title = request.getParameter("title");
		String URL = request.getParameter("url");
		String text = request.getParameter("text");
		
		HttpSession session = request.getSession();
		
		if (title.equals("")) {
			session.setAttribute("error", "Title should be filled!");
			response.sendRedirect("submit.jsp");
			return;
		}
		if (!URL.equals("") && !text.equals("")) {
			session.setAttribute("error", "Only one should be filled, URL or text!");
			response.sendRedirect("submit.jsp");
			return;
		}
		if (URL.equals("") && text.equals("")) {
			session.setAttribute("error", "At least one should be filled, URL or text!");
			response.sendRedirect("submit.jsp");
			return;
		}
		
		try {
			InitialContext context = new InitialContext();
			PostInterface postDAO = (PostInterface)context.lookup("PostDAO/local");
			
			Post postTemp = postDAO.queryByUrl(URL);
			if (postTemp != null) {
				session.setAttribute("error", "This URL already exists!");
				response.sendRedirect("submit.jsp");
				return;
			}
			
			Post post = new Post();
			post.setTitle(title);
			post.setUrl(URL);
			post.setText(text);
			post.setPostedBy((User)session.getAttribute("user"));
			postDAO.insert(post);
			
			session.setAttribute("success", "Submit successfully!");
			response.sendRedirect("index.jsp");
			return;
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
}
