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
        html += '共' + this.totalRecord + '条记录 / 每页显示<span class="red">' + this.pageSize + '</span>条&nbsp;';

        //首页/上一页
        if (this.currentIndex == 1) {
            html += '<a class="page">首页</a>';
            html += '<a class="page">上一页</a>';
        }
        else {
            html += '<a class="page" href="javascript:JSPager.toPager(1);">首页</a>';
            html += '<a class="page" href="javascript:JSPager.toPager(' + (this.currentIndex - 1) + ');">上一页</a>';
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
                    html += '<a class="page" disabled="disabled">...</a>';
                    start_flag = !start_flag;
                }
            }
                //显示范围内输出
            else if (i >= start && i <= end) {
                if (i == this.currentIndex)
                    html += '<span class="page active">' + i + '</span>';
                else
                    html += '<a class="page" href="javascript:JSPager.toPager(' + i + ');">' + i + '</a>';
            }
                //显示范围之后只显示占位符
            else if (i > end) {
                if (!end_flag) {
                    html += '<a class="page" disabled="disabled">...</a>';
                    end_flag = !end_flag;
                }
            }
        }
        //下一页/尾页
        if (this.currentIndex == total) {
            html += '<a class="page" disabled="disabled" style="margin-right: 5px;">下一页</a>';
            html += '<a class="page" disabled="disabled" style="margin-right: 5px;">末页</a>';
        }
        else {
            html += '<a class="page" href="javascript:JSPager.toPager(' + (this.currentIndex + 1) + ');">下一页</a>';
            html += '<a class="page" href="javascript:JSPager.toPager(' + total + ');">末页</a>';
        }
        
        
        var turnpage = '';
        turnpage = '转到<input id="inputpage" name="" type="text" class="page pageTxt">页&nbsp;';
        turnpage += '<input name="" type="button" value="GO" onclick="JSPager.turnTopage()" class="page page_go"/>';
        html += turnpage;
        html += '</ul></div></div>';
        //显示
        $('#' + divId).html(html);
    },

    turnTopage: function () {
        if ($.trim($("#inputpage").val()) == "") {
            AutoClose("inputpage", "请填入页码!", "top");
            return;
        }
        var reg = new RegExp("^[0-9]*$");
        if (!reg.test($("#inputpage").val())) {
            AutoClose("inputpage", "请填入正确的页码!", "top");
            return;
        }
        if ($.trim($("#inputpage").val()) == "0") {
            AutoClose("inputpage", "请填入正确的页码!", "top");
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
            AutoClose("inputpage", "页码超过总页数!", "top");
            return;
        }
        this.doPager();
    },
    /* 当前页数据加载 */
    doPager: function () {
        //..调用重写..
    }
}

