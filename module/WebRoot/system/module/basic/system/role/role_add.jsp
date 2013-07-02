<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%--
	auth : Conner
	date : 2012-09-05
	desc : 添加角色
--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css" />
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#role_name")[0].focus();
	checkAll();
});

function checkAll(){
	var role_name = new LiveValidation('role_name',{ wait : 500},{onlyOnSubmit:true});
	role_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	role_name.add( Validate.Length, { maximum: 20 } );
}
</script>
</head>
<body>
	<div class="title">添加角色</div>
	<form action="<%=basePath %>basic/sys/role_insert.action" id="form" method="post">
		<div class="editorTab">
			<table>
					<tr>
						<th><font>*</font>角色名称</th>
						<td>
							<input type="text" name="role.role_name" id="role_name" class="widStyle"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>角色类型</th>
						<td>
							<select name="role.role_type" class="downMenu">
								<option value="1">角色类型1</option>
								<option value="2">角色类型2</option>
								<option value="3">角色类型3</option>
								<option value="4">角色类型4</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><font>*</font>启用状态</th>
						<td>
							<select name="role.enabled" class="downMenu">
								<option value="1">禁用</option>
								<option value="2" selected="selected">启用</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>备注说明</th>
						<td>
							<input name="role.remark" value="${role.remark}" id="remark" maxlength="100" size="50"/>
						</td>
					</tr>
			</table>
		</div>

		<div class="btns">
			<span class="btn"><input type="submit" id="submitBtn" value="添加" /></span>
			<span class="btn"><input type="button" id="cancelBtn" value="返回" 
				onclick="javascript:window.location='<%=basePath%>basic/sys/role_query.action';"/></span>
		</div>
	</form>
</body>
</html>
