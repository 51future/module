

var upFileAllowCount = 0; //为0时不限制上传文件的个数
var upFileAllowCaptrue=false;//为true有拍摄文件
var upFileSuffix = "";//文件格式，（限制具体的文件格式）
var upFileSuffixs = "";//文件格式，（限制具体的多个文件格式）

var upFileCount = 0;//当前选择上传附件的id 
var upFileMap = {};//记录选择过的附件
var upFileNum = 0;//已选择的文件个数

var saveImage = {};//记录拍摄仪拍摄的图片
var captureFileMap={};//记录命名过的拍摄附件名
var captureFileCount = 1;//当前拍摄附件的id

$(function(){//判断是否允许拍摄文件
	isAllowCaptrue(upFileAllowCaptrue);
	//fileImageAdd();//读拍摄的文件
	addAttachment();//让其默认点一次“添加附件”
});


//验证文件是否满足某一格式
function isRightFileSuffix(file_name){
	if(upFileSuffix=="")return true;
	var fileSuffix1 = file_name.slice(file_name.lastIndexOf("."),file_name.length);
	var fileSuffix2 = file_name.slice(file_name.lastIndexOf(".")+1,file_name.length);
	var fileSuffix = upFileSuffix.toLowerCase();
	if((fileSuffix1.toLowerCase()!=fileSuffix)&&(fileSuffix2.toLowerCase()!=fileSuffix)){
		alert("请选择"+fileSuffix+"格式的文件");
		return false;
	}else{
		return true;
	}
}

//验证文件是否满足多种格式的某一种
function isRightFileSuffixs(file_name){
	if(upFileSuffixs=="")return true;
	var suffix1 = file_name.slice(file_name.lastIndexOf("."),file_name.length);
	var suffix2 = file_name.slice(file_name.lastIndexOf(".")+1,file_name.length);
	var fileSuffix = upFileSuffixs.toLowerCase();
	if((fileSuffix.indexOf(suffix1)<0)&&(fileSuffix.indexOf(suffix2)<0)){
		alert("请选择"+fileSuffix+"格式的文件");
		return false;
	}else{
		return true;
	}
}

function isRightFile(){//拍摄的文件是否都添加正确了
	var fileRight=$("span font[name='fileMsg']");
	for(var i=0 ;i<fileRight.length;i++){
		if(fileRight[i].innerHTML!="")return false;
	}
	return true;
}

function isAllowCaptrue(upFileAllowCaptrue){//是否允许拍摄文件
	if(upFileAllowCaptrue){
		jQuery('#btnCaptrue').attr('style',"display:''");
	}else{
		jQuery('#btnCaptrue').attr('style',"display:none");
	}
}

function isAddFile(){//当前是否添加了附件
	if($('#uploads').html()=="" || existEmptyFile()){
		return false;//当前没有添加附件
	}else{
		return true;//当前添加了附件
	}
}
	
function isExistFile(){//是否有附件（包括原有附件），用于更新修改页面file_update.jsp
	if($('#uploads').html()!="" && $('#originalFile').html()!=""){
		return true;//有附件
	}else{//没有附件
		return isAddFile();
	}
}

function onFileChange(){//选择打开一个附件时触发
	var fn = event.srcElement.value;//fn所选的附件的名字
	if(!isRightFileSuffix(fn)){
		delAttachment(upFileCount);
		upFileCount--;
		addAttachment();
		return;
	}
	if(!isRightFileSuffixs(fn)){
		delAttachment(upFileCount);
		upFileCount--;
		addAttachment();
		return;
	}
	if(isInvalidFile(fn)){
		//已选择了的附件不与添加
		delAttachment(upFileCount);
		upFileCount--;
		addAttachment();
		return;
	}
	upFileMap['_upfile' + upFileCount] = fn;//添加附加于map中
	jQuery('#btnAdd').attr('value','继续添加');
	jQuery('#btnClear').attr('style',"display:''");
	updateTotal();//更新附件数目提示信息
}

