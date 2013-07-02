<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>选择人员</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
var theOpeners = window.top.dialogArguments;
$(function(){
	
});

//选择用户
function  selectUser(id,name){
	theOpeners.callback(id,name);
	window.close();

}
</script>
</head>
<body>
		
		<!--查询条件表格-->
		<div class="listTab">
			<table>
				<thead>
					<tr>
					    <td>选择</td>
						<td>人员姓名</td>
						<td>所属部门</td>
						<td>手机号码</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{list}">
					<tr onclick="selectUser('${id}','${rname}')">
					    <td><a href="javascript:void(0);" class="choose" title="点击选择" onclick="selectUser('${id}','${rname}')">选择</a></td>
						<td class="tdLeft">${rname}</td>
						<td class="tdLeft">${org_name}</td>
						<td class="tdLeft">${uphone}</td>
					</tr>
					</s:iterator>
					<s:if test="%{list.size() == 0}">
					<tr>
						<td colspan="7"><font>很抱歉，没有找到您要的数据</font></td>
					</tr>
					</s:if>
				</tbody>
			</table>
			
		</div>
</body>
</html>
