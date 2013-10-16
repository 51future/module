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
<link type="text/css" href="<%=basePath%>js/lib/jquery/easyui/themes/icon.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/icon.css"/>
<script type="text/javascript" src="<%=basePath%>js/jx/JXCore.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/easyui/jquery.easyui.min.js"></script>

<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jx/combox/load_org_combox_tree.js" ></script>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath%>style/zTreeStyle-extend.css"/>

<jsp:include page="/admin/common/auto_load_user.jsp"></jsp:include>
<script language="javascript">
var basePath = '<%=basePath%>';

$(function(){
	checkAll();
	
	var userAutoComplete = new UserAutoComplete({
		user_name: 'auto_user_name',
		user_id: 'auto_user_id'
	});
	
	//加载组织部门
	var orgTreeBox = new OrgComboxTree({
		idFieldId: 'org_id',
		nameFieldId: 'org_name',
		onNodeClick: function (e, treeId, treeNode){
			if(treeNode.org_id >0){
				$("#" + this.idFieldId).val(treeNode.org_id);
				$("#" + this.nameFiledId).val(treeNode.org_name);
				$("#area_name").val(treeNode.area_name);
				$("#area_id").val(treeNode.area_id);
				loadPosition();
				this.hideTreeBox();
			}
		}
	});
	
});

function checkAll(){
	var user_account = new LiveValidation('user_account',{onlyOnSubmit:true});
	user_account.add( Validate.Presence, {failureMessage: "不能为空!"});
	user_account.add( Validate.Length, { maximum: 100} );
	user_account.add(Validate.CodeNum,{});
	user_account.add( Validate.Custom, { failureMessage: '登录账号已经存在！', against: function(value, args){
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
	
	var user_code = new LiveValidation('user_code',{onlyOnSubmit:true});
	user_code.add(Validate.Presence,{failureMessage:"不能为空!"});
	user_code.add(Validate.Length,{maximum:100});
	user_code.add(Validate.CodeNum,{});
	
	var user_type = new LiveValidation('user_type',{onlyOnSubmit:true});
	user_type.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var user_name = new LiveValidation('user_name',{onlyOnSubmit:true});
	user_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	user_name.add( Validate.Length, { maximum: 30} );
	
	var org_name = new LiveValidation('org_name',{onlyOnSubmit:true});
	org_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var pos_id = new LiveValidation('pos_id',{onlyOnSubmit:true});
	pos_id.add( Validate.Presence, {failureMessage: "不能为空!"});
	
	var cellphone_no = new LiveValidation('cellphone_no',{onlyOnSubmit:true});
	cellphone_no.add( Validate.Presence, {failureMessage: "不能为空!"});
	cellphone_no.add(Validate.Format, { pattern:/^1\d{10}$/,failureMessage: "号码有误!" });
	
	var email = new LiveValidation('email',{onlyOnSubmit:true});
	email.add( Validate.Email, {failureMessage: "邮箱地址不合法!"});
	
	var address = new LiveValidation('address',{onlyOnSubmit:true});
	address.add( Validate.Length, { maximum: 150} );
	
	var remark = new LiveValidation('remark',{onlyOnSubmit:true});
	remark.add( Validate.Length, { maximum: 150} );
}

//加载职务
function loadPosition(){
	ids = $("#org_id").val();
	if(ids == ''){
		alert("请先选择所属组织！");
		return ;
	}
	$.getJSON("<%=basePath%>basic/sys/pos_loadPositionForOrg.action", {'pos.org_id': ids, ct: (new Date()).getTime()}, function(json){
		if(json.resultCode == 'success'){
			$('#pos_id').empty();
			$('#pos_id').append('<option value="">--请选择--</option>');
			for(var i=0; i<json.posList.length; i++){
				if(json.posList[i].checked ==1)
				$('#pos_id').append('<option value="' + json.posList[i].pos_id + '">' + json.posList[i].pos_name + '</option>');
			}
		}
	});
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
								<option value="">--请选择--</option>
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
						<th><font>*</font>用户编号</th>
						<td >
							<input type="text" name="user.user_code" id="user_code" style="width: 151px;"/>
						</td>
						<th><font>*</font>用户姓名</th>
						<td>
							<input type="text" name="user.user_name" id="user_name" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>所在组织</th>
						<td>
							<input type="text"  name="user.org_name" title="点击选择信息" id="org_name"/>
							<input type="hidden" name="user.org_id"  id="org_id" class="notNull"/>
						</td>
						<th><font>*</font>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
						<td>
							<label><input type="radio" name="user.gender" value="2" checked="checked" />男</label>
							<label><input type="radio" name="user.gender" value="1" />女</label>
						</td>
					</tr>
					<tr>
						<th>所在区域</th>
						<td>
							<input type="text" name="user.area_name" id="area_name" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
							<input type="hidden" name="user.area_id" id="area_id" maxlength="100"/>
						</td>
						<th><font>*</font>可再授权</th>
						<td>
							<label><input type="radio" name="user.auth_again" value="2" checked="checked" />可以</label>
							<label><input type="radio" name="user.auth_again" value="1" />不可以</label>
						</td>
					</tr>
					<tr>
						<th><font>*</font>担任职务</th>
						<td>
							<select name="user.pos_id" id="pos_id" class="downMenu">
								<option value="">--请选择--</option>
							</select>
						</td>
						<th><font>*</font>手&nbsp;&nbsp;机&nbsp;&nbsp;号</th>
						<td><input type="text" name="user.cellphone_no" id="cellphone_no" maxlength="20"/></td>
					</tr>
					<tr>
						<th>直接上级</th>
						<td><input type="text" name="user.superior_name" id="auto_user_name" style="width: 153px;"/>
							<input type="hidden" name="user.superior_id" id="auto_user_id" />
						</td>
						<th>电子邮箱</th>
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
			<span class="btn"><input type="button" id="cancelBtn" value="返回" onclick="javascript:window.history.back()"/></span>
		</div>
	</form>
</body>
</html>
