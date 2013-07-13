package com.jinxinol.core.custom.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class TestTag extends TagSupport {
	private static final long serialVersionUID = 3506298036736635944L;

	private String name;//属性

	@Override
	public int doStartTag() throws JspException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.println("<h4>开始执行doStartTag()......</h4>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY; 
	}

	@Override
	public int doEndTag() throws JspException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.print("<h4>开始执行doEndTag()......</h4>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	//------------------------------------------------getter/setter------------------------------------------------------------//

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
