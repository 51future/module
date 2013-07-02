<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
var theOpeners = window.top.dialogArguments;

//选择用户
function  selectUser(){
	var users=$("input[name='users']:checked");
	var userList = [];
	for(var i=0; i<users.length; i++){
		var user = {};
		var tempArr = $(users[i]).val().split('_');
		user.user_id = tempArr[0];
		user.user_name = tempArr[1];
		user.org_id = tempArr[2];
		user.org_name = tempArr[3];
		
		userList.push(user);
	}
	window.returnValue=userList;
	//theOpeners.callback(userList);
	window.close();
}

function  checkUser(){
	if($("#checkAll").attr("checked")=="checked"){
		$("[name='users']").each(function()  {
			$(this).attr("checked","checked");
		});
	}else{
		$("[name='users']").each(function()  {
			$(this).attr("checked",false);
		});
	}
}
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/user_selectUser4Choose.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>部门名称</th>
					<td width="100px">
						<input type="text" name="org.o_name" value="${org.org_name}"/>
					</td>
					<th>用户姓名</th>
					<td width="100px">
						<input type="text" name="user.rname" value="${user.user_name}"/>
					</td>
					<td>
						<input type="hidden" name="user.utype" value="1"/>
						<span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
						<span class="btn" style="text-align:right"  ><input type="button"  onclick="selectUser()"  value="确定" /></span>
					</td>
					
				</tr>
			</table>
		</div>
		<!--查询条件表格-->
		<div class="listTab">
			<table>
				<thead>
					<tr>
					    <td><input type="checkbox"  id="checkAll"  onclick="checkUser()"/></td>
						<td>登录账号</td>
						<td>用户姓名</td>
						<td>所属部门</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{uList}">
					<tr>
					    <td><input type="checkbox"  name="users"  value="${user_id}_${user_name}_${org_id}_${org_name}"/></td>
						<td class="tdLeft">${user_account}</td>
						<td class="tdLeft">${user_name}</td>
						<td class="tdLeft">${org_name}</td>
					</tr>
					</s:iterator>
					<s:if test="%{uList.size() == 0}">
					<tr>
						<td colspan="4"><font>很抱歉，没有找到您要的数据</font></td>
					</tr>
					</s:if>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>