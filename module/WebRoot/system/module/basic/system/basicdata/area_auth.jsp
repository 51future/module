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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script language="javascript">

</script>
</head>
<body>
	<div class="title">綦江&nbsp;已授权用户</div>
	<div class="editorTab">
		<table>
				<tr>
					<td colspan="4">
						<div style="height:100px;">
							<input type="checkbox"/>陈兵/软件部  &nbsp;&nbsp;
							<input type="checkbox"/>罗飞/软件部  &nbsp;&nbsp;
							<input type="checkbox"/>赵晶/软件部  &nbsp;&nbsp;
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<span class="btn"><input type="button" value="全选" /></span>
						<span class="btn"><input type="button" value="反选" /></span>
						<span class="btn"><input type="button" value="删除所选用户" /></span>
					</td>
				</tr>
		</table>
	</div>
	<div class="title">綦江&nbsp;新授权用户</div>
	<div class="editorTab">
		<table>
				<tr>
					<td colspan="4">
						<div style="height:100px;">
							<input type="checkbox"/><a href="javascript:void(0);" class="del" title="点击删除">王斌/软件部  &nbsp;&nbsp;</a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<span class="btn"><input type="button" value="授权" /></span>
						<span class="btn"><input type="button" value="选择用户" /></span>
					</td>
				</tr>
		</table>
	</div>
</body>
</html>
