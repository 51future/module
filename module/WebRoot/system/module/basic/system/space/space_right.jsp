<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script type="text/javascript">
$(function(){
	loadSpaceRight();
});

var setting = {
	data: {
		key: {
			title:"remark",
			name:"right_name"
		},
		simpleData: {
			enable: true,
			idKey: "right_id",
			pIdKey: "parent_id"
		}
	},
	check: {
		enable: true,
		chkStyle: "checkbox"
	},
	view: {
		dblClickExpand: dblClickExpand ,
		selectedMulti: false
	},
	callback: {                 
		beforeDrag: false,
		onClick: onClick
	}
};

//加载权限资源
function loadSpaceRight(){
	var params = {
		ct: (new Date()).getTime(),
		'user.user_id': $('#user_id').val()
	};
	$.post("<%=basePath%>basic/sys/right_loadRightForSpace.action", params, function(json){
		if(json.resultCode == 'success'){
			for(var i=0; i<json.list.length; i++){
				if(json.list[i].source_type == 1){
					json.list[i].icon = '<%=basePath%>style/icons/right/right_01.gif';
					json.list[i].nocheck = true;
				}else if(json.list[i].source_type == 2){
					json.list[i].icon = '<%=basePath%>style/icons/right/right_02.gif';	
				}else if(json.list[i].source_type ==3){
					json.list[i].icon = '<%=basePath%>style/icons/right/right_03.gif';	
					json.list[i].nocheck = true;
				}else{
					json.list[i].icon = '<%=basePath%>style/icons/right/right_04.gif';	
				}
				
				if(json.list[i].checded == 1){
					json.list[i].checked = true;
				}else{
					json.list[i].checked = false;
				}
			}
			
			if(json.list.length > 0){
				json.list[0].open = true;
				json.list[0].nocheck = false;
				G("tDiv").style.display = "block";
				$.fn.zTree.init($("#treeDemo"), setting, json.list);
			}else if(json.list.length == 0){
				G("aDiv").style.display = "block";
				G("gBtn").style.display = "none";
				G("aDiv").innerHTML = "<font>该系统下暂无您的权限资源信息！</font>";
			}
		}else{
			alert("加载权限资源信息失败!");
		}
	});
}

function dblClickExpand(treeId, treeNode) {
	return treeNode.level_no > 0;
}

function onClick(event, treeId, treeNode, clickFlag) {
	
}

//用户授权,提交内容
function userGrant(){
	if(!validation()) return;
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = treeObj.getCheckedNodes(true);
	var sltid = "";
	var userId = $('#user_id').val();
	for (var i = 0; i < nodes.length; i++) {
		sltid += nodes[i].right_id + ",";
	}
	if (sltid == "") {
		if(confirm("没有选择权限/菜单！\r\n确定不授权或删除已有的权限吗？")){
			url = "<%=basePath %>basic/sys/space_saveSpaceRight.action?user.right_ids=" + sltid ;
			url += "&user.user_id=" + userId;
			document.location.href = url;
		}else{
			return;
		}
	} else if (sltid != "") {
		sltid = sltid.substring(0, sltid.length - 1);
		url = "<%=basePath %>basic/sys/space_saveSpaceRight.action?user.right_ids=" + sltid ;
		url += "&user.user_id=" + userId;
		document.location.href = url;
	}
}

function validation(){
	var valid = true;
	$(".LV_invalid_field").removeClass("LV_invalid_field"); 
   	$(".LV_invalid").remove(); 
	$(".notNull").each(function(){		//不能为空
		try{
			var c_value = $(this).val();
			Validate.Presence(c_value, { failureMessage: "不能为空!" } );
		}catch(e){
			valid = false;
			if ($(this).next('font')== null || $(this).next('font') == undefined ||$(this).next('font').html() == null) {
				$(this).addClass('LV_invalid_field');
				$(this).after('<font class=" LV_validation_message LV_invalid">'+ e.message + '</font>');
			}
		}
	});
	return valid;
}
</script>
<div class="editorTab">
	<table>
			<tr>
				<th><font>*</font>下属姓名</th>
				<td>&nbsp;&nbsp;&nbsp;
					<select id="user_id" onchange="loadSpaceRight();" class="downMenu notNull">
						<option value="">--请选择--</option>
						<s:iterator value="%{user.userList}">
							<option value="${user_id}">${user_name}<s:if test="%{org_path !=null && org_path !=''}">(${org_path})</s:if></option>
						</s:iterator>
					</select>
					<span class="btn" id="gBtn"><input type="button" value="授权" onclick="javascript:userGrant();"/></span>
				</td>
			</tr>
			<tr>
				<th style="vertical-align:top">我的权限</th>
				<td>
					<div id="aDiv" style="display:none;"></div>
					<div id="tDiv" class="left" style="display:none;margin:0px;">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</td>
			</tr>
	</table>
</div>
