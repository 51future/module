package com.bin.acode.utils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Collections;

/**
 * 多叉树
 */
public class BinTree {
	private Map<String,Node> nodeMap = new HashMap<String,Node>();
	private Node root = null;
	
	//添加节点
	public Map<String,Node> addNode(Node node){
		nodeMap.put(node.id, node);
		return nodeMap;
	}
	
	//转成tree
	public void toTree(){
		Set<Entry<String, Node>> entrySet = nodeMap.entrySet();
		for (Iterator<Entry<String, Node>> it = entrySet.iterator(); it.hasNext();) {
			Node node = it.next().getValue();
			if (nodeMap.get(node.pid) ==null || node.pid == null || "".equals(node.pid) ) {
				root = node;
			}else{
				nodeMap.get(node.pid).addChildren(node);
			}
		}
	}
	
	//转成list
	public List<Node> toList(){
		return root.toList();
	}
	
	//转成有序list
	public List<Node> toSortList(){
		if(root !=null){
			root.sortChildren();
		}
		return toList();
	}
	
	//转成自定义顺序的list
	public List<Node> toSortList(Comparator<Node> comparator){
		if(root !=null){
			root.sortChildren(comparator);
		}
		return toList();
	}
	
	@Override
	public String toString() {
		return root.toString();
	}


	/**
	 * 节点类
	 */
	static class Node {
		/**
		 * 节点编号
		 */
		private String id;
		/**
		 * 父节点编号
		 */
		private String pid;
		/**
		 * 节点内容
		 */
		private String text;
		
		/**
		 * 节点其他对象
		 */
		private Object obj;
		
		/**
		 * 是否为叶子
		 */
		private boolean leaf = false;
		
		/**
		 * 孩子节点列表
		 */
		private Children children = new Children();
		
		
		public Node() {
			// TODO Auto-generated constructor stub
		}
		
		// 添加孩子节点
		public void addChildren(Node node) {
			children.addChildren(node);
		}
		
		// 获取孩子节点
		public List<Node> getChildren() {
			return children.getChildren();
		}
		
		// 兄弟节点排序
		public void sortChildren() {
			if (children != null && children.getChildrenSize() != 0) {
				children.sortChildren();
			}
		}
		
		// 兄弟节点排序
		public void sortChildren(Comparator<Node> comparator) {
			if (children != null && children.getChildrenSize() != 0) {
				children.sortChildren(comparator);
			}
		}
		
		// 先序遍历，转成list
		public List<Node> toList() {
			List<Node> nodeList = new ArrayList<Node>();
			toList(nodeList);
			return nodeList;
		}
		private void toList(List<Node> nodeList) {
			nodeList.add(this);
			if (children != null && children.getChildrenSize() != 0) {
				children.toList(nodeList);
			}else{
				leaf = true;
			}
		}
		
		// 先序遍历，拼接JSON字符串
		public String toString() {
			String result = "{" + "id : '" + id + "'" + ", text : '" + text + "'";
			if (children != null && children.getChildrenSize() != 0) {
				result += ", children : " + children.toString();
			} else {
				leaf = true;
				result += ", leaf : " + leaf;
			}
			return result + "}";
		}

		
		
		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getPid() {
			return pid;
		}

		public void setPid(String pid) {
			this.pid = pid;
		}

		public String getText() {
			return text;
		}

		public void setText(String text) {
			this.text = text;
		}

		public Object getObj() {
			return obj;
		}

		public void setObj(Object obj) {
			this.obj = obj;
		}

		public boolean isLeaf() {
			return leaf;
		}

		public void setLeaf(boolean leaf) {
			this.leaf = leaf;
		}

	}

	/**
	 * 孩子列表类
	 */
	private static class Children {
		public List<Node> list = new ArrayList<Node>();
		
		public Children() {
			// TODO Auto-generated constructor stub
		}
		
		// 添加孩子节点
		public void addChildren(Node node) {
			list.add(node);
		}
		
		// 获取孩子节点
		public List<Node> getChildren() {
			return list;
		}
		
		// 孩子节点个数
		public int getChildrenSize() {
			return list.size();
		}
		
