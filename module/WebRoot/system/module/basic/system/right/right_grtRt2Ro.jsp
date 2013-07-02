<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%--
	auth : Conner
	date : 2012-09-05
	desc : 把(子系统的)权限赋给(子系统的)角色
--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css" />
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script language="javascript">
//选中checkbox
function checkIt(id){
	//alert(id);
	if(G("chk"+id).checked == true){
		G("chk"+id).checked = false;
	}else{
		G("chk"+id).checked = true;
	}
}

//把权限赋给角色
function grtRt2Ro(){
	var arrobj = getobj("input", "chk");
	var sltid = "";
	var rightId = "";  //权限id
	var url = "";
	for (var i = 0; i < arrobj.length; i++) {
		if (arrobj[i].checked == true) {
			sltid = sltid + arrobj[i].value + ",";
		}
	}
	if (sltid == "") {
		alert("没有选择角色！");
		return;
	} else if (sltid != "") {
		sltid = sltid.substring(0, sltid.length - 1);
		rightId = G("rightId").value;
		url = "<%=basePath %>basic/sys/role_grant.action?idStr=" + sltid ;
		url += "&right_id=" + rightId + "&type=grtRight2Role";
		document.location.href = url;
		
	}
}
</script>
<style type="text/css">
.box1 {display:inline;float:left;width:120px;background:#efefef;margin:3px;cursor:pointer;}
</style>
</head>
<body>
	<div class="title">把权限赋给角色</div>
	<div class="editorTab">
		<table>
				<tr>
					<th>菜单名称</th>
					<td>
						<s:property value="%{right.name }"/>
						<input type="hidden" id="rightId" value='<s:property value="%{right.id }"/>' />
					</td>
					<th>所属系统名称</th>
					<td><s:property value="%{subSystem.name}"/></td>
				</tr>
				<tr>
					<th><s:property value="%{subSystem.name}"/><br/>的角色</th>
					<td colspan="3">
						<s:iterator value="%{list}">
							<div class="box1" 
								onmouseover="this.style.background='#dddddd';"
								onmouseout="this.style.background='#efefef';"
								onclick="javascript:checkIt(${id });">
								<input type="checkbox" name="chk" id="chk${id }" value="${id }"/>${rname }
							</div>
						</s:iterator>
						<s:if test="%{list == null || list.size() == 0}"><font>暂时没有角色信息</font></s:if>
					</td>
				</tr>
		</table>
	</div>
	<div class="btns">
		<s:if test="%{list == null || list.size() == 0}">
			<span class="btn">
				<input type="button" id="cancelBtn" onclick="javascript:back();" value="返回" />
			</span>
		</s:if>
		<s:else>
			<span class="btn">
				<input type="button" id="selectAllBtn" value="全选" onclick="javascript:selectAll();" /></span>
			<span class="btn"><input type="button" id="submitBtn" value="提交" onclick="javascript:grtRt2Ro();"/></span>
			<span class="btn">
				<input type="button" id="cancelBtn" onclick="javascript:back();" value="返回"/>
			</span>
		</s:else>
	</div>
</body>
</html>
