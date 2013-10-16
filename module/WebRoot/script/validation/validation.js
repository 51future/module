/**
* desc 表单提交前验证数据
* 用法: 1 先引三个文件包，jquery.js,livevalidation.css,livevalidation.js
* 		2 需要验证的字段内容，直接在class后面添加。比如不能为空，class="LV_not_null"
*       3 实例请到:\admin\public\validation.jsp 查看
* 返回: boolean
* @author bin
*/

function validation(){
	//清除验证错误信息
   	$(".LV_invalid_field").removeClass("LV_invalid_field"); 
   	$(".LV_invalid").remove();
   	
   	var valid = true;
   	
   	//非空验证
	$(".LV_not_null").each(function(){
		try{
			var field = $(this);
			var config = {};
			config.failureMessage = field.attr('failmsg') ? field.attr('failmsg') : '不能为空';
			
			Validate.Presence(field.val(), config);
		}catch(e){
			valid = false;
			if ($(this).next('span')== null || $(this).next('span') == undefined ||$(this).next('span').html() == null) {
				$(this).addClass('LV_invalid_field');
				$(this).after('<span class=" LV_validation_message LV_invalid">'+ e.message + '</span>');
				
				$(this).bind('keydown',function(){
					$(".LV_invalid_field").removeClass("LV_invalid_field"); 
				   	$(".LV_invalid").remove(); 
				});
			}
		}
	});
	
	//数字验证
	$(".LV_number").each(function(){
		try{
			var field = $(this);
			var config = {};
			var failmsg = '只能为数字';
			if( field.attr('maximum') ){
				config.maximum = field.attr('maximum');
				failmsg += '，不能大于' + field.attr('maximum');
			}
			if( field.attr('minimum') ){
				config.minimum  = field.attr('minimum');
				failmsg += '，不能小于' + field.attr('minimum');
			}
			
			config.failureMessage = field.attr('failmsg') ? field.attr('failmsg') : failmsg;
			Validate.Numericality(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//整数验证
	$(".LV_integer").each(function(){
		try{
			var field = $(this);
			var config = {};
			config.onlyInteger = true;
			var failmsg = '只能为整数';
			if( field.attr('maximum') ){
				config.maximum = field.attr('maximum');
				failmsg += '，不能大于' + field.attr('maximum');
			}
			if( field.attr('minimum') ){
				config.minimum  = field.attr('minimum');
				failmsg += '，不能小于' + field.attr('minimum');
			}
			
			config.failureMessage = field.attr('failmsg') ? field.attr('failmsg') : failmsg;
			
			Validate.Numericality(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//正整数验证
	$(".LV_plus_integer").each(function(){
		try{
			var c_value = $(this).val();
			Validate.Numericality(c_value,{ onlyInteger: true , minimum: 1, failureMessage: '只能为正整数' });
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	
	//字符串长度验证
	$(".LV_length").each(function(){
		try{
			var field = $(this);
			var config = {};
			var failmsg = '';
			if( field.attr('maxlength') ){
				config.maximum = field.attr('maxlength');
				failmsg = '长度不能大于' + field.attr('maxlength');
			}
			if( field.attr('minlength') ){
				config.minimum  = field.attr('minlength');
				failmsg = '长度不能小于' + field.attr('minlength');
			}
			
			config.failureMessage = field.attr('failmsg') ? field.attr('failmsg') : failmsg;
			Validate.Length(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//电子邮箱地址验证
	$(".LV_email").each(function(){
		try{
			var field = $(this);
			var config = {};
			if(field.attr('failmsg')){
				config.failureMessage = field.attr('failmsg');
			}
			Validate.Email(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//价格验证
	$(".LV_price").each(function(){
		try{
			var c_value = $(this).val();
			Validate.Numericality(c_value, { failureMessage: "只能为数字"  } );
			var arr = c_value.split('.');
			if( arr[1] != null && arr[1].length > 4){
				valid = false;
				$(this).addClass('LV_invalid_field');
				$(this).after('<span class=" LV_validation_message LV_invalid">最多只能输入四位小数</span>');			
			}
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//电话号码(包括座机号)
	$(".LV_telephone").each(function(){
		try{
			var field = $(this);
			var config = {};
			if(field.attr('failmsg')){
				config.failureMessage = field.attr('failmsg');
			}
			Validate.Telephone(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//字母数字下划线组合字符串
	$(".LV_code_num").each(function(){
		try{
			var field = $(this);
			var config = {};
			if(field.attr('failmsg')){
				config.failureMessage = field.attr('failmsg');
			}
			Validate.CodeNum(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//身份证号码
	$(".LV_id_card_no").each(function(){
		try{
			var field = $(this);
			var config = {};
			if(field.attr('failmsg')){
				config.failureMessage = field.attr('failmsg');
			}
			Validate.IDCardNo(field.val(), config);
		}catch(e){
			valid = false;
			$(this).addClass('LV_invalid_field');
			$(this).after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	//radio或check 字段验证
	$(".LV_radio_check").each(function(){
		var field = $(this);
		try{
			var failmsg = '必须选择一项';
			if(field.attr('failmsg')){
				config.failureMessage = field.attr('failmsg');
			}
			
			var checkFlag = false;
			$("input[name="+field.attr("name")+"]").each(function(){
				if(this.checked){
					checkFlag = true;
				}
			});
		    
		    if(checkFlag == false){
		    	Validate.fail(failmsg);
		    }
		}catch(e){
			valid = false;
			$("input[name="+field.attr("name")+"]:last").after('<span class=" LV_validation_message LV_invalid">' + e.message + '</span>');
		}
	});
	
	return valid;
}

$(function(){
 	$('form').submit(validation);
});