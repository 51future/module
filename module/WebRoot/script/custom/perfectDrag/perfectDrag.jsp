<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>perfectDrag：http://www.17sucai.com/pins/demoshow/1002</title>
<link href="<%=basePath%>css/css/content.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/perfectDrag.js"></script>
<style type="text/css">
* { padding: 0; margin: 0; }
.panel-view { width: 966px; height: 520px; position: absolute; top: 35px; left: 50%; margin-left:-483px; overflow:hidden;}
.panel-list { width: 1932px; height: 520px; cursor: pointer; position: absolute; top: 0px; left: 0px;}
.panel{ float: left; width:966px; height:520px; overflow:hidden; list-style: none;}
</style>
<script type="text/javascript">
	window.onload = perfectDrag;
</script>

</head>
<body onload="autoWidth()">
<div class="panel-view" id="panel_view"  oncontextmenu="return false" ondragstart="return false" 
	onselectstart ="return false" onselect="document.selection.empty()"  oncopy="document.selection.empty()" 
	onbeforecopy="return false"  onmouseup="document.selection.empty()">
	  <div class="panel-list" id="panel_list" >
	    <div class="panel" id="panel">
	    
			<div class="subNav" id="navWidth" style="height:500px; width:966px; margin-top:0; position:absolute; left:50%; margin-left:-483px;">
			  <ul>
              	<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">万年历<span><a href="javascript:void(0);" onclick="openAreaW('<%=basePath %>admin/newoa/desktop/per_calendar.jsp',this)" class="xx bb">万年历</a><br /></span></li>
				<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">计算器<span><a href="javascript:void(0);" onclick="openAreaW('<%=basePath %>admin/newoa/desktop/counter.jsp',this)" class="xx bb">计算器</a><br /></span></li>
			  	<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
                <li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
                <li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
			  </ul>
			</div>
			
		</div>
		<div class="panel" >
		
			<div class="subNav" id="navWidth" style="height:500px; width:966px; margin-top:0;position:absolute; left:50%; margin-left:-483px;">
			  <ul>
              	<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">万年历<span><a href="javascript:void(0);" onclick="openAreaW('<%=basePath %>admin/newoa/desktop/per_calendar.jsp',this)" class="xx bb">万年历</a><br /></span></li>
				<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">计算器<span><a href="javascript:void(0);" onclick="openAreaW('<%=basePath %>admin/newoa/desktop/counter.jsp',this)" class="xx bb">计算器</a><br /></span></li>
			  	<li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
                <li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
                <li id="sb" class="subNavle" onMouseOver="deskcss(this)" onMouseOut="deskcssno(this)">自定义<span><br /></span></li>
			  </ul>
			</div>
			
		</div>
	</div></div>

</body>
</html>
