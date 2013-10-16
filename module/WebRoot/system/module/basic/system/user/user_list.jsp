<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<jsp:include page="/admin/common/css/style_easyui_popupWindow.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<jsp:include page="/admin/common/load_org_combox_tree.jsp"></jsp:include>
<script language="javascript">
$(function(){
	var orgTreeBox = new OrgComboxTree({
		idFieldId: 'org_id',
		nameFieldId: 'org_name'
	});
});

//更新用户状态
function updateUserState(userId, enable){
	var params = {
		ct : getCurrentTime(),
		'user.user_id': userId,
		'user.enable': enable
	};
	$.post('<%=basePath%>basic/sys/user_updateUserState.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("改变用户状态成功！");
			$('#searchBtn').click();
		}else{
			alert("改变用户状态失败，请联系管理员！");
		}
	});
}

//重置用户密码
function resetPassword(userId){
	var params = {
		ct : getCurrentTime(),
		'user.user_id': userId
	};
	$.post('<%=basePath%>basic/sys/user_resetPassword.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("重置用户密码成功！");
		}else{
			alert("重置用户密码失败，请联系管理员！");
		}
	});
}


//直接授权
function toUserRight(userId){
	var url = '<%=basePath%>basic/sys/user_toUserRight.action?user.user_id=' + userId;
	window.location.href = url;
}

//赋角色
function toUserRole(userId){
	var url = '<%=basePath%>basic/sys/user_toUserRole.action?user.user_id=' + userId;
	window.location.href = url;
}


//同步流程用户
function sync(){
	$.post('<%=basePath%>basic/sys/user_sync.action', null, function(json){
		if(json.resultCode == 'success'){
			alert("同步流程用户成功！");
		}else{
			alert("同步流程用户失败，请联系管理员！");
		}
	});
}
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/user_query.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>登录账号</th>
					<td>
						<input type="text" name="user.user_account_vague" value="${user.user_account_vague}"/>
					</td>
					<th>用户姓名</th>
					<td>
						<input type="text" name="user.user_name_vague" value="${user.user_name_vague}"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>所属组织</th>
					<td>
						<input type="text" name="user.org_name" id="org_name" value="${user.org_name}"/>
						<input type="hidden" name="user.org_id" id="org_id" value="${user.org_id}"/>
					</td>
					<th>用户状态</th>
					<td>
						<select name="user.enable" class="downMenu">
							<option value="">----请选择----</option>
							<option value="1" <s:if test="%{user.enable == 1}">selected="selected"</s:if>>禁用</option>
							<option value="2" <s:if test="%{user.enable == 2}">selected="selected"</s:if>>启用</option>
						</select>
					</td>
					<td>
						<span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
						<span class="btn">
							<input type="button" value="新增" 
								onclick="javascript:window.location.href = '<%=basePath%>admin/basic/system/user/user_add.jsp'"/>
						</span>
						<span class="btn"><input type="button" id="searchBtn" value="同步流程用户" onclick="sync();" /></span>
					</td>
				</tr>
			</table>
		</div>
		<!--查询条件表格-->
		<div class="listTab">
			<table>
				<thead>
					<tr>
						<td class="tdLeft">登录账号</td>
						<td class="tdLeft">用户姓名</td>
						<td class="tdLeft">所属区域</td>
						<td class="tdLeft">所属组织</td>
						<td class="tdLeft">担任职务</td>
						<td>手机号码</td>
						<td>状态</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{pm.list}">
					<tr>
						<td class="tdLeft">${user_account}</td>
						<td class="tdLeft">${user_name}</td>
						<td class="tdLeft">
							<s:if test="%{area_name == null}">默认区域</s:if>
							<s:else>${area_name}</s:else>
						</td>
						<td class="tdLeft">${org_path}</td>
						<td class="tdLeft">${pos_name}</td>
						<td >${cellphone_no}</td>
						<td>
							<s:if test="%{enable==1}">
								<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用"/>
							</s:if>
							<s:elseif test="%{enable==2}">
								<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用"/>
							</s:elseif>
						</td>
						<td>
							<a href="javascript:void(0);" class="audit" onclick="toUserRight(${user_id});">直接授权</a>
							<a href="javascript:void(0);" class="audit" onclick="toUserRole(${user_id});">设置角色</a>
							<a href="javascript:void(0);" class="return" onclick="resetPassword(${user_id});">重置密码</a>
							<a href="<%=basePath%>basic/sys/user_toUserEdit.action?user.user_id=${user_id}" class="modi">编辑</a>
							<s:if test="%{enable==2}">
								<a href="javascript:void(0);" class="disc" onclick="updateUserState(${user_id}, 1);">禁用</a>
							</s:if>
							<s:else>
								<a href="javascript:void(0);" class="enable" onclick="updateUserState(${user_id}, 2);">启用</a>
							</s:else>
						</td>
					</tr>
					</s:iterator>
					<s:if test="%{pm.list.size() == 0}">
					<tr>
						<td colspan="8"><font>很抱歉，没有找到您要的数据</font></td>
					</tr>
					</s:if>
				</tbody>
			</table>
		</div>
		<s:if test="%{pm.list.size() > 0}">
		<jsp:include page="/admin/common/pagemodel.jsp"></jsp:include>
		</s:if>
	</form>
</body>
</html>