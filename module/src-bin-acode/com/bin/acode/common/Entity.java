package com.bin.acode.common;

import java.io.Serializable;

/**
 * 实体抽象类
 * 
 * @company Jinxin Computer Corp.
 * @author Chenbing
 * @email wwwchenbing@gmail.com
 * @description
 * @date 2012-7-20
 */
public abstract class Entity implements Serializable {

	private static final long serialVersionUID = -3618055865507347329L;

	protected Integer pageNo = 1;
	protected Integer pageSize = 10;

	public Entity() {
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}
