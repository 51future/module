<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script language="javascript">
//添加系统模块属性
$(function(){
	var moduleTreeBox = new ModuleComboxTree({
		idFieldId: 'module_id',
		nameFieldId: 'module_name'
	});
});
if("${operResult}"=="true"){
	alert("操作成功");
}

function editConfig(key){
	window.location="<%=basePath%>basic/sys/config_toEditPage.action?sysConfig.key="+key;
}
function addConfig(typeid){
	window.location="<%=basePath%>admin/basic/system/basicdata/config_add.jsp";
}
</script>
</head>
<body>
	<form action="<%=basePath%>basic/sys/config_toConfigPage.action" id="form" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>参数名称</th>
					<td><input type="text" name="sysConfig.name" value="${sysConfig.name }" /></td>
					<th>参数代码</th>
					<td><input type="text" name="sysConfig.key" value="${sysConfig.key }" /></td>
					<th>所属系统</th>
					<td>
						<input type="text" name="sysConfig.module_name" id="module_name" value="${sysConfig.module_name }"/>
						<input type="hidden" name="sysConfig.module_id" id="module_id" value="${sysConfig.module_id }"/>
					</td>
					<td>
						<span class="btn"><input type="submit" name="button" id="button" value="查询" /></span>
						<span class="btn"><input type="button" name="button" id="button" value="添加" onclick="addConfig()" /></span>
					</td>
				</tr>
			</table>
		</div>
		<!--查询条件表格-->
		<div class="listTab">
			<table>
				<thead>
					<tr>
						<td>参数名称</td>
						<td>参数代码</td>
						<td>参数值</td>
						<td>所属模块</td>
						<td>备注说明</td>
						<td>是否可编辑</td>
						<td>是否可见</td>
						<td>类型</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="%{pm.list}">
						<tr>
							<td class="tdLeft">${name }</td>
							<td class="tdLeft">${key }</td>
							<td class="tdLeft">${value }</td>
							<td class="tdLeft">${module_name }</td>
							<td title="${remark }" class="tdLeft">${fn:substring(remark,0,15)}</td>
							<td>
								<s:if test="%{editable==2}">
									<img src="<%=basePath%>style/icons/ok.png" title="可编辑" alt="可编辑" />
								</s:if>
								<s:elseif test="%{editable==1}">
									<img src="<%=basePath%>style/icons/pause.png" title="不可编辑" alt="不可编辑" />
								</s:elseif>
							</td>
							<td>
								<s:if test="%{visible==2}">
									<img src="<%=basePath%>style/icons/ok.png" title="可见" alt="可见" />
								</s:if>
								<s:elseif test="%{visible==1}">
									<img src="<%=basePath%>style/icons/pause.png" title="不可见" alt="不可见" />
								</s:elseif>
							</td>
							<td>
								<s:if test="%{value_type==1}">数字</s:if>
								<s:elseif test="%{value_type==2}">字符串</s:elseif>
								<s:elseif test="%{value_type==3}">布尔值</s:elseif>
								<s:elseif test="%{value_type==4}">日期时间</s:elseif>
							</td>
							<td>
								<s:if test="%{editable==2}">
									<a href="javascript:void(0);" class="modi" onclick="editConfig('${key}');">编辑</a>
								</s:if>
							</td>
						</tr>
					</s:iterator>
					<s:if test="%{pm.list.size() == 0}">
						<tr>
							<td colspan="8"><font>很抱歉，没有找到您要的数据</font></td>
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
