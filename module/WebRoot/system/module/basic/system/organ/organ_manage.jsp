<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/icon.css"/>
<script type="text/javascript" src="<%=basePath%>js/jx/JXCore.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>

<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jx/combox/load_area_combox_tree.js" ></script>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/zTreeStyle-extend.css"/>
<script type="text/javascript">
var basePath = '<%=basePath%>';
var areaTreeBox = {};

$(function(){
	loadOrg(); //加载组织部门树
	checkAll();	//初始化验证规则
	areaTreeBox = new AreaComboxTree({
		idFieldId: 'area_id',
		nameFieldId: 'area_name',
		onNodeClick : function (e, treeId, treeNode){
			if(treeNode.area_id >0){//回填
				$("#" + this.nameFiledId).val(treeNode.area_name);
				$("#" + this.idFieldId).val(treeNode.area_id);
				this.hideTreeBox();
			}
		}
	});
});

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
function dblClickExpand(treeId, treeNode) {
	return treeNode.level_no > 0;
}
function onClick(event, treeId, treeNode,clickFlag) {
	if(treeNode.org_id == 0){
		$('#modeMsg').empty();
		$('#saveBtn').attr('disabled', 'disabled');//改变保存按钮的状态
		$('#saveBtn').css('display', 'none');//改变保存按钮隐藏
		$('#deleteBtn').attr('disabled', 'disabled');//改变删除按钮的状态
		$('#deleteBtn').css('display', 'none');//改变删除按钮隐藏
	}else{
		changeMode('update');
	}
	$("input[name='org.org_id']").val(treeNode.org_id);
	$("input[name='org.org_name']").val(treeNode.org_name);
	$("input[name='org.area_id']").val(treeNode.area_id);
	$("input[name='org.area_name']").val(treeNode.area_name);
	$("input[name='org.remark']").val(treeNode.remark);
	$("input[name='org.order_no']").val(treeNode.order_no);
	$("select[name='org.org_type'] option[value='" + treeNode.org_type + "']").attr('selected', 'selected');
	$("select[name='org.enable'] option[value='" + treeNode.enable + "']").attr('selected', 'selected');
	
	$("#old_area_id").val(treeNode.area_id);//特殊用法，保存当前原有的area_id
	
	var pn = treeNode.getParentNode();
	$("input[name='org.parent_id']").val(pn!=null ? pn.org_id : '');
	$("input[name='org.parent_name']").val(pn!=null ? pn.org_name : '');
	$("#parent_area_id").val(pn!=null ? pn.area_id : '');
}
function addHoverDom(treeId, treeNode) {
	var sObj = $("#" + treeNode.tId + "_span");
	if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0 || treeNode.org_type!=1) return;
	var addStr = "<span class='button add' id='addBtn_" + treeNode.id + "' title='组织机构' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	
	var btn = $("#addBtn_"+treeNode.id);
	if (btn) btn.bind("click", function(event){
		$.fn.zTree.getZTreeObj("treeDemo").selectNode(treeNode);
		changeMode('insert');
		$("input[name='org.parent_name']").val(treeNode.org_name);
		$("input[name='org.parent_id']").val(treeNode.org_id);
		$("input[name='org.parent_level_no']").val(treeNode.level_no);
		$("input[name='org.parent_node_path']").val(treeNode.node_path);
		$("#parent_area_id").val(treeNode.area_id);
		$("input[name='org.area_id']").val(treeNode.area_id);
		$("input[name='org.area_name']").val(treeNode.area_name);
		
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
	var action = '<%=basePath %>basic/sys/org_updateOrg.action';
	var modeMsg = '编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/org_insertOrg.action';
		modeMsg = '创建模式';
	}
	
	var childrens = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes(true)[0].children;
	if(childrens == undefined && mode != 'insert'){
 		$('#deleteBtn').attr('disabled',false); 
 		$('#deleteBtn').css('display','block'); //显示
 	}else{
 		$('#deleteBtn').attr('disabled','disabled'); 
 		$('#deleteBtn').css('display','none'); //隐藏
 	}
	
	$('#checkType').val(mode);
	$('#saveBtn').attr('disabled', false);
	$('#saveBtn').css('display', 'block');//显示
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
			'ct': (new Date()).getTime()
		};
		if(checkType == 'update'){
			params['org.org_id'] = $('#org_id').val();
		}
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/org_checkOrg.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	
	var area_name = new LiveValidation('area_name',{onlyOnSubmit:true});
	area_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	area_name.add( Validate.Custom, { failureMessage: '必须为父节点所在的区域或子区域！', against: function(value, args){
		var valid = 'true';
		var parent_area_id = $('#parent_area_id').val();
		var parentAreaNodeAll_area_ids = ";";//存父节点所在的区域和子区域的id
		if(parent_area_id > 0){
			var parentAreaNode = areaTreeBox.treeObj.getNodeByParam('area_id',parent_area_id,null);
			var area_id = $("#area_id").val();
			if(area_id != parentAreaNode.area_id){
				valid = 'false';
				var parentAreaNodeChildrens = parentAreaNode.children;
				if(parentAreaNodeChildrens != undefined){
					parentAreaNodeAll_area_ids += parentAreaNode.area_id+";";
					for(var i=0; i< parentAreaNodeChildrens.length; i++){
						if(area_id == parentAreaNodeChildrens[i].area_id){
							valid = 'true';
						}
						parentAreaNodeAll_area_ids += parentAreaNodeChildrens[i].area_id+";";
					}
				}
			}
		}
		
		//列出需要更新区域id的组织部门（即：当新区域不是原区域的直系节点时，需要同时修改子节点的区域值））
		if(valid=='true' && $('#checkType').val() =='update' && $('#old_area_id').val() != $('#area_id').val()){
			var currentOrgNodeChildrens = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes(true)[0].children;
			if(currentOrgNodeChildrens != undefined){
				var orgChildrenHtml = "";
				for(var i=0; i< currentOrgNodeChildrens.length; i++){
					if(parentAreaNodeAll_area_ids.indexOf(";"+currentOrgNodeChildrens[i].area_id+";") <0){
						orgChildrenHtml += '<input type="hidden" name="orgList['+i+'].org_id" value="'+currentOrgNodeChildrens[i].org_id+'"/>'
										 + '<input type="hidden" name="orgList['+i+'].area_id" value="'+$("#area_id").val()+'"/>';
					}
				}
				$("#td_update_org_area_id").html(orgChildrenHtml);
			}
		}
		return (valid == 'true');
	}});
	
	var order_no = new LiveValidation('order_no',{onlyOnSubmit:true});
	order_no.add( Validate.Presence, {failureMessage: "不能为空!"});
	order_no.add( Validate.Numericality, {notANumberMessage : "须输入数字!"});
	order_no.add( Validate.Length, { maximum: 32} );
	
	var remark = new LiveValidation('remark',{onlyOnSubmit:true});
	remark.add( Validate.Length, { maximum: 32} );
	
}

