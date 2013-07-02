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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
$(function(){
	
});

function chooseStaff(){
	var url = '<%=basePath%>admin/common/choose_staff_single.jsp';  
	openWindow(url, '选择负责人', 850, 350);
}

function authArea(){
	var userAddUrl = '<%=basePath%>admin/sys/basicdata/area_auth.jsp';  
	openWindow(userAddUrl, '区域授权');
}

</script>
</head>
<body>
	<div class="searchTab">
		<table>
			<tr>
				<th>区域名称</th>
				<td>
					<input type="text"/>
				</td>
				<th>负&nbsp;&nbsp;责&nbsp;&nbsp;人</th>
				<td>
					<a href="javascript:void(0);" onclick="chooseStaff();">
						<input type="text" readonly="readonly"/>
						<img src="<%=basePath%>style/images/ico_11.gif" />
					</a>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>备注说明</th>
				<td>
					<input type="text"/>
				</td>
				<th>顺序号</th>
				<td>
					<input type="text"/>
				</td>
				<td>
					<span class="btn"><input type="button" value="保存" /></span>
				</td>
			</tr>
		</table>
	</div>
	<!--查询条件表格-->
	<div class="listTab">
		<table>
			<thead>
				<tr>
					<td>区域名称</td>
					<td>区域状态</td>
					<td>负责人</td>
					<td>顺序号</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>万盛</td>
					<td>启用</td>
					<td>杨志</td>
					<td>1</td>
					<td>
						<a href="#" class="disc">禁用</a>
						<a href="#" class="modi">修改</a>
						<a href="#" class="report" onclick="authArea();">授权</a>
					</td>
				</tr>
				<tr>
					<td>綦江</td>
					<td>禁用</td>
					<td>杨帆</td>
					<td>3</td>
					<td>
						<a href="#" class="enable">启用</a>
						<a href="#" class="modi">修改</a>
						<a href="#" class="report" onclick="authArea();">授权</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
