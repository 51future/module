<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
function goback(){
	 window.location="<%=basePath%>basic/sys/dic_getDicByType.action?sysDictionary.typeid=${sysDictionary.typeid}";
}
$(function(){
	checkAll();
});
function checkAll(){
	var typeid = new LiveValidation('typeid',{onlyOnSubmit:true});
	typeid.add( Validate.Presence, {failureMessage: "不能为空!"});
	var key = new LiveValidation('key',{onlyOnSubmit:true});
	key.add( Validate.Presence, {failureMessage: "不能为空!"});
	key.add( Validate.Length, { maximum: 50} );
	var value = new LiveValidation('value',{onlyOnSubmit:true});
	value.add( Validate.Presence, {failureMessage: "不能为空!"});
	value.add( Validate.Length, { maximum: 255} );
	var is_active = new LiveValidation('is_active',{onlyOnSubmit:true});
	is_active.add( Validate.Presence, {failureMessage: "不能为空!"});
	var type = new LiveValidation('type',{onlyOnSubmit:true});
	type.add( Validate.Presence, {failureMessage: "不能为空!"});
}
</script>
</head>
<body>
	<div class="title">编辑字典</div>
	<form action="<%=basePath%>basic/sys/dic_addDic.action" id="form" method="post">
		<div class="editorTab">
			<table>
					<tr>
						<th><font>*</font>类别</th>
						<td>
						<input type="hidden" name="sysDictionary.typeid" value="${sysDirectorytype.id}"	/>
						<input type="text"  id="typeid" value="${sysDirectorytype.name}"/>
						</td>
						<th><font>*</font>字典值</th>
						<td><input type="text" name="sysDictionary.value" value="" id="value"/></td>
					</tr>
					<tr>
						<th><font>*</font>字典代码</th>
						<td>
							<input type="text" name="sysDictionary.key" value="" id="key"/>
						</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>内容描述</th>
						<td colspan="3">
						<textarea rows="5" cols="50%" name="sysDictionary.context" id="dic_context"></textarea>
						<div id="message"></div>
						</td>
					</tr>
					<tr>
						<th><font>*</font>是否有效</th>
						<td>
							<select name="sysDictionary.is_active" id="is_active">
								<option value="0">否</option>
								<option value="1" selected="selected">是</option>
							</select>
						</td>
						<th><font>*</font>参数类别</th>
						<td><select name="sysDictionary.type" id="type">
								<option value="1">系统内置</option>
								<option value="2" selected="selected">用户定义</option>
							</select></td>
					</tr>
			</table>
		</div>
	
		<div class="infoTips">
			加"<font>*</font>"的为必选或必填项
		</div>
		
		<div class="btns">
			<span class="btn"><input type="submit" id="submitBtn" value="提交" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="取消" 
					onclick="goback();"/>
			</span>
		</div>
	</form>
</body>
</html>
