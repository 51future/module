package com.topcheer.exam;

public class ArrayExam {
	
	/**
	 * 检索出某元素的位置
	 * @param ints 数组
	 * @param value 元素值
	 * @return 所在位置，没找到返回-1 　
	 */
	public Integer selectInt(Integer[] ints , int value){
		for(int i=0;i<ints.length;i++){
			if(ints[i] == value){
				return i;
			}
		}
		return -1;
	}
	
	/**
	 * 插入新元素到指的定位置
	 * @param ints 数组
	 * @param values 插入的值
	 * @param index 指定的位置
	 * @return
	 */
	public Integer[] insertInt(Integer[] ints, Integer[] values,int index){
		//扩数组长度,(java不能动态改变数组的长度,这里指定一个临时数组来实现)
		Integer[] tempInts = new Integer[ints.length+values.length];
		for(int i=0,j=i;i<ints.length;i++){
			if(i == index){//将values中的多个值放到临时数组中
				for(int k=0;k<values.length;k++){
					tempInts[j] = values[k];
					j++;
				}
			}
			//将数组ints的值放到临时数组中
			tempInts[j] = ints[i];
			j++;
		}
		return tempInts;
	}
	
	/**
	 * 删除指定位置的元素
	 * @param ints 数组
	 * @param index 位置
	 * @return
	 */
	public Integer[] delectInt(Integer[] ints, int index){
		Integer[] tempInts = new Integer[ints.length-1];
		for(int i=0,j=i;i<ints.length;i++){
			if(i != index){
				tempInts[j] = ints[i];
				j++;
			}
		}
		return tempInts;
	}
	
	/**
	 * 打印显示数组的值
	 * @param ints 数组
	 */
	public void printlnArray(Integer[] ints){
		String resultStr = "";
		for (Integer integer : ints) {
			resultStr += integer+";";
		}
		System.out.print("结果为:"+resultStr);
	}
	
	public static void main(String[] args) {
		Integer[] ints = {0,1,2,3,4,5};
		Integer[] values = {6,7,8,9};
		
		ArrayExam arrayExam = new ArrayExam();
		//检索出元素值为3所在的位置，结果为：3 
		System.out.println(arrayExam.selectInt(ints, 3));
		//插入新元素到指的定位置3处，结果为：0;1;2;6;7;8;9;3;4;5;
		arrayExam.printlnArray(arrayExam.insertInt(ints, values,3));
		//删除指定位置3上的元素，结果为:0;1;2;4;5;
		arrayExam.printlnArray(arrayExam.delectInt(ints, 3));
	}
}
