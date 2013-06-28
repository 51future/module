<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self" href="<%=basePath%>" />
<title>title提示</title>
<link type="text/css" rel="stylesheet" href="module/form/title/title.css" media="screen" />
<script type="text/javascript" src="module/jslib/jQuery/jquery-1.7.1.min.js"></script>

</head>
<body>


</body>
</html>