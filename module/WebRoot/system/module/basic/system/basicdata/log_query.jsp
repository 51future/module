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
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
$(function(){
	
});

function addUser(){
	var userAddUrl = '<%=basePath%>admin/system/user/userAdd.jsp';  
	openWindow(userAddUrl, '新增用户');
}

</script>
</head>
<body>
	<div class="searchTab">
		<table>
			<tr>
				<th>登录账号</th>
				<td>
					<input type="text" name="staff.staff_no" />
				</td>
				<th>用户姓名</th>
				<td>
					<input type="text" name="staff.staff_no" />
				</td>
				<th>用户状态</th>
				<td>
					<select name="select2" class="downMenu">
						<option value="1">在职</option>
						<option value="0">离职</option>
						<option value="-1">所有</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>所属部门</th>
				<td>
					<select name="select2" class="downMenu">
						<option value="-1">--按部门查询</option>
					</select>
				</td>
				<th>担任职务</th>
				<td>
					<select name="select2" class="downMenu">
						<option value="-1">--按职务查询</option>
					</select>
				</td>
				<th></th>
				<td>
					<span class="btn"><input type="button" name="button" id="button" value="查询" /></span>
				</td>
			</tr>
		</table>
	</div>
	<div class="tabBtns">
		<span class="btn"><input type="button" id="addUserBtn" value="新增用户" onclick="addUser();"/></span>
	</div>
	<!--查询条件表格-->
	<div class="listTab">
		<table>
			<thead>
				<tr>
					<td>登录账号</td>
					<td>用户姓名</td>
					<td>所属部门</td>
					<td>担任职务</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>JX0001</td>
					<td>杨学明</td>
					<td>软件研发部</td>
					<td>项目经理</td>
					<td>在职</td>
					<td>
						<a href="javascript:void(0);" class="add">赋角色</a>
						<a href="javascript:void(0);" class="add">添加下属</a>
						<a href="javascript:void(0);" class="modi">收款授权</a>
						<a href="javascript:void(0);" class="modi">初始化密码</a>
						<a href="javascript:void(0);" class="modi">编辑</a>
						<a href="javascript:void(0);" class="del">禁用</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<jsp:include page="/admin/common/pagemodel.jsp"></jsp:include>
</body>
</html>
