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
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script language="javascript">
	$(function(){
	var field1 = new LiveValidation( 'oldpwd', {onlyOnSubmit: true } );
	field1.add( Validate.Presence, {failureMessage: "不能为空!"});
	field1.add( Validate.Length, { maximum: 32 });
	
	var field2 = new LiveValidation( 'newpwd', {onlyOnSubmit: true } );
	field2.add( Validate.Presence, {failureMessage: "不能为空!"});
	field2.add( Validate.Length, { maximum: 32 });
	
	var field3 = new LiveValidation( 'pword', {onlyOnSubmit: true } );
	field3.add( Validate.Presence, {failureMessage: "不能为空!"});
	field3.add( Validate.Confirmation, {match: 'newpwd', failureMessage: "你输入的两次新密码不一致!"});
	field3.add( Validate.Length, { maximum: 32 });
/*判断原始密码和历史密码是否一致*/
	$("#oldpwd").blur(function(){
		var oldpwd=$("#oldpwd").val();
		$.post('<%=basePath%>basic/sys/user_pwdEqu.action',{'oldpwd':oldpwd},function(r){
			if(r=="none"){
				alert('历史密码和原始密码不一致！');
				$("#oldpwd").val("");
			}
		},"text")
	})
});
function updatepwd(){
	if(confirm("确定要将当前用户的密码重置为111111吗？")){
		$.post('<%=basePath%>basic/sys/user_resetPwd.action',{ct:new Date()},function(json){
		       var resultMsg=json.resultMsg;
		       alert(resultMsg);
		 });
	}
}
</script>
</head>
<body>
<div class="title">修改密码</div>
<form action="<%=basePath%>basic/sys/user_updatePassword.action" method="post" name="form1" id="form1">
<div class="editorTab">
<table>
	  <tr>
	    <th><font>*</font>历史密码</th>
	    <td><input type="password"  name="oldpwd" id="oldpwd"/></td>
	   </tr>
	   <tr> 
	    <th><font>*</font>新设密码</th>
	    <td><input type="password"  name="newpwd" id="newpwd"/></td>
	   </tr>
	   <tr>  
	    <th><font>*</font>确认密码</th>
	    <td><input type="password"  name="user.user_password" id="pword" /></td>
	    </tr>
</table>
<font>${message}</font>
</div>

 <div class="btns">  <span class="btn"><input type="submit" name="button" id="button" value="提交"/></span>
  <span class="btn"><input type="reset" value="重置密码" class="reset" onclick="updatepwd();"/></span></div>
  </form>

</body>
</html>
