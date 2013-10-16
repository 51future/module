<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<style type="text/css">
ul.ztree {margin-top: 0px; border: 0px solid #617775; background: #FFFFFF; width: 230px; 
			height: 350px; overflow-y: auto; overflow-x: auto; border-color: red; }
</style>
<div class="treeMenu">
	<div id="aDiv2" style="display:none;"></div>
	<div id="tDiv2" class="left" style="display:none;margin:0px;">
		<ul id="treeDemo2" class="ztree"></ul>
	</div>
</div>
<div class="rightBox">
	<div class="title" id="faster_msg">已添加的快捷功能 </div>
	<div class="rightArea"><ul id="faster"></ul></div>
	<div class="btns" style="top:420px;"> 
		<span class="btn" id="gBtn2"><input type="button" value="确认选择" onclick="setFaster();"/></span> 
	</div>
</div>

<script type="text/javascript">
$(function(){
	loadFasterRight();
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
		onClick: onClick,
		onCheck: onCheck
	}
};

//加载权限资源
var fasterCount = 0;//快捷菜单个数
function loadFasterRight(){
	$.post("<%=basePath%>basic/sys/right_loadRightForFaster.action", {ct: (new Date()).getTime()}, function(json){
		if(json.resultCode == 'success'){
			var fasterHtml = '';
			for(var i=0; i<json.list.length; i++){
				if(json.list[i].right_type !=1){// 资源类型1:菜单；2：按钮
					json.list[i].nocheck = true;
				}
				if(json.list[i].checded == 1){
					json.list[i].checked = true;
					json.list[i].icon = '<%=basePath%>style/icons/right/right_03.gif';	
					if(json.list[i].right_type ==1 && json.list[i].aurl !=''){// 资源类型1:菜单；2：按钮
						fasterHtml += '<li id="faster_'+json.list[i].right_id+'">'+json.list[i].right_name+'</li>';
						fasterCount++;
					}
				}else{
					json.list[i].checked = false;
					json.list[i].icon = '<%=basePath%>style/icons/right/right_04.gif';	
				}
			}
		
			$('#faster').html(fasterHtml);
			
			if(json.list.length > 0){
				json.list[0].open = true;
				json.list[0].nocheck = false;
				G("tDiv2").style.display = "block";
				$.fn.zTree.init($("#treeDemo2"), setting, json.list);
			}else if(json.list.length == 0){
				G("aDiv2").style.display = "block";
				G("gBtn2").style.display = "none";
				G("aDiv2").innerHTML = "<font>该系统下暂无您的权限资源信息</font>";
			}
		}else{
			alert("加载您的权限资源信息失败!");
		}
	});
}

function dblClickExpand(treeId, treeNode) {
	return treeNode.level_no > 0;
}

function onClick(event, treeId, treeNode, clickFlag) {
}

function onCheck(event, treeId, treeNode) {
	if(treeNode.right_type ==1 && treeNode.aurl !=''){
		if(treeNode.checked){
			if($('#faster_'+treeNode.right_id).html()==null){
				if(fasterCount < 10){
					$('#faster').append('<li id="faster_'+treeNode.right_id+'">'+treeNode.right_name+'</li>');
					fasterCount++;
					$('#faster_msg').html('已添加的快捷功能');
				}else{
					$.fn.zTree.getZTreeObj("treeDemo2").checkNode(treeNode, false, true);
					$('#faster_msg').html('已添加的快捷功能<font>(只能添加10个快捷功能)</font>');
				}
			}
		}else{
			if(fasterCount > 0 && $('#faster_'+treeNode.right_id).html()!=null) fasterCount--;
			$('#faster_'+treeNode.right_id).remove();
			$('#faster_msg').html('已添加的快捷功能');
		}
	}
	checkFaster(treeNode);
};

//控制快捷菜单的显示
function checkFaster(treeNode){
	var childrens = treeNode.children;
	if(childrens != undefined)
	for(var i=0 ; i< childrens.length;i++){
		if(childrens[i].right_type ==1 && childrens[i].aurl !=''){
			if(childrens[i].checked){
				if($('#faster_'+childrens[i].right_id).html()==null){
					if(fasterCount < 10){
						$('#faster').append('<li id="faster_'+childrens[i].right_id+'">'+childrens[i].right_name+'</li>');
						fasterCount++;
						$('#faster_msg').html('已添加的快捷功能');
					}else{
						$.fn.zTree.getZTreeObj("treeDemo2").checkNode(childrens[i], false, true);
						$('#faster_msg').html('已添加的快捷功能<font>(只能添加10个快捷功能)</font>');
						
					}
				}
			}else{
				if(fasterCount > 0 && $('#faster_'+childrens[i].right_id).html()!=null) fasterCount--;
				$('#faster_'+childrens[i].right_id).remove();
				$('#faster_msg').html('已添加的快捷功能');
			}
		}
		checkFaster(childrens[i]);
	}
}

//设置快捷键
function setFaster(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
	var nodes = treeObj.getCheckedNodes(true);
	var sltid = "";
	for (var i = 0; i < nodes.length; i++) {
		sltid += nodes[i].right_id + ",";
	}
	if (sltid == "") {
		if(confirm("没有选择快捷功能！\r\n确定不设置或删除已有的快捷功能吗？")){
			url = "<%=basePath %>basic/sys/space_saveSpaceFaster.action?user.right_ids=" + sltid ;
			document.location.href = url;
		}else{
			return;
		}
	} else if (sltid != "") {
		sltid = sltid.substring(0, sltid.length - 1);
		url = "<%=basePath %>basic/sys/space_saveSpaceFaster.action?user.right_ids=" + sltid ;
		document.location.href = url;
	}
}
</script>