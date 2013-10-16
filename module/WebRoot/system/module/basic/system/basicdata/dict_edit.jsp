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
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
$(function(){
	 var num = 500;  
	    //$("#message").html("还可以输入"+num+"个字符");
	    //getEditedNum(num);
	    //$("#dic_context").keyup(function(){getEditedNum(num);});
	checkAll();
});
function checkAll(){

	var di_key = new LiveValidation('di_key',{onlyOnSubmit:true});
	di_key.add( Validate.Presence, {failureMessage: "不能为空!"});
	di_key.add( Validate.Length, { maximum: 50} );
	
	var di_value = new LiveValidation('di_value',{onlyOnSubmit:true});
	di_value.add( Validate.Presence, {failureMessage: "不能为空!"});
	di_value.add( Validate.Length, { maximum: 255} );
}
function getEditedNum(num){ 
	
    var len = $("#dic_context").html().length; 
    var tmp = num - len;
    if(tmp<=0){  
    	$("#dic_context").html($("#dic_context").html().substring(0,num));  
        $("#message").html("还可以输入0个字符");
    }else{  
    	$("#message").html("还可以输入"+tmp+"个字符");  
    }
}
function goback(){
	//window.location.href="<%=basePath%>basic/sys/dic_getDicByType.action?sysDictionary.typeid=${sysDictionary.typeid}";
	history.go(-1);
}
</script>
</head>
<body>
	<div class="title">编辑字典</div>
	<form action="<%=basePath%>basic/sys/dict_updateDictItem.action" id="form" method="post">
		<div class="editorTab">
			<table>
					<tr>
						<th><font>*</font>类别</th>
						<td>
						<input type="hidden" name="sysDictItem.dt_code" id="dt_code" value="${sysDictItem.dt_code}"	/>
						<input type="text" value="${sysDictItem.dt_name}" readonly="readonly" class="unenterTextbox" />
						</td>
					</tr>
					<tr>
						<th><font>*</font>字典值</th>
						<td><input type="text" name="sysDictItem.di_value" id="di_value" value="${sysDictItem.di_value }" /></td>
					</tr>
					<tr>
						<th><font>*</font>字典代码</th>
						<td>
							<input type="text" name="sysDictItem.di_key" id="di_key" value="${sysDictItem.di_key }" readonly="readonly" class="unenterTextbox" />
						</td>
					</tr>
					<tr>
						<th><font>*</font>启用状态</th>
						<td>
							<select name="sysDictItem.enable" id="enable" style="width:155px;">
								<option value="1">禁用</option>
								<option value="2" <s:if test="%{sysDictItem.enable == 2}">selected</s:if>>启用</option>
							</select>
						</td>
					</tr>
					<!-- 
					<tr>
						<th><font>*</font>参数类别</th>
						<td><select name="sysDictItem.issys" id="issys" style="width:155px;">
								<option value="2">系统内置</option>
								<option value="1" <s:if test="%{sysDictItem.issys == 1}">selected</s:if>>用户定义</option>
							</select></td>
					</tr>
					 -->
					<tr>
						<th>内容描述</th>
						<td>
						<textarea rows="3" cols="50%" name="sysDictItem.remark" id="remark">${sysDictItem.remark }</textarea>
						<div id="message"></div>
						</td>
					</tr>
					
			</table>
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
