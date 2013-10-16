function bbimg(o){
	var zoom=parseInt(o.style.zoom, 10)||100;zoom+=event.wheelDelta/12;if (zoom>0) o.style.zoom=zoom+'%';
	return false;
}
function imgzoom(img,maxsize){
	var a=new Image();
	a.src=img.src
	if(a.width > maxsize)
	{
		img.style.width=maxsize;
	}
	else if(a.width >= maxsize)
	{
		img.style.width=Math.round(a.width * Math.floor(maxsize / a.width));
	}
	return false;
}
//图片自动调整的模式，1为按比例调整 ，2 按大小调整。
var resizemode=1
function imgresize(o){
	 if (resizemode==2 || o.onmousewheel){
	 	if(o.width > 500 ){
				o.style.width='500px';
			}
			if(o.height > 800){
				o.style.height='800px';
			}
		}else{
		var parentNode=o.parentNode.parentNode
		if (parentNode){
		if (o.offsetWidth>=parentNode.offsetWidth) o.style.width='98%';
		}else{
		var parentNode=o.parentNode
		if (parentNode){
			if (o.offsetWidth>=parentNode.offsetWidth) o.style.width='98%';
			}
		}
	}
}
//运行代码
function runEx(cod1)  {
	 cod=document.getElementById(cod1)
	  var code=cod.value;
	  if (code!=""){
		  var newwin=window.open('','','');  
		  newwin.opener = null 
		  newwin.document.write(code);  
		  newwin.document.close();
	}
}
//复制代码
function doCopy(ID) { 
	if (document.all){
		 textRange = document.getElementById(ID).createTextRange(); 
		 textRange.execCommand("Copy"); 
	}
	else{
		 //alert("此功能只能在IE上有效");
		 copyToClipboard(document.getElementById(ID).value);
	}
}
//另存为代码
function saveCode(cod1) {
	cod=document.getElementById(cod1)
	var code=cod.value;
	if (code!=""){
        var winname = window.open('', '_blank', 'top=10000');
        winname.document.open('text/html', 'replace');
        winname.document.write(code);
        winname.document.execCommand('saveas','','code.htm');
        winname.close();
	}
}
function copyToClipboard(txt) {
     if(window.clipboardData) {
             window.clipboardData.clearData();
             window.clipboardData.setData("Text", txt);
     } else if(navigator.userAgent.indexOf("Opera") != -1) {
          window.location = txt;
     } else if (window.netscape) {
          try {
               netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
          } catch (e) {
               alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true'");
          }
          var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
          if (!clip)
               return;
          var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
          if (!trans)
               return;
          trans.addDataFlavor('text/unicode');
          var str = new Object();
          var len = new Object();
          var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
          var copytext = txt;
          str.data = copytext;
          trans.setTransferData("text/unicode",str,copytext.length*2);
          var clipid = Components.interfaces.nsIClipboard;
          if (!clip)
               return false;
          clip.setData(trans,null,clipid.kGlobalClipboard);
     }
}
function setcount(cp,id) {
$.ajax({type: 'get',url: cp + 'stat.asp',data:'s=1&id=' + id,success: function(msg) {$('#hits').html(msg);}});
$.ajax({type: 'get',url: '/ajaxservice.asp',data:'at=digg&id=' + id,success: function(msg) {$('#digg').html(msg.split('|')[1]);}});
}
function digg(id) {
$.ajax({type: 'get',url: '/ajaxservice.asp',data:'s=1&at=digg&id=' + id,success: function(msg) {alert(msg.split('|')[0]);$('#digg').html(msg.split('|')[1]);}});
}


function postform() {
if (getCookie('dnt','userid')==0||getCookie('dnt','userid')==''||getCookie('dnt','userid')==null) {
	document.write ("用户名：<input type='text' name='username' class='ainput' maxlength='15' size='12' />&nbsp;密码：<input type='password' class='ainput' name='password' maxlength='15' size='12' />");	
$("#noname").attr("checked","checked")
} else {
	document.write ("您好，"+getCookie('dnt','username')+"，欢迎留言！<a href=\"/my/logout.asp\" target = \"_blank\" class=\"hot\">[退出]</a>");	
$("#noname").attr("checked","")
}
}
