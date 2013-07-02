<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script type="text/javascript">
var setting = {
	data: {
		key: {
			title: 'remark',
			name: 'dt_name'
		},
		simpleData: {
			enable: true,
			idKey: 'dt_code',
			pIdKey: 'pid'				
		}
	},
	callback:{
		onClick: showDicByType
	}
};

$(document).ready(function(){
	//加载数据字典类别
	var params = {
		ct: (new Date()).getTime()
	};
	$.getJSON("<%=basePath%>basic/sys/dict_loadDictType.action", params, function(json){
		if(json.resultCode == 'success'){
			for(var i=0; i<json.dictTypeList.length; i++){
				json.dictTypeList[i].pId=0;
			}
			json.dictTypeList[json.dictTypeList.length] = { id: 0, pId: -1, dt_name: "字典类别", open:true};
			$.fn.zTree.init($("#treeDemo"), setting, json.dictTypeList);
		}else{
			alert("加载数据字典类别失败!");
		}
	});
});

function showDicByType(event, treeId, treeNode) {
    $("#frame_dic").attr("src","<%=basePath%>basic/sys/dict_queryDictItem.action?sysDictItem.dt_code="+treeNode.dt_code);
};

function editdic(dt_code,di_key){
	$("#frame_dic").attr("src","<%=basePath%>basic/sys/dict_gotoUpdateDictItem.action?sysDictItem.dt_code="+dt_code+'&sysDictItem.di_key='+di_key);
}
function addDictItem(dt_code){
	if(dt_code == '' || dt_code == 'undefined'){
		alert("请选择要添加的类别!");
		return false;
	}
	$("#frame_dic").attr("src","<%=basePath%>basic/sys/dict_addDictItemPage.action?sysDictType.dt_code="+dt_code);
}
</script>
<style type="text/css">
html,body{height:100%;}
div.content_wrap {width: 1150px;height:100%;}
div.content_wrap div.left{float: left;width: 250px;}
div.content_wrap div.right{float: right;width: 900px; height: 100%}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<iframe id="frame_dic" scrolling="auto" height="99%" width="100%" frameborder="0" src="<%=basePath%>admin/basic/system/basicdata/dict_list.jsp"></iframe>
		</div>
	</div>
</body>
</html>
