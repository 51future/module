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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/zTree/css/demo.css"/>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/easyui/themes/default/easyui.css"/>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript">
var setting = {
	data: {
		key: {
			name: 'node_name'
		},
		simpleData: {
			enable: true,
			idKey: 'node_id',
			pIdKey: 'parent_id'				
		}
	},
	view: {
			showIcon: function(treeId, treeNode){
				if(treeNode.node_type == 0){
					return true;
				}else{
					return false;
				}
			},
			dblClickExpand: false,
			selectedMulti: false
	},
	callback: {                 
			beforeDrag: false,
			onClick: loadDictItem
		}
}

//点击事件
var listDate = null;
var dt_code = "";//全局调用
function loadDictItem(event, treeId, treeNode){//单击选择node并查询数据
	dt_code = '';
	if(treeNode.node_type==0){//过滤掉模块
		dt_code = treeNode.node_id.substr(4,treeNode.node_id.length);
		if(dt_code){
			loadDate(dt_code);
		}
	}else{
			if(treeNode.node_name =='字典分类'){
				loadDate();
			}else{
				addRow([]);
			}
	}
}

var listcache = [];
$(function(){
	//加载数据字典类别
	var params = {
		ct: (new Date()).getTime()
	};
	$.ajaxSetup({async:false});
	$.post("<%=basePath%>basic/sys/SysModuleDictTreeAction.action", params, function(json){
		if(json.resultCode == 'success'){
			if(json.list.length > 0){
					json.list[0].open = true;
				}
			json.list[0].node_name = "字典分类";
			listcache = json.list;
			$.fn.zTree.init($("#treeDemo"), setting, json.list);
		}else{
			alert("加载数据字典类别失败!");
		}
	});
});
//------------------------------------------------------treegrid-------------------------------------------------------------//
//加载数据(treegrid数据)
function loadDate(dt_code){
	var param = {};
	param["sysDictItem.dt_code"]= dt_code ;
	param["time"] = new Date();
	$.post('<%=basePath%>basic/sys/dict_loadDictItemAll.action',param,function(json){
     	if(json.resultCode == 'success'){
     		listDate=json.list;
     		}
     },'json');
     addRow(listDate);
}
//用于treegrid加载数据
function addRow(listDate){
		var lastIndex =0;
        $('#treegrid').treegrid({
         title:'字典项',
     	 idField:'di_key_index',    
	     treeField:'di_value',
         nowrap: false,
         rownumbers: true,
         animate: true,
         iconCls: 'icon-ok',
		 collapsible: true,
		 fitColumns: true,
         height:350,
         width:700,
         showFooter:true,
	     columns:[[
	     	{title:'字典值',field:'di_value',width:300,editor:'text'},
	     	{field:'dt_code',title:'类别编码',width:120},    
	        {field:'di_key',title:'字典键',width:100,editor:'text'},    
	        {field:'issys',title:'是否系统内置',width:80,formatter:function(value,rowData,rowIndex){
	        	return value == 1 ? '否':'是'
	        },editor:'numberbox'} ,
	        {field:'enable',title:'是否启用',width:80, formatter:function(value, rowData, rowIndex){
	        		return value == 1 ? '禁用' : '启用';
	        	},editor:'numberbox'
	        },
	        {field:'parent_key', title:'上级字典键',width:80}
	        ,{
	        	field:'di_key_index',title:'字典键标识',width:90
	        },
	       {field:'remark',title:'备注',width:100,editor:'text'}
	    ]],
	    onContextMenu: onContextMenu
     });
     $('#treegrid').treegrid("loadData",listDate);
}

var clickMethod = function(row){
	alert($("#row").find("td").find("input").eq(1).val());
	var parent = $('#treegrid').treegrid("getParent",row.di_key_index);
	alert(parent.di_key);
	
}

//table菜单
function onContextMenu(e,row){
	e.preventDefault();
	$(this).treegrid('select', row.di_key_index);
	$('#mm').menu('show',{
		left: e.pageX,
		top: e.pageY
	});
}

