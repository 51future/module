<%@ page language="java" pageEncoding="UTF-8"%>
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
//更新角色状态
function updateRoleState(roleId, enabled){
	var params = {
			ct : getCurrentTime(),
			'role.role_id' : roleId,
			'role.enabled' : enabled
	};
	$.getJSON('<%=basePath%>basic/sys/role_updateRoleState.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("改变角色状态成功！");
			$('#searchBtn').click();
		}else{
			alert("改变角色状态失败，请联系管理员！");
		}
	});
}

function addRole(){
	var url = '<%=basePath %>admin/basic/system/role/role_add.jsp';
	window.location.href = url;
}

//编辑
function edit(role_id){
	var url = '<%=basePath%>basic/sys/role_gotoUpdate.action?role.role_id=' + role_id;
	document.location.href = url;
}


//删除多个
/**
function del(url) {
	var arrobj = getobj("input", "chk");
	var sltid = "";
	for (var i = 0; i < arrobj.length; i++) {
		if (arrobj[i].checked == true) {
			sltid = sltid + arrobj[i].value + ",";
		}
	}
	if (sltid == "") {
		alert("没有选择删除项！");
		return;
	} else if (sltid != "") {
		sltid = sltid.substring(0, sltid.length - 1);
		if(confirm("此操作不可恢复，确定删除吗？")){
			document.location.href = url + "?idStr=" + sltid;
		}
	}
}
*/
//删除一个
function deleteById(id, url){
	if(confirm("此操作不可恢复，确定删除吗？")){
			document.location.href = url + "?role.role_id=" + id;
			document.location.reload();
	}
}

function roleGrant(id){
	var url = "<%=basePath%>basic/sys/role_gotoRoleGrant.action" + "?role.role_id=" + id;
	document.location.href = url;
}

function setUsers(id){
	var url = "<%=basePath%>basic/sys/role_toRoleUser.action?role.role_id=" + id;
	document.location.href = url;
}
function selectSingleUser(){
	url='<%=basePath%>admin/basic/system/user/user_choose_single.jsp';
	var obj= openModalWindow(url,"选择区域",'custom',900,550);
	for(var i=0; i<obj.length; i++){
		alert(obj[i].user_id);
		alert(obj[i].user_name);
	}
}
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/role_query.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>角色名称</th>
					<td>
						<input type="text" name="role.role_name" value="${role.role_name}" onclick="selectSingleUser();" />
					</td>
					<th>启用状态</th>
					<td>
						<select name="role.enabled" class="downMenu">
							<option value="">----请选择----</option>
							<option value="1" <s:if test="%{role.enabled == 1}">selected="selected"</s:if>>禁用</option>
							<option value="2" <s:if test="%{role.enabled == 2}">selected="selected"</s:if>>启用</option>
						</select>
					</td>
					<th>&nbsp;</th>
					<td>
						<span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
						<span class="btn"><input type="button" id="addBtn" value="添加" onclick="addRole();"/></span>
					</td>
				</tr>
			</table>
		</div>
		<!--查询条件表格-->
		<div class="listTab">
			<table>
				<thead>
					<tr>
						<td>角色名称</td>
						<td>角色类型</td>
						<td>系统内置</td>
						<td>备注说明</td>
						<td>启用状态</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{pm.list}">
					<tr>
						<td align="left">${role_name}</td>
						<td><s:if test="%{role_type == 1}">角色类型1</s:if>
							<s:if test="%{role_type == 2}">角色类型2</s:if>
						</td>
						<td>
							<s:if test="%{issys==1}">否</s:if>
							<s:elseif test="%{issys==2}">是</s:elseif>
						</td>
						<td align="left">${remark}</td>
						<td>
							<s:if test="%{enabled==1}">
								<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用"/>
							</s:if>
							<s:elseif test="%{enabled==2}">
								<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用"/>
							</s:elseif>
						</td>
						<td>
							<a href="javascript:void(0);" class="audit"	onclick="roleGrant('${role_id }');">角色授权</a>
							<a href="javascript:void(0);" class="audit"	onclick="setUsers('${role_id }', '${role_name }');">设置用户</a>
							<s:if test="%{issys==1}">
								<a href="javascript:void(0);" class="modi" onclick="edit(${role_id});">编辑</a>
								<a href="javascript:void(0);" class="del" onclick="deleteById(${role_id }, '<%=basePath%>basic/sys/role_delete.action');">删除</a>
								<s:if test="%{enabled == 2}">
									<a href="javascript:void(0);" class="disc" onclick="updateRoleState(${role_id }, 1);">禁用</a>
								</s:if>
								<s:else>
									<a href="javascript:void(0);" class="enable" onclick="updateRoleState(${role_id }, 2);">启用</a>
								</s:else>
							</s:if>
							<s:elseif test="%{issys==2}">
								<a href="javascript:void(0);" class="modi"><font style="color: gray">编辑</font></a>
								<a href="javascript:void(0);" class="del"><font style="color: gray">删除</font></a>
								<s:if test="%{enabled == 2}">
									<a href="javascript:void(0);" class="disc"><font style="color: gray">禁用</font></a>
								</s:if>
								<s:else>
									<a href="javascript:void(0);" class="enable"><font style="color: gray">启用</font></a>
								</s:else> 
							</s:elseif>
						</td>
					</tr>
					</s:iterator>
					<s:if test="%{pm.list.size() == 0}">
					<tr>
						<td colspan="6"><font>很抱歉，没有找到您要的数据</font></td>
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
