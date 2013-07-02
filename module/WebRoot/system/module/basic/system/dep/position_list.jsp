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
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
$(function(){
	changeMode('insert');
	
	//初始化校验规则
	checkAll();
});

//更新职务状态
function updatePosState(posId, enable){
	var params = {
			ct : getCurrentTime(),
			'pos.pos_id': posId,
			'pos.enable': enable,
			'pos.org_id': '${pos.org_id}'
	};
	$.getJSON('<%=basePath%>basic/sys/orgpos_updatePositionState.action', params, function(json){
		if(json.resultCode == 'success'){
			if(enable == 2){
				alert("启用职务操作成功！");
			}else{
				alert("禁用职务操作成功！");
			}
			window.location.href = window.location.href;
		}else{
			if(enable == 2){
				alert("启用职务操作失败！");
			}else{
				alert("禁用职务操作失败！");
			}
		}
	});
}

function deletePosition(posId){
	var params = {
			ct : getCurrentTime(),
			'pos.pos_id': posId
	};
	$.getJSON('<%=basePath%>basic/sys/orgpos_deletePosition.action', params, function(json){
		if(json.resultCode == 'success'){
			alert("删除职务操作成功！");
			window.location.href = window.location.href;
		}else{
			alert("该职务正在使用中，不能删除！");
		}
	});
}

function edit(posId, posName, remark){
	changeMode('update');
	
	$('input[name="pos.pos_name"]').val(posName);
	$('input[name="pos.pos_id"]').val(posId);
	$('input[name="pos.remark"]').val(remark);
	
	$('#checkType').val("update");
	$('#form').attr('action', '<%=basePath%>basic/sys/orgpos_updatePosition.action');
}

function checkAll(){
	var org_name = new LiveValidation('org_name',{onlyOnSubmit:true});
	org_name.add( Validate.Presence, {failureMessage: "请先选择一个组织部门!"});
	
	var pos_name = new LiveValidation('pos_name',{onlyOnSubmit:true});
	pos_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	pos_name.add( Validate.Length, { maximum: 40} );
	pos_name.add( Validate.Custom, { failureMessage: '名称已经存在！', against: function(value, args){
		var valid = 'true';
		var checkType = $('#checkType').val();
		var params = {
			'pos.pos_name': $('#pos_name').val(),
			'pos.org_id': $('#org_id').val(),
			'checkType': checkType,
			ct: (new Date()).getTime()
		};
		if(checkType == 'update'){
			params['pos.pos_id'] = $('#pos_id').val();
		}
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/orgpos_checkPos.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
}

//更改操作模式
function changeMode(mode){
	if(!mode){
		mode = $('#checkType').val();
		mode = (mode == 'insert' ? 'update' : 'insert');
	}
	var action = '<%=basePath %>basic/sys/orgpos_updatePosition.action';
	var modeMsg = '编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/orgpos_insertPosition.action';
		modeMsg = '创建模式';
	}
	
	$('#checkType').val(mode);
	$('#form').attr('action', action);
	$('#modeMsg').empty().append(modeMsg);
}

</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/orgpos_insertPosition.action" id="form" method="post">
	<div class="searchTab">
		<table>
			<tr>
				<th><font>*</font>所属部门</th>
				<td>
					<input type="text" name="pos.org_name" readonly="readonly" class="unenterTextbox" value="${org.org_name}" id="org_name"/>
					<input type="hidden" name="pos.org_id" value="${org.org_id}" id="org_id"/>
					<input type="hidden" name="checkType" id="checkType" value="insert"/>
				</td>
				<th><font>*</font>职务名称</th>
				<td>
					<input type="text" name="pos.pos_name" id="pos_name"/>
					<input type="hidden" name="pos.pos_id" id="pos_id"/>
				</td>
			</tr>
			<tr>
				<th>备注说明</th>
				<td>
					<input type="text" name="pos.remark" maxlength="50"/>
				</td>
				<th></th>
				<td>
					(<font id="modeMsg" style="font-weight:bold;"></font>)
					<span class="btn"><input type="button" id="subBtn" value="切换模式" onclick="changeMode();"/></span>
					<span class="btn"><input type="submit" id="subBtn" value="保存"/></span>
				</td>
			</tr>
		</table>
	</div>
	</form>
	
	<!--查询条件表格-->
	<div class="listTab">
		<table>
			<thead>
				<tr>
					<td>职务名称</td>
					<td>所属部门</td>
					<td>状态</td>
					<td>备注说明</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="%{posList}">
				<tr>
					<td class="tdLeft">${pos_name}</td>
					<td class="tdLeft">${org_name}</td>
					<td>
						<s:if test="%{ enable==2}">
							<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用"/>
						</s:if>
						<s:elseif test="%{enable==1}">
							<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用"/>
						</s:elseif>
					</td>
					<td class="tdLeft">${remark}</td>
					<td>
						<s:if test="%{enable==1}">
							<a href="javascript:void(0);" class="enable" onclick="updatePosState(${pos_id}, 2);">启用</a>
						</s:if>
						<s:else>
							<a href="javascript:void(0);" class="disc" onclick="updatePosState(${pos_id}, 1);">禁用</a>
						</s:else>
						<a href="javascript:void(0);" class="modi" onclick="edit(${pos_id}, '${pos_name}', '${remark}')">编辑</a>
						<a href="javascript:void(0);" class="del" onclick="deletePosition(${pos_id});">删除</a>
					</td>
				</tr>
				</s:iterator>
				<s:if test="%{posList.size() == 0}">
				<tr>
					<td colspan="5"><font>很抱歉，没有找到您要的数据</font></td>
				</tr>
				</s:if>
			</tbody>
		</table>
	</div>
</body>
</html>