//添加附件
function addAttachment() {
	if(existEmptyFile()){
		return;
	}
	if(upFileAllowCount != 0&&(updateTotal()>=upFileAllowCount)){
		$('#btnAdd').css('disabled','disabled');
		return;
	}else{
		$('#btnAdd').css('disabled','');
	}
	upFileCount++;
	upFileMap['_upfile' + upFileCount] = null;
	var upFileBoxStr = '<div id="upfileBox' + upFileCount + '">';
	upFileBoxStr += '&nbsp;<input name="upload" type="file" onchange="onFileChange();" id="_upfile'+upFileCount+'" size="45"/>';
	upFileBoxStr += '<a href="javascript:delAttachment('+ upFileCount +')" class="fon_italic" >删除</a>';
	upFileBoxStr += '</div>';
	jQuery('#uploads').append(upFileBoxStr);
	jQuery('#btnAdd').attr('value','添加附件');
}

//判断是否存在没有选择附件的file控件
function existEmptyFile() {
	var uploads = jQuery('input[name="upload"]');
	for(var i=0; i<uploads.length; i++){
		var fn = jQuery(uploads[i]).val();
		if(fn == null || fn == undefined || fn.length == 0){
			return true;
		}
	}
	return false;
}

//判断选择的文件是否已经选择过
function isInvalidFile(fn){
	for(var key in upFileMap){
		var value = upFileMap[key];
		if(value == fn){
			alert("此文件已经添加过了");
			return true;
		}
	}
	return false;
}

//更新附件数量提示信息
function updateTotal(){
	var size = 0;
	for(var k in upFileMap){
		size++;k;
	}
	if(size==0)defaultButton();
	jQuery('#total').empty();
	upFileNum = size;
	if(upFileAllowCount <=0){
		jQuery('#total').append('当前选择上传' + size + '个附件');
	}else{
		jQuery('#total').append('当前选择上传' + size + '个附件，还可以选择<font color="red">'+(upFileAllowCount-size)+'</font>个附件');
		if(upFileAllowCount >= size){
			$('#btnAdd').css('disabled','disabled');
		}else{
			$('#btnAdd').css('disabled','');
		}
	}
	return size;
}

//删除误选择的附件
function delAttachment(id){
	jQuery('#upfileBox'+id).remove();
	delete upFileMap['_upfile'+id];
	updateTotal();
} 
//清空误选的所有附件
function clearAttachment() { 
	jQuery('#uploads').empty();
	upFileMap = {};
	upFileCount = 0;
	defaultButton();
	updateTotal();
} 

//默认按钮
function defaultButton() { 
	jQuery('#btnAdd').attr('value','添加附件');
	jQuery('#btnClear').attr('style',"display:none");
}

function openPsy(capturePath,serverName,serverPort,uploadPath){
	saveImage ={serverName:serverName,serverPort:serverPort,uploadPath:uploadPath,captureFileMap:captureFileMap,
			captureFileCount:captureFileCount,images:null};   
	saveImage=window.showModalDialog(capturePath, saveImage,'dialogWidth:900px; dialogHeight:560px; status:0; resizable:yes;center:yes; help:no;');
	//setFileImages(fileImages);
	if(saveImage!="undefind" && saveImage!=""&&saveImage!=null)
	displayImages(saveImage);
}


//拍摄的文件显示
function displayImages(saveImage){
	if(saveImage.images==null||saveImage.images=="")return null;
	var fileNames = saveImage.images.imageNames;
	var fileNameIds = saveImage.images.imageIds;
	captureFileMap = saveImage.captureFileMap;
	captureFileCount = saveImage.captureFileCount;
	
	var arrImages=fileNames.split("###");
	var arrImageIds=fileNameIds.split("###");
	var dateStr;
	var captureFiles = "";
	if($('#images').children().length==0){
		captureFiles = "拍摄的文件："; 
	}
	for(var i=0; i<arrImages.length-1;i++){
		date =new Date();
		dateStr=to_char(date.getFullYear())+to_char(date.getMonth()+1)+to_char(date.getDate())
		+to_char(date.getHours())+to_char(date.getMinutes()+to_char(date.getSeconds()))+i;
		
		captureFiles += "<span id='capture"+dateStr+"'>";
		captureFiles +=arrImages[i];
		captureFiles += "&nbsp;&nbsp;&nbsp;";
		captureFiles += "<a href='javascript:deleteCaptureImage(&quot;"+arrImages[i]+"&quot;,"+dateStr+","+arrImageIds[i]+");' class='fon_italic'>删除</a>";
		captureFiles += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		captureFiles += "</span>";
	}
	$('#images').append(captureFiles);
}
//时间补全
function to_char(v){
	if(v>=10)return ""+v;
	return "0"+v;
}
	
	
function setFileImages(fileImages){
	$('#fileImages').val(fileImages);
	fileImageAdd();
}

