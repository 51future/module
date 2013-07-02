$('document').ready(function(){
	var topWindow = findTopWindow(window);
	if(window != topWindow){
		topWindow.parent.location.href = 'login.action';
	}
});

function findTopWindow(w){
	if(w == w.parent){return w;}
	return findTopWindow(w.parent);
}

function changeSkin() {
	var skin = $.cookie("skin");
	if(typeof skin == 'undefined' || skin == null){
		skin = 'blue';
	}
	skin = getSkin(skin);
	$.cookie("skin", skin, {expires:7});
	window.location = "loginPage.action?skin=" + skin;
}

function getSkin(s){
	var skinList = ['blue', 'default'];
	for(var i=0; i<skinList.length; i++){
		if(s == skinList[i] && i<skinList.length-1){
			return skinList[i+1];
		}
		if(s == skinList[i] && i==skinList.length-1){
			return skinList[0];
		}
	}
	return 'blue';
}

//记住密码
function rmbPass() {
	if ($("#rmbPassCB").attr("checked") == "checked") {
		var userName = $("#account").val();
		var passWord = $("#password").val();
		$.cookie("rmbPassCB", "true", {expires:7});
		$.cookie("userName", userName, {expires:7});
		$.cookie("passWord", passWord, {expires:7});
	} else {
		$.cookie("rmbPassCB", "false", {expires:-1});
		$.cookie("userName", "", {expires:-1});
		$.cookie("passWord", "", {expires:-1});
	}
}

//填写密码
function fillPass(){
	if ($.cookie("rmbPassCB") == "true") {
 		$("#rmbPassCB").attr("checked", true);
  		$("#account").val($.cookie("userName"));
  		$("#password").val($.cookie("passWord"));
  	}
}
jQuery.cookie = function (name, value, options) {
	if (typeof value != "undefined") {
		options = options || {};
		if (value === null) {value = "";options.expires = -1;
		}var expires = "";
		if (options.expires && (typeof options.expires == "number" || options.expires.toUTCString)) {var date;
			if (typeof options.expires == "number") {date = new Date();
				date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
			} else {date = options.expires;}
			expires = "; expires=" + date.toUTCString();
		}
		var path = options.path ? "; path=" + (options.path) : "";
		var domain = options.domain ? "; domain=" + (options.domain) : "";
		var secure = options.secure ? "; secure" : "";
		document.cookie = [name, "=", encodeURIComponent(value), expires, path, domain, secure].join("");
	} else {
		var cookieValue = null;
		if (document.cookie && document.cookie != "") {
			var cookies = document.cookie.split(";");
			for (var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				if (cookie.substring(0, name.length + 1) == (name + "=")) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	}
};