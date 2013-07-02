<%@page import="java.util.Date"%>
<%@page import="org.activiti.engine.impl.interceptor.Session"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String att_type = request.getParameter("att_type");
	att_type = (att_type == null ? "default" : att_type);
	String field_id = request.getParameter("field_id");
	String field_name = request.getParameter("field_name");
	String upFileAllowCount = request.getParameter("upFileAllowCount");
	String upFileSuffixT = request.getParameter("upFileSuffixT");
	String upFileSuffixs = request.getParameter("upFileSuffixs");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>上传文件</title>
<base target="_self" href="<%=basePath%>" />
<link  type="text/css" rel="stylesheet" href="js/lib/jquery/plupload/js/jquery.plupload.queue/css/jquery.plupload.queue.css" media="screen" />
<script type="text/javascript" src="js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/lib/jquery/plupload/js/plupload.full.js"></script>
<script type="text/javascript" src="js/lib/jquery/plupload/js/jquery.plupload.queue/jquery.plupload.queue.js"></script>
<script type="text/javascript" src="js/lib/jquery/plupload/js/i18n/cn.js"></script>
<script type="text/javascript">
	var upFileAllowCount = 1; //默认只能添加一个附件
	if(!isNaN('<%=upFileAllowCount%>')){
		upFileAllowCount = new Number('<%=upFileAllowCount%>');
	}
	var upFileSuffixT = '所有文件(*.*)'; //默认不限制文件类型
	var upFileSuffixs = '*'; //默认不限制文件类型
	if('<%=upFileSuffixs%>' != 'null' && '<%=upFileSuffixs%>'.length > 0) {
		upFileSuffixs = '<%=upFileSuffixs%>';
	}
	if('<%=upFileSuffixT%>' != 'null' && '<%=upFileSuffixT%>'.length > 0) {
		upFileSuffixT = '<%=upFileSuffixT%>';
	}
	$(function() {
		$("#uploader").pluploadQueue({
			runtimes : 'gears,flash,silverlight,browserplus,html5,html4',
			url : '<%=basePath%>basic/sys/filePlupload.action',
			max_file_size : '1024mb',
			unique_names : true,
			dragdrop : true,
			multiple_queues : true,
			chunk_size: '1mb',
			//resize: { width: 320, height: 240, quality: 100},
			filters : [{title : upFileSuffixT, extensions : upFileSuffixs}],
			flash_swf_url : '<%=basePath%>js/lib/jquery/plupload/js/plupload.flash.swf',
			silverlight_xap_url : '<%=basePath%>/plupload/js/plupload.silverlight.xap',
			multipart_params : { 'att_type' : '<%=att_type%>','fileInfos' : null},
			init : {
				FileUploaded: function(up, file, info) {
					var json = eval('(' + info.response + ')');
					if(json.resultCode == 'success'){
						window.returnValue = json.fileInfos; 
						up.settings.multipart_params = {'att_type' : '<%=att_type%>'};
					}else{
						alert('文件'+file.name+'上传失败，请联系管理员!');
					}
	            }
			}
		});
	});
</script>
</head>
<body>
	<!-- --------------------------附件上传----------------------------------- -->
	<fieldset style="border: 1pxsolid #84A24A; text-align: left; COLOR: #84A24A; FONT-SIZE: 12px; font-family: Verdana; padding: 5px;">
		<div id="uploader">
			<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
		</div>
	</fieldset>
</body>
</html>