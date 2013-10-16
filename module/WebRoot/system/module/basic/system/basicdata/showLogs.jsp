<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<title>系统日志</title>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<jsp:include page="/admin/common/auto_load_user.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/jx/JXCore.js"></script>
<jsp:include page="/admin/common/auto_load_user.jsp"></jsp:include>
<script language="javascript">
$(function() {
	
	var userAutoComplete = new UserAutoComplete({
		user_name: 'operator_name',
		user_id: 'operator_id'
	});
});
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/sysLog_query.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>
						操作人
					</th>
					<td>
						<input type="text" name="sysBizLog.operator_name" id="operator_name" value="${sysBizLog.operator_name}"  class="autoInput"/>
						<input type="hidden" name="sysBizLog.operator_id" id="operator_id" value="${sysBizLog.operator_id}" />
					</td>
					<th>
						日志类型
					</th>
					<td>
						<select name="sysBizLog.log_type" class="downMenu">
						  <option value="" selected="selected">--请选择--</option>
				     	  <option value="app_start" <s:if test='sysBizLog.log_type == "app_start" '>selected</s:if>>app_start(系统启动)</option>
				     	  <option value="app_stop" <s:if test='sysBizLog.log_type == "app_stop" '>selected</s:if>>app_stop(系统关闭)</option>
				     	  <option value="user_login" <s:if test='sysBizLog.log_type == "user_login" '>selected</s:if>>user_login(用户登录)</option>
				     	  <option value="user_logout" <s:if test='sysBizLog.log_type == "user_logout" '>selected</s:if>>user_logout(用户退出)</option>
				     	  <option value="insert" <s:if test='sysBizLog.log_type == "insert" '>selected</s:if>>insert(数据插入)</option>
				     	  <option value="update" <s:if test='sysBizLog.log_type == "update" '>selected</s:if>>update(数据更新)</option>
				     	  <option value="delete" <s:if test='sysBizLog.log_type == "delete" '>selected</s:if>>delete(数据删除)</option>
				     	  <option value="query" <s:if test='sysBizLog.log_type == "query" '>selected</s:if>>query(数据查询)</option>
				     	  <option value="other" <s:if test='sysBizLog.log_type == "other" '>selected</s:if>>other(其它)</option>
		         	   </select>
					</td>
					<th>
						开始时间
					</th>
					<td>
						<input type="text" name="sysBizLog.start_time" id="sysBizLog.start_time" value="<s:date name="sysBizLog.start_time" format="yyyy-MM-dd HH:mm:ss"/>" 
							class="dateInput" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:00'})" onchange="setDueDate('${id}',this.value);"/>
					</td>
					<th>
						结束时间
					</th>
					<td>
						<input type="text" name="sysBizLog.end_Time" id="sysBizLog.end_Time" value="<s:date name="sysBizLog.end_Time" format="yyyy-MM-dd HH:mm:ss"/>" 
							class="dateInput" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'%y-%M-%d %H:%m:00'})" onchange="setDueDate('${id}',this.value);"/>
					</td>
					<td>
						<span class="btn"><input type="submit" id="button" value="查询" /></span>
					</td>
				</tr>
			</table>
		</div>
		<div class="listTab">
			<table>
				<thead>
					<tr>
						<td>
							日志类型
						</td>
						<td>
							日志内容
						</td>
						<td>
							所属子系统
						</td>
						<td>
							所属子模块
						</td>
						<td>
							操作状态
						</td>
						<td>
							操作人
						</td>
						<td>
							操作时间
						</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{pm.list }">
						<tr>
							<td class="tdLeft">
								${log_type}
							</td>
							<td class="tdLeft">
								${content}
							</td>
							<td class="tdLeft">
								${sub_system}
							</td>
							<td class="tdLeft">
								${sub_module}
							</td>
							<td class="tdLeft">
								<s:if test=' operate_status ==1 '>成功</s:if>
								<s:if test=' operate_status ==2 '>失败</s:if>
							</td>
							<td class="tdLeft">
								${operator_name}
							</td>
							<td>
								<s:date name="operate_time" format="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
					</s:iterator>

					<s:if test="%{pm.list.size() == 0}">
						<tr>
							<td colspan="7">
								<font>很抱歉，没有找到您要的数据</font>
							</td>
						</tr>
					</s:if>
				</tbody>
			</table>
		</div>
		<s:if test="%{pm.list.size() > 0}">
			<jsp:include page="/admin/common/pagemodel.jsp"></jsp:include>
		</s:if>
	</form>
</body>
</html>
