<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>

<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/zTreeStyle-extend.css"/>
<script language="javascript">
$(function(){
	checkAll();
});

function checkAll(){
	var user_account_lv = new LiveValidation('user_account',{onlyOnSubmit:true});
	user_account_lv.add( Validate.Presence, {failureMessage: "不能为空!"});
	user_account_lv.add( Validate.Length, { maximum: 30} );
	user_account_lv.add( Validate.Custom, { failureMessage: '登录账号已经存在！', against: function(value, args){
		var valid = 'true';
		var params = {
			'user.user_account': $('#user_account').val(),
			'checkType': 'insert',
			ct: getCurrentTime()
		};
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/user_checkUser.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	
	var user_type =  new LiveValidation('user_type',{onlyOnSubmit:true});
	user_type.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var user_name = new LiveValidation('user_name',{onlyOnSubmit:true});
	user_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var gender = new LiveValidation('gender',{onlyOnSubmit:true});
	gender.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var org_name = new LiveValidation('org_name',{onlyOnSubmit:true});
	org_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var dept_name = new LiveValidation('dept_name',{onlyOnSubmit:true});
	dept_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var pos_id = new LiveValidation('pos_id',{onlyOnSubmit:true});
	pos_id.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var cellphone_no = new LiveValidation('cellphone_no',{onlyOnSubmit:true});
	cellphone_no.add( Validate.Presence, {failureMessage: "不能为空!"});
	cellphone_no.add(Validate.Format, { pattern:/^1\d{10}$/,failureMessage: "号码有误!" });
	
	var email = new LiveValidation('email',{onlyOnSubmit:true});
	email.add( Validate.Email, {failureMessage: "邮箱地址不合法!"});
	
	var area_name = new LiveValidation('area_name',{onlyOnSubmit:true});
	area_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	
}
/*
function chooseOrgan(){
	var url = '<%=basePath%>admin/basic/system/dep/organ_choose.jsp'; 
	window.callback = fillOrgan;
	openModalWindow(url, window, 'small');
}

function fillOrgan(orgId, orgName){
	$('input[name="user.org_id"]').val(orgId);
	$('input[name="user.org_name"]').val(orgName);
	
	var params = {
		ct: (new Date()).getTime(),
		'pos.org_id': orgId
	};
	
	$.getJSON("<%=basePath%>basic/sys/orgpos_loadPositionJSON.action", params, function(json){
		if(json.resultCode == 'success'){
			$('#pos_id').empty();
			$('#pos_id').append('<option value="">--请选择--</option>');
			for(var i=0; i<json.list.length; i++){
				$('#pos_id').append('<option value="' + json.list[i].pos_id + '">' + json.list[i].pos_name + '</option>');
			}
		}
	});
	
}
*/
var mode_demo='';
var class_id='';
var class_name='';
var menuContent='';
var com_list=null;
var ids = '';
var types = '';
function chooseOrgan(ulId,org_ids,org_name,divId,type,ids){
	mode_demo = ulId;
	class_id = org_ids;
	class_name = org_name;
	menuContent = divId;
	ids = ids;
	types = type;
	com_list = null;
	if(com_list==null){
		//加载组织数据
		$.ajaxSetup({async: false});
		$.getJSON("<%=basePath%>basic/sys/orgpos_loadOrg.action", {'org.org_type':type,ct: (new Date()).getTime()}, function(json){
			if(json.resultCode == 'success'){
				if(json.list.length > 0){
					json.list[0].open = true;
					json.list[0].nocheck = true;
					com_list = json.list;
				}
			}else{
				alert("加载组织失败!");
			}
		}); 
	}
	$.fn.zTree.init($("#"+mode_demo), setting, com_list);
	//获取文本框的偏移位置和高度
	var cityObj = $("#"+class_name);
	var cityOffset = $("#"+class_name).offset();
	$("#"+menuContent).css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", clickBodyDown);
}
//选择部门
function chooseOrgan2(ulId,org_ids,org_name,divId,type){
	ids = $("#org_id").val();
	if(ids == ''){
		alert("请先选择组织!");
		return ;
	}
	mode_demo = ulId;
	class_id = org_ids;
	class_name = org_name;
	menuContent = divId;
	types = type;
	com_list = null;
	if(com_list==null){
		//加载组织数据
		$.ajaxSetup({async: false});
		$.getJSON("<%=basePath%>basic/sys/orgpos_loadOrg.action", {'org.parent_id':ids,ct: (new Date()).getTime()}, function(json){
			if(json.resultCode == 'success'){
				if(json.list.length > 0){
					json.list[0].open = true;
					json.list[0].nocheck = true;
					com_list = json.list;
				}
			}else{
				alert("加载组织失败!");
			}
		}); 
	}
	$.fn.zTree.init($("#"+mode_demo), setting, com_list);
	//获取文本框的偏移位置和高度
	var cityObj = $("#"+class_name);
	var cityOffset = $("#"+class_name).offset();
	$("#"+menuContent).css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
	$("body").bind("mousedown", clickBodyDown);
}

//选择职位
function choosePost(){
	ids = $("#dept_id").val();
	if(ids == ''){
		alert("请先选择部门!");
		return ;
	}
	$.getJSON("<%=basePath%>basic/sys/orgpos_loadPositionJSON.action", {'pos.org_id': ids, ct: (new Date()).getTime()}, function(json){
		if(json.resultCode == 'success'){
			$('#pos_id').empty();
			$('#pos_id').append('<option value="">--请选择--</option>');
			for(var i=0; i<json.list.length; i++){
				$('#pos_id').append('<option value="' + json.list[i].pos_id + '">' + json.list[i].pos_name + '</option>');
			}
		}
	});
}

//加载药品类型为一棵树
var setting = {
			check: {
				enable: false
			},
			view: {
				dblClickExpand: false,
				selectedMulti: false
			},
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
			callback: {                 
				beforeDrag: false,
				onClick: onClick
			}
		};
//单机选择时选择id和name 然后隐藏药品类型树
function onClick(e, treeId, treeNode) {
		if(treeNode.org_id == ids || treeNode.org_type != types){
			alert("对不起,请重新选择!");
			return;
		}
		//回填
		$("#"+class_name).val(treeNode.org_name);
		$("#"+class_id).val(treeNode.org_id);
		hideMenu();
		var dept_id = '';
		dept_id = $("#dept_id").val();
		if(dept_id != ''){
			choosePost();
		}
}
//隐藏树
function hideMenu() {
		$("#"+menuContent).hide();
}   
//放下鼠标时隐藏树
function clickBodyDown(event) {
		if (!($(event.target).parents("#"+menuContent).length>0)) {
			hideMenu();
		}
}

//加载区域信息
function chooseArea(area_id,area_name){
	 url='<%=basePath%>admin/basic/system/area/area_choose.jsp';
	 var obj= openModalWindow(url,"选择区域",'custom',300,450);
	 if(obj){
		 var data=obj.split(',');
		 $('#'+area_id).val(parseInt(data[0]));
		 $('#'+area_name).val(data[1]);
	 }
}

</script>
</head>
<body>
	<div class="title">新增用户</div>
	<form action="<%=basePath %>basic/sys/user_insert.action" id="form" method="post">
	   <input type="hidden" name="user.utype" value="1"/>
		<div class="editorTab">
			<table>
					<tr>
						<th><font>*</font>用户类型</th>
						<td>
							<select name="user.user_type" id="user_type" class="downMenu">
								<option value="">----请选择----</option>
								<option value="1">用户类型1</option>
								<option value="2">用户类型2</option>
								<option value="3">用户类型3</option>
							</select>
						</td>
						<th><font>*</font>登录账号</th>
						<td >
							<input type="text" name="user.user_account" id="user_account" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>所在组织</th>
						<td>
							<div id="menuContentOne" class="menuContent" style="display:none; position: absolute;" >
								<ul id="drugTypeOne" class="ztree" style="margin-top:0; width:140px; height: 300px;"></ul>
							 </div>
							<input type="text" class="chooseInput" title="点击选择信息" onclick="chooseOrgan('drugTypeOne','org_id','org_name','menuContentOne',1,0);" readonly="readonly" name="user.org_name" id="org_name" style="width:153px;" readonly="readonly"/>
							<input type="hidden" name="user.org_id" id="org_id" />
						</td>
						<th><font>*</font>用户姓名</th>
						<td>
							<input type="text" name="user.user_name" id="user_name" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>所在部门</th>
						<td>
							<div id="menuContentTwo" class="menuContent" style="display:none; position: absolute;" >
								<ul id="drugTypeTwo" class="ztree" style="margin-top:0; width:140px; height: 300px;"></ul>
							 </div>
							<input type="text" class="chooseInput" title="点击选择信息" onclick="chooseOrgan2('drugTypeTwo','dept_id','dept_name','menuContentTwo',2);" readonly="readonly" name="user.dept_name" id="dept_name" style="width:153px;" readonly="readonly"/>
							<input type="hidden" name="user.dept_id" id="dept_id" />
						</td>
						<th><font>*</font>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
						<td>
							<select name="user.gender" id="gender" class="downMenu">
								<option value="">----请选择----</option>
								<option value="2">男</option>
								<option value="1">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><font>*</font>担任职务</th>
						<td>
							<select name="user.pos_id" id="pos_id" class="downMenu">
								<option value="">--请选择--</option>
							</select>
						</td>
						<th><font>*</font>用户手机号</th>
						<td><input type="text" name="user.cellphone_no" id="cellphone_no" maxlength="20"/></td>
					</tr>
					<tr>
						<th><font>*</font>所在区域</th>
						<td>
							<input type="text" name="user.area_name" id="area_name" class="chooseInput" style="width:153px;" title="点击选择信息" onclick="chooseArea('area_id','area_name');" readonly="readonly" />
							<input type="hidden" id="area_id" name="user.area_id" />
						</td>
						<th><font>*</font>电子邮箱</th>
						<td><input type="text" name="user.email" id="email" maxlength="100"/></td>
					</tr>
					<tr>
						<th>联系地址</th>
						<td colspan="3"><input type="text" name="user.address" id="address" size="80"/></td>
					</tr>
					<tr>
						<th>备注说明</th>
						<td colspan="3"><input type="text" name="user.remark" id="remark" size="80"/></td>
					</tr>
			</table>
		</div>
		<div class="btns">
			<span class="btn"><input type="submit" id="submitBtn" value="提交" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="返回" 
					onclick="javascript:window.location.href='<%=basePath%>basic/sys/user_query.action'"/>
			</span>
		</div>
	</form>
</body>
</html>
