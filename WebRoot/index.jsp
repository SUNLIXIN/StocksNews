<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <meta charset="UTF-8">
    <title>Stocks News</title>
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
			      <li><a href="<%=basePath%>threads">Threads</a></li>
			      <li><a href="<%=basePath%>comments">Comments</a></li>
			      <li><a href="<%=basePath%>leaders">Leaders</a></li>
			      <li><a href="<%=basePath%>submit">Submit</a></li>
			    </ul>

			    <ul class="nav navbar-nav navbar-right">
			      <li><a href="<%=basePath%>user?id=<%  %>">User</a></li>
			      <li><a href="<%=basePath%>logout">Logout</a></li>
			    </ul>
			  </div>
			</nav>
		</div>

		<div class="container">
			<ol>
				<li></li>
			</ol>
		</div>

		<div class="container">
			<footer>
				<hr>
				<a href="<%=basePath%>">Stocks News</a>
			</footer>
		</div>
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
