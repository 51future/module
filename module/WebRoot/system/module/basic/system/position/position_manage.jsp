<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<jsp:include page="/admin/common/css/style_easyui.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<link type="text/css" href="<%=basePath%>js/lib/jquery/easyui/themes/icon.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/icon.css"/>
<script type="text/javascript" src="<%=basePath%>js/jx/JXCore.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/easyui/jquery.easyui.min.js"></script>

<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jx/combox/load_org_combox_tree.js" ></script>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/zTreeStyle-extend.css"/>

<script type="text/javascript">
	var basePath = '<%=basePath%>';
	
	var dataGrid = {};
	var isHandleSave = false;//是否可以进行“保存”操作
	var isHandleAdd = true;//是否可以进行“添加”操作
	var isHandleEdit = true;//是否可以进行“编辑”操作
	var currentRow = 0;//当前选中的行
	var checkType = ""; //操作类型，新增：insert; 编辑:update
	function initDatagrid(){
		dataGrid = $('#tt').datagrid({
			loadMsg: "请稍等，正在为您努力加载数据！",
			checkOnSelect : false,
			selectOnCheck : false,
			toolbar:[{
				text:'添加',
				iconCls:'icon-add',
				handler:function(){
					if(isHandleAdd){
						$('#tt').datagrid('endEdit', currentRow);
						$('#tt').datagrid('insertRow',{
							index: 0,
							row: {
								pos_id:'',
								pos_name:'',
								enable:'2',
								issys:'1',
								remark:''
							}
						});
						
						currentRow = 0;
						$('#tt').datagrid('selectRow', currentRow);
						$('#tt').datagrid('beginEdit', currentRow);
						isHandleSave = true;	
						isHandleAdd = false;
						isHandleEdit = false;
						checkType = "insert";
					}
				}
			},'-',{
				text:'删除',
				iconCls:'icon-remove',
				handler:function(){
					var row = $('#tt').datagrid('getSelected');
					if (row){
						if(row.pos_id !=undefined && row.pos_id !=''){
							if(row.issys != 2){//issys,是否系统内置 1：否；2：是
								var result =  deletePos(row);
								if( result.isOk){//操作成功
									currentRow = $('#tt').datagrid('getRowIndex', row);
									$('#tt').datagrid('deleteRow', currentRow);
									
									var posOrg = $('#pos_'+row.pos_id);
									if(posOrg != undefined && posOrg != null && posOrg !=''){
										posOrg.remove();
									}
									
									isHandleSave = false;	
									isHandleAdd = true;
									isHandleEdit = true;
								}else{
									//alert('职务【'+row.pos_name+'】删除失败！');
								}
							}else{
								alert('职务【'+row.pos_name+'】属于系统内置数据，不可以删除！');
							}
						}else{
							currentRow = $('#tt').datagrid('getRowIndex', row);
							$('#tt').datagrid('deleteRow', currentRow);
							isHandleSave = false;	
							isHandleAdd = true;
							isHandleEdit = true;
						}
					}else{
					}
				}
			},'-',{
				text:'保存',
				iconCls:'icon-save',
				handler:function(){
					var row = $('#tt').datagrid('getSelected');
					if(row && isHandleSave){
						currentRow = dataGrid.datagrid('getRowIndex',row);
						$('#tt').datagrid('acceptChanges');
						row = $('#tt').datagrid('getSelected');
						if(row.pos_id == undefined || row.pos_id == ''){//添加
							if(row.pos_name == undefined || row.pos_name == '' 
								|| row.enable == undefined || row.enable == '') {
								dataGrid.datagrid('beginEdit', currentRow);
								return;
							}
							var result = insertPos(row);
							if(result.isOk){//添加成功
								dataGrid.datagrid('updateRow',{index:currentRow,row:{
									pos_id:result.pos_id,
									handle:'<input type="checkbox" id="handle_'+result.pos_id+'" onclick = "checkPos(&quot;'+result.pos_id+'&quot;,&quot;'+row.pos_name+'&quot;)"/>'
								}});
								isHandleSave = false;
								isHandleAdd = true;
								isHandleEdit = true;
							}else{//添加失败
								dataGrid.datagrid('beginEdit', currentRow);
							}
						}else{//更新
							var result = updatePos(row);
							if(result.isOk){//更新成功
								var posOrg = $('#pos_'+row.pos_id);
								if(posOrg != undefined && posOrg != null && posOrg !=''){
									posOrg.remove();
								}
								dataGrid.datagrid('updateRow',{index:currentRow,row:{
									handle:'<input type="checkbox" id="handle_'+row.pos_id+'" onclick = "checkPos(&quot;'+row.pos_id+'&quot;,&quot;'+row.pos_name+'&quot;)"/>'
								}});
								
								isHandleSave = false;
								isHandleAdd = true;
								isHandleEdit = true;
							}else{//更新失败
								dataGrid.datagrid('beginEdit', currentRow);
							}
						}
					}
				}
			}],
			onBeforeLoad:function(){
				$(this).datagrid('rejectChanges');
			},
			onDblClickRow:function(rowIndex, rowData){
				if(isHandleEdit){
					$('#tt').datagrid('selectRow', rowIndex);
					$('#tt').datagrid('beginEdit', rowIndex);
					checkType = "update";
					currentRow = rowIndex;
					isHandleSave = true;
					isHandleAdd = false;
					isHandleEdit = false;
				}else{
					$('#tt').datagrid('selectRow', currentRow);
					$('#tt').datagrid('beginEdit', currentRow);
				}
			},
			onDblClickCell :function (rowIndex, field, value){
				if(isHandleEdit){
					$('#tt').datagrid('selectRow', rowIndex);
					$('#tt').datagrid('beginEdit', rowIndex);
					checkType = "update";
					currentRow = rowIndex;
					isHandleSave = true;
					isHandleAdd = false;
					isHandleEdit = false;
				}else{
					$('#tt').datagrid('selectRow', currentRow);
					$('#tt').datagrid('beginEdit', currentRow);
				}
			},
			onClickRow:function (rowIndex, rowData){
				if(isHandleAdd && isHandleEdit){
					currentRow = rowIndex;
					$('#tt').datagrid('selectRow', currentRow);
				}else{
					$('#tt').datagrid('selectRow', currentRow);
				}
			},
			onClickCell:function (rowIndex, field, value){
				if(isHandleAdd && isHandleEdit){
					currentRow = rowIndex;
					$('#tt').datagrid('selectRow', currentRow);
				}else{
					$('#tt').datagrid('selectRow', currentRow);
				}
			}
		});
	}

	//加载职务信息
	function loadPosition(){
		var url = '<%=basePath%>basic/sys/pos_loadPosition.action';
		$.post(url,{'ct' : new Date()},function(json){
			var posList = json.posList;
			if(json.resultCode){
				if(posList !=null && posList !='')
				for(var i=0 ;i<posList.length;i++){
					var posData = {
						pos_id : posList[i].pos_id,
						pos_name: posList[i].pos_name,
						enable: posList[i].enable,
						remark: posList[i].remark,
						issys: posList[i].issys,
						handle:'<input type="checkbox" id="handle_'+posList[i].pos_id+'" onclick = "checkPos(&quot;'+posList[i].pos_id+'&quot;,&quot;'+posList[i].pos_name+'&quot;)"/>'
					};
					dataGrid.datagrid('appendRow', posData);
				}
				
			}else{
				alert("加载职务信息失败，请联系管理员！");
			}
		});
	}
	
	//添加职务
	function insertPos(row){
		var url = '<%=basePath%>basic/sys/pos_insertAjax.action';
		var param = {
			'pos.pos_name' : row.pos_name,
			'pos.enable' : row.enable,
			'pos.issys' : row.issys,
			'pos.remark' : row.remark,
			'ct' : new Date()
		};
		var result = {"isOk":false};
		$.ajaxSetup({async: false});
		$.post(url,param,function(json){
			if(json.resultCode == 'success'){
				result = {"isOk":true,"pos_id":json.pos_id};
				alert('添加职务【'+row.pos_name+'】操作成功！');
			}else{
				result = {"isOk":false};
				alert('添加职务【'+row.pos_name+'】操作失败！');
			}
		});
		return result;
	}
	
	//更新职务
	function updatePos(row){
		var url = '<%=basePath%>basic/sys/pos_updateAjax.action';
		var param = {
			'pos.pos_id' : row.pos_id,
			'pos.pos_name' : row.pos_name,
			'pos.enable' : row.enable,
			'pos.remark' : row.remark,
			'ct' : new Date()
		};
		$.ajaxSetup({async: false});
		var result = {"isOk":false};
		$.post(url,param,function(json){
			if(json.resultCode == 'success'){
				result = {"isOk":true};
				alert('更新职务【'+row.pos_name+'】操作成功！');
			}else{
				result = {"isOk":false};
				alert('更新职务【'+row.pos_name+'】操作失败！');
			}
		});
		return result;
	}
	
	//删除职务
	function deletePos(row){
		var posName = row.pos_name;
		var params = { 'pos.pos_id': row.pos_id, 'ct' : new Date() };
		if(!confirm('确定要删除职位【'+posName+'】吗？')) return false;
		var valid = 'true';
		var result = {"isOk":false};
		$.ajaxSetup({async:false});
		$.post('<%=basePath%>basic/sys/pos_checkPosDel.action',params,function(json){valid = json.valid;});
		if((valid == 'true')){
			$.getJSON('<%=basePath%>basic/sys/pos_deleteAjax.action', params, function(json){
				if(json.resultCode == 'success'){
					result = {"isOk":true};
					alert('删除职务【'+row.pos_name+'】操作成功！');
				}else{
					result = {"isOk":false};
					alert('删除职务【'+row.pos_name+'】操作失败！');
				}
			});
		}else{
			result = {"isOk":false};
			alert('职位【'+posName+'】存在关联不能删除！');
		}
		return result;
	}
	
	//格式化职务的启用状态
	var statusData = [
  		    {enable:'2',name:'启用'},
  		    {enable:'1',name:'禁用'}
  		];
	function statusF(value){
		for(var i=0; i<statusData.length; i++){
			if (statusData[i].enable == value) return statusData[i].name;
		}
		return value;
	}
	
	//加载组织部门下的职务
	var posIdsForOrg = "";//记录次部门下的职务id
	function loadPositionForOrg(){
		var url = '<%=basePath%>basic/sys/pos_loadPositionForOrg.action';
		$.post(url,{'pos.org_id':$('#org_id').val(),'ct':new Date()},function(json){
			if(json.resultCode == 'success'){
				var posHtml = "";
				posIdsForOrg = ";";
				for(var i=0; i< json.posList.length; i++){
					if(json.posList[i].checked ==1 ){
						posHtml += '<li id="pos_'+json.posList[i].pos_id+'">'+json.posList[i].pos_name+'</li>';
						$('#handle_'+json.posList[i].pos_id).attr('checked',true);
						posIdsForOrg +=json.posList[i].pos_id + ";";
					}else{
						$('#handle_'+json.posList[i].pos_id).attr('checked',false);
					}
				}
				$('#posArea').html(posHtml);
			}else{
				alert('加载组织部门【'+$('#org_name')+'】下的职务信息失败！');
			}
		});
	}
	
	//控制职务在组织部门下的显示
	function checkPos(pos_id,pos_name){
		if($('#handle_'+pos_id).is(':checked')){
			if($('#pos_'+pos_id) ==undefined || $('#pos_'+pos_id).html() ==null || $('#pos_'+pos_id).html() =='')
			$('#posArea').append('<li id="pos_'+pos_id+'">'+pos_name+'</li>');
		}else{
			if(posIdsForOrg == ";" || posIdsForOrg.indexOf(";"+pos_id+";")<0){
				$('#pos_'+pos_id).remove();
			}else{
				var valid = 'true';
				var org_id = $('#org_id').val();
				var url = '<%=basePath%>basic/sys/user_checkUserPos.action';
				$.ajaxSetup({async: false});
				$.post(url,{'user.org_id':org_id,'user.pos_id':pos_id,'ct':new Date()},function(json){
					valid=json.valid;
				});
				if(valid == 'true'){
					$('#pos_'+pos_id).remove();
				}else{
					$('#handle_'+pos_id).attr('checked',true);
					alert('职务【'+pos_name+'】已被用户使用，不能移除！');
				}
			}
		}
	}

	//保存组织部门对应的职务
	function setOrgPos(){
		if(!validation()) return;
		var pos_id = "";
		var org_id = $('#org_id').val();
		var param = {};
		var posArea = $('#posArea').find('li');
		if(posArea.length > 0){
			posArea.each(function(index){
				pos_id = $(this).attr('id').substr(4);
				param['org.posOrgList['+index+'].pos_id'] = pos_id;
				param['org.posOrgList['+index+'].org_id'] = org_id;
			});
			param['org.org_id'] = org_id;
			param['ct'] = new Date();
		}else{
			if(confirm("没有选择职务！\r\n确定不设置或删除已设置的职务吗？")){
				param['org.org_id'] = org_id;
				param['ct'] = new Date();
			}else{
				return;
			}
		}
		var url = '<%=basePath%>basic/sys/org_setOrgPos.action';
		$.post(url,param,function(json){
			if(json.resultCode == 'success'){
				alert("设置组织部门对应的职务成功！");
			}else{
				alert("设置组织部门对应的职务失败！");
			}
		});
	}
	
	//验证不能为空
	function validation(){
		var valid = true;
		$(".LV_invalid_field").removeClass("LV_invalid_field"); 
	   	$(".LV_invalid").remove(); 
		$(".notNull").each(function(){//不能为空
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
	
	//扩展validatebox验证
	$.extend($.fn.validatebox.defaults.rules, {
	    onlyName: {//验证职务名称唯一
	        validator: function(value, param) {
	        	var valid = 'false';
	    		var params = {
	    			'pos.pos_name': value,
	    			'checkType': checkType,
	    			'ct': new Date()
	    		};
	    		if(checkType == 'update'){
	    			var row = $('#tt').datagrid('getSelected');
	    			params['pos.pos_id'] = row.pos_id;
	    		}
	    		
	    		$.ajaxSetup({async: false});
	    		$.post('<%=basePath%>basic/sys/pos_checkPos.action', params, function(json){
	    			valid=json.valid;
	    		});
	    		return (valid == 'true');
	        },
	        message: '名称已经存在！'
	    }
	});

	
	$(function(){
		initDatagrid();//初始化datagrid
		loadPosition();//加载职务信息
		
		//加载组织部门
		var orgTreeBox = new OrgComboxTree({
			idFieldId: 'org_id',
			nameFieldId: 'org_name',
			onNodeClick: function (e, treeId, treeNode){
				$("#" + this.idFieldId).val(treeNode.org_id);
				$("#" + this.nameFiledId).val(treeNode.org_name);
				loadPositionForOrg();
				this.hideTreeBox();
			}
		});
	});
	
</script>
<style type="text/css">
	div.content_wrap {width: 80%;height:380px;}
	div.content_wrap div.left{float: left;width: 70%;}
	div.content_wrap div.right{float: right;width: 30%;}
</style>
</head>
<body>
	<div class="content_wrap">
		<div class="left">
			<div class="easyui-layout" style="width:90%;height:400px;">
			<!-- 
				<div region="east" title="组织部门对应的职务" split="true" style="width:380px;">
				</div>
			 -->
				<div region="center" title="职务管理" style="background:#fafafa;overflow:hidden">
					<table id="tt" class="easyui-datagrid"  border="false" fit="true" fitColumns="true" singleSelect ="true" autoRowHeight="true">
						<thead>
							<tr>
								<th field="pos_name" editor="{type:'validatebox',options:{required:true,missingMessage:'不能为空!',validType:'onlyName'}}" width="200">职务名称</th>
								<th field="enable" formatter="statusF" editor="{type:'combobox',options:{valueField:'enable',textField:'name',data:statusData,required:true, missingMessage:'不能为空!'}}" width="100">启用状态</th>
								<th field="remark" editor="{type:'text'}" width="250" align="left">备注说明</th>
								<th field="handle" width="80" align="center">赋给组织</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		
		<div class="right">
			
			<div class="editorTab">
				<table>
					<tr>
						<th><font>*</font>组织部门</th>
						<td>&nbsp;&nbsp;
							<input type="text"  id="org_name" title="点击选择信息"  />
							<input type="hidden" id="org_id" class="notNull"/>&nbsp;&nbsp;
							<span  style="float: left" class="btn" >
								<input type="button" value="保存" onclick="javascript:setOrgPos();"/></span>
						</td>
					</tr>
					<tr>
						<th style="vertical-align:top">职务名称</th>
						<td>
							<div class="rightArea"><ul id="posArea"></ul></div>
						</td>
					</tr>
				</table>
			</div>
		
		</div>
	</div>
	

 
</body>
</html>