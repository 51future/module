<%@page import="java.util.Date"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String att_type = request.getParameter("att_type");
	att_type = (att_type == null ? "default" : att_type);
	String field_id = request.getParameter("field_id");
	String field_name = request.getParameter("field_name");
	String upFileAllowCount = request.getParameter("upFileAllowCount");
	String upFileSuffixs = request.getParameter("upFileSuffixs");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>上传文件</title>
<base  target="_self"/>
<style type="text/css">
	#mask{width:100%; height:100%; position:absolute; top:0px; left:0px; background-color:#FFF; filter:alpha(opacity=70); opacity:0.7; z-index:65534;}
</style>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/form/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>admin/common/file_upload/file_upload.js"></script>

<script type="text/javascript">
upFileAllowCount = 0; //默认不限制文件个数
if(!isNaN('<%=upFileAllowCount%>')){
	upFileAllowCount = new Number('<%=upFileAllowCount%>');
}
upFileSuffixs = ''; //默认不限制文件类型
if('<%=upFileSuffixs%>' != 'null' && '<%=upFileSuffixs%>'.length >0){
	upFileSuffixs = '<%=upFileSuffixs%>'; 
}

$(function(){
	var formSetting = {
		dataType: 'text',
		success: function(res, status, xhr){
			$('#mask').css('display','none');
			try{
				var json = eval('(' + res + ')');
				if(json.resultCode == 'success'){
					window.returnValue = json.fileInfos;
					window.close();
				}else{
					alert('文件上传失败，请联系管理员!');
				}
			}catch(e){
				alert('文件上传失败，请联系管理员!');
			}
		},
		error: function(){
			$('#mask').css('display','none');
			alert("文件上传失败，请联系管理员!");
		}
	};
	formSetting.beforeSubmit = function(){
		if(upFileNum == 0){
			 alert("请选择一个文件!");
			 return false;
		 }else{
			 $('#mask').css('display','block');
			 return true;
		 }
	};
	
	$('#file_form').on('submit', function(e) {
	    e.preventDefault();
	    $(this).ajaxSubmit(formSetting);
	});
});
</script>
</head>
<body>
<!-- --------------------------添加附件----------------------------------- -->
<form id="file_form" action="<%=basePath%>basic/sys/fileUpload.action"  method="post" enctype="multipart/form-data">
	<fieldset style="border: 1pxsolid #84A24A; text-align: left; COLOR: #84A24A; FONT-SIZE: 12px; font-family: Verdana; padding: 5px;">
	    <input type="button" value="添加附件" id="btnAdd" onclick="addAttachment();" class="btn" />
	    &nbsp;
	    <input type="button" value="清空附件" id="btnClear" onclick="clearAttachment();" style="display: none" class="btn"/>
	    <input type="submit" value="上传附件" id="btnUpload" class="btn"/>
	    
	    <div id="uploads"></div>
	    <div id="total" style="margin: 3px0px0px0px;"> 当前选择上传0个附件 </div>
	    <div style="color:red;"> 单次上传的文件总和大小不能超过50M </div>
	    
	    <input type="hidden" name="att_type" value="<%=att_type%>"/>
	</fieldset>
</form>
<div id="mask" style="display: none"></div>
</body>
</html>