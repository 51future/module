
FUNC = function(c){
	this.basePath = c.basePath;
	
	this.loadJQuery = function(){
		window.jQuery || document.write('<script src="'+this.basePath+'script/jQuery/jquery-min.js"><\/script>');
	};
	
	//获取客户端当前时间
	this.getCurrentTime = function(){
			return (new Date()).getTime();
		};
		
	//字符串为空判断
	this.isEmpty = function(str){
			if(str == null || str == undefined || str.length == 0){
				return true;
			}
			return false;
		};
		
	//判断数组是否包含了指定的元素
	this.contains =	function(arr, ele){
			var result = false;
			for(var i=0; i<arr.length; i++){
				if(arr[i] == ele){
					result = true;
					break;
				}
			}
			return result;
		};
		
	//去左空格
	this.ltrim = function(str){  
			if(isEmpty(str))return str;
			return str.replace(/^\s*/, "");  
		};  
		
	//去右空格
	this.rtrim = function(str){  
			if(isEmpty(str))return str;
			return str.replace(/\s*$/, "");  
		};
		
	//去掉左右空格
	this.trim = function(str){
			if(isEmpty(str))return str;
			return rtrim(ltrim(str));
		};
		
	//判断指定年份是否为闰年
	this.isLeapYear = function(year){
			return !!((year & 3) == 0 && (year % 100 || (year % 400 == 0 && year)));
		};
		
	//获取指定月份的天数
	this.daysOfMonth = function(year, month){
			if(month == 1 || month==3 || month==5 ||month==7 ||month==8 ||month==10 ||month==12){
				return 31;
			}
			if(month == 4 || month==6 || month==9 ||month==11){
				return 30;
			}
			if(month == 2 && isLeapYear(year)){
				return 29;
			}
			if(month == 2 && !isLeapYear(year)){
				return 28;
			}
			return 0;
		};
		
	//页面返回
	this.pageBack = function(){
			window.history.back();
		};
		
	//初始化数据表格样式	  
	this.initTableGrid = function(tab_id){
			var Ptr=document.getElementById(tab_id).getElementsByTagName("tr");
			for (var i=1; i<Ptr.length+1; i++){ 
				Ptr[i-1].style.backgroundColor = (i%2>0)?"#fff":"#eef2ea"; 
			}
			for(var i=0; i<Ptr.length; i++) {
				Ptr[i].onmouseover=function(){
					this.tmpClass=this.className;
					this.style.backgroundColor = "#e3f8fc";
				};
				Ptr[i].onmouseout=function(){
					for (i=1;i<Ptr.length+1;i++) { 
						Ptr[i-1].style.backgroundColor = (i%2>0)?"#fff":"#eef2ea"; 
					}
				};
			}
		};
		
	//弹出窗口
	this.openModalWindow = function(url, opener,width_,height_){
			var w = window.screen.width;
			var h = window.screen.height;
			if(width_ == undefined)width_ = w;
			if(height_ == undefined)height_ = h;
			return showModalDialog(url, opener, 'dialogWidth:'+width_+'px; dialogHeight:'+height_+'px; center:yes; help:no; resizable:yes; status:no;');
		};
	//获得窗口的大小
	this.getPageSize =	function() {
			var mask = {};
			if (document.documentElement && document.documentElement.clientHeight) {
				var doc = document.documentElement;
				mask.maskWidth = (doc.clientWidth > doc.scrollWidth) ? doc.clientWidth - 1: doc.scrollWidth;
				mask.maskHeight = (doc.clientHeight > doc.scrollHeight) ? doc.clientHeight: doc.scrollHeight;
			} else {
				var doc = document.body;
				mask.maskWidth = (window.innerWidth > doc.scrollWidth) ? window.innerWidth: doc.scrollWidth;
				mask.maskHeight = (window.innerHeight > doc.scrollHeight) ? window.innerHeight: doc.scrollHeight;
			}
			return mask;
		};
		
	//人民币金额转大写
	this.toRMB = function(num) {
			var capUnit = [ '万', '亿', '万', '元', '' ];
			var capDigit = {2 : [ '角', '分', '' ],4 : [ '仟', '佰', '拾', '' ]};
			var capNum = [ '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' ];
			var sign ='';
			if(isNaN(num))return num;
			if(Number(num)<0){sign = '负';num = Math.abs(num);}
			if(num ==0) return "零元";
			if (((num.toString()).indexOf('.') > 16) || (isNaN(num)))return num;
			num = ((Math.round(num * 100)).toString()).split('.');
			num = (num[0]).substring(0, (num[0]).length - 2)+ '.'+ (num[0]).substring((num[0]).length - 2,(num[0]).length);
			num = ((Math.pow(10, 19 - num.length)).toString()).substring(1)+ num;
			var rmb_str='', j=0, nodeNum, k, subret, len, subChr, CurChr = [];
			for (var i = 0; i < 5; i++, j = i * 4 + Math.floor(i / 4)) {
				nodeNum = num.substring(j, j + 4);
				for (k = 0, subret = '', len = nodeNum.length; ((k < len) && (parseInt(nodeNum.substring(k), 10) != 0)); k++) {
					CurChr[k % 2] = capNum[nodeNum.charAt(k)]+ ((nodeNum.charAt(k) == 0) ? '': capDigit[len][k]);
					if (!((CurChr[0] == CurChr[1]) && (CurChr[0] == capNum[0])))
						if (!((CurChr[k % 2] == capNum[0]) && (subret == '') && (rmb_str == '')))
							subret += CurChr[k % 2];
				}
				subChr = subret + ((subret == '') ? '' : capUnit[i]);
				if (!((subChr == capNum[0]) && (rmb_str == ''))) rmb_str += subChr;
			}
			return (rmb_str == '') ? sign+capNum[0] + capUnit[3] : sign+rmb_str;
		};
		
	//获得顶层对象
	this.getTop = function (){
			var fn = arguments.callee,w;
			if(!fn.t){
				try{w = window; 
					fn.t = w!=parent? (parent.getTop? parent.getTop() : parent.parent.getTop()) : w;
				}catch(e){
					fn.t = w;
				}
			}
			return fn.t;
		};
		
	//cookie对象
	this.Cookie = { 
			g : function(k) {return ((new RegExp(["(?:; )?",k,"=([^;]*);?"].join(""))).test(document.cookie)&&RegExp["$1"])||"";},
			s : function(k,v,t,d) {document.cookie = [k,"=",v, t&&t["toUTCString"]?';expires='+t.toUTCString():"",";path=/;domain=",d||".module.bin.com"].join("");}
		};
	
	this.CSSCoder = {//css代码整理器
	        format: function (css) {//格式化css代码
	        	css = css.replace(/\s*([\{\}\:\;\,])\s*/g, "$1");
	        	css = css.replace(/;\s*;/g, ";"); //清除连续分号
	        	css = css.replace(/\,[\s\.\#\d]*{/g, "{");
	        	css = css.replace(/([^\s])\{([^\s])/g, "$1 {\n\t$2");
	        	css = css.replace(/([^\s])\}([^\n]*)/g, "$1\n}\n$2");
	        	css = css.replace(/([^\s]);([^\s\}])/g, "$1;\n\t$2");
	            return css;
	        },
	        pack: function (css) {//压缩css代码
	        	css = css.replace(/\/\*(.|\n)*?\*\//g, ""); //删除注释
	        	css = css.replace(/\s*([\{\}\:\;\,])\s*/g, "$1");
	        	css = css.replace(/\,[\s\.\#\d]*\{/g, "{"); //容错处理
	        	css = css.replace(/;\s*;/g, ";"); //清除连续分号
	        	css = css.match(/^\s*(\S+(\s+\S+)*)\s*$/); //去掉首尾空白
	            return (css == null) ? "" : css[1];
	        }
	    };

	
	//抖动窗口
	this.shakeWin = function(c){
		//c = {id:抖动那个对象,isWin:是否抖动整个窗口}
		var t=0 , z=3 , del=function(){clearInterval(shakeWin.ID); return shakeWin;};
		del().ID=setInterval(function(){
			var i = t/180*Math.PI , x = Math.sin(i)*z , y = Math.cos(i)*z , s = c.ID.style;
			c.isWin? window.moveBy(x,y) : (s.top=x+'px',s.left=y+'px');
			if((t+=90) > 1080) del();
		},30);
	};

	
	
};











