package com.topcheer.exam;

public class LinkExam {
	private Node header = new Node();//链表头
	private int size = 0;//链表长度
	
	/**
	 * 检索出某元素的位置
	 * @param link 链表
	 * @param value 元素值
	 * @return 所在位置，没找到返回-1 　
	 */
	public Object selectInt(LinkExam link , Object value){
		Node node = link.getHeader();
		for(int i=0;i<link.getSize();i++){
			if(node.getData() == value){
				return i;
			}
			node = node.getNext();
		}
		return -1;
	}

	
	/**
	 * 插入新元素到指的定位置
	 * @param link 链表
	 * @param newNode 插入的新值
	 * @param index 指定的位置
	 * @return
	 */
	public LinkExam insertInt(LinkExam link,Node newNode,int index){
		Node node = link.getHeader();
		for(int i=0;i<link.getSize();i++){
			if(i == index){
				node.getLast().setNext(newNode);
				newNode.setLast(node.getLast());
				newNode.setNext(node);
				node.setLast(newNode);
				link.setSize(link.getSize()+1);
				break;
			}
			node = node.getNext();
		}
		return link;
	}
	
	/**
	 * 删除指定位置上的一个元素
	 * @param link 链表
	 * @param index 指定的位置
	 * @return
	 */
	public LinkExam delectInt(LinkExam link, int index){
		Node node = link.getHeader();
		for(int i=0;i<link.getSize();i++){
			if(i == index){
				Node oldNode = node.getLast();
				oldNode.setNext(node.getNext());
				node.getNext().setLast(oldNode);
				link.setSize(link.getSize()-1);
				break;
			}
			node = node.getNext();
		}
		return link;
	}
	
	/**
	 * 打印显示链表中的值
	 * @param link 链表
	 */
	public void printlnLink(LinkExam link){
		String resultStr = "";
		Node node = link.getHeader();
		for(int i=0;i<link.getSize();i++){
			resultStr += node.getData()+";";
			node = node.getNext();
		}
		System.out.print("结果为:"+resultStr);
	}
	
	public static void main(String[] args) {
		Node node0 = new Node();
		Node node1 = new Node();
		Node node2 = new Node();
		Node node3 = new Node();
		Node node4 = new Node();
		Node node5 = new Node();
		node0.setData(0);
		node0.setNext(node1);
		node1.setData(1);
		node1.setLast(node0);
		node1.setNext(node2);
		node2.setData(2);
		node2.setLast(node1);
		node2.setNext(node3);
		node3.setData(3);
		node3.setLast(node2);
		node3.setNext(node4);
		node4.setData(4);
		node4.setLast(node3);
		node4.setNext(node5);
		node5.setData(5);
		node5.setLast(node4);
		
		LinkExam linkExam = new LinkExam();
		linkExam.setHeader(node0);
		linkExam.setSize(6);
		
		//检索出元素值为3所在的位置，结果为：3 
		System.out.println(linkExam.selectInt(linkExam, 3));
		//插入新元素到指的定位置3,结果为：0;1;2;6;3;4;5;
		Node newNode = new Node();
		newNode.setData(6);
		linkExam.printlnLink(linkExam.insertInt(linkExam, newNode,3));
		//删除指定位置3之后的一个元素,结果为:0;1;2;3;4;5;
		linkExam.printlnLink(linkExam.delectInt(linkExam, 3));
	}

	public Node getHeader() {
		return header;
	}

	public void setHeader(Node header) {
		this.header = header;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}
}

/**
 * 节点
 * @author wbin
 */
class Node{
	private Node last;//上一节点
	private Object data;//数据
	private Node next;//下一节点
	
	public Node() {
		// TODO Auto-generated constructor stub
	}
	
	public Node getLast() {
		return last;
	}

	public void setLast(Node last) {
		this.last = last;
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
	
}
