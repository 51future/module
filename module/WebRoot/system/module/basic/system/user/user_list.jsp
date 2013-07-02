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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
$(function(){
	
});

//更新用户状态
function updateUserState(userId, enable){
	var params = {
			ct : getCurrentTime(),
			'user.user_id': userId,
			'user.enable': enable
	};
	$.getJSON('<%=basePath%>basic/sys/user_updateUserState.action', params, function(json){
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
	alert(userId);
	var params = {
			ct : getCurrentTime(),
			'user.user_id': userId
	};
	$.getJSON('<%=basePath%>basic/sys/user_resetPassword.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("重置用户密码成功！");
		}else{
			alert("重置用户密码失败，请联系管理员！");
		}
	});
}

function gotoUserPosition(userId, orgId){
	var url = '<%=basePath%>basic/sys/user_gotoUserPosition.action?user.id=' + userId + '&user.org_id=' + orgId;
	window.location.href = url
}

function gotoUserRole(userId){
	var url = '<%=basePath%>basic/sys/user_gotoUserRole.action?user.user_id=' + userId;
	window.location.href = url
}

function chooseOrgan(){
	var url = '<%=basePath%>admin/basic/system/dep/organ_choose.jsp'; 
	window.callback = fillOrgan;
	openModalWindow(url, window, 'small');
}

function fillOrgan(orgId, orgName){
	$('input[name="user.dept_id"]').val(orgId);
	$('input[name="user.dept_name"]').val(orgName);
}
/**
 * 设置下级
 */
function chooseSubordinate(userId){
	var url = '<%=basePath%>basic/sys/user_setSubordinate.action?user.id=' + userId;
	openWindow(url, '设置下级');
}
function cle(){
	$("#orgname").val('');
	$("#orgid").val('');
}
//同步流程用户
function sync(){
	$.getJSON('<%=basePath%>basic/sys/user_sync.action', null, function(json){
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
						<input type="text" name="user.uname" value="${user.user_account}"/>
					</td>
					<th>用户姓名</th>
					<td>
						<input type="text" name="user.rname" value="${user.user_name}"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<th>所属部门</th>
					<td><input name="user.dept_name" type="text" class="chooseInput" title="点击选择信息" id="orgname"  onclick="chooseOrgan();" value="${user.dept_name}" size="20" readonly="readonly"/>
				    <span class="btn"><input type="button" value="清空" onclick="cle();"/></span>
						<input type="hidden" id="orgid" name="user.dept_id" value="${user.dept_id}"/>
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
							<input type="button" value="新增用户" 
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
						<td>登录账号</td>
						<td>用户姓名</td>
						<td>所属区域</td>
						<td>所属组织</td>
						<td>所属部门</td>
						<td>担任职务</td>
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
						<td class="tdLeft">${org_name}</td>
						<td class="tdLeft">${dept_name}</td>
						<td class="tdLeft">${pos_name}</td>
						<td class="tdLeft">${cellphone_no}</td>
						<td>
							<s:if test="%{enable==1}">
								<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用"/>
							</s:if>
							<s:elseif test="%{enable==2}">
								<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用"/>
							</s:elseif>
						</td>
						<td>
							<a href="javascript:void(0);" class="audit" onclick="gotoUserRole(${user_id});">赋角色</a>
							<!-- <a href="javascript:void(0);" class="set" onclick="gotoUserPosition(${user_id},'${org_id}');">添加职务</a> -->
							<a href="javascript:void(0);" class="return" onclick="resetPassword(${user_id});">重置密码</a>
							<a href="<%=basePath%>basic/sys/user_editUser.action?user.user_id=${user_id}" class="modi">编辑</a>
							<s:if test="%{enable==2}">
								<a href="javascript:void(0);" class="disc" onclick="updateUserState(${user_id}, 1);">禁用</a>
							</s:if>
							<s:else>
								<a href="javascript:void(0);" class="enable" onclick="updateUserState(${user_id}, 2);">启用</a>
							</s:else>
							<!-- 
							<a href="javascript:void(0);" class="set" onclick="chooseSubordinate(${user_id});">设置下级</a>
							 -->
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