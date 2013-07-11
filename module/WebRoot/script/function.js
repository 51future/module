
//初始化数据表格样式	  
function initTableGrid(tab_id){
	Ptr=document.getElementById(tab_id).getElementsByTagName("tr");
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
}

/*******************wbin****util******start**********************************/
//人民币金额转大写
function toRMB(num) {
	var capUnit = [ '万', '亿', '万', '元', '' ];
	var capDigit = {
		2 : [ '角', '分', '' ],
		4 : [ '仟', '佰', '拾', '' ]
	};
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
}

//弹出窗口
function openModalWindow(url, opener,width_,height_){
	var w = window.screen.width;
	var h = window.screen.height;
	if(width_ == undefined)width_ = w;
	if(height_ == undefined)height_ = h;
	return showModalDialog(url, opener, 'dialogWidth:'+width_+'px; dialogHeight:'+height_+'px; center:yes; help:no; resizable:yes; status:no;');
}
/*******************wbin****util******end************************************/


//获得窗口的大小
function getPageSize() {
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
}

//获取客户端当前时间
function getCurrentTime(){
	return (new Date()).getTime();
}

//字符串为空判断
function isEmpty(str){
	if(str == null || str == undefined || str.length == 0){
		return true;
	}
	return false;
}

//判断指定年份是否为闰年
function isLeapYear(year){
	return !!((year & 3) == 0 && (year % 100 || (year % 400 == 0 && year)));
}

//获取指定月份的天数
function daysOfMonth(year, month){
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
}

//判断数组是否包含了指定的元素
function contains(arr, ele){
	var result = false;
	for(var i=0; i<arr.length; i++){
		if(arr[i] == ele){
			result = true;
			break;
		}
	}
	return result;
}

//去左空格
function ltrim(s){  
	if(isEmpty(s))return s;
	return s.replace(/^\s*/, "");  
}  

//去右空格
function rtrim(s){  
	if(isEmpty(s))return s;
	return s.replace(/\s*$/, "");  
}

//去掉左右空格
function trim(s){
	if(isEmpty(s))return s;
    return rtrim(ltrim(s));
}

//页面返回
function pageBack(){
	window.history.back();
}




