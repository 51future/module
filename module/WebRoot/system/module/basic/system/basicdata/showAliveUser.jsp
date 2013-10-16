<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.jinxinol.basic.system.domain.SysUser"%>
<%@page import="com.jinxinol.basic.common.SessionListener"%>
<%@page import="com.jinxinol.core.common.CommonConstants"%>
<%@page import="com.jinxinol.basic.common.SessionAttributeListener"%>
<%!static final int eachRow = 3;//每行最多显示3个人%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	List<SysUser> list = SessionAttributeListener.getAliveUser();
	int thisUserId = ((SysUser) session
			.getAttribute(CommonConstants.CURRENT_USER)).getUser_id();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>在线用户列表</title>
		<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
		<script type="text/javascript"
			src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
		<script type="text/javascript">
			function doThis(id,name){
				if(window.confirm('确定要强制【' + name + '】下线么?')){
					var obj = $('form');
					obj.find('input').val(id);
					obj.submit();
				}
				return false;
			}
		</script>
	</head>
	<body>
		<%
			if (list.size() == 0) {
		%>
		<font class="noUsers">当前没有用户在线!</font>
		<%
			} else {
		%>
		<div class="title">
			当前有
			<font><%=list.size()%></font>个用户在线
		</div>
		<table class="onlineUsers" cellspacing="10" align="center">
			<tr>
				<%
					for (int i = 0, size = list.size(); i < size; i++) {
							if (i % eachRow == 0) {//需要换行了
				%>
			</tr>
			<tr>
				<%
					}
							SysUser user = list.get(i);
							//当前用户不能让自己下线;任何人都不能让管理员下线
							boolean isOK = user.getUser_id().equals(thisUserId) || user.getUser_id().equals(0);
				%>
				<td><%=user.getUser_name()%>(<%=(user.getOrg_path() == null ? "" : user.getOrg_path())%>)
					<button
						onclick="return doThis(<%=user.getUser_id()%>,'<%=user.getUser_name()%>');"
						<%if (isOK) {%> disabled="disabled" <%}%>>
						强制下线
					</button>
				</td>
				<%
					}
				%>
			</tr>
		</table>
		<form action="<%=basePath%>compel_logout.action" method="post">
			<input type="hidden" name="userId" />
		</form>
		<%
			}
		%>
	</body>
</html>