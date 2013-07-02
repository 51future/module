<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		<script type="text/javascript" src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
	</head>
	<body>
	<form action="<%=basePath%>basic/sys/sysseqsno_findAllSSN.action" id="sf" method="post">
		<div class="searchTab">
			<table>
				<tr>
					<th>引用标识</th>
					<td>
						<input type="text" name="sysSeqsNo.order_type_no" value="${sysSeqsNo.order_type_no}"/>
					</td>
					<th>业务编码</th>
					<td>
						<input type="text" name="sysSeqsNo.order_type" value="${sysSeqsNo.order_type}"/>
					</td>
					<th>公司编码</th>
					<td>
						<select name="sysSeqsNo.sec_code_flag" id="sec_code_flag" class="downMenu">
						  <option value="" selected="selected">--请选择--</option>
				     	  <option value="N" <s:if test=' sysSeqsNo.sec_code_flag =="N" '>selected</s:if>>不启用</option>
				     	  <option value="Y" <s:if test=' sysSeqsNo.sec_code_flag =="Y" '>selected</s:if>>启用</option>
		         	   </select>
					</td>
				</tr>
				<tr>
					<th>年月序列</th>
					<td>
						<select name="sysSeqsNo.year_month_flag" id="year_month_flag" class="downMenu">
						  <option value="" selected="selected">--请选择--</option>
				    	  <option value="N" <s:if test=' sysSeqsNo.year_month_flag =="N" '>selected</s:if>>不启用</option>
				    	  <option value="Y" <s:if test=' sysSeqsNo.year_month_flag =="Y" '>selected</s:if>>启用年月</option>
				    	</select>
					</td>
					<th>编码用途</th>
					<td>
						<input type="text" name="sysSeqsNo.comments" value="${sysSeqsNo.comments}"/>
					</td>
					<th></th>
					<td>
						<span class="btn"><input type="submit" id="searchBtn" value="查询"/></span>
						<span class="btn">
							<input type="button" value="新增单据编码" 
								onclick="javascript:window.location.href = '<%=basePath%>admin/basic/system/seqsno/bianhao.jsp'"/>
						</span>
					</td>
				</tr>
			</table>
		</div>
		<div class="listTab">
		<table>
				<thead>
					<tr>
						<td>引用标识</td>
						<td>业务编码</td>
						<td>公司编码</td>
						<td>年月序列</td>
						<td>流水长度</td>
						<td>编码用途</td>
						<td>操作</td>
					</tr>
				</thead>
			<tbody>
			<s:iterator value="%{pm.list }">
			<tr>
        		<td class="tdLeft">${order_type_no}</td>
        		<td>${order_type}</td>
        		<td>
        			<s:if test=' sec_code_flag =="Y" '>启用</s:if>
        			<s:if test=' sec_code_flag =="N" '>不启用</s:if>
        		</td>
        		<td>
        			<s:if test=' year_month_flag =="Y" '>启用</s:if>
        			<s:if test=' year_month_flag =="N" '>不启用</s:if>
        		</td>
        		<td>${seq_length}</td>
        		<td align="left">${comments}</td>
        		<td>
	        		<a href="<%=basePath %>basic/sys/sysseqsno_deleteS.action?id=${order_type_no}" class="del" onclick="return confirm('此操作不可恢复，确定删除吗？')" title="点击删除本条信息">删除</a>
	        		<a href="<%=basePath %>basic/sys/sysseqsno_findByIdS.action?id=${order_type_no}" class="modi" title="点击查看或修改该单据">修改</a>
        		</td>
			</tr>
			</s:iterator>
			
			<s:if test="%{pm.list.size() == 0}">
			<tr>
				<td colspan="7"><font>很抱歉，没有找到您要的数据</font></td>
			</tr>
			</s:if>
			</tbody>
		</table>
		</div>
		<s:if test="%{pm.list.size() > 0}">
		<jsp:include page="/admin/common/pagemodel.jsp"></jsp:include>
		</s:if>
		</form>
	</body>
</html>