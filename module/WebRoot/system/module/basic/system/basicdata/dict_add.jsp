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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
function goback(dt_code){
	 window.location="<%=basePath%>basic/sys/dict_queryDictItem.action?sysDictItem.dt_code="+dt_code;
}
$(function(){
	checkAll();
});
function checkAll(){
	var di_key = new LiveValidation('di_key',{onlyOnSubmit:true});
	di_key.add( Validate.Presence, {failureMessage: "不能为空!"});
	di_key.add( Validate.Length, { maximum: 50} );
	di_key.add( Validate.Custom, { failureMessage: '该值已经存在!', against: function(value, args){
		var valid = 'true';
		var params = {
			'sysDictItem.di_key': $('#di_key').val(),
			'sysDictItem.dt_code': $('#dt_code').val(),
			'checkType': 'insert',
			ct: getCurrentTime()
		};
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/dict_checkDictItem.action', params, function(json){
			valid=json.valid;
		});
		return (valid == 'true');
	}});
	di_key.add( Validate.Format, { failureMessage: "只能由字母/数字/下划线组成!", pattern: /^\w+$/});
	
	var di_value = new LiveValidation('di_value',{onlyOnSubmit:true});
	di_value.add( Validate.Presence, {failureMessage: "不能为空!"});
	di_value.add( Validate.Length, { maximum: 255} );

}
</script>
</head>
<body>
	<div class="title">添加字典</div>
	<form action="<%=basePath%>basic/sys/dict_insertDictItem.action" id="form" method="post">
		<div class="editorTab">
			<table>
					<tr>
						<th>类别</th>
						<td>
							${sysDictType.dt_name}
							<input type="hidden" name="sysDictItem.dt_code" id="dt_code" value="${sysDictType.dt_code}"	/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>字典值</th>
						<td><input type="text" name="sysDictItem.di_value" value="" id="di_value"/></td>
					</tr>
					<tr>
						<th><font>*</font>字典代码</th>
						<td>
							<input type="text" name="sysDictItem.di_key" value="" id="di_key"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>启用状态</th>
						<td>
							<select name="sysDictItem.enable" id="enable" style="width:155px;">
								<option value="1">禁用</option>
								<option value="2" selected="selected">启用</option>
							</select>
						</td>
					</tr>
					<!-- 
					<tr>
						<th><font>*</font>参数类别</th>
						<td><select name="sysDictItem.issys" id="issys" style="width:155px;">
								<option value="2">系统内置</option>
								<option value="1" selected="selected">用户定义</option>
							</select></td>
					</tr>
					 -->
					<tr>
						<th>内容描述</th>
						<td>
						<textarea rows="3" cols="50%" name="sysDictItem.remark" id="remark"></textarea>
						<div id="message"></div>
						</td>
					</tr>
					
			</table>
		</div>

		<div class="btns">
			<span class="btn"><input type="submit" id="submitBtn" value="提交" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="取消" 
					onclick="goback('${sysDictType.dt_code}');"/>
			</span>
		</div>
	</form>
</body>
</html>
