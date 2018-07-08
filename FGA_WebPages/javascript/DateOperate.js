//比较两个日期的大小dateCompare("2011-06-27","2011-06-28") /r 返回（1：大于 2：等于 3：小于）

function dateCompare(date1, date2) {
    date1 = date1.replace(/\-/gi, "/");
    date2 = date2.replace(/\-/gi, "/");
    var time1 = new Date(date1).getTime();
    var time2 = new Date(date2).getTime();
    if (time1 > time2) {
        return 1;
    } else if (time1 == time2) {
        return 2;
    } else {
        return 3;
    }
}

//日期格式化
Date.prototype.format = function (fmt) {
    //author: meizz 
    var o =
    {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}



Date.prototype.addDays = function (d) {
    this.setDate(this.getDate() + d);
};




Date.prototype.addWeeks = function (w) {
    this.addDays(w * 7);
};




Date.prototype.addMonths = function (m) {
    var d = this.getDate();
    this.setMonth(this.getMonth() + m);


    if (this.getDate() < d)
        this.setDate(0);
};




Date.prototype.addYears = function (y) {
    var m = this.getMonth();
    this.setFullYear(this.getFullYear() + y);


    if (m < this.getMonth()) {
        this.setDate(0);
    }
};




//js格式化时间
Date.prototype.toDateString = function (formatStr) {
    var date = this;
    var timeValues = function () { };
    timeValues.prototype = {
        year: function () {
            if (formatStr.indexOf("yyyy") >= 0) {
                return date.getYear();
            }
            else {
                return date.getYear().toString().substr(2);
            }
        },
        elseTime: function (val, formatVal) {
            return formatVal >= 0 ? (val < 10 ? "0" + val : val) : (val);
        },
        month: function () {
            return this.elseTime(date.getMonth() + 1, formatStr.indexOf("MM"));
        },
        day: function () {
            return this.elseTime(date.getDate(), formatStr.indexOf("dd"));
        },
        hour: function () {
            return this.elseTime(date.getHours(), formatStr.indexOf("hh"));
        },
        minute: function () {
            return this.elseTime(date.getMinutes(), formatStr.indexOf("mm"));
        },
        second: function () {
            return this.elseTime(date.getSeconds(), formatStr.indexOf("ss"));
        }
    }
    var tV = new timeValues();
    var replaceStr = {
        year: ["yyyy", "yy"],
        month: ["MM", "M"],
        day: ["dd", "d"],
        hour: ["hh", "h"],
        minute: ["mm", "m"],
        second: ["ss", "s"]
    };
    for (var key in replaceStr) {
        formatStr = formatStr.replace(replaceStr[key][0], eval_r("tV." + key + "()"));
        formatStr = formatStr.replace(replaceStr[key][1], eval_r("tV." + key + "()"));
    }
    return formatStr;
}


function formatStrDate(date) {
    var str = date.toDateString("yyyy-MM-dd hh:mm:ss");
    if (str.indexOf("00:00:00") != -1) {
        return str.replace("00:00:00", "10:00:00");
    }
    return str;
}
/**              
* 日期 转换为 Unix时间戳
* @param <string> 2014-01-01 20:20:20  日期格式              
* @return <long> unix时间戳(毫秒13位)              
*/
function DateToUnix(string) {
    string = string.replace(/-/g, "/")
    return (new Date(string)).getTime();
}