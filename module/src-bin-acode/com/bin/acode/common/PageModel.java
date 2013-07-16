package com.bin.acode.common;

import java.util.List;


/**
 * 
 * @company Jinxin Computer Corp.
 * @author LXD
 * @email 247428412@qq.com
 * @description 分页
 * @date 2012-7-13
 */
public class PageModel<E extends Entity> {
	public static final String PAGE_SIZE = "pageSize";
	public static final String PAGE_NO = "pageNo";
	
	protected List<E> list;  //结果集
	
	protected Integer totalRecords; //查询记录数
	
	protected Integer pageSize = 10;  //每页多少条数据
	
	protected Integer pageNo = 1;  //第几页
	
	protected String pageHtml; //页面分页HTML 
	
	protected String pageType = "Y" ;//分页类型 Y 带count  N不带count分页
	
	/**
	 * 类型: HTML标签
	 * return ： 返回页面需要的HTML格式字符串
	 * 字段名: pageHtml
	 */
	public String getPageHtml() {
		if (pageType.equals("Y")) {
			if (this.getTotalPages() > 1) {
				return "<input type='submit' value='首页' " +
						"onclick=\"javascript:document.getElementById('pageNo').value=" + this.getTopPageNo() + ";\" /> "
						
						+ "<input type='text' size='1' name='pm.pageNo' id='pageNo' value='" + this.pageNo + "' " +
								"title='跳转到第几页' /> "
						
						+ "<input type='text' size='1' name='pm.pageSize' id='pageSize' value='" + this.pageSize + "' " +
								"title='每页显示记录条数'  /> "
						
						+"<input type='submit' value='上一页' " +
						"onclick=\"javascript:document.getElementById('pageNo').value=" + this.getPreviousPageNo() + ";\"/>"
						
						+"<input type='submit' value='下一页' " +
						"onclick=\"javascript:document.getElementById('pageNo').value=" + this.getNextPageNo() + ";\" /> "
						
						+ "<input type='submit' value='尾页' " +
						"onclick=\"javascript:document.getElementById('pageNo').value=" + this.getTotalPages() + ";\" /> "
						
						+ " 当前第 " + this.pageNo
						+ " 页   共 " + this.getTotalPages() + " 页 ";
			} else {
				return "<font color=#CCCCCC>首页</font> "
						+ "<font color=#CCCCCC>下一页</font> "
						+ "<font color=#CCCCCC>上一页</font> "
						+ "<font color=#CCCCCC>尾页</font>"
						+ "<font color=#CCCCCC>  当前第 " + this.getTotalPages() + " 页  共 "
						+ this.getTotalPages() + " 页</font>";
			}
		} else {
			return "<input type='text' size='1' name='pm.pageNo' id='pageNo' value='" + this.pageNo + "'  /> "
					+ "<input type='text' size='1' name='pm.pageSize' id='pageSize' value='" + this.pageSize + "'  /> "
					+ "<input type='submit' value='上一页' " + "onclick=\"javascript:document.getElementById('pageNo').value=" + this.getPreviousPageNo() + ";\" /> "
					+ "<input type='submit' value='下一页' " + "onclick=\"javascript:document.getElementById('pageNo').value=" + this.getNextPageNo() + ";\" /> ";
		}
		
	}

	/**
	 * 类型: String
	 * 字段名: pageHtml
	 */
	public void setPageHtml(String pageHtml) {
		this.pageHtml = pageHtml;
	}
	
	/**
	 * 总页数
	 * @return
	 */
	public Integer getTotalPages() {
		return (totalRecords + pageSize - 1) / pageSize;
	}
	
	/**
	 * 取得首页
	 * @return
	 */
	public Integer getTopPageNo() {
		return 1;
	}
	
	/**
	 * 上一页
	 * @return
	 */
	public Integer getPreviousPageNo() {
		if (pageNo <= 1) {
			return 1;
		}
		return pageNo - 1;
	}
	
	/**
	 * 下一页
	 * @return
	 */
	public Integer getNextPageNo() {
		if (pageNo >= getBottomPageNo()) {
			return getBottomPageNo();
		}
		return pageNo + 1;	
	}
	
	/**
	 * 取得尾页
	 * @return
	 */
	public Integer getBottomPageNo() {
		return getTotalPages();
	}
	
	
	public List<E> getList() {
		return list;
	}

	public void setList(List<E> list) {
		this.list = list;
	}

	public Integer getTotalRecords() {
		return totalRecords;
	}

	public void setTotalRecords(Integer totalRecords) {
		this.totalRecords = totalRecords;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	/**
	 * 类型: String
	 * 字段名: pageType
	 */
	public String getPageType() {
		return pageType;
	}

	/**
	 * 类型: String
	 * 字段名: pageType
	 */
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	/**
	 * 类型: Integer
	 * 字段名: pageSize
	 */
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 类型: Integer
	 * 字段名: pageNo
	 */
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
}
