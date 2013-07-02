<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<title>字典FRAME</title>
<script type="text/javascript">
	if("${operResult}"=="true"){
		alert("操作成功");
	}
	function updateDicState(dt_code,di_key,enable){
		window.location="<%=basePath%>basic/sys/dict_updateDictItem.action?sysDictItem.dt_code="+dt_code+"&sysDictItem.di_key="+di_key+"&sysDictItem.enable="+enable;
	}
	function deleteDic(dt_code,di_key){
		if(confirm("确定要删除此项吗？删除后不可恢复。")){
			window.location="<%=basePath%>basic/sys/dict_deleteDictItem.action?sysDictItem.dt_code="+dt_code+"&sysDictItem.di_key="+di_key;
		}
	}
</script>
</head>
<body>
	<div class="struRight">
		<div class="searchTab">
			<form action="<%=basePath%>basic/sys/dict_queryDictItem.action" id="form" method="post">
				<table>
					<tr align="left">
						<th>字典代码</th>
						<td><input type="text" size="20" name="sysDictItem.di_key" value="${sysDictItem.di_key}"/></td>
						<th>字典描述</th>
						<td>
							<input type="text" size="20" name="sysDictItem.remark" value="${sysDictItem.remark}"/>
							<input type="hidden" size="20" name="sysDictItem.dt_code" value="${sysDictItem.dt_code}"/>
						</td>
						<td colspan="3">
							<span class="btn"><input type="submit" value="查询" /></span>
							<span class="btn"><input type="button" value="添加" onclick="parent.addDictItem('${sysDictItem.dt_code }');" /></span>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="listTab">
			<table style="width: 890px;">
				<thead>
					<tr>
						<td>字典代码</td>
						<td>字典值</td>
						<td title="描述过长时，只显示前10个字符。">描述</td>
						<td>字典类型</td>
						<td>启用状态</td>
						<td>参数种类</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
				<s:iterator value="%{pm.list}">
					<tr>
						<td>${di_key}</td>
						<td>${di_value}</td>
						<td title="${remark}">${fn:substring(remark,0,10)}</td>
						<td>${dt_code}</td>
						<td>
							<s:if test="%{enable==2}">
								<img src="<%=basePath%>style/icons/ok.png" title="启用" alt="启用"/>
							</s:if>
							<s:elseif test="%{enable==1}">
								<img src="<%=basePath%>style/icons/pause.png" title="禁用" alt="禁用"/>
							</s:elseif>
						</td>
						<td>
							<s:if test="%{issys==2}">
								系统内置
							</s:if>
							<s:elseif test="%{issys==1}">
								用户定义
							</s:elseif>
						</td>
						<td>
							<a href="javascript:void(0);" class="modi" onclick="parent.editdic('${dt_code}', '${di_key}');">编辑</a>
							<s:if test="%{enable==2}">
								<a href="javascript:void(0);" class="disc" onclick="updateDicState('${dt_code}', '${di_key}', 1);">禁用</a>
							</s:if>
							<s:else>
								<a href="javascript:void(0);" class="enable" onclick="updateDicState('${dt_code}', '${di_key}', 2);">启用</a>
							</s:else>
					    	<s:if test="%{issys == 1}">
					    		<a href="javascript:deleteDic('${dt_code}', '${di_key}');" class="del">删除</a>
					    	</s:if>
					    	<s:else>
					    		<a href="javascript:void(0);" class="disc" style="color: gray">删除</a>
					    	</s:else>
					    </td>
					</tr>
				</s:iterator>
				<s:if test="%{pm.list.size() == 0}">
					<tr><td colspan="7"><font>很抱歉，没有找到您要的数据</font></td></tr>
				</s:if>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>