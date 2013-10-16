
function g(id) {
    return document.getElementById(id);
}
function Paste() {
    if ($.browser.msie) {
        g("txtInitCode").value = window.clipboardData.getData("Text");
        g("lblInitCode").innerHTML = "初始代码：" + g("txtInitCode").value.length + "字";
    }
}

function Empty() {
    g("txtInitCode").value = '';
    g("lblInitCode").innerHTML = "初始代码：";
    g("txtResultCode").value = '';
}

function ConfusionOptions() {
    //MUI.Window.open({ id: 'ConfusionOptionsWin', style: 'default', width: 400, height: 255, title: '混淆选项设置', resize: false}, { overlay: 10 });
    //MUI.Window.open({ id: 'ConfusionOptionsWin', type:"fonshen", style: 'vista', width: 410, height: 265, title: '混淆选项设置', resize: false, content: g("ConfusionOptions") }, { overlay: 10 });
    var el = g("ConfusionOptions");
    if (!el.show) {
        el.className = 'jqmWindow default';
        var p = $(el).bounds();
        $(el).jqm({ overlay: 10, onShow: function(hash) {
            hash.w.css("left", (p.left || (document.documentElement.scrollLeft + ($(window).width() - parseInt(p.width || hash.w.width())) / 2)) + "px");
            hash.w.css("top", (p.top || Math.max((document.documentElement.scrollTop + ($(window).height() - parseInt(p.height || hash.w.height())) / 2 - 20), 10)) + "px");
            //hash.w.css('opacity', 0.88).show(); 
            hash.w.show();
        }, onHide: function(hash) {
            hash.w.css('opacity', 1);
            hash.w.fadeOut('2000', function() { hash.o.remove(); });
        }
        });
        el.show = true;
    }
    $(el).jqmShow();
}
function BasicCompression() {
    Submit("BasicCompression");
}
function Confuse() {
    if (!CheckSet()) { $(g("ConfusionOptions")).jqmShow(); return; }
    Submit("Confuse");
} 
function Encrypt() {
    Submit("Encrypt");
}
function ConfuseEncrypt() {
    if (!CheckSet()) { $(g("ConfusionOptions")).jqmShow(); return; }
    Submit("ConfuseEncrypt");
}
function Format() {
    Submit("Format");
}
function CheckSet(b) {
    if (g("IsVariablePre").checked && g("VariablePre").value.trim() != "" && /^[a-zA-Z_\\$].*$/.test(g("VariablePre").value) == false) {
        alert("非法变量名前缀！");
        if(b)g("VariablePre").focus();
        return false;
    }
    if (/^\d$/.test(g("VarLength").value.trim()) == false) {
        alert("非法变量长度！");
        if (b) g("VarLength").focus();
        return false;
    }
    else if (g("Seed").value.trim() != "" && parseInt(g("VarLength").value) < 3) {
        alert("当使用混淆种子时变量位数至少3位！");
        if (b) g("VarLength").focus();
        return false;
    }
    return true;
}
var maxSize = 100, maxFormatSize = 100, maxConfuseSize = 30;
function Submit(type) {
    var valid = false;
    switch (type) {
        case "Format":
            ms = maxFormatSize;
            break;
        case "Confuse":
        case "ConfuseEncrypt":
            ms = maxConfuseSize;
            break;
        default:
            ms = maxSize;
            break;
    }
    var p = $.q("p");
    if(p){
        var ed = eval(unescape(p));
        if (ed) {
            if (new Date().toString() < ed) {
                valid = true;
            }
        }
    }
    
    var initCode = g("txtInitCode").value;
    if (initCode.length == 0) return;
    if (!valid && initCode.length > 1024 * ms) {
        alert("代码太长，目前在线版只支持不大于"+ms+"K的代码！请下载单机版使用！");
//        $.post("http://www.moralsoft.com/Handler/hdojso.ashx?action=CheckLength", { "data": initCode.length }, function(ret) {
//            if (ret == "") {
//                PostData(type);
//            } else {
//                alert(ret);
//            }
//        });
    } else {
        PostData(type);
    }
}
function PostData(type) {
//return;
    showDealing();
    var data = { "data": g("txtInitCode").value };
    if (type == "Confuse" || type == "ConfuseEncrypt") {
        data.IsMoveStr = g("IsMoveStr").checked;
        data.IsEncodeStr = g("IsEncodeStr").checked;
        data.IsIntToHex = g("IsIntToHex").checked;
        data.IsConfuseVariable = g("IsConfuseVariable").checked;
        data.IsConfuseFunctionName = g("IsConfuseFunctionName").checked;
        data.IsConfuseClassMember = g("IsConfuseClassMember").checked;
        data.NoVariable = g("NoVariable").value;
        data.NoClassMember = g("NoClassMember").value;

        data.IsVariablePre = g("IsVariablePre").checked;
        data.VariablePre = g("VariablePre").value;
        data.Seed = g("Seed").value;
        data.VarLength = g("VarLength").value;
        data.IsConfuseRootGlobalVar = true;
        data.IsConfusePre_ = g("IsConfusePre_").checked;
        data.IsConfusePreS = g("IsConfusePreS").checked;

        data.IsUseSquareBracket = g("IsUseSquareBracket").checked;
        data.IsIncludeSystemObject = g("IsIncludeSystemObject").checked;
    }
    $.post("http://www.moralsoft.com/Handler/hdojso.ashx?action=" + type, data, callback);
}
function callback(ret) {
    if (ret && ret.substr(0, 1) == "{") {
        var o = eval("(" + ret + ")");
        alert("代码太长，目前在线版只支持不大于" + o.size + "K的代码！");
        $("#div_tip").hide();
        return;
    }
    g("txtResultCode").value = ret;
    g("lblInitCode").innerHTML = "初始代码：" + g("txtInitCode").value.length + "字";
    g("lblResultCode").innerHTML = "结果代码:" + ret.length + "字";
    g("lblRadio").innerHTML = "压缩比：" + (parseFloat(ret.length * 1.00 / g("txtInitCode").value.length)).toFixed(2);
    $("#div_tip").hide();
};
$(document).ready(function() {
    $(document.body).append("<div id='div_tip' onclick=\"this.style.display='none';\" class='check_size' style='display:none;width:300px;height:50px;position:absolute;left:0;top:0'></div>");

});
function showDealing() {
    showTip("<div style=''>正在处理中，请稍候...</div>");
}
function showTip(html) {
        var l = Math.max(0, ($(window).width() - 300) / 2) + "px";
        var t = Math.max(0, ($(window).height() - 50) / 2) + "px";
        var el = g("div_tip");
        el.innerHTML = html;
        el.style.left = l;
        el.style.top = t;
        $(el).show();
}
function Copy() {
    if ($.browser.msie) clipboardData.setData("Text", g("txtResultCode").value);
}
function Exec() {
    try {
        eval(g("txtResultCode").value);
    } catch (e) {
        alert(e.description);
    }
}
function RestoreDefault() {
    g("IsMoveStr").checked = false;
    g("IsEncodeStr").checked = false;
    g("IsIntToHex").checked = false;
    g("IsConfuseVariable").checked = true;
    g("IsConfuseFunctionName").checked = true;
    g("IsConfuseClassMember").checked = true; 
    g("NoVariable").value="";
    g("NoClassMember").value = "";
    g("IsUseSquareBracket").checked = false;
    g("IsIncludeSystemObject").checked = false;
    g("IsConfusePre_").checked = true;
    g("IsConfusePreS").checked = true;
    g("IsVariablePre").checked = false;
    g("VariablePre").value = "";
    g("Seed").value = "";
    g("VarLength").value = "0";

    setTimeout("$('#ConfusionOptions').jqmHide();", 1000);
}

