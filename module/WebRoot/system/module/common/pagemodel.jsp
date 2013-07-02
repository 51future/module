<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="tabPaging">
	当前显示第 
	${((pm.pageNo - 1) * pm.pageSize + 1)} 条至第 ${(pm.pageNo * pm.pageSize) > pm.totalRecords ? pm.totalRecords : (pm.pageNo * pm.pageSize)}条 
	&nbsp;一共${pm.totalRecords}条
	<input type='submit' name="fp" value='' class="start" title="首页" onclick="gotoPage(1)"/>
	<input type='submit' name='pp' value='' class="up" title="上一页" onclick="gotoPage(${pm.pageNo-1})"/>
	<input type='submit' name='np' value='' class="next" title="下一页"  onclick="gotoPage(${pm.pageNo+1})"/>
	<input type='submit' name='lp' value='' class="end" title="尾页" onclick="gotoPage(${pm.totalPages})"/>&nbsp;&nbsp;&nbsp;&nbsp;
	每页显示&nbsp;<select name="pm.pageSize" id="pageSize" onchange="changePageSize();">
		<option value="10" <s:if test="%{pm.pageSize == 10}">selected="selected"</s:if> >10</option>
		<option value="20" <s:if test="%{pm.pageSize == 20}">selected="selected"</s:if>>20</option>
		<option value="30" <s:if test="%{pm.pageSize == 30}">selected="selected"</s:if>>30</option>
		<option value="40" <s:if test="%{pm.pageSize == 40}">selected="selected"</s:if>>40</option>
		<option value="50" <s:if test="%{pm.pageSize == 50}">selected="selected"</s:if>>50</option>
	</select>&nbsp;条&nbsp;&nbsp;&nbsp;&nbsp;
	当前第&nbsp;<input type="text" id="pageNo" name="pm.pageNo" value="${pm.pageNo}" style="width: 20px;"/>&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;共${pm.totalPages}页
</div>
<script type="text/javascript">
	function gotoPage(pageNo){
		if(/^\d+$/.test(pageNo)&&pageNo>0&&pageNo<='${pm.totalPages}'){
			document.getElementById("pageNo").value=pageNo;
		}
	}
	function changePageSize(){
		document.getElementById("pageNo").value =1;
		document.forms[0].submit();
	}
</script>