<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加字典</title>
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/lib/check/check.js"></script>
<script type="text/javascript">
//----当用户选择启用公司代码时，显示公司代码输入框-----------
$(document).ready(function (){
	$("#sec_code_flag").change(function () {
		var s = $("#sec_code_flag").val();
		if(s=='Y'){
			$("#dict_gongsi1").css("display","inline");
			$("#dict_gongsi2").css("display","inline");
			$("#dict_value").attr("isnull","true");
		}else {
			$("#dict_gongsi1").css("display","none");
			$("#dict_gongsi2").css("display","none");
			$("#dict_value").removeAttr("isnull");
		}
	});
});
function subForm(){
	var flag = attrCheckByFormName('form1');
	if(flag){
		var name = $("#name").val();
		var sec_code_flag = $("#sec_code_flag").val();   
		var sec_code = $("#dict_value").val();
		var yera_month_flag = $("#year_month_flag").val();
		$.ajax({
			type:"post",
			url:"<%=basePath%>basic/sys/sysseqsno_checkIsExist.action",
			data:"sysSeqsNo.order_type="+name,
			success:function(msg){
				if(msg=="0"){
					document.form1.submit();
				}else{
					alert("当前业务单据编码已经存在,请重新填写");
					return;
				}
			}
		});
	}
	
}
</script>
</head>
<body>
<div class="title">新增单据编码</div>
<form id="form1" name="form1" method="post" action="<%=basePath %>basic/sys/sysseqsno_insertS.action">
<div class="editorTab">
	<table>
		<tr>
		    <td align="right"><font color="#FF0000">*</font>引用标识</td>
		    <td><input type="text" name="sysSeqsNo.order_type_no" id="order_type_no" isnull="true" /> <span id="d_no" style="color:red;"></span></td>
  		</tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>业务编码</td>
		    <td><input type="text" name="sysSeqsNo.order_type" id="name" isnull="true" /> <span id="d_name" style="color:red;"></span></td>
  		</tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>启用公司编码</td>
		    <td><select name="sysSeqsNo.sec_code_flag" id="sec_code_flag" style="width:155px;">
		      <option value="N" selected="selected">不启用</option>
		      <option value="Y">启用</option>
            </select></td>
	    </tr>
	    <tr id="dict_gongsi1" style="display:none">
	    	<td align="right" ><font color="#FF0000">*</font>公司简写编码</td>
		    <td id="dict_gongsi2" style="display:none"><input type="text" name="sysSeqsNo.sec_code" id="dict_value" />
		      <span id="d_value" style="color:red;"></span>
		    </td>
	    </tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>启用年月序列</td>
		    <td><select name="sysSeqsNo.year_month_flag" id="year_month_flag" style="width:155px;">
		      <option value="N" selected="selected">不启用</option>
		      <option value="Y">启用年月</option>
		      </select>
    		</td>
  		</tr>
  		<tr>
  		  <td align="right"><font color="#FF0000">*</font>流水序列长度</td>
  		  <td><input type="text" name="sysSeqsNo.seq_length" isnull="true" checktype="+int" id="seq_length" value="4" /></td>
	  </tr>
  	  <tr>
  		  <td align="right">编码用途说明</td>
  		  <td><textarea name="sysSeqsNo.comments" id="textarea" cols="45" rows="3"></textarea></td>
	  </tr>
	</table>
	</div>
		
		<div class="btns">
			<span class="btn"><input name="input" type="button" value="提交" onclick="subForm();" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="返回" 
					onclick="javascript:window.location.href='<%=basePath%>basic/sys/sysseqsno_findAllSSN.action'"/>
			</span>
		</div>
</form>
</body>
</html>