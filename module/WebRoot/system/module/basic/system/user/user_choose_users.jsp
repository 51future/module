<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>选择人员</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/zTree/css/demo.css"/>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript">

var setting = {
	data: {
		key: {
			title:"o_remark",
			name:"o_name"
		},
		simpleData: {
			enable: true,
			idKey: "id",
			pIdKey: "f_id"				
		}
	},
	check: {
		enable: false
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
		ct: (new Date()).getTime()
	};
	$.getJSON("<%=basePath%>basic/sys/orgpos_loadOrg.action", params, function(json){
		if(json.resultCode == 'success'){
			if(json.list.length > 0){
				json.list[0].open = true;
			}
			$.fn.zTree.init($("#treeDemo"), setting, json.list);
		}else{
			alert("加载部门信息失败!");
		}
	});
});

function dblClickExpand(treeId, treeNode) {
	return treeNode.o_level > 0;
}

function onClick(event, treeId, treeNode,clickFlag) {
	if(treeNode.id == 0){
		return;
	}
	var url = '<%=basePath %>basic/sys/user_selectUser3Choose.action?org.id=' + treeNode.id;
	url += '&user.ustate=1'
	$('#frame').attr('src', url);
}
</script>
<style type="text/css">
html,body{height:100%;}
div.content_wrap {width: 950px;height:100%;}
div.content_wrap div.left{float: left;width: 250px;}
div.content_wrap div.right{float: right;width: 700px; height: 100%}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<iframe scrolling="auto" id="frame" frameborder="0" style="width:100%; height:98%;"
				src="<%=basePath %>basic/sys/user_selectUser3Choose.action?user.org_id=0"></iframe>
		</div>
	</div>
</body>
</html>
