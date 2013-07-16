package com.bin.acode.common;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service抽象类，具体的业务类直接继承该抽象类
 * @company Jinxin Computer Corp.
 * @author Chenbing
 * @email wwwchenbing@gmail.com
 * @description 
 * @date 2012-7-20
 */
public abstract class AbstractService<T extends Entity> implements IService<T> {
	

	protected IMapper<T> mapper;
	
	/** 
	  * description 添加方法
	  */
	@Override
	public void insert(T t) throws Exception {
		mapper.insert(t);		
	}

	/** 
	  * description 删除方法
	  */
	@Override
	public void delete(T t) throws Exception {
		mapper.delete(t);
	}

	/** 
	  * description 修改方法
	  */
	@Override
	public void update(T t) throws Exception {
		mapper.update(t);
	}
	
	/** 
	  * description 通过id查询
	  */
	@Override
	public T findById(Integer id) throws Exception {
		return mapper.findById(id);
	}

	/**
	 * 按条件查询
	 */
	@Override
	public List<T> find(T t) throws Exception{
		return mapper.findByEntity(t);
	}
	
	/**
	 * 按条件查询
	 * @param map Map<String, Object> 查询条件
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<T> find(Map<String, Object> map) throws Exception{
		return mapper.findByMap(map);
	}

	@Override
	public PageModel<T> findOnPage(T t, PageModel<T> pm) throws Exception {
		if(t == null){
			throw new Exception("实体查询条件对象不能为NULL，请检查Action中的查询条件对象是否初始化！");
		}
		
		if(pm == null){
			pm = new PageModel<T>();
		}
		
		//查询数据记录总数
		Integer count = mapper.findByEntityOnPageCount(t);
		pm.setTotalRecords(count);
		
		if(pm.getPageNo() > pm.getTotalPages()){
			pm.setPageNo(pm.getBottomPageNo());
		}
		
		if(pm.getPageNo() < 1){
			pm.setPageNo(1);
		}
		
		t.setPageNo(pm.getPageNo());
		t.setPageSize(pm.getPageSize());
		
		//查询数据列表
		List<T> list = mapper.findByEntityOnPage(t);
		pm.setList(list);
		
		return pm;
	}

	@Override
	public PageModel<T> findOnPage(Map<String, Object> map, PageModel<T> pm) throws Exception {
		if(pm == null){
			pm = new PageModel<T>();
		}
		
		if(map == null){
			map = new HashMap<String, Object>();
		}
		
		//查询数据记录总数
		Integer count = mapper.findByMapOnPageCount(map);
		pm.setTotalRecords(count);
		
		if(pm.getPageNo() > pm.getTotalPages()){
			pm.setPageNo(pm.getBottomPageNo());
		}
		
		if(pm.getPageNo() < 1){
			pm.setPageNo(1);
		}
		
		//查询数据列表
		map.put(PageModel.PAGE_NO, pm.getPageNo());
		map.put(PageModel.PAGE_SIZE, pm.getPageSize());
		List<T> list = mapper.findByMapOnPage(map);
		pm.setList(list);
		
		return pm;
	}

	/**
	 * 获取下一个ID
	 */
	@Override
	public Integer getNextId() throws Exception {
		return mapper.getNextId();
	}
}