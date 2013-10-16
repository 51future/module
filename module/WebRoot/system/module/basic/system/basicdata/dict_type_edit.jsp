<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加字典</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<jsp:include page="/admin/common/load_module_combox_tree.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript">
//添加系统模块属性
$(function(){
	var moduleTreeBox = new ModuleComboxTree({
		idFieldId: 'module_id',
		nameFieldId: 'module_name'
	});
});

//----当用户选择启用公司代码时，显示公司代码输入框-----------
$(document).ready(function (){
	var dt_code = new LiveValidation('dt_code',{onlyOnSubmit:true});
	dt_code.add( Validate.Presence, {failureMessage: "不能为空!"});
	dt_code.add( Validate.Length, { maximum: 100} );
	dt_code.add( Validate.Format, { failureMessage: "只能由字母/数字/下划线组成!", pattern: /^\w+$/});
	dt_code.add( Validate.Format, { failureMessage: "当前类别编码已经存在!,请重新填写", against: function(value,args){
		if($("#dt_code").val() == $("#dt_old_code").val()){
			return false;
		}
		var valid = false;
		$.ajaxSetup({async:false});
		$.ajax("<%=basePath%>basic/sys/sysDictTypeAction_checkSysDictTypeDtCodeOrDtName.action","sysDictType.dt_code=" + $("#dt_code").val(),function(json){
			valid = json.resultMsg == "true";
		});
		return valid;
	}});
	
	var dt_name = new LiveValidation('dt_name',{onlyOnSubmit:true});
	dt_name.add( Validate.Presence, {failureMessage: "不能为空!"});
	dt_name.add( Validate.Length, { maximum: 100} );
	dt_name.add( Validate.Custom, { failureMessage: '当前字典类别名称已经存在,请重新填写', against: function(value, args){
		if($("#dt_name").val() == $("#dt_old_name").val()){
			return true;
		}
		var valid = true;
		$.ajaxSetup({async:false});
		$.ajax("<%=basePath%>basic/sys/sysDictTypeAction_checkSysDictTypeDtCodeOrDtName.action","sysDictType.dt_code=" + $("#dt_name").val(),function(json){
			valid = json.resultMsg != "true";
		});
		return valid;
	}});
	
});

function checkDtCode(flag){//用于检查类别的唯一性,flag 不为空时 表示 输入后失去焦点时触发的
	if($("#dt_code").val() == $("#dt_old_code").val()){
		return;
	}
	$("#d_no").text("");
	var valid = false;
	$.ajaxSetup({async:false});
	if(!$("#dt_code").val()){
		return;
	}
	$.post("<%=basePath%>basic/sys/sysDictTypeAction_checkSysDictTypeDtCodeOrDtName.action","sysDictType.dt_code=" + $("#dt_code").val()+"",function(json){
		valid = json.resultMsg == "true";
	});
	if(valid==true && flag){
		$("#d_no").removeAttr("style");
		$("#d_no").attr("style","color:red;")
		$("#d_no").text("该类别编码已经存在请重新填写");
		$("#dt_code").focus();
	}
	if(valid!=true && flag){
		$("#d_no").removeAttr("style");
		$("#d_no").attr("style","color:green;")
		$("#d_no").text("该类别编码可以录入");
	}
	return valid;
}

function checkDtName(flag){//用于检查类别名称的唯一性
	if($("#dt_name").val() == $("#dt_old_name").val()){
		return;
	}
	$("#d_name").text("");
	var valid = false;
	$.ajaxSetup({async:false});
	if(!$("#dt_name").val()){
		return;
	}
	$.post("<%=basePath%>basic/sys/sysDictTypeAction_checkSysDictTypeDtCodeOrDtName.action","sysDictType.dt_name=" + $("#dt_name").val()+"",function(json){
		valid = json.resultMsg == "true";
	});
	if(valid==true && flag){
		$("#d_name").removeAttr("style");
		$("#d_name").attr("style","color:red;")
		$("#d_name").text("该类别名称已经存在请重新填写");
		$("#dt_name").focus();
	}
	if(valid!=true && flag){
		$("#d_name").removeAttr("style");
		$("#d_name").attr("style","color:green;")
		$("#d_name").text("该类别名称可以录入");
	}
	return valid;
}

</script>
<style type="text/css">
.box{
	width: 300px;
	height: auto;
	border-color: red;
}
</style>
</head>
<body>
<div class="title">字典类别编辑</div>
<form id="form1" name="form1" method="post" action="<%=basePath%>basic/sys/sysDictTypeAction_updateSysDictType.action">
<div class="editorTab">
	<table>
		<tr>
		    <td align="right"><font color="#FF0000">*</font>类别编码</td>
		    <td><input type="text" disabled="disabled" name="sysDictType.dt_code" value="${sysDictType.dt_code }" onblur="javascript:checkDtCode(1);" id="dt_code"  /> <span id="d_no" style="color:red;"></span>
		    	<input type="hidden" id="dt_old_code" name="sysDictType.dt_old_code" value="${sysDictType.dt_code }"/>
		    </td>
  		</tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>类别名称</td>
		    <td><input  type="text" name="sysDictType.dt_name" value="${sysDictType.dt_name }"  onblur="javascript:checkDtName(1);"  id="dt_name" /> <span id="d_name" style="color:red;"></span>
		    	<input type="hidden" id="dt_old_name" name="sysDictType.dt_old_name" value="${sysDictType.dt_name }"/>
		    </td>
  		</tr>
  		<tr>
		    <td align="right">是否启用</td>
		    <td><select name="sysDictType.enable"  id="enable" style="width:155px;">
		      <option value="1"  <s:if test="sysDictType.enable==1">selected="selected"</s:if>>禁用 </option>
		      <option value="2" <s:if test="sysDictType.enable==2">selected="selected"</s:if>>启用</option>
            </select></td>
	    </tr>
	    <tr >
	    	<td align="right" >类别结构</td>
		    <td align="left">
			    <select name="sysDictType.dt_type" id="dt_type" style="width:155px;">
			      <option value="1" <s:if test="sysDictType.dt_type==1">selected="selected"</s:if>>列表结构</option>
			      <option value="2"  <s:if test="sysDictType.dt_type==2">selected="selected"</s:if>>树形结构</option>
			    </select>
		    </td>
	    </tr>
		  <tr>
	  		<td align="right">所属业务模块</td>
	  		<td>
				<div class="box">
					<input type="text" name="sysDictType.module_name" value="${sysDictType.module_name }" id="module_name" />
					<input type="hidden" name="sysDictType.module_id" value="${sysDictType.module_id }" id="module_id" />
				</div>
		  	</td>
		  </tr>
  	  <tr>
  		  <td align="right">备注说明</td>
  		  <td><textarea name="sysDictType.remark" id="textarea" cols="45" rows="3">${sysDictType.remark }</textarea></td>
	  </tr>
	</table>
	</div>
		
		<div class="btns">
			<span class="btn"><input name="input" type="submit" value="提交" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="返回" 
					onclick="javascript:window.location.href='<%=basePath%>basic/sys/sysDictTypeAction_selectDictTypeAll.action'"/>
			</span>
		</div>
</form>
</body>
</html>