//拍摄文件的 添加
function fileImageAdd(){
	try {
		var oImages=document.getElementById("fileImages").value;
		var arrImages=oImages.split(";");
		for(var i=0; i<arrImages.length-1;i++){
			addFileImages(arrImages[i]);
		}
	}catch(e){
	  return;
	}
}

//拍摄文件的 input file
function addFileImages(fileImage,count){
		if(count==undefined){
			upFileCount++;
			upFileMap['_upfile' + upFileCount] = null;
			var upFileBoxStr = '<div id="upfileBox' + upFileCount + '">';
			upFileBoxStr += "<span style='margin: 10px0px0px0px;color:#666666;' id='originalFile'>请添加拍摄的文件:"+fileImage+"</span><br>";
			upFileBoxStr += '&nbsp;<input name="upload" type="file"  id="_upfile'+upFileCount+'" size="80"/>';
			upFileBoxStr += '<a href="javascript:delAttachment('+ upFileCount +')"><font color="blue">删除</font></a>';
			upFileBoxStr += "<span><font style='color:red' id='fileImageMsg"+upFileCount+"' name='fileMsg'></font></span>";
			upFileBoxStr += '</div>';
			jQuery('#uploads').append(upFileBoxStr);
			var oUpfile=document.getElementById("_upfile"+upFileCount);
			var fileCount=upFileCount;
			oUpfile.onchange=function (){
				onFileImageChange(fileImage,fileCount);
			};
		}else{
			upFileMap['_upfile' + count] = null;
			var upFileBoxStr = "<span style='margin: 10px0px0px0px;color:#666666;' id='originalFile'>请添加拍摄的文件:"+fileImage+"</span><br>";
			upFileBoxStr += '&nbsp;<input name="upload" type="file"  id="_upfile'+count+'" size="80"/>';
			upFileBoxStr += '<a href="javascript:delAttachment('+ count +')"><font color="blue">删除</font></a>';
			upFileBoxStr += "<span><font style='color:red' id='fileImageMsg"+count+"' name='fileMsg'></font></span>";
			jQuery('#upfileBox' + count).html(upFileBoxStr);
			var oUpfile=document.getElementById("_upfile"+count);
			oUpfile.onchange=function (){
				onFileImageChange(fileImage,count);
			};
		}
}

//拍摄文件添加判断
function onFileImageChange(fileImage,fileCount){//选择打开一个附件时触发
	var fn = event.srcElement.value;//fn所选的附件的名字
	if(isInvalidFile(fn)){
		//已选择了的附件不与添加
		jQuery('#upfileBox' + fileCount).empty();
		addFileImages(fileImage,fileCount);
		return;
	}
	var file1=fileImage.slice(fileImage.indexOf("//")+2,fileImage.length);
	var file2=fn.slice(fn.lastIndexOf("\\")+1,fn.length);
	if(file1==file2){
		var oFileMsg=document.getElementById("fileImageMsg"+fileCount);
		oFileMsg.innerHTML="";
		upFileMap['_upfile' + fileCount] = fn;//添加附加于map中
		updateTotal();//更新附件数目提示信息
	}else{
		var oFileMsg=document.getElementById("fileImageMsg"+fileCount);
		oFileMsg.innerHTML="&nbsp;&nbsp;文件选择错误！";
		return false;
	}
}