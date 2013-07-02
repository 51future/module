<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%--
	auth : Conner
	date : 2012-09-05
	desc : 编辑角色
--%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  	<base target="_self" /> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>编辑角色</title>
	<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
	<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
	<script type="text/javascript">
	</script>
  </head>
  
  <body>
  	<div class="title">编辑角色</div>
    <form action="<%=basePath %>basic/sys/role_update.action" id="form1" name="form1" method="post" onsubmit="checkRoleForm();">
	<font color="red">${message }</font>
	<div class="editorTab">
			<table>
					<tr>
						<th><font>*</font>角色名称</th>
						<td>
							<input type="hidden" name="role.role_id" class="widStyle" value="${role.role_id}"/>
							<input type="text" name="role.role_name" id="role_name" class="widStyle" value="${role.role_name}" maxlength="20"/>
						</td>
					</tr>
					<tr>
						<th><font>*</font>启用状态</th>
						<td>
							<select name="role.enabled" class="downMenu">
								<option value="1" <s:if test="%{role.enabled == 1}">selected="selected"</s:if>>禁用</option>
								<option value="2" <s:if test="%{role.enabled == 2}">selected="selected"</s:if>>启用</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>备注说明</th>
						<td>
							<input name="role.remark" value="${role.remark}" id="remark" maxlength="100" size="50"/>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="btns">
			<span class="btn"><input type="submit" id="submitBtn" value="修改" /></span>
			<span class="btn"><input type="button" id="cancelBtn" value="返回" 
				onclick="javascript:window.location='<%=basePath%>basic/sys/role_query.action';"/></span>
		</div>
	</form>
  </body>
</html>
