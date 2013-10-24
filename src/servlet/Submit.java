package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostDAO;

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

		if (title == null) {
			session.setAttribute("error", "Title should be filled!");
			response.sendRedirect("submit.jsp");
			return;
		}
		if (URL != null && text != null) {
			session.setAttribute("error", "Only one should be filled, URL or text!");
			response.sendRedirect("submit.jsp");
			return;
		}
		
		Post post = new Post();
		post.setTitle(title);
		post.setUrl(URL);
		post.setText(text);
		post.setPostedBy((User)session.getAttribute("user"));
		
		PostDAO postDAO = new PostDAO();
		postDAO.insert(post);
	}
}
