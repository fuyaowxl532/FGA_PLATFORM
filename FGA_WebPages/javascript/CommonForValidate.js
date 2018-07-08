// JavaScript Document
//检查关键词是否合法
function CheckGjc(gjc) 
{
    var obj = new Object();
    obj.Type = true;
    obj.Message = "";
    gjc = $.trim(gjc);

    //检索字符串中是否包含特殊的字符
    var regexp = /[#\&\\\'\";/,<>?、|:+“”\[\]]+/gi;
    if (gjc.match(regexp)) {
        obj.Type = false;
        obj.Message = "关键词中不能包含以下特殊字符# \& \\ \' \" ; / . , < > ? 、 | : + “ ”\[\] ";
        return obj;
    }
    return obj;
}