// 编辑节点;
var editingId;
//添加下一节点
var idIndex = 100;
var flagType= '';
//用于添加同级节点
function insert(){
	if(editingId != undefined){
		alert("存在编辑项，请先保存，然后再添加");
		return;
	}
	idIndex++;
	var node = $("#treegrid").treegrid('getSelected');
	if(node){
		$("#treegrid").treegrid('insert',{
			after: node.di_key_index,
			data:{
					di_key: idIndex,
					dt_code:dt_code,
					di_value: 'new_node_'+idIndex,
					remark: '',
					issys:1,
					enable:2,
					parent_key:node.parent_key,
					di_key_index:idIndex
				}
		});
	  editingId = idIndex;
	  flagType = 'insert';
	 $('#treegrid').treegrid('beginEdit',idIndex);
	}else{
		alert("请选择参照行");
		return;
	}
}
function append(){
	if(editingId != undefined){
		alert("存在编辑项，请先保存，然后再添加");
		return;
	}
	idIndex++;
	var node = $('#treegrid').treegrid('getSelected');
	if(node && dt_code.length!=0){
		$('#treegrid').treegrid('append',{
			parent: node.di_key_index,
			data: [{
				di_key: idIndex,
				dt_code:dt_code,
				di_value: 'new_node'+idIndex,
				remark: '',
				issys:1,
				enable:2,
				parent_key:node.di_key,
				di_key_index:idIndex
			}]
		});
		 editingId = idIndex;
		 flagType = 'insert';
		$('#treegrid').treegrid('beginEdit',idIndex);
	}
	if(dt_code.length!=0 && !node){
		$('#treegrid').treegrid('append',{
			parent: null,
			data: [{
				di_key: idIndex,
				dt_code:dt_code,
				di_value: 'new_node'+idIndex,
				remark: '',
				issys:1,
				enable:2,
				parent_key:'-1',
				di_key_index:idIndex
			}]
		});
		 editingId = idIndex;
		  flagType = 'insert';
		$('#treegrid').treegrid('beginEdit',idIndex);
	}
}
//移除节点
function removeIt(){
	var node = $('#treegrid').treegrid('getSelected');
	if(editingId != undefined){
		alert("当前存在行为编辑模式，请选保存或者取消编辑，然后再进行此操作");
		return;
	}
	if (node && confirm('该操作不能恢复，是否进行删除?')){
	   childrens = $('#treegrid').treegrid('getChildren',node.di_key_index);
		if(childrens.length>0){
			alert("该级存在子项，不能进行删除，如需删除，请先删除完该级子项");
			return;
		}
		var param = {};
		param["time"] = new Date();
		param["sysDictItem.dt_code"] = node.dt_code;
		param["sysDictItem.di_key"] = node.di_key;
		var url = "<%=basePath%>basic/sys/dict_deleteForDictItem.action";
		$.post(url,param,function(json){
			if(json.resultCode == 'success'){
				alert("删除字典项成功");
			}else{
				alert("新增字典项失败");
				return;
			}
		},'json');
		$('#treegrid').treegrid('remove', node.di_key_index);
	}
}
//折叠节点
function collapse(){
	var node = $('#treegrid').treegrid('getSelected');
	if (node){
		$('#treegrid').treegrid('collapse', node.di_key_index);
	}
}
//展开节点
function expand(){
	var node = $('#treegrid').treegrid('getSelected');
	if (node){
		$('#treegrid').treegrid('expand', node.di_key_index);
	}
}
//编辑节点
function edit(){
	if (editingId != undefined){
		$('#treegrid').treegrid('select', editingId);
		return;
	}
	var node = $('#treegrid').treegrid('getSelected');
	if (node){
		editingId = node.di_key_index;
		 flagType = 'edit';
		$('#treegrid').treegrid('beginEdit',editingId);
	}
}
//保存节点
function save(){
	if (editingId != undefined){
		var t = $('#treegrid');
		t.treegrid('endEdit', editingId);
		//用于保存编辑后的数据
		var param = {};
		param["time"] = new Date();
		var node = $("#treegrid").treegrid("find",editingId);//找到节点并返回节点数据
		param["sysDictItem.dt_code"] = dt_code;
		param["sysDictItem.di_key"] = node.di_key;
		var vali = false;
		if(!(flagType.length!=0 && flagType == 'edit' && node.di_key_index == node.di_key)){
			//进行唯一性检查
			$.post('<%=basePath%>basic/sys/dict_checkDIKey.action',param,function(json){
					if(json.resultCode == 'success'){
						alert("该字典键已经存在请重新输入字典键");
						$('#treegrid').treegrid('beginEdit',editingId);
						vali = true;
					}
			},'json');
		}
		if(vali){//如果已经存在了，就不能再进行提交或者修改
			return;
		}
		if(node.di_value==null){
			alert("该字典输入的字典值不能为空");
			return;
		}
		param["sysDictItem.di_value"] = node.di_value;
		param["sysDictItem.remark"] = node.remark;
		param["sysDictItem.issys"] = node.issys;//是否洗头内置
		if(node.parent_key =='-1'){
			param["sysDictItem.isleaf"] = 1;//不是叶子结点
		}else{
			param["sysDictItem.isleaf"] = 2;//是叶子结点
		}
		param["sysDictItem.enable"] = node.enable;
		param["sysDictItem.node_path"] = dt_code+"_"+node.parent_key+"/"+node.di_key;
		param["sysDictItem.parent_key"] = node.parent_key;
		if( flagType.length!=0 && flagType == 'insert'){//添加模式
			var url = "<%=basePath%>basic/sys/dict_insertForDictItem.action";
			$.post(url,param,function(json){
				if(json.resultCode == 'success'){
					alert("新增字典项成功");
					loadDate(dt_code);
				}else{
					alert("新增字典项失败");
					$('#treegrid').treegrid('beginEdit',editingId);
					return;
				}
			},'json');
		}else{//编辑模式
			var url = "<%=basePath%>basic/sys/dict_updateForDictItem.action";
			param["sysDictItem.di_key_index"] = node.di_key_index;
			$.post(url,param,function(json){
				if(json.resultCode == 'success'){
					alert("编辑字典项成功");
					loadDate(dt_code);
				}else{
					alert("编辑字典项失败");
					$('#treegrid').treegrid('beginEdit',editingId);
					return;
				}
			},'json');
		}
		flagType = '';
		editingId = undefined;
	}
}
//取消当前编辑
function cancel(){
	if (editingId != undefined){
		if(flagType=='edit'){
			$('#treegrid').treegrid('cancelEdit', editingId);
			editingId = undefined;
		}else if(flagType == 'insert'){
			//$('#treegrid').treegrid('cancelEdit', editingId);
			$('#treegrid').treegrid('remove', editingId);
			editingId = undefined;
		}
		flagType = '';
	}
}
</script>
<style type="text/css">
html,body{height:100%;}
div.content_wrap {width: 1150px;height:100%;}
div.content_wrap div.left{float: left;width: 10px;heigth:100%;}
div.content_wrap div.right{float: right;width: 900px; height: 100%}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<ul id="treeDemo" class="ztree"></ul>
		</div>
		<div class="right">
				 <div class="title">字典项管理</div>
				 <div style="margin:10px 0;"></div>
				  <div style="margin:10px 0;">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="insert()">添加同级</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="append()">添加下一级</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="removeIt()">移除当前级</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit()">编辑</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="cancel()">取消编辑</a>
				</div>
				<table id="treegrid">
				</table>
				<div id="mm" class="easyui-menu" style="width:120px;">
					<div onclick="insert()" data-options="iconCls:'icon-insert'">添加同级</div>
					<div onclick="append()" data-options="iconCls:'icon-add'">添加下一级</div>
					<div onclick="removeIt()" data-options="iconCls:'icon-remove'">移除</div>
					<div class="menu-sep"></div>
					<div onclick="collapse()">折叠</div>
					<div onclick="expand()">展开</div>
				</div>
		</div>
	</div>
</body>
</html>
