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
<title>新增单据编码</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
<jsp:include page="/admin/common/load_module_combox_tree.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=basePath%>js/lib/validation/css/livevalidation.css"/>
<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
<script type="text/javascript">
//添加系统模块属性
$(function(){
	var moduleTreeBox = new ModuleComboxTree({
		idFieldId: 'module_id',
		nameFieldId: 'module_name'
	});
});

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
	var order_type_no = new LiveValidation('order_type_no',{onlyOnSubmit:true});
	order_type_no.add( Validate.Presence, {failureMessage: "不能为空!"});
	order_type_no.add( Validate.Length, { maximum: 50} );
	order_type_no.add( Validate.Format, { failureMessage: "只能由字母/数字/下划线组成!", pattern: /^\w+$/});
	
	var name = new LiveValidation('name',{onlyOnSubmit:true});
	name.add( Validate.Presence, {failureMessage: "不能为空!"});
	name.add( Validate.Length, { maximum: 50} );
	name.add( Validate.Format, { failureMessage: "只能由字母组成!", pattern: /^[A-Za-z]+$/});
	name.add( Validate.Custom, { failureMessage: '当前业务单据编码已经存在,请重新填写', against: function(value, args){
		var valid = false;
		
		$.ajaxSetup({async: false});
		$.post('<%=basePath%>basic/sys/sysseqsno_checkIsExist.action', 'sysSeqsNo.order_type=' + $("#name").val(), function(msg){
			valid = msg == "0";
		});
		return valid;
	}});
	
	var seq_length = new LiveValidation('seq_length',{onlyOnSubmit:true});
	seq_length.add( Validate.Presence, {failureMessage: "不能为空!"});
	seq_length.add( Validate.Length, { maximum: 10} );
	seq_length.add( Validate.Format, { failureMessage: "只能是正整数!", pattern: /^\d+$/});
});

//显示编码生成
function showBusinessCode(){
	var show_code = "";
	if($("#name").val()){
		var name = $("#name").val();
		var sec_code_flag = $("#sec_code_flag").val();
		show_code+=name;
		if(sec_code_flag && sec_code_flag=="Y"){
			var dict_value = $("#dict_value").val();
			show_code+="_"+dict_value;
		}
		if($("#year_month_flag").val() && $("#year_month_flag").val() == 'Y'){
			var time = getNowDate();
			alert(time);
			show_code+= time;
		}
		if($("#seq_length").val()){
			if(isNaN($("#seq_length").val())){
				alert("序列不是一个有效数字");
				$("#seq_length").focus();
				return;
			}
			var length = $("#seq_length").val();
			var number="";
			for(var i=0;i<length-1;i++){
				number+= "0";
			}
			show_code+= number+"1";
		}
		$("#showCode").text(show_code);	
		
	}
}
//获取当前时间函数
function getNowDate(){
	var now = new Date();    
    var year = now.getFullYear();       //年   
    var month = now.getMonth() + 1;     //月   
    var day = now.getDate();            //日
    if(month<10){
    	month = "0"+month+""
    }
	var time=""+year+month+""
	return time;
}
</script>

<style type="text/css">
.box{
	width: 300px;
	height: auto;
	border-color: red;
}
</style>
</head>
<body>
<div class="title">新增单据编码</div>
<form id="form1" name="form1" method="post" action="<%=basePath %>basic/sys/sysseqsno_insertS.action">
<div class="editorTab">
	<table>
		<tr>
		    <td align="right"><font color="#FF0000">*</font>引用标识</td>
		    <td><input checktype="word" type="text" name="sysSeqsNo.order_type_no" id="order_type_no" isnull="true" /> <span id="d_no" style="color:red;"></span></td>
  		</tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>业务编码</td>
		    <td><input checktype="alphabet" type="text" name="sysSeqsNo.order_type"  onblur="javascript:showBusinessCode();"  id="name" isnull="true" /> <span id="d_name" style="color:red;"></span></td>
  		</tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>启用公司编码</td>
		    <td><select name="sysSeqsNo.sec_code_flag" onchange="javascript:showBusinessCode();" id="sec_code_flag" style="width:155px;">
		      <option value="N" selected="selected">不启用</option>
		      <option value="Y">启用</option>
            </select></td>
	    </tr>
	    <tr id="dict_gongsi1" style="display:none">
	    	<td align="right" ><font color="#FF0000">*</font>公司简写编码</td>
		    <td id="dict_gongsi2" style="display:none"><input type="text" onblur="javascript:showBusinessCode();" name="sysSeqsNo.sec_code" id="dict_value" />
		      <span id="d_value" style="color:red;"></span>
		    </td>
	    </tr>
  		<tr>
		    <td align="right"><font color="#FF0000">*</font>启用年月序列</td>
		    <td><select name="sysSeqsNo.year_month_flag" id="year_month_flag" onchange="javascript:showBusinessCode();" style="width:155px;">
		      <option value="N" selected="selected">不启用</option>
		      <option value="Y">启用年月</option>
		      </select>
    		</td>
  		</tr>
  		<tr>
  		  <td align="right"><font color="#FF0000">*</font>流水序列长度</td>
  		  <td><input type="text" name="sysSeqsNo.seq_length" isnull="true" onblur="javascript:showBusinessCode();" checktype="+int" id="seq_length" value="4" /></td>
	  </tr>
	  <tr>
  		<td align="right">所属业务模块</td>
  		<td>
			<div class="box">
				<input type="text" name="sysSeqsNo.module_name" id="module_name" />
				<input type="hidden" name="sysSeqsNo.module_id" id="module_id" />
			</div>
	  	</td>
	  </tr>
	  <tr>
	  	<td align="right">预览编码样式</td>
	  	<td><span id="showCode"></span></td>
	  </tr>
  	  <tr>
  		  <td align="right">编码用途说明</td>
  		  <td><textarea name="sysSeqsNo.comments" id="textarea" cols="45" rows="3"></textarea></td>
	  </tr>
	</table>
	</div>
		
		<div class="btns">
			<span class="btn"><input name="input" type="submit" value="提交" /></span>
			<span class="btn">
				<input type="button" id="cancelBtn" value="返回" 
					onclick="javascript:window.location.href='<%=basePath%>basic/sys/sysseqsno_findAllSSN.action'"/>
			</span>
		</div>
</form>
</body>
</html>