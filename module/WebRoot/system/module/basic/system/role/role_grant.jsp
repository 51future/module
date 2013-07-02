<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%--
	auth : Conner
	date : 2012-09-07
	desc : 角色授权
--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/zTree/css/demo.css"/>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
var role_id = "${role.role_id}";
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

$(function(){
	var params = {
		ct: (new Date()).getTime(),
		'role.role_id': '${role.role_id}'
	};
	$.getJSON("<%=basePath%>basic/sys/right_loadRight.action", params, function(json){
		if(json.resultCode == 'success'){
			for(var i=0; i<json.list.length; i++){
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
				G("aDiv").innerHTML = "<font>该系统下暂无权限资源信息</font>";
			}
		}else{
			alert("加载权限资源信息失败!");
		}
	});
});

function dblClickExpand(treeId, treeNode) {
	return treeNode.o_level > 0;
}

function onClick(event, treeId, treeNode, clickFlag) {
	
}

//角色授权,提交内容
function roleGrant(roleId){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = treeObj.getCheckedNodes(true);
	var sltid = "";
	for (var i = 0; i < nodes.length; i++) {
		sltid += nodes[i].right_id + ",";
	}
	if (sltid == "") {
		if(confirm("没有选择权限/菜单！\r\n确定不授权吗？")){
			url = "<%=basePath %>basic/sys/role_grant.action?idStr=" + sltid ;
			url += "&role.role_id=" + roleId;
			document.location.href = url;
		}else{
			return;
		}
	} else if (sltid != "") {
		sltid = sltid.substring(0, sltid.length - 1);
		url = "<%=basePath %>basic/sys/role_grant.action?idStr=" + sltid ;
		url += "&role.role_id=" + roleId;
		document.location.href = url;
	}
}

</script>
<style type="text/css">
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
ul.ztree {margin-top:0px;border: 0px solid #617775;background: #FFFFFF; width:230px;height:320px;overflow-y:auto;overflow-x:auto;}
</style>
</head>
<body>
	<div class="title">角色授权</div>
	<div class="editorTab">
		<table>
				<tr>
					<th>角色名称</th>
					<td colspan="3"><span id="role_name">${role.role_name}</span></td>
				</tr>
				<tr>
					<th style="vertical-align:top">权限资源</th>
					<td colspan="3">
						<div id="aDiv" style="display:none;"></div>
						<div id="tDiv" class="left" style="display:none;margin:0px;">
							<ul id="treeDemo" class="ztree"></ul>
						</div>
					</td>
				</tr>
		</table>
	</div>
	<div class="btns">
		<span class="btn" id="gBtn"><input type="button" id="submitBtn" value="授权" onclick="javascript:roleGrant(${role.role_id});"/></span>
		<span class="btn"><input type="button" id="cancelBtn" value="返回" onclick="javascript:window.history.back()"/></span>
	</div>
</body>
</html>
