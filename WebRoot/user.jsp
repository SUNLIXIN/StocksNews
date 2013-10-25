<%@ page language="java" import="java.util.*,entity.User" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <meta charset="UTF-8">
    <title>Stocks News | user</title>
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
			  <div class="navbar-header">
			    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
			      <span class="sr-only">Toggle navigation</span>
			      <span class="icon-bar"></span>
			      <span class="icon-bar"></span>
			      <span class="icon-bar"></span>
			    </button>
			    <a class="navbar-brand" href="<%=basePath%>">Stocks News</a>
			  </div>
			
			  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			    <ul class="nav navbar-nav">
			      <li class="active"><a href="<%=basePath%>new">New</a></li>
			      <% if (session.getAttribute("user") != null) { %>
			      	<li><a href="<%=basePath%>threads?id=<%= ((User)session.getAttribute("user")).getName() %>">Threads</a></li>
			      <% } %>
			      <li><a href="<%=basePath%>comments">Comments</a></li>
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
			</nav>
		</div>

		<div class="container">
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
      <div class="page-header">
				<h1>User</h1>
			</div>
			
			<% if (session.getAttribute("isHimSelf") != null && (Boolean)session.getAttribute("isHimSelf")) { %>
				<% User user = (User)session.getAttribute("user"); %>
				<form class="form-horizontal" role="form" method="post" action="login">
				  <div class="form-group">
				    <label for="username" class="col-sm-2 control-label">user</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="username" name="username" value="<%= user.getName() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="created-time" class="col-sm-2 control-label">created time</label>
				    <div class="col-sm-10">
				      <label class="form-control" id="created-time"><%= user.getCreatedTime() %></label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-2 control-label">password</label>
				    <div class="col-sm-10">
				      <a href="<%=basePath%>resetpw" class="form-control" id="password">reset password</a>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="saved" class="col-sm-2 control-label">saved</label>
				    <div class="col-sm-10">
				      <a href="<%=basePath%>saved?id=<%= user.getName() %>" class="form-control" id="saved">
				      	<% if (user.getSaved() == null) { %>
				      		0
				      	<% } else { %>
				      		user.getSaved().size();
				      	<% } %>
				      </a>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="karma" class="col-sm-2 control-label">karma</label>
				    <div class="col-sm-10">
				      <label class="form-control" id="karma"><%= user.getKarma() %></label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="about" class="col-sm-2 control-label">about</label>
				    <div class="col-sm-10">
				      <textarea class="form-control" id="about" name="about" placeholder="About"><% if(user.getAbout()!=null){out.print(user.getAbout());}%></textarea>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="email" class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="showdead" class="col-sm-2 control-label">showdead</label>
				    <div class="col-sm-10">
				      <input type="checkbox" class="form-control" id="showdead" name="showdead" value="<%= user.isShowdead() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="noprocrast" class="col-sm-2 control-label">noprocrast</label>
				    <div class="col-sm-10">
				      <input type="checkbox" class="form-control" id="noprocrast" name="noprocrast" value="<%= user.isNoprocrast() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="maxvisit" class="col-sm-2 control-label">maxvisit</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="maxvisit" name="maxvisit" value="<%= user.getMaxvisit() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="minaway" class="col-sm-2 control-label">minaway</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="minaway" name="minaway" value="<%= user.getMinaway() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="delay" class="col-sm-2 control-label">delay</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="delay" name="delay" value="<%= user.getDelay() %>">
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="submit" class="btn btn-default">Update</button>
				    </div>
				  </div>
				</form>
			<% } else { %>
				<% User user = (User)session.getAttribute("userShowed"); %>
				<label>User: <%= user.getName() %></label>
				<label>Created Time: <%= user.getCreatedTime() %></label>
				<label>Karma: <%= user.getKarma() %></label>
				<label>About: <%= user.getAbout() %></label>
				<a href="<%=basePath%>submitted?id=<%= user.getId() %>">submissions</a>
				<a href="<%=basePath%>threads?id=<%= user.getId() %>">comments</a>
			<% } %>
		</div>

		<div class="container">
			<footer>
				<hr>
				<a href="/">Stocks News</a>
			</footer>
		</div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
