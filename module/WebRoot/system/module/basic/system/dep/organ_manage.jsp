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
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/icon.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript">

//组织部门树配置
var setting = {
	data: {
		key: {
			title: 'remark',
			name: 'org_name'
		},
		simpleData: {
			enable: true,
			idKey: 'org_id',
			pIdKey: 'parent_id'				
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
	//加载初始化组织部门树
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
			alert("加载组织信息失败!");
		}
	});
	
	//初始化验证规则
	checkAll();
});

function dblClickExpand(treeId, treeNode) {
	return treeNode.level_no > 0;
}

function onClick(event, treeId, treeNode,clickFlag) {
	if(treeNode.org_id == 0){
		$('#modeMsg').empty();
		$('#saveBtn').attr('disabled', 'disabled');
	}else{
		changeMode('update');
	}
	$("input[name='org.org_name']").val(treeNode.org_name);
	$("input[name='org.org_id']").val(treeNode.org_id);
	$("input[name='org.remark']").val(treeNode.remark);
	$("input[name='org.order_no']").val(treeNode.order_no);
	$("select[name='org.org_type'] option[value='" + treeNode.org_type + "']").attr('selected', 'selected');
	$("select[name='org.enable'] option[value='" + treeNode.enable + "']").attr('selected', 'selected');
	
	var pn = treeNode.getParentNode();
	$("input[name='org.parent_id']").val(pn!=null ? pn.org_id : '');
	$("input[name='org.parent_name']").val(pn!=null ? pn.org_name : '');
	$("input[name='org.parent_level']").val(pn!=null ? pn.level_no : '');
}
				
function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
	if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
	var addStr = "<span class='button add' id='addBtn_" + treeNode.id + "' title='组织机构' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	
	var btn = $("#addBtn_"+treeNode.id);
	if (btn) btn.bind("click", function(event){
		changeMode('insert');
		
		$("input[name='org.parent_name']").val(treeNode.org_name);
		$("input[name='org.parent_id']").val(treeNode.org_id);
		$("input[name='org.parent_level_no']").val(treeNode.level_no);
		$("input[name='org.parent_node_path']").val(treeNode.node_path);
		
		$("input[name='org.org_id']").val('');
		$("input[name='org.org_name']").val('');
		$("input[name='org.remark']").val('');
		$("input[name='org.order_no']").val('');
		event.stopPropagation();
	});
};

function removeHoverDom(treeId, treeNode) {
	$("#addBtn_"+treeNode.id).unbind().remove();
};

//更改操作模式
function changeMode(mode){
	var action = '<%=basePath %>basic/sys/orgpos_updateOrg.action';
	var modeMsg = '编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/orgpos_insertOrg.action';
		modeMsg = '创建模式';
	}
	var childrens = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes(true)[0].children;
	if(childrens == undefined){
		$('#deleteBtn').attr('disabled', false);
	}else{
		$('#deleteBtn').attr('disabled', 'disabled');
	}
	//$('#deleteBtn').attr('disabled', false);
	$('#checkType').val(mode);
	$('#saveBtn').attr('disabled', false);
	$('#form').attr('action', action);
	$('#modeMsg').empty().append(modeMsg);
}

function checkAll(){
	var org_name = new LiveValidation('org_name',{onlyOnSubmit:true});
	org_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	org_name.add( Validate.Length, { maximum: 30} );
	org_name.add( Validate.Custom, { failureMessage: '组织名称已经存在！', against: function(value, args){
		var valid = 'true';
		var checkType = $('#checkType').val();
		var params = {
			'org.org_name': $('#org_name').val(),
			'org.parent_id': $('#parent_id').val(),
			'checkType': checkType,
			ct: (new Date()).getTime()
		};
		
		if(checkType == 'update'){
			params['org.org_id'] = $('#org_id').val();
		}
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/orgpos_checkOrg.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	
	var order_code = new LiveValidation('order_no',{onlyOnSubmit:true});
	order_code.add( Validate.Presence, {failureMessage: "不能为空!"});
	order_code.add( Validate.Numericality, {notANumberMessage : "须输入数字!"});
}
//删除
function deleteOrgan(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var node = treeObj.getSelectedNodes(true)[0];
	var childrens = node.children;
	var idStr = node.org_id;
	alert(idStr);
	$.post("<%=basePath %>basic/sys/orgpos_deleteOrgan.action",{'org.org_id':idStr},function (json){
		if(json.resultCode){
			alert("操作成功");
			window.location.href = window.location.href;
		}else{
			alert("操作失败");
		}
	});
}
</script>
<style type="text/css">
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}

.title1{
	margin-top:10px;
	margin-bottom:-5px;
	padding-left:15px;
	color:#0B67A8;
	font-weight:bold;
	font-size:12px;
}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<div class="title1">
				企业名称：<input type="text" name="root_org" id="root_org" size="17" value="企业名称"/><button>保存</button>
			</div>
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<form action="<%=basePath %>basic/sys/orgpos_updateOrg.action" id="form" method="post">
				<div class="title" style="margin-top: 25px;">组织部门信息</div>
				<div class="editorTab" style="width: 500px;">
					<table>
							<tr>
								<th style="width: 20%;">操作模式</th>
								<td>
									<font id="modeMsg" style="font-weight:bold; font-size: medium;"></font>
									<input type="hidden" name="checkType" id="checkType"/>
								</td>
							</tr>
							<tr>
								<th>上级组织</th>
								<td>
									<input type="text" name="org.parent_name" readonly="readonly" class="unenterTextbox" />
									<input type="hidden" name="org.parent_id" id="parent_id"/>
									<input type="hidden" name="org.parent_level_no"/>
									<input type="hidden" name="org.parent_node_path"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>所在区域</th>
								<td>
									<input type="text" class="chooseInput" title="点击选择区域" name="org.area_name" value="${bpmProcessInfo.pt_name }" onclick="showMenu('drugTypeOne','org_id','org_name','menuContentOne',1);" id="area_name" readonly="readonly" />
									<input type="hidden" name="org.area_id" id="org_id" />
									<div onclick="clearField('org_id','org_name');" class="icon-clear" title="清空"></div>
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织名称</th>
								<td>
									<input type="text" name="org.org_name" id="org_name"/>
									<input type="hidden" name="org.org_id" id="org_id"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织类型</th>
								<td>
									<select name="org.org_type" class="downMenu">
										<option value="1">组织类型1</option>
										<option value="2">组织类型2</option>
										<option value="3">组织类型3</option>
										<option value="4">组织类型4</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织状态</th>
								<td>
									<select name="org.enable" class="downMenu">
										<option value="1">禁用</option>
										<option value="2">启用</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><font>*</font>顺&nbsp;&nbsp;序&nbsp;&nbsp;号</th>
								<td>
									<input type="text" name="org.order_no" id="order_no"/>
								</td>
							</tr>
							<tr>
								<th>备注说明</th>
								<td><input type="text" name="org.remark" maxlength="100"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<span class="btn"><input type="submit" value="保存" id="saveBtn" disabled="disabled"/></span>
									<span class="btn"><input type="button" value="删除" id="deleteBtn" disabled="disabled" onclick="javascript:deleteOrgan();"/></span>
								</td>
							</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
