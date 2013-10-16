<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=basePath%>script/jQuery/jquery-min.js"></script>
<link type="text/css" href="<%=basePath%>script/validation/css/livevalidation.css"  rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath%>script/validation/livevalidation.js"></script>
<script type="text/javascript" src="<%=basePath%>script/validation/validation.js"></script>
<script language="javascript">
	
</script>
</head>
<body>
	<form action="" method="post" id="form0">
		<table>
			<tr>
				<th>用户姓名</th>
				<td><input type="text" name="username" class="LV_notNull" failmsg="不能为空"/></td>
				<td>不能为空</td>
			</tr>
			<tr>
				<th>身份证号码</th>
				<td><input type="text" name="idCardNo"
					class="LV_notNull LV_idCardNo" /></td>
				<td>不能为空</td>
			</tr>
			<tr>
				<th>用户编号</th>
				<td><input type="text" name="codeNo"
					class="LV_notNull LV_codeNo" /></td>
				<td>不能为空</td>
			</tr>
			<tr>
				<th>性别</th>
				<td>男<input type="radio" name="gender" value="male" class="LV_radioCheck" /><br /> 
					女<input type="radio" name="gender" value="female" class="" />
				</td>
			</tr>
			<tr>
				<th>爱好</th>
				<td>唱歌<input type="checkbox" name="aihao" value="cg" class="LV_radioCheck" /> 
					跳舞<input type="checkbox" name="aihao" value="tw" /> 
					羽毛球<input type="checkbox" name="aihao" value="ymq" />
					乒乓球<input type="checkbox" name="aihao" value="ppq" /> 
					篮球<input type="checkbox" name="aihao" value="lq" />
				</td>
			</tr>
			<tr>
				<th>年龄</th>
				<td><input type="text" name="age" class="LV_notNull LV_integer" maximum="120" minimum="0" /></td>
				<td>不能为空，只能为大于等于0且小于等于120的整数</td>
			</tr>

			<tr>
				<th>体重</th>
				<td><input type="text" name="weight" class="LV_notNull LV_numberic" minimum="0" /></td>
				<td>不能为空，只能为大于0的数字</td>
			</tr>
			<tr>
				<th>个性签名</th>
				<td><input type="text" name="qianming" class="LV_notNull LV_length" maxlength="10" /></td>
				<td>不能为空，长度大于5小于10</td>
			</tr>
			<tr>
				<th>电子邮箱</th>
				<td><input type="text" name="email" class="LV_email" /></td>
				<td></td>
			</tr>
			<tr>
				<th>价格</th>
				<td><input type="text" name="price" class="LV_price" /></td>
				<td>数字、小数点后只有4位</td>
			</tr>
			<tr>
				<th>电话</th>
				<td><input type="text" name="price" class="LV_telephone" /></td>
				<td>电话号码</td>
			</tr>

		</table>
		<input type="submit" value="提交" />
	</form>
</body>
</html>
