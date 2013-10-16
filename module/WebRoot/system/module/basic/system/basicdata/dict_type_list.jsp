<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>字典类别维护</title>
		<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
		<jsp:include page="/admin/common/load_module_combox_tree.jsp"></jsp:include>
		<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/lib/check/check.js"></script>
		<script type="text/javascript">
			//添加系统模块属性
		$(function(){
				var moduleTreeBox = new ModuleComboxTree({
					idFieldId: 'module_id',
					nameFieldId: 'module_name'
				});
			});
			
		function beforeDeleteCheck(dt_code){
			if(confirm("该操作不可恢复，确认删除?")){
				var checkUrl = "<%=basePath%>basic/sys/sysDictTypeAction_deleteBeforCheck.action"
				var vali = false;
				$.post(checkUrl,{"sysDictType.dt_code":dt_code},function(json){
					if(json.resultCode == 'success'){
						alert("该类别已经再使用，禁止删除");
						vali = true;
					}
				},'json');
				if(vali){
					return;
				}
				var url = "<%=basePath%>basic/sys/sysDictTypeAction_deleteSysDictType.action?sysDictType.dt_code="+dt_code;
				window.location.href = url;
				}
		}
		</script>
	</head>
	<body>
	<form action="<%=basePath%>basic/sys/sysDictTypeAction_selectDictTypeAll.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>类别编码</th>
					<td>
						<input type="text"  name="sysDictType.dt_code" value="${sysDictType.dt_code }"/>
					</td>
					<th>类别名称</th>
					<td>
						<input type="text"  name="sysDictType.dt_name" value="${sysDictType.dt_name }"/>
					</td>
					<th>所属模块</th>
					<td>
							<input type="text" name="sysDictType.module_name" id="module_name" value="${sysDictType.module_name }"/>
							<input type="hidden" name="sysDictType.module_id" id="module_id" value="${sysDictType.module_id }"/>
					</td>
				</tr>
				<tr>
					<th>结构类型</th>
					<td>
						<select name="sysDictType.dt_type" style="width:155px;">
							<option value="">--选择类型--</option>
							<option value="1" <s:if test="sysDictType.dt_type==1">selected="selected"</s:if>>列表结构</option>
							<option value="2" <s:if test="sysDictType.dt_type==2">selected="selected"</s:if>>树形树形</option>
						</select>
					</td>
					<th>启用状态</th>
					<td>
						<select name="sysDictType.enable" style="width:155px;">
							<option value="">--选择状态--</option>
							<option value="1" <s:if test="sysDictType.enable==1">selected="selected"</s:if>>禁用</option>
							<option value="2" <s:if test="sysDictType.enable==2">selected="selected"</s:if>>启用</option>
						</select>
					</td>
					<th></th>
					<td>
						<span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
						<span class="btn">
							<input type="button" value="新增" 
								onclick="javascript:window.location.href ='<%=basePath%>admin/basic/system/basicdata/dict_type_add.jsp'"/>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<div class="listTab">
		<table>
				<thead>
					<tr>
						<td>类别编码</td>
						<td>类别名称</td>
						<td>所属模块</td>
						<td>启用状态</td>
						<td>结构类型</td>
						<td>备注说明</td>
						<td>操作</td>
					</tr>
				</thead>
			<tbody>
			<s:iterator value="%{pm.list }">
			<tr>
				<td align="left">${dt_code }</td>
				<td align="left">${dt_name }</td>
				<td align="left">${module_name }</td>
				<td>
					<s:if test="enable==1">禁用</s:if>
					<s:if test="enable==2">启用</s:if>
				</td>
				<td>
					<s:if test="dt_type==1">列表结构</s:if>
					<s:if test="dt_type==2">树形结构</s:if>
				</td>
				<td align="left">${remark }</td>
        		<td>
	        		<a onclick="javascript:beforeDeleteCheck('${dt_code }');" class="del"  title="点击删除本条信息">删除</a>
	        		<a href="<%=basePath%>basic/sys/sysDictTypeAction_findSysDictTypeById.action?sysDictType.dt_code=${dt_code }" class="modi" title="点击查看或修改该单据">修改</a>
        		</td>
			</tr>
			</s:iterator>
			
			<s:if test="%{pm.list.size() == 0}">
			<tr>
				<td colspan="7"><font>很抱歉，没有找到您要的数据</font></td>
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