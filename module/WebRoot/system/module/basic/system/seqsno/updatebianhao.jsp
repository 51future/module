<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage=""%>
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
		<title>设备管理系统</title>
		<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
		<jsp:include page="/admin/common/load_module_combox_tree.jsp"></jsp:include>
		<script type="text/javascript" src="<%=basePath%>js/lib/validation/livevalidation.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/lib/check/check.js"></script>
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
		});
		function subForm(){
			var flag = attrCheckByFormName('form1');
			if(flag){
				var name = $("#name").val().toUpperCase();
				var oldname = $("#oldname").val().toUpperCase();
				var sec_code_flag = $("#sec_code_flag").val();   
				var sec_code = $("#dict_value").val();
				var yera_month_flag = $("#year_month_flag").val();
				$.ajax({
					type:"post",
					url:"<%=basePath%>basic/sys/sysseqsno_checkIsExist.action",
					//data:"sysSeqsNo.order_type="+name+"&sysSeqsNo.sec_code_flag="+sec_code_flag+"&sysSeqsNo.sec_code="+sec_code+"&sysSeqsNo.year_month_flag="+yera_month_flag,
					data:"sysSeqsNo.order_type="+name,
					success:function(msg){
						if(msg=="0"){
							document.form1.submit();
						}else if(name==oldname){
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
		<style type="text/css">
			.box{
				width: 300px;
				height: auto;
				border-color: red;
			}
		</style>
	</head>
	<body>
	<div class="title">修改单据编码</div>
		<form id="form1" name="form1" method="post" action="<%=basePath %>basic/sys/sysseqsno_updateS.action" >
		<div class="editorTab">
		<table>
  			<tr>
		  	  <td align="right"><font color="#FF0000">*</font>业务单据编码</td>
		  	  <td><input type="text" disabled="disabled" name="sysSeqsNo.order_type" isnull="true" id="name" value="${sysSeqsNo.order_type}" /><span id="d_name" style="color:red;"></span>
		  	  	  <input type="hidden" name="old" id="oldname" value="${sysSeqsNo.order_type}" />
		  	  </td>
  			</tr>
  			<tr>
		  	  <td align="right"><font color="#FF0000">*</font>引用标识</td>
		  	  <td><input type="text" name="sysSeqsNo.order_type_no" isnull="true" id="name" value="${sysSeqsNo.order_type_no}" /><span id="d_no" style="color:red;"></span>
		  	  	  <input type="hidden" name="oldno" id="oldnameno" value="${sysSeqsNo.order_type_no}" />
		  	  </td>
  			</tr>
  			<tr>
		  	  <td align="right"><font color="#FF0000">*</font>公司编码设置</td>
		  	  <s:if test=' sysSeqsNo.sec_code_flag =="N" '>
		  	  	 <td><select name="sysSeqsNo.sec_code_flag" id="sec_code_flag" style="width:155px;">
		     	 <option value="N" selected="selected">不启用</option>
		     	 <option value="Y">启用</option>
         	   </select></td>
		  	  </s:if>
		  	   <s:if test=' sysSeqsNo.sec_code_flag =="Y" '>
		  	  	 <td><select name="sysSeqsNo.sec_code_flag" id="sec_code_flag" style="width:155px;">
		  	  	 <option value="N">不启用</option>
		     	 <option value="Y" selected="selected">启用</option>
         	   </select></td>
		  	  </s:if>
	    	</tr>
	    	<s:if test=' sysSeqsNo.sec_code_flag =="N" '>
	    	<tr id="dict_gongsi1" style="display:none">
	    	  <td align="right"><font color="#FF0000">*</font>公司简写编码</td>
				  <td id="dict_gongsi2" style="display:none"><input type="text" name="sysSeqsNo.sec_code" id="dict_value" value=""/>
		    	  <span id="d_value" style="color:red;"></span>
		   	  	  </td>		
	    	</tr>
	    	</s:if> 
	    	<s:if test=' sysSeqsNo.sec_code_flag =="Y" '>
	    	<tr id="dict_gongsi1">
	    	  <td align="right"><font color="#FF0000">*</font>公司简写编码</td>
				  <td id="dict_gongsi2" ><input type="text" name="sysSeqsNo.sec_code" isnull="true" id="dict_value" value="${sysSeqsNo.sec_code}"/>
		    	  <span id="d_value" style="color:red;"></span>
		   	  	  </td>		
	    	</tr>
	    	</s:if>
  			<tr>
		  	  <td align="right"><font color="#FF0000">*</font>启用年月序列</td>
		  	  <s:if test='sysSeqsNo.year_month_flag=="N" '>
		  	  	  <td><select name="sysSeqsNo.year_month_flag" id="year_month_flag" style="width:155px;">
		    	  <option value="N" selected="selected">不启用</option>
		    	  <option value="Y">启用年月</option>
		    	  </select>
    			</td>
		  	  </s:if>
		  	   <s:if test='sysSeqsNo.year_month_flag=="Y" '>
		  	  	  <td><select name="sysSeqsNo.year_month_flag" id="year_month_flag" style="width:155px;">
		    	  <option value="N">不启用</option>
		    	  <option value="Y" selected="selected">启用年月</option>
		    	  </select>
    			</td>
		  	  </s:if>
  			</tr>
  			<tr>
		  		<td align="right">所属业务模块</td>
		  		<td>
					<div class="box">
						<input type="text" name="sysSeqsNo.module_name" id="module_name" value="${sysSeqsNo.module_name }"/>
						<input type="hidden" name="sysSeqsNo.module_id" id="module_id" value="${sysSeqsNo.module_id }"/>
					</div>
			  	</td>
			  </tr>
  			<tr>
  		 	   <td align="right"><font color="#FF0000">*</font>流水序列长度</td>
  		 	   <td><input type="text" name="sysSeqsNo.seq_length" isnull="true" checktype="+int" id="seq_length" value="${sysSeqsNo.seq_length}" /></td>
	 		</tr>
  		<tr>
  		  <td align="right">编码用途说明</td>
  		  <td><textarea name="sysSeqsNo.comments" id="textarea" cols="45" rows="3">${sysSeqsNo.comments}</textarea>
  		  </td>
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