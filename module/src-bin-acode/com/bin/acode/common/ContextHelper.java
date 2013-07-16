package com.bin.acode.common;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.context.ServletContextAware;

import com.jinxinol.basic.system.domain.SysUser;
import com.opensymphony.xwork2.ActionContext;

/**
 * 上下文工具类
 * @author Chenbing(Jack.Chen)
 * @version 1.0
 * @createTime 2012 11:41:35 AM
 * @Email wwwchenbing@gmail.com
 */
public final class ContextHelper implements ApplicationContextAware,ServletContextAware{
	/**
	 * 当前应用内部Bean所在的application上下文
	 */
	public static ApplicationContext applicationContext;
	
	/**
	 * 当前应用所在的servlet上下文
	 */
	public static ServletContext servletContext;
	
	
	public ContextHelper(){}
	
	
	/**
	 * 返回当前登录用户
	 * @return
	 */
	public static SysUser getCurrentUser(){
		return (SysUser)getSession().getAttribute(CommonConstants.CURRENT_USER);
	}
	
	/**
	 * 返回SessionMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> getSessionMap(){
		return ActionContext.getContext().getSession();
	}
	
	/**
	 * 返回HttpServletRequest
	 * @return
	 */
	public static HttpServletRequest getRequest(){
		return ServletActionContext.getRequest();
	}
	
	/**
	 * 返回HttpServletResponse
	 * @return
	 */
	public static HttpServletResponse getResponse(){
		return ServletActionContext.getResponse();
	}
	
	/**
	 * 返回HttpServletResponse
	 * @return
	 */
	public static HttpSession getSession(){
		return ServletActionContext.getRequest().getSession(true);
	}
	
	/**
	 * 返回ServletContext
	 * @return
	 */
	public static ServletContext getServletContext(){
		return ContextHelper.servletContext;
	}
	
	/**
	 * 返回ApplicationContext
	 * @return
	 */
	public static ApplicationContext getApplicationContext(){
		return ContextHelper.applicationContext;
	}
	
	/**
	 * <p>获得当前ApplicationContext内部定义的Bean实例。</p>
	 *
	 * @param beanName Bean的引用名称。
	 * @return Object Bean实例。
	 */
	public static Object getBean(String beanName) {
		return ContextHelper.applicationContext.getBean(beanName);
	}

	/**
	 * <p>获得指定ApplicationContext中定义的Bean实例。</p>
	 *
	 * @param ctx ApplicationContext对象实例。
	 * @param beanName Bean的引用名称。
	 * @return Object Bean实例。
	 */
	public static Object getBean(ApplicationContext ctx, String beanName) {
		try {
			return ctx.getBean(beanName);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 返回日志器
	 * @param clazz
	 * @return
	 */
	public static Log getLogger(Class<?> clazz){
		return LogFactory.getLog(clazz);
	}

	/**
	 * <p>设置ApplicationContext。</p>
	 */
	@Override   
	public void setApplicationContext(ApplicationContext appContext) throws BeansException {
		ContextHelper.applicationContext = appContext;
	}
	
	
	/**
	 * <p>设置ServletContext。</p>
	 */
	@Override
	public void setServletContext(ServletContext servletContext) {
		ContextHelper.servletContext = servletContext;	
	}
}
