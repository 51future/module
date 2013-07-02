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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
//保存职务信息
function save(){
	//新增副职
	var posIds = [];
	var posSels = $('select[name="pos_id"]');
	for(var i=0; i<posSels.length; i++){
		var posId = $(posSels[i]).val();
		if(posId==null){
			 alert('职务不能为空');
			 return;
		 }
		if(!isEmpty(posId)){
			posIds.push(posId);
		}
	}
	
	//原有副职
	var spans = $('.position');
	for(var i=0; i<spans.length; i++){
		var posId = $(spans[i]).attr('posid');
		if(!isEmpty(posId)){
			posIds.push(posId);
		}
	}
	
	//去除重复职务
	var tempArr = [];
	for(var i=0; i<posIds.length; i++){
		if(!contains(tempArr, posIds[i])){
			tempArr.push(posIds[i]);
		}
	}
	posIds = tempArr;
	//保存职务
	var params = {
		ct: (new Date()).getTime(),
		'user.id': '${user.id}',
		'user.posIds': posIds.join(';'),
		'user.position_id': $('#position').val()
	};
	$.getJSON("<%=basePath%>basic/sys/user_saveUserPosition.action", params, function(json){
		if(json.resultCode == 'success'){
			alert('保存用户职务信息成功！');
			window.location.href = window.location.href;
		}else{
			alert('保存用户职务信息失败，请联系管理员！');
		}
	});
}

var rowOrder = 0;
function chooseOrgan(order){
	rowOrder = order;
	var url = '<%=basePath%>admin/basic/system/dep/organ_choose.jsp'; 
	window.callback = fillOrgan;
	openModalWindow(url, window, 'small');
}

function fillOrgan(orgId, orgName){
	$('#org_name_' + rowOrder).val(orgName);
	$('#org_id_' + rowOrder).val(orgId);
	
	var params = {
		ct: (new Date()).getTime(),
		'pos.org_id': orgId
	};
	$.getJSON("<%=basePath%>basic/sys/orgpos_loadPositionJSON.action", params, function(json){
		if(json.resultCode == 'success'){
			$('#pos_' + rowOrder).empty();
			for(var i=0; i<json.list.length; i++){
				$('#pos_' + rowOrder).append('<option value="' + json.list[i].position_id + '">' + json.list[i].position_name + '</option>');
			}
		}
	});
}

var order = 0;
function addTr(){
	var html = '<tr><td colspan="4">';
	html	 += '&nbsp;&nbsp;&nbsp;&nbsp;部门:&nbsp;&nbsp;&nbsp;&nbsp;';
	html	 += '<input type="text" id="org_name_' + order + '" readonly="readonly" class="unenterTextbox"/>';
	html	 += '<input type="hidden" id="org_id_' + order + '"/>';
	html	 += '<a href="javascript:void(0);" class="choose" onclick="chooseOrgan(' + order + ');">选择</a>';
	html	 += '&nbsp;&nbsp;&nbsp;&nbsp;职务:&nbsp;&nbsp;&nbsp;&nbsp;';
	html	 += '<select id="pos_' + order + '" class="downMenu" name="pos_id"></select>';
	html	 += '<a href="javascript:void(0);" class="del" onclick="delTr();">删除副职</a>';
	html	 += '</td></tr>';
	
	$('#tbody').append(html);
	order = order + 1;
}

function delTr(){
	$(event.srcElement).parent().parent().remove();
}

function delPos(){
	$(event.srcElement).parent().remove();
}
</script>
</head>
<body>
	<div class="title">用户职务维护</div>
	<div class="editorTab">
		<table>
			<tbody id="tbody">
				<tr>
					<th>登录账号</th>
					<td>
						<input type="text" name="user.uname" id="uname" value="${user.uname}"  readonly="readonly" class="unenterTextbox" />
					</td>
					<th>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</th>
					<td>
						<input type="text" name="user.rname" id="rname" value="${user.rname}"  readonly="readonly" class="unenterTextbox" />
					</td>
				</tr>
				<tr>
					<th>所在部门</th>
					<td>
						<input type="text" name="user.org_name" id="org_name" value="${user.org_name}" readonly="readonly" class="unenterTextbox"/>
						<input type="hidden" id="main_org_id" name="user.org_id" value="${user.org_id}"/>
					</td>
					<th><font>*</font>主&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职</th>
					<td>
						<select name="user.position_id" id="position" class="downMenu">
							<s:iterator value="%{posList}">
								<option value="${position_id}" <s:if test="%{position_id == user.position_id}">selected="selected"</s:if> >${position_name}</option>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<th>副&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;职</th>
					<td colspan="3">
						<s:iterator value="user.positionList">
							<span class="position" posid="${position_id}">
								${position_name}&nbsp;&nbsp;&nbsp;(${org_name})
								<a href="javascript:void(0);" class="del" onclick="delPos();">删除</a><br/>
							</span>
						</s:iterator>
					</td>
				</tr>
				<tr id="addRow">
					<td colspan="4">
						<span class="btn">
							<input type="button" id="cancelBtn" value="增加副职" onclick="addTr();"/>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="btns">
		<span class="btn"><input type="button" id="submitBtn" value="保存" onclick="save();"/></span>
		<span class="btn">
			<input type="button" id="cancelBtn" value="返回" 
				onclick="javascript:window.location.href='<%=basePath%>basic/sys/user_selectUser.action'"/>
		</span>
	</div>
</body>
</html>