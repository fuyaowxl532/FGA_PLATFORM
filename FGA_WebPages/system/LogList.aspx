<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogList.aspx.cs" Inherits="FGA_PLATFORM.system.LogList" %>

<%@ Register Src="~/ascx/boottom.ascx" TagPrefix="uc1" TagName="boottom" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>日志查看</title>
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/style.css" rel="stylesheet" />


    
  
</head>
<body>
    <input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
    <ol class="breadcrumb breadcrumb-2"> 
				<li><a href="javascript:void(0)" style="cursor:default"><i class="fa fa-home"></i>SYSTEMMANAGER</a></li> 
				<li class="active"><strong>LOG</strong></li> 
			</ol>
    <div class="outsideBox outBox3">
            <div class="insideBox insideBox3">
                <img src="../images/condition_icon5.png"></div>
            <input name="" id="btnImportSelect" type="button" value="导出所选" class="search">
        </div>
   
        <div class="outsideBox outBox3" id="div_seles_tool" style="display:none;">
            <span style="float: right; margin: 0 4px;" >您共选择了<span id="lbjscnt"></span>条数据
            </span>
        </div>
    <div class="divsearch">
                            
                            <i class="icon-chevron-right"></i>&nbsp;姓名&nbsp;<asp:TextBox runat="server" ID="txtName" CssClass="form-control" Width="200" MaxLength="40" placeholder="输入姓名..." />
                            <i class="icon-chevron-right"></i>&nbsp;状态&nbsp;
                            <asp:DropDownList ID="ddpStatus" runat="server" Width="240px" CssClass="form-control">
                                <%-- <asp:ListItem Value="">- 请选择 -</asp:ListItem>
                                <asp:ListItem Value="0">删除</asp:ListItem>
                                <asp:ListItem Value="1" Selected="True">正常</asp:ListItem>
                                <asp:ListItem Value="2">禁用</asp:ListItem>--%>
                            </asp:DropDownList>
                            <span class="right">
                                <asp:Button Text=" 检 索 " Width="80" runat="server" ID="Button1" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                                <button type="button" class="btn btn-success" onclick="javascript:userCommand('add');" style="width: 80px;">新 增 </button>
                            </span>
                        </div>
    <div class="clear"></div>
    <table class="bordered">
        <thead>
            <tr>
                <th  width="5%" style="text-align:center;"> <input type="checkbox" id="cbk_all" class="checkBox" name="qwselect" onclick="CheckAll(this, 'list_cbk', 'div_seles_tool', 'lbjscnt')" /></th>
                <th width="17%"> &nbsp;模块</th>
                <th width="42%">详情</th>
                <th width="13%">时间</th>
                <th width="12%">IP</th>
                <th width="10%">操作人</th>
            </tr>
        </thead>
        <tbody id="tabResult">
        </tbody>



    </table>
    <div class="pagination" id="pager1">
    </div>
    <script src="../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../javascript/JSPagerDarkstyle.js"></script>
    <script src="../javascript/DateOperate.js"></script>
    <script>
        /* 页面加载 */
        $(document).ready(function () {
            //按钮事件
            $('#btnSearch').click(function () {

                var q = true;
                var key = $.trim($("#txtFullName").val());
                if (key != "" && key != null) {
                    if (key.match(/[#\&\\\'\";/,%<>?、|:+“”\[\]]+/gi)) {
                        //  $("#errorMessage").html("不能包含特殊字符!");
                        AutoClose("txtFullName", "不能包含特殊字符!", "bottom left");
                        $("#txtFullName").focus();
                        q = false;
                        return;
                    }
                }
                if (q) {
                    ClearSession(); //清空session 
                    JSPager.currentIndex = 1;
                    JSPager.pageSize = $('#hidPageSize').val();
                    Search();
                }
            });

            //导出所选
            $('#btnImportSelect').click(function () {

                $.ajax({
                    url: "../ascx/ImportDialog.aspx/AddLog",
                    data: "{pagename:'log'}",
                    method: 'post',
                    contentType: "application/json; charset=utf-8",
                    dataType: 'json',
                    async: false,
                    success: function (data) {
                        var t = data.d;
                    }
                });

                importSelectExcelDefault("imporlog");//导出所选
               

            });

            //加载自动检索
            $('#btnSearch').click();

            InitMenu();
        });

        function InitMenu() {
            $.ajax({
                type: "post",
                url: "loglist.aspx/getFirstMenu",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var res = data.d;
                    if (res != "" && res != null) {
                        var html = '';
                        var sz = res.split(",");
                        var htmlString = "";
                        for (var i = 0; i < sz.length; i++) {
                            html += '<li firstid=' + sz[i] + '><a href="javascript:void(0)">' + sz[i] + '</a></li>';
                        }
                        $("#firstMenu").html('<li firstid=""><a href="javascript:void(0)">全部模块</a></li>' + html);

                        $("#btnFirst,#txtFirst").click(function () {
                            var isplay = $("#firstMenu").css('display');
                            if (isplay != 'none')
                                $("#firstMenu").css('display', 'none');
                            else
                                $("#firstMenu").css('display', '');
                        });
                        $("#firstMenu li").each(function () {
                            $(this).click(function () {
                                $("#txtFirst").val($(this).find("a").html());
                                $("#firstMenu").css('display', 'none');
                                InitSecondMenu();
                            })
                        });

                    } 
                }
            });
        }


        function InitSecondMenu() {
            $("#txtSecond").val('');
            $.ajax({
                type: "post",
                url: "loglist.aspx/getSecondMenu",
                data: "{type:'" + $("#txtFirst").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var res = data.d;
                    if (res != "" && res != null) {
                        $("#txtSecond").attr('placeholder', '请选择菜单...');
                        var html = '';
                        var sz = res.split(",");
                        var htmlString = "";
                        for (var i = 0; i < sz.length; i++) {
                            html += '<li onclick="selectMenu(\'' + sz[i] + '\')"><a href="javascript:void(0)">' + sz[i] + '</a></li>';
                        }

                        $("#secondMenu").html(html);
                    } else {
                        $("#txtSecond").attr('placeholder', '无二级菜单');
                        $("#secondMenu").html("");
                    }
                }
            });
        }

        function show() {
            var isplay = $("#secondMenu").css('display');
            if (isplay != 'none')
                $("#secondMenu").css('display', 'none');
            else
                $("#secondMenu").css('display', '');
        }

        function selectMenu(name) {
            $("#txtSecond").val(name);
            $("#secondMenu").css('display', 'none');
        }

        function Search() {
            $('#tabResult').html('<tr class="tr_loading"><td colspan="8"><img src="/images/loading.gif" alt="" />数据加载中...</td></tr>');
            $.ajax({
                type: "post",
                url: "loglist.aspx/DoLogsSearch",
                data: "{txtFullName:'" + $.trim($("#txtFullName").val()) + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "',type:'" + $("#txtFirst").val() + "',type1:'" + $("#txtSecond").val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    try {
                        $('#tabResult').html('');
                        var json = data.d;
                        if (json == "") {
                            $('#tabResult').html('<tr class="tr_loading"><td colspan="8">未查询到相关数据</td></tr>');
                            JSPager.resetPager('pager1');
                            return;
                        }
                        json = $.parseJSON(json);
                        var html = '';
                        var results = json.sysLoglist;
                        for (var i = 0; i < results.length; i++) {
                            var item = results[i];
                            if (i % 2 == 0)
                                html += '<tr>';
                            else
                                html += '<tr class="highlight">';
                            html += '<td  style="text-align:center;"><input id=\'Checkbox1\' type=\'checkbox\' name=\'list_cbk\' value=\'' + item.id + '\' onclick=\"SaveSelect(this,\'div_seles_tool\',\'lbjscnt\',\'' + item.id + '\')\"></td>';
                            html += '<td>' + item.typeName + '</td>';
                            html += '<td><span title="' + item.result + '">' + CutString(item.result, 45) + '</span></td>';
                            html += '<td>' + item.time + '</td>';
                            html += '<td>' + item.ip + '</td>';
                            html += '<td>' + item.uName + '</td>';


                            html += '</tr>';
                        }
                        $('#tabResult').html(html);
                        //pager2
                        JSPager.totalRecord = json.totalRecord;
                        JSPager.doPager = Search;
                        JSPager.initPager('pager1');
                        loadSelect("div_seles_tool", "lbjscnt", "list_cbk", "cbk_all");
                    }
                    catch (e) {
                        $('#tabResult').html('<tr class="tr_loading"><td colspan="8">' + e.message + '</td></tr>');
                        JSPager.resetPager('pager1');
                    }
                }
            });
        }



    </script>
</body>
</html>