String.prototype.trim = function() {
    return this.replace(/(^\s+)|\s+$/g, "");
};


function ConvertToDateTime(str) {
    var a = str.toString().match(/^(\d{0,4})-(\d{0,2})-(\d{0,2}) (\d{0,2}):(\d{0,2}):(\d{0,2})$/);
    if (a == null) return null;
    return new Date(a[1], a[2] - 1, a[3], a[4], a[5], a[6]);
}

Function.prototype.overwrite = function(f) {
    var result = f;
    if (!result.original) {
        result.original = this;
    }

    return result;
}
Date.is = function(v) {
    return v != null && typeof v == "object" && !isNaN(v);
}
Date.prototype.toString = Date.prototype.toString.overwrite(
	function(format) {
	    if (!format) format = "yyyy-MM-dd HH:mm:ss";
	    var result = new String();
	    if (typeof (format) == "string") {
	        result = format;
	        result = result.replace(/yyyy|YYYY/, this.getFullYear());
	        result = result.replace(/yy|YY/, this.getFullYear().toString().substr(2, 2));
	        result = result.replace(/MM/, this.getMonth() >= 9 ? this.getMonth() + 1 : "0" + (this.getMonth() + 1));
	        result = result.replace(/M/, this.getMonth());
	        result = result.replace(/dd|DD/, this.getDate() > 9 ? this.getDate() : "0" + this.getDate());
	        result = result.replace(/d|D/, this.getDate());
	        result = result.replace(/hh|HH/, this.getHours() > 9 ? this.getHours() : "0" + this.getHours());
	        result = result.replace(/h|H/, this.getHours());
	        result = result.replace(/mm/, this.getMinutes() > 9 ? this.getMinutes() : "0" + this.getMinutes());
	        result = result.replace(/m/, this.getMinutes());
	        result = result.replace(/ss|SS/, this.getSeconds() > 9 ? this.getSeconds() : "0" + this.getSeconds());
	        result = result.replace(/s|S/, this.getSeconds());
	    }

	    return result.replace(" 00:00:00", "");
	});