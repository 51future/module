package com.bin.acode.common;

import java.util.List;
import java.util.Map;


/**
 * 
 * @company Jinxin Computer Corp.
 * @author Chenbing
 * @email wwwchenbing@gmail.com
 * @description 
 * @date 2012-7-20
 */
public interface IService<T extends Entity> {
	
	/** 
	  * description 添加方法
	  * @return void
	  */
	public abstract void insert(T t) throws Exception;

	/** 
	  * description 删除方法
	  * @return void 
	  */
	public abstract void delete(T t) throws Exception;

	/** 
	  * description 修改方法
	  * @return void 
	  */
	public abstract void update(T t) throws Exception;

	/** 
	  * description 通过id查询方法
	  * @return 对象
	  */
	public abstract T findById(Integer id) throws Exception;

	/**
	 * 按条件查询
	 * @param t T 查询条件
	 * @return
	 * @throws Exception
	 */
	public abstract List<T> find(T t) throws Exception;
	
	/**
	 * 按条件分页查询
	 * @param t T 查询条件
	 * @return
	 * @throws Exception
	 */
	public abstract PageModel<T> findOnPage(T t, PageModel<T> pm) throws Exception;
	
	/**
	 * 按条件查询
	 * @param map Map<String, Object> 查询条件
	 * @return
	 * @throws Exception
	 */
	public abstract List<T> find(Map<String, Object> map) throws Exception;
	
	/**
	 * 按条件分页查询
	 * @param map Map<String, Object> 查询条件
	 * @return
	 * @throws Exception
	 */
	public abstract PageModel<T> findOnPage(Map<String, Object> map, PageModel<T> pm) throws Exception;
	
	/**
	 * 获取下一个ID
	 * @return
	 * @throws Exception
	 */
	public Integer getNextId() throws Exception;
}