//加载组织部门树
function loadOrg(){
	$.post("<%=basePath%>basic/sys/org_loadOrg.action", {'ct':new Date()}, function(json){
		if(json.resultCode == 'success'){
			if(json.list.length > 0){
				json.list[0].open = true;
				$('#root_org').val(json.list[0].org_name);
			}
			$.fn.zTree.init($("#treeDemo"), setting, json.list);
		}else{
			alert("加载组织 部门信息失败!");
		}
	});
}

//删除组织部门
function deleteOrgan(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var node = treeObj.getSelectedNodes(true)[0];
	var idStr = node.org_id;
	var org_type = node.org_type == 1? '组织' : '部门'; // 组织类型1：组织；2：部门
	if(!confirm("确定要删除"+org_type+"【"+node.org_name+"】吗？")) return false;
	var valid = 'true';
	$.ajaxSetup({async:false});
	$.post('<%=basePath%>basic/sys/org_checkOrgDel.action',{'org.org_id':idStr},function(json){valid = json.valid;});
	if((valid == 'true')){
		$.post("<%=basePath %>basic/sys/org_deleteOrgan.action",{'org.org_id':idStr},function (json){
			if(json.resultCode == 'success'){
				alert("操作成功");
				window.location.href = window.location.href;
			}else{
				alert("操作失败");
			}
		});
	}else{
		alert(org_type+"【"+node.org_name+"】存在关联不能删除！");
	}
}

//更新根节点名称
function updateRoot(){
	var param = {'org.org_id' : 0,'org.org_name' : $('#root_org').val(),ct : new Date()};
	$.post("<%=basePath %>basic/sys/org_updateRoot.action",param,function (json){
		if(json.resultCode == 'success'){
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
	margin:10px 0 10px 10px;
	color:#0B67A8;
	font-weight:bold;
	font-size:12px;
}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<div class="title1" >
				根节点名：<input type="text" name="root_org" id="root_org" size="13" value="企业名称"/>
				<span class="btn">
					<input type="button" value="更新" id="updateBtn" onclick="updateRoot();"/>
				</span>
			</div>
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<form action="<%=basePath %>basic/sys/org_updateOrg.action" id="form" method="post">
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
									<input type="text" name="org.parent_name" readonly="readonly" style="width: 150px;" class="unenterTextbox" />
									<input type="hidden" name="org.parent_id" id="parent_id"/>
									<input type="hidden" name="org.parent_level_no"/>
									<input type="hidden" name="org.parent_node_path"/>
									<input type="hidden" id="parent_area_id" />
									<input type="hidden" id="old_area_id" />
								</td>
							</tr>
							<tr>
								<th><font>*</font>所在区域</th>
								<td>
									<input type="text" name="org.area_name" id="area_name" style="width: 150px;"/>
									<input type="hidden" name="org.area_id" id="area_id" />
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织名称</th>
								<td>
									<input type="text" name="org.org_name" id="org_name" style="width: 151px;"/>
									<input type="hidden" name="org.org_id" id="org_id"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织类型</th>
								<td>
									<select name="org.org_type" class="downMenu">
										<option value="1">组织</option>
										<option value="2">部门</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><font>*</font>组织状态</th>
								<td>
									<select name="org.enable" class="downMenu">
										<option value="2">启用</option>
										<option value="1">禁用</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><font>*</font>顺&nbsp;&nbsp;序&nbsp;&nbsp;号</th>
								<td>
									<input type="text" name="org.order_no" id="order_no" style="width: 151px;"/>
								</td>
							</tr>
							<tr>
								<th>备注说明</th>
								<td><input type="text" name="org.remark" id="remark" maxlength="100" style="width: 151px;"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<span class="btn"><input type="submit" value="保存" id="saveBtn" style="display:none;" disabled="disabled"/></span>
									<span class="btn"><input type="button" value="删除" id="deleteBtn" style="display:none;" disabled="disabled" onclick="javascript:deleteOrgan();"/></span>
								</td>
							</tr>
							<tr><td colspan="2" id="td_update_org_area_id"></td></tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
