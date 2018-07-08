



// 加载页面的勾选以及其他选项
// 参数说明   divID:显示“您共选择了XX条数据”的div（div_seles_tool）    countID:显示“您共选择了XX条数据”的XX数字的span 的ID（lbjscnt）
//  checkBoxName： 页面多个checkbox的Name（list_cbk）  checkID:那一个全选按钮的ID（cbk_all）
function loadSelect(divID, countID, checkBoxName,checkID) {
    // 1.  得到翻页勾选多少条
    $.ajax({
        type: "Post",
        url: "../ajaxHandle/flip.aspx/GetSelectCount", 
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "0") {
                $("#" + divID).css("display", "");
                $("#" + countID).html(data.d);
            }
            else
                $("#" + divID).css("display", "none");
        }
    });
   // alert(document.getElementsByName("" + checkBoxName).length);

    // 2. 把当前页的选中项，勾选效果加上，并且如果是全选，单选的全选按钮也加上
    $.ajax({
        type: "Post",
        url: "../ajaxHandle/flip.aspx/AllSelectInput",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            var t = data.d;
            if (t != "") {
                var count = 0;
                //$("input[name='list_cbk']").each(function () {
                //    if(t.indexOf("\\"+ $(this).val()+"\\")==-1 ){
                //        $(this).prop("checked", false);
                //    }else{
                //        $(this).prop("checked", true);
                //        count++;
                //    }
                //});

                var q = document.getElementsByName(""+checkBoxName);
               
                for (var i = 0; i < q.length; i++) {

                    if (t.indexOf("\\" + q[i].value + "\\") == -1) {

                        q[i].checked = false;
                    } else {
                        q[i].checked = true;
                        count++;
                    }
                }
                if (count == q.length) {  //全选按钮上来
                    $("#" + checkID).prop("checked", true);
                } else {
                    $("#" + checkID).prop("checked", false);
                }

            }


        }
    });
}


//obj：当前对象   checkBoxName： 页面多个checkbox的Name（list_cbk） 
//divID:显示“您共选择了XX条数据”的div（div_seles_tool）    countID:显示“您共选择了XX条数据”的XX数字的span 的ID（lbjscnt）
//全选
function CheckAll(obj, checkBoxName, divID, countID) {
    var q = "fan";
    if ($(obj).prop("checked")) {
        q = "quan";
        $("input[name='" + checkBoxName + "']").each(function () {
            $(this).prop("checked", true);
        });
    }
    else {
        $("input[name='" + checkBoxName + "']").each(function () {
            $(this).prop("checked", false);
        });
        $("#" + countID).html("");//反选的时候把选择了XX条数据的XX 为空，因为生哥根据 XX来判断是否有数据的
    }
    CreateList(q, checkBoxName, divID, countID);
}



//时时更改选中的数据
function CreateList(q, checkBoxName, divID, countID) {
    var list = "";
    var i = 0;
    $("input[name='" + checkBoxName + "']").each(function () {
        if ($(this).prop("checked")) {
            if (list == "") {
                list = $(this).val() + "■";
                i++;
            }
            else {
                list += $(this).val() + "■";
                i++;
            }
        }
    });

    var t = "";
    $("input[name='" + checkBoxName + "']").each(function () {
        t += $(this).val() + "■";
    });

    $.ajax({
        type: "Post",
        url: "../ajaxHandle/flip.aspx/SaveAll",
        data: "{all:'" + t + "',q:'" + q + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {

            if (data.d != "0") {
                $("#" + divID).css("display", "");
                $("#" + countID).html(data.d);
            }
            else
                $("#" + divID).css("display", "none");

        }
    });
}



