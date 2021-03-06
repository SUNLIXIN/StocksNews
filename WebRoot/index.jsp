<%@ page language="java" import="java.util.*,entity.*,javax.naming.*,dao.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <meta charset="UTF-8">
    <title>Stocks News | Index</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

		<style>
		body {
			padding-top: 70px;
		}
		</style>

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
		<div class="container">
			<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			 <div class="col-md-10 col-md-offset-1">
			  <div class="navbar-header">
			    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			      <span class="sr-only">Toggle navigation</span>
			      <span class="icon-bar"></span>
			      <span class="icon-bar"></span>
			      <span class="icon-bar"></span>
			    </button>
			    <a class="navbar-brand" href="<%=basePath%>"><strong>Stocks News</strong></a>
			  </div>
			
			  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			    <ul class="nav navbar-nav">
			      <li class="active"><a href="<%=basePath%>new">New</a></li>
			      <% if (session.getAttribute("user") != null) { %>
			      	<li><a href="<%=basePath%>threads?id=<%= ((User)session.getAttribute("user")).getName() %>">Threads</a></li>
			      <% } %>
			      <li><a href="<%=basePath%>newcomments">Comments</a></li>
			      <li><a href="<%=basePath%>leaders">Leaders</a></li>
			      <li><a href="<%=basePath%>submit">Submit</a></li>
			    </ul>

					<% if (session.getAttribute("user") == null) { %>
				    <ul class="nav navbar-nav navbar-right">
				      <li><a href="<%=basePath%>login">Login</a></li>
				      <li><a href="<%=basePath%>register">Register</a></li>
				    </ul>
				  <% } else { %>
				  	<% User user = (User)session.getAttribute("user"); %>
				  	<ul class="nav navbar-nav navbar-right">
				      <li><a href="<%=basePath%>user?id=<%= user.getName() %>"><%= user.getName() %></a></li>
				      <li><a href="<%=basePath%>logout">Logout</a></li>
				    </ul>
				  <% } %>
			  </div>
			 </div>
			</nav>
		</div>

		 <div class="container">
		 <div class="col-md-10 col-md-offset-1">
			<br><br>
			<% if (session.getAttribute("success") != null) {%>
			  <div class="alert alert-success" alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <%= session.getAttribute("success") %>
        </div>
        <% session.removeAttribute("success"); %>
      <% } %>
     	<% if (session.getAttribute("info") != null) {%>
			  <div class="alert alert-info" alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <%= session.getAttribute("info") %>
        </div>
        <% session.removeAttribute("info"); %>
      <% } %>
      <% if (session.getAttribute("warning") != null) {%>
			  <div class="alert alert-warning" alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <%= session.getAttribute("warning") %>
        </div>        
        <% session.removeAttribute("warning"); %>
      <% } %>
      <% if (session.getAttribute("error") != null) {%>
			  <div class="alert alert-danger" alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <%= session.getAttribute("error") %>
        </div>
        <% session.removeAttribute("error"); %>
      <% } %>
      <ol>
				<% InitialContext context = new InitialContext(); %>
				<% PostInterface postDAO = (PostInterface) context.lookup("PostDAO/local"); %>
				<% List<Post> posts = postDAO.queryAll(); %>
				<% for (Post post : posts) { %>
					<% if (post.getType() == 0) { %>
						<li><a href="<%= post.getUrl() %>" target="_blank"><%= post.getTitle() %></a></li>
					<% } else { %>
						<li><a href="<%=basePath%>item?id=<%= post.getId() %>" target="_blank"><%= post.getTitle() %></a></li>
					<% } %>
				<% } %>
			</ol>
		</div>
		</div>

		<div class="container">
		 <div class="col-md-10 col-md-offset-1">
			<footer>
				<hr>
				<a href="<%=basePath%>">Stocks News</a>
			</footer>
		</div>
		</div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
