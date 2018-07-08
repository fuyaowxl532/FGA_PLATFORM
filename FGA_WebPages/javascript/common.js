/* ymprompt弹窗 */
window.qmalert = function (title, msg, width, height, callback) {
    ymPrompt.alert({ message: msg, handler: callback, width: width, height: height, title: title, titleBar: true, showShadow: true });
}
window.qmalertto = function (title, msg, width, height, jumpurl) {
    ymPrompt.alert({ message: msg, handler: function () { location.href = jumpurl; }, width: width, height: height, title: title, titleBar: true, showShadow: true });
}

window.qmconfirm = function (title, msg, callback, width, height) {
    ymPrompt.confirmInfo({ message: msg, handler: callback, width: width, height: height, title: title, titleBar: true, showShadow: true });
}

window.showDialog = function (title, url, width, height, callback) {
    ymPrompt.win({ message: url, handler: callback, width: width, height: height, title: title, titleBar: true, showShadow: true, iframe: true, maskAlpha: 0.3 });
}
/* 全局变量 */
window.SPLIT = "卐";
window.SPLIT2 = "⊙";
window.SPLIT_NM = ",";
window.ST_OK = "ok";
window.ST_ERROR = "error";
window.ST_DATAERROR = "dataerror";
window.EMPTY = '--';
window.ZERO = '0';



function CutString(value, length) {
    var res = "";
    if (value != ".") {
        if (value.length > length) {
            res = value.substring(0, length) + "...";
        } else {
            res = value;
        }
    }
    return res;
}


function GetServersityValueByLevel(value) {
    var res = "";
    if (value == "无") {
        res = "0";
    } else if (value == "低") {
        res = "1";
    } else if (value == "中") {
        res = "2";
    } else if (value == "高") {
        res = "3";
    }
    return res;
}
function GetServersityTextByLevel(level) {
    var res = "";
    if (level == "0") {
        res = "无";
    } else if (level == "1") {
        res = "低";
    } else if (level == "2") {
        res = "中";
    } else if (level == "3") {
        res = "高";
    }
    return res;
}

/*获取文件类型以及路径*/
function GetFile(fileType, fileName, location) {
    var res = "";
    var name = "";
    if (fileType in fileicon) {
        name = fileicon[fileType];
    }
    else
    {
        if (fileType != "" && fileType != null && fileName != "" && fileName != null) {
            name = "<img src=\"../images/icon/unkown.png\" title=\"unkown\" />";
        }
    }
    name = name + fileName;
   // name += fileType == "" ? "--" : fileName + "." + fileType;
    //if (location.toLowerCase().indexOf("http://") == -1) {
    //    location = "http://" + location;
    //}
    //if (location != null && location != "" && location != "http://") {
    //    res = "<a href=\"" + location + "\" target=\"_blank\">" + name + "</a>";
    //}
    //else {
    //    res = name;
    //}

    return name;
}
/* 底部提示条 */
var globalTimeOut = null;
window.showBottomMessage = function (msg) {
    try {
        if (globalTimeOut != null)
            window.clearTimeout(globalTimeOut);
        $('.divmessage').remove();
    } catch (e) { }
    var html = "<div class='divmessage'>" + msg + "<img src='../images/close.png' alt='' onclick='$(this).parent().slideUp(300);' /></div>";
    $('body').append(html);
    var divmsg = $('.divmessage');
    divmsg.slideDown(300);
    globalTimeOut = window.setTimeout(function () {
        $('.divmessage').slideUp(300);
    }, 3000);
}
/* 顶部部提示条 msg:提示信息；height:高度；指定具体高度（px）;不确定可填auto,width:宽度，指定具体宽度（px）或100%*/
var globalTopTimeOut = null;
function showTopMessage(msg, height, width) {
    try {
        if (globalTopTimeOut != null)
            window.clearTimeout(globalTopTimeOut);
        $('.divcentermessage').remove();
    } catch (e) { }
    var html = "<div class='divcentermessage' style=\"height:" + height + ";width:" + width + "\">" + msg + "<img src='../images/close.png' title='关闭' onclick='$(this).parent().slideUp(300);' /></div>";
    $('body').append(html);
    var divmsg = $('.divcentermessage');
    divmsg.slideDown(300);
    globalTopTimeOut = window.setTimeout(function () {
        $('.divcentermessage').slideUp(300);
    }, 4500);
}



/* URL前缀检查 */
function urlspell(url) {
    if (url == null || url.length <= 0)
        return "";
    if (url.indexOf('http://') == 0 || url.indexOf('https://') == 0)
        return url;
    return "http://" + url;
}



/* 2秒钟关闭的弹框 */
function AutoClose(id, content, align) {
    var d = dialog({
        align: '' + align, //align有12个全方位的值
        content: '' + content
    });
    d.show(document.getElementById('' + id));
    document.getElementById('' + id).focus();
    setTimeout(function () {
        d.close().remove();
        document.getElementById('' + id).focus();
    }, 2000);
    
}




function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}


function ChangeTab(total,current,headid,contentid) {
    for (var i = 0; i < total; i++) {
        if (i == current) {
            $("#" + headid+i).attr("class", "active");
            $("#" + contentid+i).css("display","block");
        } else {
            $("#" + headid + i).removeAttr("class", "active");
            $("#" + contentid + i).css("display", "none");
        }
    }
}


function ReplaceToBR(r) {
  //  r = r.replace(/\n/g, "<br />");
  //  r = r.replace(/\r/g, "<br />");
    r = r.replace(/\r\n/g, "<br />");
    return r;
}