		// 孩子节点排序
		public void sortChildren() {
			// 对本层节点进行排序,这里 使用ID比较器
			Collections.sort(list, new Comparator<Node>(){
				@Override
				public int compare(Node o1, Node o2) {
					int v1 = Integer.parseInt(o1.id);
					int v2 = Integer.parseInt(o2.id);
					return (v1 < v2 ? -1 : (v1 == v2 ? 0 : 1));
				}
			});
			// 对每个节点的下一层节点进行排序
			for (Iterator<Node> it= list.iterator(); it.hasNext();) {
				it.next().sortChildren();
			}
		}
		
		// 孩子节点排序，自定义比较器
		public void sortChildren(Comparator<Node> comparator) {
			// 对本层节点进行排序
			Collections.sort(list, comparator);
			// 对每个节点的下一层节点进行排序
			for (Iterator<Node> it = list.iterator(); it.hasNext();) {
				it.next().sortChildren(comparator);
			}
		}
		
		// 转孩子节点的为list
		public void toList(List<Node> nodeList) {
			for (Node node : list) {
				node.toList(nodeList);
			}
		}
		
		// 拼接孩子节点的JSON字符串
		public String toString() {
			String result = "[";
			for (Iterator<Node> it = list.iterator(); it.hasNext();) {
				result += it.next().toString();
				result += ",";
			}
			result = result.substring(0, result.length() - 1);
			result += "]";
			return result;
		}
		
	}

	
	// 构造无序的结果集列表，实际应用中，该数据应该从数据库中查询获得；
	public List<Map<String,String>> getVirtualResult() {
		List<Map<String,String>> dataList = new ArrayList<Map<String,String>>();
		
		HashMap<String,String> dataRecord1 = new HashMap<String,String>();
		dataRecord1.put("id", "112000");
		dataRecord1.put("text", "廊坊银行解放道支行");
		dataRecord1.put("parentId", "110000");
		
		HashMap<String,String> dataRecord2 = new HashMap<String,String>();
		dataRecord2.put("id", "112200");
		dataRecord2.put("text", "廊坊银行三大街支行");
		dataRecord2.put("parentId", "112000");
		
		HashMap<String,String> dataRecord3 = new HashMap<String,String>();
		dataRecord3.put("id", "112100");
		dataRecord3.put("text", "廊坊银行广阳道支行");
		dataRecord3.put("parentId", "112000");
		
		HashMap<String,String> dataRecord4 = new HashMap<String,String>();
		dataRecord4.put("id", "113000");
		dataRecord4.put("text", "廊坊银行开发区支行");
		dataRecord4.put("parentId", "110000");
		
		HashMap<String,String> dataRecord5 = new HashMap<String,String>();
		dataRecord5.put("id", "100000");
		dataRecord5.put("text", "廊坊银行总行");
		dataRecord5.put("parentId", "");
		
		HashMap<String,String> dataRecord6 = new HashMap<String,String>();
		dataRecord6.put("id", "110000");
		dataRecord6.put("text", "廊坊分行");
		dataRecord6.put("parentId", "100000");
		
		HashMap<String,String> dataRecord7 = new HashMap<String,String>();
		dataRecord7.put("id", "111000");
		dataRecord7.put("text", "廊坊银行金光道支行");
		dataRecord7.put("parentId", "110000");
		
		dataList.add(dataRecord2);
		dataList.add(dataRecord4);
		dataList.add(dataRecord1);
		dataList.add(dataRecord3);
		dataList.add(dataRecord6);
		dataList.add(dataRecord5);
		dataList.add(dataRecord7);
		return dataList;
	}
	
	public static void main(String[] args) {
		BinTree bintree = new BinTree();
		
		// 读取层次数据结果集列表
		List<Map<String,String>> dataList = bintree.getVirtualResult();
		for (Iterator<Map<String, String>> it = dataList.iterator(); it.hasNext();) {
			Map<String,String> dataRecord = it.next();
			Node node = new BinTree.Node();
			node.id = (String) dataRecord.get("id");
			node.text = (String) dataRecord.get("text");
			node.pid = (String) dataRecord.get("parentId");
			bintree.addNode(node);
		}
		bintree.toTree();
		
		// 输出无序的树形菜单的JSON字符串
		System.out.println(bintree.toString());
		
		// 对多叉树进行横向排序
		//bintree.root.sortChildren();
		// 输出有序的树形菜单的JSON字符串
		System.out.println(bintree.toString());
		
		List<Node> nodeList = bintree.toSortList();
		for (Node node : nodeList) {
			System.out.println(node.text);
		}
		
	}
}
