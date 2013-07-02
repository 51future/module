<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<link type="text/css" rel="stylesheet" href="<%=basePath%>js/lib/jquery/jqueryui/themes/redmond/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>js/lib/jquery/multiselect/css/ui.multiselect.css"  />
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jqueryui/ui/jquery-ui-1.8.23.custom.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/multiselect/js/plugins/localisation/jquery.localisation-min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/multiselect/js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/multiselect/js/ui.multiselect.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/floatdiv/floatdiv.js"></script>
<script language="javascript">
	$(function(){
		$.localise('ui-multiselect', {language: 'zh', path: '<%=basePath%>js/lib/jquery/multiselect/js/locale/'});
		$(".multiselect").multiselect();
		
		//添加浮动功能按钮层
		$(".btns").eq(0).floatdiv("middlebottom");
	});
		
	function tijiao(){
		if($("#idStr").val()==null){//表示没有选则
			alert("请选择用户");
		}else{
			$("#form1").submit();
		}
	}
</script>
</head>
<body>
<div class="title">角色的用户维护&nbsp;&nbsp;角色信息:${role.role_name}</div>

<form id="form1" action="<%=basePath %>basic/sys/role_roleFuUser.action" method="post">
  	<input type="hidden" name="role.role_id" value="${role.role_id}"/>
	 <div style="margin:10px auto 0 auto; width:800px;">
	  	<select name="idStr" id="idStr" class="multiselect" multiple="multiple">
				<s:iterator value="%{uList}">
					<option value="${user_id}" <s:if test="%{ischoose}">selected="selected"</s:if>>${user_name}(${org_name })</option>
				</s:iterator>
	     </select>
	 </div>
</form>
<div class="btns">
	<span class="btn">
         <input type="button" value="保存" onclick="tijiao();"/>
    </span> 
    <span class="btn">
		<input type="button" id="cancelBtn" value="返回" onclick="javascript:window.location.href='<%=basePath%>basic/sys/role_query.action'"/>
	</span>
</div>
</body>
</html>
