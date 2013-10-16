<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script type="text/javascript">
var user_name = new LiveValidation('user_name',{onlyOnSubmit:true});
user_name.add( Validate.Presence, {failureMessage: "不能为空!"});
user_name.add( Validate.Length, { maximum: 30} );

var cellphone_no = new LiveValidation('cellphone_no',{onlyOnSubmit:true});
cellphone_no.add( Validate.Presence, {failureMessage: "不能为空!"});
cellphone_no.add(Validate.Format, { pattern:/^1\d{10}$/,failureMessage: "号码有误!" });

</script>
<style type="text/css"> .autoArea{width:253px; height:60px; overflow:auto; padding:5px;}</style>
<form action="<%=basePath %>basic/sys/space_saveSpaceInfo.action" id="space_info_form" method="post">
   <input type="hidden" name="user.utype" value="1"/>
	<div class="editorTab">
		<table>
				<tr>
					<th>登录账号</th>
					<td >
						<input value="${user.user_account}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
					</td>
					<th>用户类型</th>
					<td>
						<s:if test="%{user.user_type ==1}">
							<input value="用户类型1" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
						</s:if><s:elseif test="%{user.user_type ==2}">
							<input value="用户类型2" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
						</s:elseif><s:elseif test="%{user.user.type ==3}">
							<input value="用户类型3" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
						</s:elseif>
					</td>
				</tr>
				<tr>
					<th><font>*</font>用户姓名</th>
					<td>
						<input type="text" name="user.user_name" id="user_name" value="${user.user_name}" style="width: 152px;"/>
					</td>
					<th>用户编号</th>
					<td >
						<input value="${user.user_code}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
					</td>
				</tr>
				<tr>
					<th>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</th>
					<td>
						<label><input type="radio" name="user.gender" value="2" 
							<s:if test="%{user.gender == 2}">checked="checked"</s:if> disabled="disabled"/>男</label>
						<label><input type="radio" name="user.gender" value="1" 
							<s:if test="%{user.gender == 1}">checked="checked"</s:if> disabled="disabled"/>女</label>
					</td>
					<th>所在组织</th>
					<td>
						<input value="${user.org_name}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
					</td>
				</tr>
				<tr>
					<th>可再授权</th>
					<td>
						<label><input type="radio" name="user.auth_again" value="2" 
							<s:if test="%{user.auth_again == 2}">checked="checked"</s:if> disabled="disabled"/>可以</label>
						<label><input type="radio" name="user.auth_again" value="1" 
							<s:if test="%{user.auth_again == 1}">checked="checked"</s:if> disabled="disabled"/>不可以</label>
					</td>
					<th>所在区域</th>
					<td>
						<input value="${user.area_name}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
					</td>
				</tr>
				<tr>
					<th><font>*</font>手&nbsp;&nbsp;机&nbsp;&nbsp;号</th>
					<td><input type="text" name="user.cellphone_no" id="cellphone_no" value="${user.cellphone_no}" style="width: 152px;"/></td>
					<th>担任职务</th>
					<td>
						<input value="${user.pos_name}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/>
					</td>
				</tr>
				<tr>
					<th>电子邮箱</th>
					<td><input value="${user.email}" class="unenterTextbox" readonly="readonly"  style="width: 152px;"/></td>
					<th>直接上级</th>
					<td>
						${user.superior_name}<s:if test="%{user.superior_org_path !=null}">(${user.superior_org_path})</s:if>
					</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">拥有角色</th>
					<td><div class="autoArea">
							<s:iterator value="%{user.userRoleList}">
								${role_name}<br/>
							</s:iterator>
						</div>
					</td>
					<th style="vertical-align: middle;">直接下级</th>
					<td><div class="autoArea">
							<s:iterator value="%{user.userList}">
								${user_name}<s:if test="%{org_path != null}">(${org_path})</s:if><br/>
							</s:iterator>
						</div>
					</td>
				</tr>
				<tr>
					<th>联系地址</th>
					<td colspan="3"><input name="user.address" id="address" value="${user.address}" size="80"/></td>
				</tr>
				<tr>
					<th>备注说明</th>
					<td colspan="3"><input name="user.remark" id="remark" value="${user.remark}" size="80"/></td>
				</tr>
		</table>
	</div>
	<div class="btns">
		<span class="btn"><input type="submit" id="submitBtn" value="提交" /></span>
		<!-- 
		<span class="btn"><input type="button" id="cancelBtn" value="返回" onclick="javascript:window.history.back()"/></span>
		 -->
		<input type="hidden" name="user.user_id" value="${user.user_id}"/>
	</div>
</form>
