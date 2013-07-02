<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/My97DatePicker/WdatePicker.js"></script>
<script language="javascript">
	
</script>
</head>
<body>
	<div class="title">用户详细信息</div>
	<div class="editorTab">
		<table>
				<tr>
					<th>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
					<td>张笑</td>
					<th>家庭住址</th>
					<td>清溪桥八十七号</td>
					<th>事业单位部门</th>
					<td>税务局人事部</td>
				</tr>
				<tr>
					<th>订&nbsp;&nbsp;单&nbsp;&nbsp;号</th>
					<td>123456</td>
					<th>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门</th>
					<td>人事部</td>
					<th>订单日期</th>
					<td>2012-5-8</td>
				</tr>
				<tr>
					<th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
					<td colspan="5">备注说明信息</td>
				</tr>
		</table>
	</div>
	<div class="btns">
		<span class="btn"><input type="button" name="button2" id="button2" value="返回" /></span>
	</div>
</body>
</html>
