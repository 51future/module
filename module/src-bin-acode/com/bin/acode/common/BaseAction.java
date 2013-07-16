package com.bin.acode.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.jinxinol.basic.system.domain.SysAttachment;
import com.jinxinol.basic.system.domain.SysUser;
import com.jinxinol.core.util.JSONGenerator;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @company Jinxin Computer Corp.
 * @author Chenbing
 * @email wwwchenbing@gmail.com
 * @description 应用系统WEB Action的基类
 * @date 2012-7-12
 */
public abstract class BaseAction extends ActionSupport implements ServletRequestAware,ServletResponseAware {
	private static final long serialVersionUID = -7852462244113057816L;
	/**
	 * 日志器
	 */
	protected static final Log logger = ContextHelper.getLogger(BaseAction.class);
	
	/**
	 *Http请求
	 */
	protected HttpServletRequest request;
	/**
	 * Http相应
	 */
	protected HttpServletResponse response;
	/**
	 * Http会话
	 */
	protected HttpSession session;
	
	/**
	 * 提示信息，用于存放操作结果提示信息、错误原因提示信息等
	 */
	protected String message;
	/**
	 * 返回URL，用于存放返回地址URL（通常情况下在进入异常错误提示页面后，需要提供返回地址）
	 */
	protected String backUrl;
	
	/**
	 * 是否关闭窗口
	 */
	protected boolean closeWindow = false;
	
	/**
	 * 附件信息
	 */
	protected List<SysAttachment> filelist;
	
	/**
	 * <p>用于Ajax请求处理结果</p>
	 * <p>JSON数据对象，用于存放需要以JSON格式返回的数据</p>
	 */
	protected Map<String, Object> jsonObject = new HashMap<String, Object>();
	/**
	 * <p>用于Ajax请求处理结果</p>
	 * <p>常量字段：结果码</p>
	 * <p>调用举例：this.jsonObject.put(RESULT_CODE, SUCCESS);</p>
	 */
	public static final String RESULT_CODE = "resultCode";
	/**
	 * <p>用于Ajax请求处理结果</p>
	 * <p>常量字段：结果消息</p>
	 * <p>调用举例：this.jsonObject.put(RESULT_MSG, "操作失败，请检查输入参数！");</p>
	 */
	public static final String RESULT_MSG = "resultMsg";
	
	protected BaseAction(){
	}
	
	/**
	 * 将jsonObject以JSON格式输出到客户端
	 */
    protected void pushJsonResult() {
    	pushJsonResult(jsonObject);
    }
    
    /**
     * 将指定的对数据对象以JSON格式输出到客户端
     * @param jsonObject
     */
    protected void pushJsonResult(Object jsonObject){
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0L);
        try {
        	response.getWriter().write(JSONGenerator.toJSON(jsonObject));
        	response.flushBuffer();
        } catch (IOException e) {
        	logger.error("Pushing JSON result occure exceptin.", e);
        }
    }

    @Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		this.response.setCharacterEncoding("UTF-8");
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		this.session = request.getSession();
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getBackUrl() {
		return backUrl;
	}

	public void setBackUrl(String backUrl) {
		this.backUrl = backUrl;
	}

	public List<SysAttachment> getFilelist() {
		return filelist;
	}

	public void setFilelist(List<SysAttachment> filelist) {
		this.filelist = filelist;
	}

	public boolean isCloseWindow() {
		return closeWindow;
	}

	public void setCloseWindow(boolean closeWindow) {
		this.closeWindow = closeWindow;
	}
	
	public SysUser getSysUser(){
		return ContextHelper.getCurrentUser();
	}
}
