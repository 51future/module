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

<style type="text/css">
	.box{
		width: 300px;
		height: auto;
		border-color: red;
	}
</style>
</head>
<body>
	<div class="title">编辑系统参数（上传文件目录）</div>
	<form action="<%=basePath%>basic/sys/config_updateConfig.action" id="form" method="post">
	<div class="editorTab">
		<table>
				<tr>
					<th>参数代码</th>
					<td>
						<input type="text" name="sysConfig.key" readonly="readonly" class="unenterTextbox" value="${sysConfig.key}" id="key"/>
					</td>
				</tr>
				<tr>
					<th><font>*</font>参数名称</th>
					<td>
						<input type="text" name="sysConfig.name" value="${sysConfig.name}" id="name"/>
					</td>
				</tr>
				<tr>
					<th><font>*</font>参&nbsp;&nbsp;数&nbsp;&nbsp;值</th>
					<td>
						<input type="text" name="sysConfig.value" value="${sysConfig.value}" id="value"/>
					</td>
				</tr>
				<tr>
					<th>参数值类型</th>
					<td>
						<s:if test="%{sysConfig.value_type==1}">数字</s:if>
						<s:if test="%{sysConfig.value_type==2}">字符串</s:if>
						<s:if test="%{sysConfig.value_type==3}">布尔</s:if>
						<s:if test="%{sysConfig.value_type==4}">日期时间</s:if>
					</td>
				</tr>
				<tr>
					<th>是否可编辑</th>
					<td>
						<s:if test="%{sysConfig.editable==1}">否</s:if>
						<s:if test="%{sysConfig.editable==2}">是</s:if>
					</td>
				</tr>
				<tr>
					<th>是否可见</th>
					<td>
						<s:if test="%{sysConfig.visible==1}">否</s:if>
						<s:if test="%{sysConfig.visible==2}">是</s:if>
					</td>
				</tr>
				<tr>
			  		<th>所属业务模块</th>
			  		<td>
						<div class="box">
							<input type="text" name="sysConfig.module_name" id="module_name" value="${sysConfig.module_name }"/>
							<input type="hidden" name="sysConfig.module_id" id="module_id" value="${sysConfig.module_id }"/>
						</div>
				  	</td>
				 </tr>
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
