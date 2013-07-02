<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript">
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
		enable: false
	},
	view: {
		dblClickExpand: dblClickExpand ,
		addHoverDom: addHoverDom,
		removeHoverDom: removeHoverDom,
		selectedMulti: false
	},
	callback: {                 
		beforeDrag: false,
		onClick: onClick
	}
};

$(function(){
	//加载权限资源树
	var params = {
		ct: (new Date()).getTime()
	};
	$.getJSON("<%=basePath%>basic/sys/right_loadRight.action", params, function(json){
		if(json.resultCode == 'success'){
			if(json.list.length > 0){
				json.list[0].open = true;
			}
			$.fn.zTree.init($("#treeDemo"), setting, json.list);
		}else{
			alert("加载权限资源信息失败!");
		}
	});
	
	toggelWinSize(2);
	//初始化验证规则
	checkAll();
});

function dblClickExpand(treeId, treeNode) {
	return treeNode.o_level > 0;
}

function onClick(event, treeId, treeNode,clickFlag) {
	if(treeNode.right_type!='' && treeNode.right_type == 0){
		$('#modeMsg').empty();
		$('#saveBtn').attr('disabled', 'disabled');
	}else{
		changeMode('update');
	}
	$("input[name='right.right_name']").val(treeNode.right_name);
	$("input[name='right.right_id']").val(treeNode.right_id);
	$("input[name='right.order_no']").val(treeNode.order_no);
	$("input[name='right.open_mode'][value='" + treeNode.open_mode + "']").attr('checked', 'checked');
	toggelWinSize(treeNode.open_mode);
	$("input[name='right.box_width']").val(treeNode.box_width);
	$("input[name='right.box_height']").val(treeNode.box_height);
	$("input[name='right.right_code']").val(treeNode.right_code);
	$("input[name='right.aurl']").val(treeNode.aurl);
	$("input[name='right.remark']").val(treeNode.remark);
	
	var pn = treeNode.getParentNode();
	$("input[name='right.parent_id']").val(pn!=null ? pn.right_id : '');
	$("input[name='right.parent_name']").val(pn!=null ? pn.right_name : '');
	event.stopPropagation();
}
				
function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
	if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
	var addStr = "<span class='button add' id='addBtn_" + treeNode.id + "' title='新增权限资源' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	var btn = $("#addBtn_"+treeNode.id);
	if (btn) btn.bind("click", function(event){
		changeMode('insert',treeNode);
		$("input[name='right.parent_name']").val(treeNode.right_name);
		$("input[name='right.parent_id']").val(treeNode.right_id);
		
		$("input[name='right.right_id']").val('');
		$("input[name='right.right_name']").val('');
		$("input[name='right.order_no']").val('');
		$("input[name='right.open_mode'] [value='2']").attr('checked', 'checked');
		$("input[name='right.box_width']").val(0);
		$("input[name='right.box_height']").val(0);
		$("input[name='right.right_code']").val('');
		$("input[name='right.aurl']").val('');
		$("input[name='right.remark']").val('');
		event.stopPropagation();
	});
};

function removeHoverDom(treeId, treeNode) {
	$("#addBtn_"+treeNode.id).unbind().remove();
};

//更改操作模式
function changeMode(mode){
	var action = '<%=basePath %>basic/sys/right_updateRight.action';
	var modeMsg = '编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/right_insert.action';
		modeMsg = '创建模式';
	}
	var saveBtn = 1,delBtn = 0,grantBtn = 1;
	var childrens = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes(true)[0].children;
	if(childrens == undefined){
		delBtn = 1;
	}else{
		delBtn = 0;
	}
	
	$('#checkType').val(mode);
	toggleButtons(saveBtn,delBtn,grantBtn);
	$('#form').attr('action', action);
	$('#modeMsg').empty().append(modeMsg);
	
}

function toggleButtons(saveBtn, deleteBtn, grantBtn){
	if(saveBtn == '1'){
		$('#saveBtn').css('display', '');
	}else{
		$('#saveBtn').css('display', 'none');
	}
	if(deleteBtn == '1'){
		$('#deleteBtn').css('display', '');
	}else{
		$('#deleteBtn').css('display', 'none');
	}
	/*
	if(grantBtn == '1'){
		$('#grantBtn').css('display', '');
	}else{
		$('#grantBtn').css('display', 'none');
	}*/
}

function toggelWinSize(mode){
	if(mode == 2){
		$('#tr_win_size').hide();
	}else if(mode == 1){
		$('#tr_win_size').show();
	}
}

