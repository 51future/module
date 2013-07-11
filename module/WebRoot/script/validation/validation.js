/**
 * 表单提交前验证数据 用法: 引入jQuery,livevalidation.css,livevalidation.js ；
 * 需要验证的字段内容，直接在class后面添加。比如不能为空，class="notNull"。
 */
var valid_min = 5;
var valid_max = 10;
function validation() {
	var valid = true;
	$(".LV_invalid_field").removeClass("LV_invalid_field");
	$(".LV_invalid").remove();
	$(".Null").each(
			function() { // 不能为空
				try {
					var c_value = $(this).val();
					Validate.Presence(c_value, {
						failureMessage : "不能为空!"
					});
				} catch (e) {
					valid = false;
					$(this).addClass('LV_invalid_field');
					$(this).after(
							'<span class=" LV_validation_message LV_invalid">'
									+ e.message + '</span>');
				}
			});

	// ------------长度限制，如果自定义范围，先调用setValidVale(_min,_max)---------
	$(".Length").each(
			function() {
				try {
					var c_value = $(this).val();
					Validate.Presence(c_value, {
						failureMessage : "长度范围" + valid_min + " -" + valid_max
								+ "!"
					});
					Validate.Length(c_value, {
						minimum : valid_min,
						maximum : valid_max
					});
				} catch (e) {
					valid = false;
					if ($(this).next('span').html() == null) {
						$(this).addClass('LV_invalid_field');
						$(this).after(
								'<span class=" LV_validation_message LV_invalid">'
										+ e.message + '</span>');
					}
				}
			});
	// ----------------------只允许正数-------------------
	$(".Integer").each(
			function() {
				try {
					var c_value = $(this).val();
					Validate.Numericality(c_value, {
						onlyInteger : true,
						minimum : 0
					});
				} catch (e) {
					valid = false;
					if ($(this).next('span').html() == null) {
						$(this).addClass('LV_invalid_field');
						$(this).after(
								'<span class=" LV_validation_message LV_invalid">'
										+ e.message + '</span>');
					}
				}
			});
	// -----------------------邮件验证---------------------
	$(".Email").each(
			function() {
				try {
					var c_value = $(this).val();
					Validate.Email(c_value);
				} catch (e) {
					valid = false;
					if ($(this).next('span').html() == null) {
						$(this).addClass('LV_invalid_field');
						$(this).after(
								'<span class=" LV_validation_message LV_invalid">'
										+ e.message + '</span>');
					}
				}
			});
	$(".Number").each(
			function() {
				try {
					var c_value = $(this).val();
					Validate.Numericality(c_value, {
						failureMessage : "必须是数字!"
					});
				} catch (e) {
					valid = false;
					if ($(this).next('span').html() == null) {
						$(this).addClass('LV_invalid_field');
						$(this).after(
								'<span class=" LV_validation_message LV_invalid">'
										+ e.message + '</span>');
					}
				}
			});
	return valid;
}

$(function() {
	$('form').submit(validation);
});

// -----------设置大小范围=-----------
function setValidVale(_min, _max) {
	this.valid_min = _min;
	this.valid_max = _max;
}
