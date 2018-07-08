/*
 * JS分页显示功能
 * 描述：根据相关参数在指定区域输出分页html
 */
var JSPager = {
    /* 当前页码(从1开始,默认1) */
    currentIndex: 1,
    /* 总记录数 */
    totalRecord: 0,
    /* 每页显示数量 */
    pageSize: 0,
    /* 总页数(只读) */
    totalPage: function () {
        if (this.totalRecord == 0 || this.pageSize == 0)
            return 0;
        var pct = this.totalRecord % this.pageSize;
        var dvd = parseInt(this.totalRecord / this.pageSize);
        if (pct == 0)
            return dvd;
        else
            return dvd + 1;
    },
    /* 页码显示范围(偏移数) */
    indexArea: 5,
    /* 初始化 */
    initPager: function (divId) {
        var div = $('#' + divId);
        if (div == null || div.length == 0) {
            alert('div not found.');
        }
        var html = '';
        html += '<div class="col-sm-4">' + '<div id="sample-table-2_info" class="dataTables_info" style="padding-top:2px;line-height: 32px;font-size: 14px;">' + 'Total:' + this.totalRecord + ' / ' + this.pageSize + 'per page' + '</div>' + '</div>';
        html += '<div class="col-sm-8"><div class="dataTables_paginate paging_bootstrap" style="white-space: nowrap;text-align: left;"><ul class="pagination" style="margin:2px 0 2px 0">';

        //首页/上一页
        if (this.currentIndex == 1) {
            html += '<li class="prev disabled"><a disabled="disabled">First</a></li>';
            html += '<li><a disabled="disabled">Prev</a></li>';
        }
        else {
            html += '<li><a href="javascript:JSPager.toPager(1);">First</a></li>';
            html += '<li><a href="javascript:JSPager.toPager(' + (this.currentIndex - 1) + ');">Prev</a></li>';
        }
        //页码处理
        var total = this.totalPage();
        //var start = this.currentIndex - this.indexArea;//理论显示起始页码
        var start = this.currentIndex;//理论显示起始页码
        var end = this.currentIndex + this.indexArea;//理论显示最后页码
        var start_flag = false;//起始溢出占位
        var end_flag = false;//结束溢出占位
        for (var i = 1; i <= total; i++) {
            //显示范围之前只显示占位符
            if (i < start) {
                if (!start_flag) {
                    html += '<li><a disabled="disabled">...</a></li>';
                    start_flag = !start_flag;
                }
            }
                //显示范围内输出
            else if (i >= start && i <= end) {
                if (i == this.currentIndex)
                    html += '<li class="active"><span style="margin-right: 5px; font-weight: Bold;">' + i + '</span></li>';
                else
                    html += '<li><a href="javascript:JSPager.toPager(' + i + ');">' + i + '</a></li>';
            }
                //显示范围之后只显示占位符
            else if (i > end) {
                if (!end_flag) {
                    html += '<li><a disabled="disabled">...</a></li>';
                    end_flag = !end_flag;
                }
            }
        }
        //下一页/尾页
        if (this.currentIndex == total) {
            html += '<li><a disabled="disabled" style="margin-right: 5px;">Next</a></li>';
            html += '<li><a disabled="disabled" style="margin-right: 5px;">Last</a></li>';
        }
        else {
            html += '<li><a href="javascript:JSPager.toPager(' + (this.currentIndex + 1) + ');">Next</a></li>';
            html += '<li><a href="javascript:JSPager.toPager(' + total + ');">Last</a></li>';
        }
        var turnpage = '&nbsp;<li><input id="inputpage" type="text" style="" /></li><li><input id="inputok" onclick="JSPager.turnTopage()"  type="button" value="OK" style="" /></li>';
        html += turnpage;
        html += '</ul></div></div>';
        //显示
        $('#' + divId).html(html);
    },
    
    turnTopage: function () {
        if ($.trim($("#inputpage").val()) == "") {
            AutoClose("inputpage", "Please input page number!", "top");
            return;
        }
        var reg = new RegExp("^[0-9]*$");
        if (!reg.test($("#inputpage").val())) {
            AutoClose("inputpage", "Please input correct page number!", "top");
            return;
        }
        if ($.trim($("#inputpage").val()) == "0") {
            AutoClose("inputpage", "Please input correct page number!", "top");
            return;
        }
        this.toPager(parseInt($("#inputpage").val()));
    },
    /* 重置 */
    resetPager: function (divId) {
        $('#' + divId).html('');
    },
    /* 跳转至目标页 */
    toPager: function (targetIndex) {
        this.currentIndex = targetIndex;
        if (targetIndex > this.totalPage()) {
            AutoClose("inputpage", "Page number over total pages", "top");
            return;
        }
        this.doPager();
    },
    /* 当前页数据加载 */
    doPager: function () {
        //..调用重写..
    }
}

