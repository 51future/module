<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">var basePath = '<%=basePath%>';</script>
<script type="text/javascript" src="<%=basePath%>script/lodop/LodopFuncs.js"></script>
<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
	<embed id="LODOP_EM" TYPE="application/x-print-lodop" width=0 height=0 PLUGINSPAGE="install_lodop32.exe"></embed>
</object> 
<script language="javascript" type="text/javascript"> 
	function MyPreview(strTITLE,strHTML) {	
		var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
		if(strTITLE ==null || ""==strTITLE || strTITLE == undefined)strTITLE = "打印控件Lodop打印输出";
		if(strHTML == null || ""==strHTML || strHTML == undefined)strHTML=document.getElementsByTagName("html")[0].innerHTML;
		LODOP.PRINT_INIT(strTITLE);
		//LODOP.SET_PRINT_PAGESIZE(2, "135mm","230mm","CreateCustomPage");
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strHTML);
		/*
		LODOP.NewPageA();
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strHTML);
		LODOP.SET_PRINT_STYLEA(2,"AngleOfPageInside",-90);
		LODOP.NewPageA();
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strHTML);
		LODOP.SET_PRINT_STYLEA(0,"AngleOfPageInside",90);
		LODOP.NewPageA();
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strHTML);
		LODOP.SET_PRINT_STYLEA(0,"AngleOfPageInside",180);
		*/
		LODOP.PREVIEW();
	};
	
	//导出excel
	function OutToFile(){  
		var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
		LODOP.PRINT_INIT("");  
		LODOP.ADD_PRINT_TABLE(100,20,500,"100%",document.getElementById("div1").innerHTML);  
		LODOP.SAVE_TO_FILE("新文件名.xls");  
	};
</script>