function checkAll(){
	var name = new LiveValidation('rightName',{onlyOnSubmit:true});
	name.add( Validate.Presence, {failureMessage: "不能为空!"});
	name.add( Validate.Length, { maximum: 30} );
	name.add( Validate.Custom, { failureMessage: '权限资源名称已经存在!', against: function(value, args){
		var valid = 'true';
		var checkType = $('#checkType').val();
		var params = {
			'right.right_name': $('#rightName').val(),
			'right.parent_id': $('#parent_id').val(),
			'checkType': checkType,
			ct: (new Date()).getTime()
		};
		
		if(checkType == 'update'){
			params['right.right_id'] = $('#rightId').val();
		}
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/right_checkRight.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	
	var order = new LiveValidation('order', {onlyOnSubmit:true});
	order.add( Validate.Presence, {failureMessage: "不能为空!"});
	order.add( Validate.Numericality, {notANumberMessage : "须输入数字!"});
	
	var boxWidth = new LiveValidation('box_width', {onlyOnSubmit:true});
	boxWidth.add( Validate.Presence, {failureMessage: "不能为空!"});
	boxWidth.add( Validate.Numericality, {notANumberMessage : "须输入数字!"});
	
	var boxHeight = new LiveValidation('box_height', {onlyOnSubmit:true});
	boxHeight.add( Validate.Presence, {failureMessage: "不能为空!"});
	boxHeight.add( Validate.Numericality, {notANumberMessage : "须输入数字!"});
}

//删除权限
function deleteRight(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var node = treeObj.getSelectedNodes(true)[0];
	var childrens = node.children;
	var idStr = node.right_id;

	$.post("<%=basePath %>basic/sys/right_delete.action",{'right.right_id':idStr},function (json){
		if(json.resultCode){
			alert("操作成功");
			window.location.href = "<%=basePath %>admin/basic/system/right/right_manage.jsp";
		}else{
			alert("操作失败");
		}
	});
}
</script>
<style type="text/css">
.ztree li span.button.pIcon01_ico_open{margin-right:2px; background: url(<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/img/diy/1_open.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.pIcon01_ico_close{margin-right:2px; background: url(<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/img/diy/1_close.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.pIcon02_ico_open{margin-right:2px; background: url(<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/img/diy/3.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle} 
.ztree li span.button.pIcon02_ico_close{margin-right:2px; background: url(<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/img/diy/3.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<form action="<%=basePath %>basic/sys/right_updateRight.action" id="form" method="post">
				<div class="title">权限资源信息</div>
				<div class="editorTab" style="width: 700px;">
					<table>
							<tr>
								<th style="width: 20%">操作模式</th>
								<td colspan="3">
									<font id="modeMsg" style="font-weight:bold; font-size: medium;"></font>
									<input type="hidden" name="checkType" id="checkType"/>
								</td>
							</tr>
							<tr>
								<th>父&nbsp;&nbsp;节&nbsp;&nbsp;点</th>
								<td colspan="3">
									<input type="text" name="right.parent_name" id="parent_name" readonly="readonly" class="unenterTextbox" />
									<input type="hidden" name="right.parent_id" id="parent_id"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>资源名称</th>
								<td colspan="3">
									<input type="text" name="right.right_name" id="rightName"/>
									<input type="hidden" name="right.right_id" id="rightId"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>顺&nbsp;&nbsp;序&nbsp;&nbsp;号</th>
								<td colspan="3">
									<input type="text" name="right.order_no" id="order"/>
								</td>
							</tr>
							<tr id="tr_open_mode">
								<th><font>*</font>打开模式</th>
								<td colspan="3">
									<label><input type="radio" name="right.open_mode" value="2" checked="checked" onclick="javascript:toggelWinSize(2);"/>非弹出式</label>
									&nbsp;&nbsp;
									<label><input type="radio" name="right.open_mode" value="1" onclick="javascript:toggelWinSize(1);"/>弹出式</label>
								</td>
							</tr>
							<tr id="tr_win_size">
								<th><font>*</font>弹出窗宽高(像素)</th>
								<td colspan="3">
									宽<input type="text" name="right.box_width" id="box_width" size="4" maxlength="4" value="0" onclick="javascript:this.select();"/>
									&nbsp;*&nbsp;
									高<input type="text" name="right.box_height" id="box_height" size="4" maxlength="4" value="0" onclick="javascript:this.select();"/>
								</td>
							</tr>
							<tr id="tr_code">
								<th>权限编码</th>
								<td colspan="3">
									<input name="right.right_code" id="right_code" maxlength="100" size="50"/>
								</td>
							</tr>
							<tr id="tr_url">
								<th>访问URL</th>
								<td colspan="3">
									<input name="right.aurl" id="url" maxlength="400" size="50"/>
								</td>
							</tr>
							<tr>
								<th>备注说明</th>
								<td colspan="3">
									<input name="right.remark" id="remark" maxlength="50" size="50"/>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center" id="buttons">
									<span class="btn" id="saveSpan"><input type="submit" value="保存" id="saveBtn" style="display:none;"/></span>
									<span class="btn" ><input type="button" value="删除" id="deleteBtn" style="display:none;" onclick="javascript:deleteRight();"/></span>
									<span class="btn"><input type="button" value="授权角色" id="grantBtn" style="display:none;"/></span>
								</td>
							</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
