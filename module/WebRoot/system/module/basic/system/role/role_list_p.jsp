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
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">

$(function(){
	changeMode('insert');
	//初始化校验规则
	checkAll();
});

//更新角色状态
function updateRoleState(roleId, enable){
	var params = {
			ct : getCurrentTime(),
			'role.role_id' : roleId,
			'role.enable' : enable
	};
	$.getJSON('<%=basePath%>basic/sys/role_updateRoleState.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("改变角色状态成功！");
			window.location.href = window.location.href;
		}else{
			alert("改变角色状态失败，请联系管理员！");
		}
	});
}

//编辑
function edit(roleId,roleName,remark){
	$('#checkType').val("update");
	changeMode('update');
	
	$('input[name="role.role_name"]').val(roleName);
	$('input[name="role.role_id"]').val(roleId);
	$('input[name="role.remark"]').val(remark);
}

//删除一个
function deleteById(id,roleName){
	if(!confirm("确定要删除角色【"+roleName+"】吗？")) return false;
	var url = '<%=basePath%>basic/sys/role_delete.action';
	document.location.href = url + "?role.role_id=" + id;
	document.location.reload();
}

//角色授权
function toRoleRight(role_id){
	var url = "<%=basePath%>basic/sys/role_toRoleRight.action" + "?role.role_id=" + role_id;
	document.location.href = url;
}

//设置用户
function toRoleUser(role_id){
	var url = "<%=basePath%>basic/sys/role_toRoleUser.action?role.role_id=" + role_id;
	document.location.href = url;
}

//表单校验
function checkAll(){
	var org_name = new LiveValidation('org_name',{onlyOnSubmit:true});
	org_name.add( Validate.Presence, {failureMessage: "请先选择一个组织部门!"});
	
	var role_name = new LiveValidation('role_name',{onlyOnSubmit:true});
	role_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	role_name.add( Validate.Length, { maximum: 30} );
	role_name.add( Validate.Custom, { failureMessage: '名称已经存在！', against: function(value, args){
		var valid = 'true';
		var checkType = $('#checkType').val();
		var params = {
			'role.role_name': $('#role_name').val(),
			'role.org_id': $('#org_id').val(),
			'checkType': checkType,
			ct: (new Date()).getTime()
		};
		if(checkType == 'update'){
			params['role.role_id'] = $('#role_id').val();
		}
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/role_checkRole.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	
	var remark = new LiveValidation('remark',{onlyOnSubmit:true});
	remark.add( Validate.Length, { maximum: 100} );
}

//更改操作模式
function changeMode(mode){
	if(!mode){
		mode = $('#checkType').val();
		mode = (mode == 'insert' ? 'update' : 'insert');
	}
	var action = '<%=basePath %>basic/sys/role_update.action';
	var modeMsg = '编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/role_insert.action';
		modeMsg = '创建模式';
	}
	$('#checkType').val(mode);
	$('#form').attr('action', action);
	$('#modeMsg').empty().append(modeMsg);
}

</script>
</head>
<body>
	<form action="<%=basePath %>basic/sys/role_insert.action" id="form" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th><font>*</font>所属部门</th>
					<td><input type="text" id="org_name" name="role.org_name" value="${org.org_name}" readonly="readonly" class="unenterTextbox" /> 
						<input type="hidden" id="org_id" name="role.org_id" value="${org.org_id}" />
						<input type="hidden" id="checkType" name="checkType" value="insert" />
					</td>
					<th><font>*</font>角色名称</th>
					<td><input type="text" id="role_name" name="role.role_name" /> 
						<input type="hidden" id="role_id" name="role.role_id" />
					</td>
				</tr>
				<tr>
					<th>备注说明</th>
					<td><input type="text" id="remark" name="role.remark" maxlength="50" /></td>
					<th></th>
					<td>(<font id="modeMsg" style="font-weight: bold;"></font>) 
						<span class="btn"><input type="button" id="subBtn" value="切换模式" onclick="changeMode();" /></span> 
						<span class="btn"><input type="submit" id="subBtn" value="保存" /></span>
					</td>
				</tr>
			</table>
		</div>
	</form>

	<div class="listTab">
		<table>
			<thead>
				<tr>
					<td>角色名称</td>
					<td>所属机构</td>
					<td>启用状态</td>
					<td>备注说明</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="%{pm.list}">
					<tr>
						<td align="left">${role_name}</td>
						<td align="left">${org_name}</td>
						<td><s:if test="%{enable==1}">
								<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用" />
							</s:if><s:elseif test="%{enable==2}">
								<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用" />
							</s:elseif>
						</td>
						<td align="left">${remark}</td>
						<td>
							<s:if test="%{issys==1}">
								<s:if test="%{enable == 2}">
									<a href="javascript:void(0);" onclick="updateRoleState(${role_id }, 1);" class="disc" >禁用</a>
								</s:if><s:else>
									<a href="javascript:void(0);" onclick="updateRoleState(${role_id }, 2);" class="enable" >启用</a>
								</s:else>
								<a href="javascript:void(0);" onclick="edit('${role_id}','${role_name}','${remark}');" class="modi" >编辑</a>
								<a href="javascript:void(0);" onclick="deleteById(${role_id},'${role_name}');" class="del" >删除</a>
							</s:if><s:elseif test="%{issys==2}">
								<s:if test="%{enable == 2}">
									<a href="javascript:void(0);" class="disc" style="color: gray">禁用</a>
								</s:if><s:else>
									<a href="javascript:void(0);" class="enable" style="color: gray">启用</a>
								</s:else>
								<a href="javascript:void(0);" class="modi" style="color: gray">编辑</a>
								<a href="javascript:void(0);" class="del" style="color: gray">删除</a>
							</s:elseif>
							<a href="javascript:void(0);" onclick="toRoleRight('${role_id }');" class="audit" >角色授权</a> 
							<a href="javascript:void(0);" onclick="toRoleUser('${role_id}');" class="audit" >设置用户</a> 
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
</body>
</html>
