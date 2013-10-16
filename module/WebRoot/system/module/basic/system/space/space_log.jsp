<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="toolbar">  
	<table>
		<tr>
			<th>
				日志时间
			</th>
			<td>
				<input name="bizLog.start_time" id="start_time" value="<s:date name="bizLog.start_time" format="yyyy-MM-dd HH:mm:ss"/>" 
					class="dateInput" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'end_time\')}'})" />
				到<input name="bizLog.end_Time" id="end_time" value="<s:date name="bizLog.end_Time" format="yyyy-MM-dd HH:mm:ss"/>" 
					class="dateInput" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'start_time\')}'})" />
			</td>
			<th>
				日志类型
			</th>
			<td>
				<select name="bizLog.log_type" id="log_type" class="downMenu">
				  <option value="" selected="selected">--请选择--</option>
		     	  <option value="insert">数据插入</option>
		     	  <option value="update">数据更新</option>
		     	  <option value="delete">数据删除</option>
		     	  <option value="query">数据查询</option>
		     	  <option value="app_start">系统启动</option>
		     	  <option value="app_stop">系统关闭</option>
		     	  <option value="user_login">用户登录</option>
		     	  <option value="user_logout">用户退出</option>
		     	  <option value="other">其它</option>
         	   </select>
			</td>
			<td>
				<span class="btn"><input type="button" value="查询" onclick="selSpaceLog();"/></span>
			</td>
		</tr>
	</table>
</div>  
<table id="dataGrid"></table>
<script type="text/javascript">
$('#dataGrid').datagrid({
	iconCls:'icon-save',
	loadMsg: "请稍等，正在为您努力加载数据！",
	nowrap: false,
	border: false,
	striped: true,
	url:'<%=basePath%>basic/sys/space_selSpaceLog.action?ct=' + new Date(),
	sortName: 'log_id',
	sortOrder: 'log_id',
	remoteSort: false,
	idField:'log_id',
	singleSelect:true,  
	pagination:true,
	rownumbers:true,
	toolbar: '#toolbar',
	columns:[[
	    {title:'log_id', field:"log_id", hidden:true},
		{title:'时间',field:'operate_time',width:150},
		{title:'日志类型',field:'log_type',width:150,formatter: function(value, rowData, rowIndex){
			if(value == 'app_start'){
				return '系统启动';
			}else if(value == 'app_stop'){
				return '系统关闭';
			}else if(value == 'user_login'){
				return '用户登录';
			}else if(value == 'user_logout'){
				return '用户退出';
			}else if(value == 'insert'){
				return '数据插入';
			}else if(value == 'update'){
				return '数据更新';
			}else if(value == 'delete'){
				return '数据删除';
			}else if(value == 'query'){
				return '数据查询';
			}else if(value == 'other'){
				return '其它';
			}else{
		    	return value;
			}
         }},
		{title:'操作人姓名',field:'operator_name',width:150},
		{title:'日志内容',field:'content',width:350},
           {title:'操作状态',field:'operate_status',width:100, formatter: function(value, rowData, rowIndex){
           	if(value == 1){
           		return "成功";
           	}else if(value = 2){
           		return " 失败";
           	}
	    	return value;
           }}
	]]
});

//设置分页控件  
var p = $('#dataGrid').datagrid('getPager');  
$(p).pagination({  
    pageSize: 10,//每页显示的记录条数，默认为10  
    pageList: [10,15,20,25,30,35,40],//可以设置每页记录条数的列表  
    beforePageText: '第',//页数文本框前显示的汉字  
    afterPageText: '页    共 {pages} 页',  
    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',  
});

//查询
function selSpaceLog(){
	var param =  {
		'bizLog.start_time' : $('#start_time').val(),
		'bizLog.end_Time' : $('#end_time').val(),
		'bizLog.log_type' : $('#log_type').val(),
		'ct' : new Date()
	};
	$('#dataGrid').datagrid('load', param); 
}
</script>