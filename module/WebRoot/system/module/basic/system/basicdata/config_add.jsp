<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<jsp:include page="/admin/common/load_module_combox_tree.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
//添加系统模块属性
$(function(){
	var moduleTreeBox = new ModuleComboxTree({
		idFieldId: 'module_id',
		nameFieldId: 'module_name'
	});
});

$(function(){
	checkAll();
});
function checkAll(){
	var name = new LiveValidation('name',{onlyOnSubmit:true});
	name.add( Validate.Presence, {failureMessage: "不能为空!"});
	name.add( Validate.Length, { maximum: 100} );
	var value_type = new LiveValidation('value_type',{onlyOnSubmit:true});
	value_type.add( Validate.Presence, {failureMessage: "不能为空!"});
	var key = new LiveValidation('key',{onlyOnSubmit:true});
	key.add( Validate.Presence, {failureMessage: "不能为空!"});
	key.add( Validate.Length, { maximum: 50} );
	var value = new LiveValidation('value',{onlyOnSubmit:true});
	value.add( Validate.Presence, {failureMessage: "不能为空!"});
	value.add( Validate.Length, { maximum: 500} );
}

function goback(){
	window.location = "<%=basePath%>basic/sys/config_toConfigPage.action";
}
</script>
</head>
<body>
	<div class="title">新增系统参数</div>
	<form action="<%=basePath%>basic/sys/config_addConfig.action" id="form" method="post">
	<div class="editorTab">
		<table>
				<tr>
					<th><font>*</font>参数代码</th>
					<td>
						<input type="text" name="sysConfig.key" id="key" value="${sysConfig.key}"/>
					</td>
					
				</tr>
				<tr>
					<th><font>*</font>参数名称</th>
					<td>
						<input type="text" name="sysConfig.name" id="name" value="${sysConfig.name}"/>
					</td>
				</tr>
				<tr>
					<th><font>*</font>参&nbsp;&nbsp;数&nbsp;&nbsp;值</th>
					<td>
						<input type="text" name="sysConfig.value" id="value" value="${sysConfig.value}"/>
					</td>
				</tr>
				<tr>
					<th><font>*</font>参数值类型</th>
					<td>
						<select name="sysConfig.value_type" id="value_type" class="downMenu">
							<option value="1" <s:if test="%{sysConfig.value_type==1}">selected="selected"</s:if>>数字</option>
							<option value="2" <s:if test="%{sysConfig.value_type==2}">selected="selected"</s:if>>字符串</option>
							<option value="3" <s:if test="%{sysConfig.value_type==3}">selected="selected"</s:if>>布尔</option>
							<option value="4" <s:if test="%{sysConfig.value_type==4}">selected="selected"</s:if>>日期时间</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><font>*</font>是否可编辑</th>
					<td>
						<select name="sysConfig.editable" id="editable" class="downMenu">
							<option value="2" <s:if test="%{sysConfig.editable==2}">selected="selected"</s:if>>是</option>
							<option value="1" <s:if test="%{sysConfig.editable==1}">selected="selected"</s:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><font>*</font>是否可见</th>
					<td>
						<select name="sysConfig.visible" id="visible" class="downMenu">
							<option value="2" <s:if test="%{sysConfig.visible==2}">selected="selected"</s:if>>是</option>
							<option value="1" <s:if test="%{sysConfig.visible==1}">selected="selected"</s:if>>否</option>
						</select>
					</td>
				</tr>
				<tr>
			  		<td align="right">所属业务模块</td>
			  		<td>
						<div class="box">
							<input type="text" name="sysConfig.module_name" id="module_name" />
							<input type="hidden" name="sysConfig.module_id" id="module_id" />
						</div>
				  	</td>
				<tr>
					<th>备注说明</th>
					<td>
						<input name="sysConfig.remark" value="${sysConfig.remark}" id="remark" maxlength="100" size="50"/>
					</td>
				</tr>
		</table>
	</div>
	<div class="btns">
		<span class="btn"><input type="submit" value="提交"/></span>
		<span class="btn"><input type="button" value="返回" onclick="goback();"/></span>
	</div>
	</form>
</body>
</html>
