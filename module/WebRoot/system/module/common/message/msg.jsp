<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>消息通知</title>
<link href="<%=basePath%>style/msg/msg.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var handle;
	function start() {
		var obj = document.getElementById("panel");
		if (parseInt(obj.style.height) == 0) {
			obj.style.display = "block";
			handle = setInterval("changeH('up')", 2);
		} else {
			handle = setInterval("changeH('down')", 2);
		}
	}
	function changeH(str) {
		var obj = document.getElementById("panel");
		if (str == "up") {
			if (parseInt(obj.style.height) > 170) {
				clearInterval(handle);
			} else {
				obj.style.height = (parseInt(obj.style.height) + 8).toString()+ "px";
			}
		}
		if (str == "down") {
			if (parseInt(obj.style.height) < 8) {
				clearInterval(handle);
				obj.style.display = "none";
			} else
				obj.style.height = (parseInt(obj.style.height) - 8).toString()+ "px";
		}
	}
	
	function showwin() {
		document.getElementsByTagName("html")[0].style.overflow = "hidden";
	}
	
	function recover() {
		document.getElementsByTagName("html")[0].style.overflow = "auto";
	}
	//window.attachEvent("onload", showwin); //绑定到onload事件
	
$(function(){
	showMessage();
	setInterval(function(){
		showMessage();
	},60000);
});
//用于更新状态
function updateStatus(id,obj){
	 var url = "<%=basePath%>sysmyinfo_updateMsgStatus.action";
	 $.post(url,{"smi.id":id,"time":new Date()},function(json){
	 	if(json.resultCode == 'success'){
	 		$(obj).parent().parent().remove();
	 	}
	 });
}
//用于查询消息
var showMessage = function showMessage(){
	var url = "<%=basePath%>sysmyinfo_findAllMsgByUserId.action";
	$.post(url,null,function(json){
		if(json.resultCode == 'success' ){
			var html = "";
			$("#showMessage").empty();
			if(json.list.length>0){
				for(var i=0;i<json.list.length;i++){
					html += "<tr><td>&nbsp;&nbsp;"+(i+1)+",</td>";
					html += "<td align='center'>&nbsp;&nbsp;&nbsp;&nbsp;"+json.list[i].infoconten+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class='IndexTableHeaderStyle' onclick='updateStatus("+json.list[i].id+",this);');'>关闭本条消息</a></td>"
					html += "</tr>";
				}
				$("#showMessage").append(html);
				 start();
			}else{
				html +="<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td align='rigth'>没有查询到相关信息</td></tr>";
				$("#showMessage").append(html);
			}
			
		}else if(json.resultCode == 'error'){
			alert("读取消息异常，请联系管理员");
		}
	},'json');
}
</script>
</head>
<body>

<div id="panel" style="height:0px;">
  <h1>消息通知<img src="<%=basePath%>style/msg/imgs/msg.gif" /><a href="javascript:void(0)" onclick="start()">×</a> </h1>
  <div class="panelContent">
   <table>
   		<tbody id="showMessage">
   		</tbody>
   </table>
</div>

</div>
</body>
</html>
