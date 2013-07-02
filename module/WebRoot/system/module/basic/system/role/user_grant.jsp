<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<jsp:include page="/admin/common/css/style_sub.jsp"></jsp:include>
		<script type="text/javascript"
			src="<%=basePath%>js/lib/jquery/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
		<script language="javascript">
/**
	 * 弹出系统用户页面
	 */
	function chooseUser(){
	    var url = '<%=basePath%>admin/basic/system/user/user_choose_single.jsp'; 
	  	window.callback = backfill;
		openModalWindow(url,window,'full');
	}
	/**
	 * 回调函数
 	*/
	function backfill(users){
	   for(var i=0;i<users.length;i++){
        var str="<input type='checkbox' checked name='ids' value='"+users[i].id+"' id='C1_"+users[i].id+"' />"
	   							+ "<a href='javascript:void(0);' title='点击可删除' onclick='del("+users[i].id+");' id='C2_"+users[i].id+"' class='del'>"+users[i].uname+ "(" + users[i].org_name + ")"+"</a>";
    	 $("#AuthPeople").append(str);
   	 }
	}  
 /**
  *提交表单
  */
  function submitForm(){
		$.post("<%=basePath%>basic/sys/role_setUserRole.action",$("#from").serialize(),function(json){
			if(json.code == 1){
			  	alert("操作成功");
			   	window.location.href = window.location.href;
			}else if(json.code == 0){
		 		alert("操作失败");
			}
		});
	}
	function del(id){
	     $('#C1_'+id+'').remove();
	     $('#C2_'+id+'').remove();
	}
</script>
	</head>
	<body>
	 <form id="from" action="" method="post">
        <input type="hidden" name="role.id" value="${role.id}" />
		<div class="title">
			角色设置用户
		</div>
		<div class="editorTab">
			<table>
				<tr>
					<th>角色名称</th>
					<td>${role.rname}</td>
				</tr>
			</table>
		</div>
		
		<div class="title">
			已添加的用户
		</div>
		<div class="editorTab">
			<table>
					<tr>
						<td colspan="4">
							<div style="height: 100px;">
								<s:iterator value="sysUserroleList">
									<input type="checkbox" checked="checked" name="ids"
										value="${userid}" id="C1_${userid}" />
									<a href="javascript:void(0);" title="点击可删除"
										onclick="del(${userid});" id="C2_${userid}" class="del">${username}(${org_name})</a>
								</s:iterator>
							</div>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="title">
			待添加的用户
		</div>
		<div class="editorTab">
			<table>
					<tr>
						<td colspan="4">
							<div style="height: 100px;" id="AuthPeople">

							</div>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<span class="btn"><input type="button"
									onclick="submitForm()" value="确定添加" />
							</span>
							<span class="btn"><input type="button"
									onclick="chooseUser()" value="选择用户" />
							</span>
							<span class="btn"> <input type="button" id="cancelBtn" value="返回"
								onclick="javascript:window.location.href='<%=basePath%>basic/sys/role_selectRole.action'" />
							</span>
						</td>
					</tr>
			</table>
		</div>
	</form>
  </body>
</html>