//记录和取消勾选
// obj：当前对象  bs：url参数，当前ID
//divID:显示“您共选择了XX条数据”的div（div_seles_tool）    countID:显示“您共选择了XX条数据”的XX数字的span 的ID（lbjscnt）
function SaveSelect(obj, divID, countID, bs) {
    if ($(obj).prop("checked") == true) {
        $.ajax({
            type: "Post",
            url: "../ajaxHandle/flip.aspx/SaveSelect",
            data: "{biaoshi:'" + bs + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "false") {
                    if (data.d != "0") {
                        $("#" + divID).css("display", "");
                        $("#" + countID).html(data.d);
                    }
                    else
                        $("#" + divID).css("display", "none");
                }
                else
                    $(obj).prop("checked", false);
            }
        });

    } else {
        $.ajax({
            type: "Post",
            url: "../ajaxHandle/flip.aspx/UnSaveSelect",
            data: "{biaoshi:'" + bs + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "false") {
                    if (data.d != "0") {
                        $("#" + divID).css("display", "");
                        $("#" + countID).html(data.d);
                    }
                    else
                        $("#" + divID).css("display", "none");
                }
                else
                    $(obj).prop("checked", true);
            }
        });
    }
}

//普通和自定义弹框导出
function importSelectExcel(type,pagename) { //type 记录需要调用哪个方法,pagename你从哪个页面进来的,自定义导出需要
    var count = "0";
    $.ajax({
        type: "Post",
        url: "../ajaxHandle/flip.aspx/GetSelectCount",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            count = data.d;
        }
    });

    if (count == "0") {
        window.parent.qmalert("提示", "未选择任何数据", 300, 200, null);
        return;
    }
    window.parent.showDialog('导出所选', '../ascx/importdialog.aspx?opertype=' + type+"&pagename="+pagename, 400, 400, null);

    //window.parent.qmconfirm(
    //        '提示',
    //        '确定要导出选择的记录吗？',
    //        function (res) {
    //            if (res == 'ok') {
    //                //location.href = '../ajaxhandle/GlobalHandle.ashx?opertype=importslct&r=' + Math.random();
    //                location.href = "../ajaxhandle/GlobalHandle.ashx?opertype="+type+"&r=" + Math.random();
    //            }
    //        },
    //        400,
    //        160
    //    );
        
}

//普通导出，不弹框，没有自定义
function importSelectExcelDefault(type) { //type 记录需要调用哪个方法,pagename你从哪个页面进来的,自定义导出需要
    var count = "0";
    $.ajax({
        type: "Post",
        url: "../ajaxHandle/flip.aspx/GetSelectCount",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (data) {
            count = data.d;
        }
    });

    if (count=="0") {
        // window.parent.qmalert('未选择任何数据');
        window.parent.qmalert("提示", "未选择任何数据", 300, 200, null);
        return;
    }

    window.parent.qmconfirm(
            '提示',
            '确定要导出选择的记录吗？',
            function (res) {
                if (res == 'ok') {
                    //location.href = '../ajaxhandle/GlobalHandle.ashx?opertype=importslct&r=' + Math.random();
                    location.href = "../ajaxhandle/GlobalHandle.ashx?opertype="+type+"&r=" + Math.random();
                }
            },
            400,
            160
        );

}

function importAllExcel(type) {//type 记录你从哪个页面进来的，需要调用哪个方法。
    if (urlparamForImptAll == null || urlparamForImptAll.length <= 0)
        return;
    window.parent.qmconfirm(
            '提示',
            '确定要导出当前检索结果吗？',
            function (res) {
                if (res == 'ok') {
                    //location.href = '../ajaxhandle/GlobalHandle.ashx?opertype=importall' + urlparamForImptAll;
                    location.href ="../ajaxhandle/GlobalHandle.ashx?opertype="+type + urlparamForImptAll;
                }
            },
            400,
            160
        );
}


function ClearSession() { //清空session.页面上导出以后，直接点搜索，需要先清空之前的勾选项

    $("#cbk_all").prop("checked", false);
    $.ajax({
        url: "../ajaxHandle/flip.aspx/ClearSession",
        data: "",
        method: 'post',
        dataType: 'json',
        async: false,
        contentType: "application/json; charset=utf-8",
        success: function (data) {

        }
    });

}