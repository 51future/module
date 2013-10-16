<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
var oldpwd = new LiveValidation( 'oldpwd', {onlyOnSubmit: true } );
oldpwd.add( Validate.Presence, {failureMessage: "不能为空!"});
oldpwd.add( Validate.Length, { maximum: 32 });
oldpwd.add(Validate.Custom,{failureMessage:'历史密码不正确!',against:function(value,args){
	var valid='true';
	var params = {
			'user.user_account': '${user.user_account}',
			'user.user_password':$('#oldpwd').val(),
			'ct':new Date()
	};
	$.ajaxSetup({async:false});
	$.post('<%=basePath%>basic/sys/space_checkUserPassword.action',params,function(json){valid=json.valid;});
	return (valid == 'true');
}});

var newpwd = new LiveValidation( 'newpwd', {onlyOnSubmit: true } );
newpwd.add( Validate.Presence, {failureMessage: "不能为空!"});
newpwd.add( Validate.Length, {minimum:6, maximum: 32 });
newpwd.add(Validate.CodeNum,{});

var pword = new LiveValidation( 'pword', {onlyOnSubmit: true } );
pword.add( Validate.Presence, {failureMessage: "不能为空!"});
pword.add( Validate.Confirmation, {match: 'newpwd', failureMessage: "您输入的新密码不一致!"});
pword.add( Validate.Length, { minimum:6, maximum: 32 });
pword.add(Validate.CodeNum,{});
</script>
<div class="title">修改密码</div>
	<form action="<%=basePath%>basic/sys/space_saveSpacePassword.action" method="post" id="space_pass_form">
		<div class="editorTab">
			<table>
				<tr>
					<th><font>*</font>历史密码</th>
					<td><input type="password" name="oldpwd" id="oldpwd" /></td>
				</tr>
				<tr>
					<th><font>*</font>新设密码</th>
					<td><input type="password" name="newpwd" id="newpwd" /></td>
				</tr>
				<tr>
					<th><font>*</font>确认密码</th>
					<td><input type="password" name="user.user_password" id="pword" /></td>
				</tr>
			</table>
		</div>

		<div class="btns">
			<span class="btn"><input type="submit" name="button" value="提交" /></span> 
		</div>
	</form>
