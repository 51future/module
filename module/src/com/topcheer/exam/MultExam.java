package com.topcheer.exam;

import java.util.ArrayList;
import java.util.List;

public class MultExam {
	private Node header = new Node();//链表头
	private Node end = new Node();//链表尾
	private int size = 0;//链表长度
	
	/**
	 * 检索出某个位置上的元素值
	 * @param multLick 多级链
	 * @param index 某个位置
	 * @return 元素值 　
	 */
	public Object getValue(MultExam multLick, Integer index) {
		int low = 0;
		int high = multLick.getSize() - 1;
		if (index > high) return "out of size";
		int level = 0;// 级
		while (low <= high) {
			int middle = (low + high) / 2;
			// 得到左半部分的中间节点
			Node m_node = getIndexNode(multLick, middle);
			level++;
			multLick.getHeader().getPointers()
					.add(new Pointer(m_node, level, middle));
			m_node.getPointers().add(
					new Pointer(multLick.getEnd(), level, middle));
			if (index == middle) {
				return m_node.getData();
			} else if (index < middle) {// 左半部分
				high = middle - 1;
				level++;
				// 得到左半部分的中间节点
				Node lm_node = getIndexNode(multLick, (low + high) / 2);
				multLick.getHeader().getPointers()
						.add(new Pointer(m_node, level, (low + high) / 2));
				// 左半部分中间节点增加一个指针
				lm_node.getPointers().add(
						new Pointer(m_node, level, (low + high) / 2));
			} else { // 右半部分
				low = middle + 1;
				level++;
				// 得到右半部分的中间节点
				Node rm_node = getIndexNode(multLick, (low + high) / 2);
				m_node.getPointers().add(
						new Pointer(rm_node, level, (low + high) / 2));
				// 右半部分的中间节点增加一个指针
				rm_node.getPointers()
						.add(new Pointer(multLick.getEnd(), level,
								(low + high) / 2));
			}
		}
		return multLick.getHeader().getNext().getData();
	}
	
	/**
	 * 插入新元素到指的定位置
	 * @param link 链表
	 * @param newNode 插入的新值
	 * @param index 指定的位置
	 * @return
	 */
	public MultExam insert(MultExam multLick,Node newNode,int index){
		Node node = multLick.getHeader();
		for(int i=0;i<multLick.getSize();i++){
			if(i == index){
				getIndexNode(multLick,index-1).setNext(newNode);
				newNode.setNext(node);
				newNode.setPointers(new ArrayList<Pointer>());
				multLick.setSize(multLick.getSize()+1);
				break;
			}
			node = node.getNext();
		}
		return multLick;
	}
	
	/**
	 * 删除指定位置上的一个元素
	 * @param link 链表
	 * @param index 指定的位置
	 * @return
	 */
	public MultExam delect(MultExam multLick, int index){
		Node node = multLick.getHeader();
		for(int i=0;i<multLick.getSize();i++){
			if(i == index){
				getIndexNode(multLick,index-1).setNext(node.getNext());
				multLick.setSize(multLick.getSize()-1);
				break;
			}
			node = node.getNext();
		}
		return multLick;
	}
	
	/**
	 * 打印显示链表中的值
	 * @param link 链表
	 */
	public void printlnLink(MultExam link){
		String resultStr = "";
		Node node = link.getHeader().getNext();
		for(int i=0;i<link.getSize();i++){
			resultStr += node.getData()+";";
			node = node.getNext();
		}
		System.out.print("结果为:"+resultStr);
	}
	
	/**
	 *  获取某个位置上的节点
	 */
	private Node getIndexNode(MultExam multLick ,Integer index){
		Node node = multLick.getHeader();
		for(int i=0;i<multLick.getSize();i++){
			if(index ==i){
				return node;
			}
			node = node.getNext();
		}
		return node;
	}
	
	public static void main(String[] args) {
		Node node1 = new Node();
		Node node2 = new Node();
		Node node3 = new Node();
		Node node4 = new Node();
		Node node5 = new Node();
		Node node6 = new Node();
		Node node7 = new Node();
		MultExam multLick = new MultExam();
		multLick.setSize(7);
		multLick.getHeader().setNext(node1);
		multLick.getHeader().setPointers(new ArrayList<Pointer>());
		
		node1.setData(1);
		node1.setNext(node2);
		node1.setPointers(new ArrayList<Pointer>());
		
		node2.setData(2);
		node2.setNext(node3);
		node2.setPointers(new ArrayList<Pointer>());
		
		node3.setData(3);
		node3.setNext(node4);
		node3.setPointers(new ArrayList<Pointer>());
		
		node4.setData(4);
		node4.setNext(node5);
		node4.setPointers(new ArrayList<Pointer>());
		
		node5.setData(5);
		node5.setNext(node6);
		node5.setPointers(new ArrayList<Pointer>());
		
		node6.setData(6);
		node6.setNext(node7);
		node6.setPointers(new ArrayList<Pointer>());
		
		node7.setData(7);
		node7.setNext(multLick.getEnd());
		node7.setPointers(new ArrayList<Pointer>());
		//检索出位置3上的元素值,结果为：3
		System.out.println(multLick.getValue(multLick,3));
		//插入新元素到指的定位置3,结果为：1;2;6;3;4;5;6;7;
		Node newNode = new Node();
		newNode.setData(6);
		multLick.printlnLink(multLick.insert(multLick, newNode,3));
		//删除指定位置3之后的一个元素,结果为:1;2;3;4;5;6;7;  删除了新插入元素值为6
		multLick.printlnLink(multLick.delect(multLick, 3));
		
	}
	
	public Node getHeader() {
		return header;
	}
	public void setHeader(Node header) {
		this.header = header;
	}
	public Node getEnd() {
		return end;
	}
	public void setEnd(Node end) {
		this.end = end;
	}
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}

	/**
	 * 节点
	 * @author wbin
	 */
	private static class Node{
		private Object data;//数据
		private Node next;//下一节点
		private List<Pointer> pointers;//指针
		
		public Node() {
			// TODO Auto-generated constructor stub
		}

		public Object getData() {
			return data;
		}

		public void setData(Object data) {
			this.data = data;
		}

		public Node getNext() {
			return next;
		}

		public void setNext(Node next) {
			this.next = next;
		}

		public List<Pointer> getPointers() {
			return pointers;
		}

		public void setPointers(List<Pointer> pointers) {
			this.pointers = pointers;
		}
	}
	
	/**
	 * 指针
	 * @author wbin
	 */
	private static class Pointer{
		private Node node;//指向的节点
		private Integer level; //级数
		private Integer range;//距离
		
		public Pointer() {
			// TODO Auto-generated constructor stub
		}
		
		public Pointer(Node node,Integer level,Integer range){
			this.node = node;
			this.level = level;
			this.range = range;
		}

		public Node getNode() {
			return node;
		}

		public void setNode(Node node) {
			this.node = node;
		}

		public Integer getLevel() {
			return level;
		}

		public void setLevel(Integer level) {
			this.level = level;
		}

		public Integer getRange() {
			return range;
		}

		public void setRange(Integer range) {
			this.range = range;
		}
	}

}