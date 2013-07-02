<%@ page language="java"  pageEncoding="utf-8"%>
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

//区域树配置
var setting = {
	data: {
		key: {
			title: 'remark',
			name: 'area_name'
		},
		simpleData: {
			enable: true,
			idKey: 'area_id',
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
//加载区域树的数据
$(function(){
	var params = {
		ct: (new Date()).getTime()
	};
	//通过json模式得到数据值
	 	$.getJSON("<%=basePath%>basic/sys/area_loadArea.action", params, function(json){
		if(json.resultCode == 'success'){
			if(json.list.length > 0){
				json.list[0].open = true;
			}
			$.fn.zTree.init($("#treeDemo"), setting, json.list);
		}else{
			alert("加载区域信息失败!");
		}
	});
	
	//初始化验证规则
	checkAll();
});

function dblClickExpand(treeId, treeNode) {
	return treeNode.o_level > 0;
}

//单击事件
function onClick(event, treeId, treeNode,clickFlag) {
	if(treeNode.area_id== 0){
		$('#modeMsg').empty();//清空操作模式
		$('#saveBtn').attr('disabled', 'disabled');//改变保存按钮的状态
	}else{
		changeMode('update');//改变操作模式
	}
	//给文本框赋值
	$("input[name='area.area_name']").val(treeNode.area_name);
	$("input[name='area.area_id']").val(treeNode.area_id);
	$("input[name='area.remark']").val(treeNode.remark);
	$("input[name='area.order_no']").val(treeNode.order_no);
	//给下拉列表赋值
	$("select[name='area.enable'] option[value='" + treeNode.enable + "']").attr('selected','selected');
	//
	var pn=treeNode.getParentNode();//得到父节点对象
	$("input[name='area.parent_id']").val(pn!=null ? pn.area_id : '');
	$("input[name='area.parent_name']").val(pn!=null ? pn.area_name : '');
	$("input[name='area.parent_level_no']").val(pn!=null ? pn.level_no : '');
}

//在树形图中指针指定的节点后面加按钮
function addHoverDom(treeId,treeNode){
	var sObj = $("#" + treeNode.tId + "_span");
	if(treeNode.editNameFlag || $("#addBtn_" + treeNode.id).length>0) return;
	var addStr = "<span class='button add' id='addBtn_"+treeNode.id + "' title='区域' onfocus='this.blur();'></span>";
	sObj.after(addStr);
	var btn=$("#addBtn_"+treeNode.id);
	if(btn) btn.bind("click",function(event){
		changeMode('insert');//将模式改成添加
			//给文本框赋值
		$("input[name='area.parent_name']").val(treeNode.area_name);
		$("input[name='area.parent_id']").val(treeNode.area_id);
		$("input[name='area.parent_level_no']").val(treeNode.level_no);
		$("input[name='area.parent_node_path']").val(treeNode.parent_node_path);
		//赋空值
		$("input[name='area.area_name']").val('');
		$("input[name='area.area_id']").val('');
		$("input[name='area.remark']").val('');
		$("input[name='area.order_no']").val('');
		event.stopPropagation();
	});
}
//鼠标移开时给指定节点解绑按钮
 function removeHoverDom(treeId,treeNode){
 	$("#addBtn_"+treeNode.id).unbind().remove();
 }
 
 //改变操作模式
 function changeMode(mode){
	var action = '<%=basePath %>basic/sys/area_update.action'; 
	var modeMsg='编辑模式';
	if(mode == 'insert'){
		action = '<%=basePath %>basic/sys/area_insert.action'; 
		modeMsg='创建模式';
	}
	var childrens = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes(true)[0].children;
 	if(childrens == undefined){
 		$('#deleteBtn').attr('disabled',false); 
 	}else{
 		$('#deleteBtn').attr('disabled','disabled'); 
 	}
 	
 	$('#checkType').val(mode);
 	$('#saveBtn').attr('disabled',false);
 	$('#form').attr('action',action);
 	$('#modeMsg').empty().append(modeMsg);
 }

function checkAll(){
	//名称验证
	var area_name = new LiveValidation('area_name',{onlyOnSubmit:true});
	area_name.add(Validate.Presence,{failureMessage:"不能为空!"});
	area_name.add(Validate.Length,{maximum:30});
	area_name.add(Validate.Custom,{failureMessage:'区域名称已经存在!',against:function(value,args){
	
		var valid='true';
		var checkType = $("#checkType").val();
		var params = {
				'area.area_name':$('#area_name').val(),
				'area.parent_id':$('#parent_id').val(),
				'checkType':checkType
		};
		if(checkType=='update') params['area.area_id'] = $('#area_id').val();
		$.ajaxSetup({async:false});
		$.post('<%=basePath%>basic/sys/area_checkArea.action',params,function(json){valid=json.valid});
		return (valid == 'true');
	}});
	var order_code = new LiveValidation('order_no',{onlyOnSubmit:true});
	order_code.add(Validate.Presence,{failureMessage:"不能为空！"});
	order_code.add(Validate.Numericality,{notANumberMessage:"须输入数字!"});
	
}

//删除
function deleteArea(){
	var treeObj= $.fn.zTree.getZTreeObj("treeDemo");
	var node = treeObj.getSelectedNodes(true)[0];
	var childrens = node.children;
	var idStr = node.area_id;
	alert("删除id为"+idStr);
	$.post("<%=basePath %>basic/sys/area_delete.action",{'area.area_id':idStr},function (json){
		if(json.resultCode){
			alert("操作成功");
			window.location.href=window.location.href;//刷新
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
</style>
  </head>
  
<body>
	<div class="content_wrap">
		<div class="left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
			<form action="<%=basePath %>basic/sys/area_update.action" id="form" method="post">
				<div class="title">区域信息</div>
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
								<th>上级地区</th>
								<td>
									<input type="text" name="area.parent_name" readonly="readonly" class="unenterTextbox" />
									<input type="hidden" name="area.parent_id" id="parent_id"/>
									<input type="hidden" name="area.parent_level_no"/>
									<input type="hidden" name="area.parent_node_path"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>区域编号</th>
								<td>
									<input type="text" name="area.area_code" id="area_code"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>区域名称</th>
								<td>
									<input type="text" name="area.area_name" id="area_name"/>
									<input type="hidden" name="area.area_id" id="area_id"/>
								</td>
							</tr>
							<tr>
								<th><font>*</font>区域状态</th>
								<td>
									<select name="area.enable" class="downMenu">
										<option value="1">禁用</option>
										<option value="2">启用</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><font>*</font>顺&nbsp;&nbsp;序&nbsp;&nbsp;号</th>
								<td>
									<input type="text" name="area.order_no" id="order_no"/>
								</td>
							</tr>
							<tr>
								<th>备注说明</th>
								<td><input type="text" name="area.remark" maxlength="100"/></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<span class="btn"><input type="submit" value="保存" id="saveBtn" disabled="disabled"/></span>
									<span class="btn"><input type="button" value="删除" id="deleteBtn" disabled="disabled" onclick="javascript:deleteArea();"/></span>
								</td>
							</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
