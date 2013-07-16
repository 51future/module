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
public interface IMapper<T extends Entity> {
	/**
	 * 添加
	 * @return 
	 * */
	Integer insert(T entity) throws Exception;
	
	/**
	 * 删除
	 * */
	void delete(T entity) throws Exception;

	/**
	 * 修改
	 * */
	void update(T entity) throws Exception;
	
	/**
	 * 通过id查询
	 * */
	T findById(Integer id) throws Exception;
	
	
	/**
	 * 按条件查询
	 * @param t T 查询条件
	 * @return 返回查询结果列表
	 * @throws Exception
	 */
	List<T> findByEntity(T t) throws Exception;
	
	/**
	 * 按条件分页查询
	 * @param t 实体查询条件
	 * @return 返回查询结果列表
	 * @throws Exception
	 */
	List<T> findByEntityOnPage(T t)throws Exception;
	
	/**
	 * 统计查询结果总数
	 * @param t 实体查询条件
	 * @return 返回查询结果列表
	 * @throws Exception
	 */
	Integer findByEntityOnPageCount(T t)throws Exception;
	
	/**
	 * 按条件查询
	 * @param map Map<String, Object> 查询条件
	 * @return
	 * @throws Exception
	 */
	List<T> findByMap(Map<String, Object> map) throws Exception;
	
	/**
	 * 按条件分页查询
	 * @param map Map<String, Object>查询条件
	 * @return 返回查询结果列表
	 * @throws Exception
	 */
	List<T> findByMapOnPage(Map<String, Object> map)throws Exception;

	/**
	 * 统计查询结果总数
	 * @param map Map<String, Object>查询条件
	 * @return 返回查询结果列表
	 * @throws Exception
	 */
	Integer findByMapOnPageCount(Map<String, Object> map)throws Exception;
	
	/**
	 * 获取下一个ID
	 */
	Integer getNextId()throws Exception;
}