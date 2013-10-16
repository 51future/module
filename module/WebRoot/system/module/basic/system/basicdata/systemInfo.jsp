<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.jinxinol.basic.system.domain.SystemInfo"%>
<%
	SystemInfo systemInfo = new SystemInfo();
%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统信息展示</title>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
</head>
<body>
<div class="editorTab">
  <table>
    <tr>
      <th>系统版本</th>
      <td><%=systemInfo.getVersion() %></td>
    </tr>
    <tr>
      <th>软件供应商</th>
      <td><%=systemInfo.getVendor() %></td>
    </tr>
    <tr>
      <th>操作信息名称</th>
      <td><%=systemInfo.getOs_name() %></td>
    </tr>
    <tr>
      <th>操作信息版本</th>
      <td><%=systemInfo.getOs_version() %></td>
    </tr>
    <tr>
      <th>java运行名称</th>
      <td><%=systemInfo.getJava_run_name() %></td>
    </tr>
    <tr>
      <th>java运行环境</th>
      <td><%=systemInfo.getJava_run_version() %></td>
    </tr>
    <tr>
      <th>cpu型号</th>
      <td><%=systemInfo.getCpu_version() %></td>
    </tr>
    <tr>
      <th>cpu使用率</th>
      <td><%=systemInfo.getCpu_ratio() %></td>
    </tr>
    <tr>
      <th>内存总量</th>
      <td><%=systemInfo.getMerry_total() %></td>
    </tr>
    <tr>
      <th>内存使用率</th>
      <td><%=systemInfo.getMerry_ratio() %></td>
    </tr>
  </table>
</div>
</body>
</html>