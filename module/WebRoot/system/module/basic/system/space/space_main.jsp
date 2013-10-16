<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/My97DatePicker/WdatePicker.js"></script>

<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/zTree/css/demo.css"/>
<link rel="stylesheet" href="<%=basePath%>js/lib/jquery/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.core-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.excheck-3.3.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/zTree/js/jquery.ztree.exedit-3.3.js"></script>

<jsp:include page="/admin/common/css/style_easyui.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/jquery/easyui/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/easyui/jquery.easyui.min.js"></script>
<script language="javascript">
	$(function() {
		$('#userSpace').tabs({
			onSelect : function(title,index) {
				var space = $(this).tabs('getTab', index);
				if(index == 0){
					$.post("<%=basePath %>basic/sys/space_toSpaceInfo.action",{'ct':new Date()},function(html){
						space.html(html);
					});
				}else if(index == 1){
					$.post("<%=basePath %>basic/sys/space_toSpacePassword.action",{'ct':new Date()},function(html){
						space.html(html);
					});
				}else if(index == 2){
					$.post("<%=basePath %>basic/sys/space_toSpaceRight.action",{'ct':new Date()},function(html){
						space.html(html);
					});
				}else if(index == 3){
					$.post("<%=basePath %>basic/sys/space_toSpaceFaster.action",{'ct':new Date()},function(html){
						space.html(html);
					});
				}else if(index == 4){
					$.post("<%=basePath%>basic/sys/space_toSpaceLog.action",{'ct':new Date()},function(html){
						space.html(html);
					});
				}
			}
		});
	});
</script>
</head>
<body>
	<div id="userSpace" class="easyui-tabs"  tools="#tab-tools" >
		<div title="我的资料" cache="false" tools="#p-tools"></div>
		<div title="修改密码" cache="false">	</div>
		<div title="权限分配" cache="false">	</div>
		<div title="设置快捷功能" cache="false"></div>
		<div title="操作日志" cache="false"></div>
	</div>
</body>
</html>

