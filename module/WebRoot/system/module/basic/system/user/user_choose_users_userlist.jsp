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

function chooseOrgan(){
	var url = '<%=basePath%>admin/basic/system/dep/organ_choose.jsp'; 
	window.callback = fillOrgan;
	openModalWindow(url, window, 'small');
}


//选择用户
function  selectUser(id,name){
	theOpeners.callback(id,name);
	window.close();

}
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/user_selectUser4Choose.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>部门名称</th>
					<td>
						<input type="text" name="org.o_name" value="${org.o_name}"/>
					</td>
					<th>用户姓名</th>
					<td>
						<input type="text" name="user.rname" value="${user.rname}"/>
					</td>
					<td><span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
					<span class="btn" style="text-align:right"  ><input type="button"  onclick="selectUser()"  value="确定" /></span>
					</td>
					
				</tr>
			</table>
		</div>
		<div class="listTab">
			<table>
				<thead>
					<tr>
					    <td>选择</td>
						<td>用户姓名</td>
						<td>所属部门</td>
						<td>担任职务</td>
						<td>手机号码</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{list}">
					<tr onclick="selectUser('${id}','${rname}')">
					    <td><a href="javascript:void(0);" class="choose" title="点击选择" onclick="selectUser('${id}','${rname}')">选择</a></td>
						<td class="tdLeft">${rname}</td>
						<td class="tdLeft">${org_name}</td>
						<td class="tdLeft">${position_name}</td>
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
	</form>
</body>
</html>
