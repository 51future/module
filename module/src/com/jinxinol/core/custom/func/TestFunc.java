package com.jinxinol.core.custom.func;

public class TestFunc {
	
	public static String substring(String s, int length) throws Exception {
		return s==null?"":s.substring(0,s.length()<length?s.length():length);
	}
}
