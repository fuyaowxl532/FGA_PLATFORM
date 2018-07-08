<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="FGA_PLATFORM.system.users" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>UserManager</title>

    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />
    <link href="../css/style/mystyle.css" rel="stylesheet" />
    <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->
    <!-- Bootstrap stylesheet min version -->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
    <!--弹消息窗样式-->
    <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>

    <script src="../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../javascript/common.js" type="text/javascript"></script>
    <script src="../javascript/My97DatePicker/WdatePicker.js"></script>
    <!--验证-->
    <script src="../javascript/ValidationCheck.js"></script>
    <style>
        .bordered td, .bordered th {
            text-align: left;
        }
    </style>
</head>
<body>
    <input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
    <div class="head"><i class="fa fa-wrench"></i>&nbsp;&nbsp;SystemManager /&nbsp;<i class="fa fa-user"></i>&nbsp;UserManager</div>
    <div class="Box">
        <div class="outsideBox">
            <input name="" id="txtLoginId" type="text" value="" placeholder="input username..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="txtName" type="text" value="" placeholder="input name..." class="txtAll" />
        </div>
        <div class="outsideBox">
            <input name="" id="ddpStatus" type="text" value="normal" class="txtAll" style="cursor: not-allowed" disabled="disabled" />
            <input name="" type="button" class="listBtn" style="left:190px"/>
            <ul class="boxContent" style="display: none">
                <li><a href="javascript:void(0)">delete</a></li>
                <li><a href="javascript:void(0)">normal</a></li>
                <li><a href="javascript:void(0)">disable</a></li>
            </ul>
        </div>
        <div class="outsideBox outBox2" id="btnSearch" style="cursor: pointer">
            <div class="insideBox insideBox2">
                <img src="../images/condition_icon3.png" /></div>
            <input name="" type="button" value="Search" class="search">
        </div>
        <div class=" " style="float: right; margin-right: 1%;">
            <div class="outsideBox outBox4">
                <div class="insideBox insideBox4">
                    <img src="../images/condition_icon6.png"></div>
                <input name="" type="button" value="AddUser" onclick="javascript: userCommand('add');" class="search" style="cursor: pointer" />
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    <table class="bordered">
        <thead>
            <tr>
                <th width="10%">&nbsp;Username</th>
                <th width="10%">Name</th>

                <th width="15%">Role</th>
                <th width="10%">Status</th>
                <th width="20%">CreateTime</th>
                <th width="20%">Operation</th>
            </tr>
        </thead>
        <tbody id="tabResult">
        </tbody>



    </table>
    <div class="clear"></div>
    <div class="pagination" id="pager1">
    </div>
    <script src="../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../javascript/JSPager.js"></script>
    <script src="../javascript/DateOperate.js"></script>
    <script>
        var state = {
            'delete': '0',
            'normal': '1',
            'disable': '2'
        };
        /* 页面加载 */
        $(document).ready(function () {
            $(".listBtn").click(function () {
                var isplay = $(".boxContent").css('display');
                if (isplay != 'none')
                    $(".boxContent").css('display', 'none');
                else
                    $(".boxContent").css('display', '');
            });
            $(".boxContent li").each(function () {
                $(this).click(function () {
                    $("#ddpStatus").val($(this).find("a").html());
                    $(".boxContent").css('display', 'none');
                })
            });
            //按钮事件
            $('#btnSearch').click(function () {
                JSPager.currentIndex = 1;
                JSPager.pageSize = $('#hidPageSize').val();
                Search();
            });
            //加载自动检索
            $('#btnSearch').click();
        });

        function Search() {
            $('#tabResult').html('<tr class="tr_loading"><td colspan="8"><img src="../images/loading.gif" alt="" />数据加载中...</td></tr>');
            var curstate = state[$.trim($("#ddpStatus").val())];
            $.ajax({
                type: "post",
                url: "users.aspx/DoUsersSearch",
                data: "{strLoginId:'" + $.trim($("#txtLoginId").val()) + "',strName:'" + $.trim($("#txtName").val()) + "',status:'" + curstate + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
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
                        var results = json.userlist;
                        for (var i = 0; i < results.length; i++) {
                            var item = results[i];
                            if (i % 2 == 0)
                                html += '<tr>';
                            else
                                html += '<tr class="highlight">';
                            html += '<td>&nbsp;' + item.USERNAME + '</td>';
                            html += '<td>' + item.USERNAME + '</td>';
                     
                            html += '<td>' + item.rolename + '</td>';
                            html += '<td>' + item.STATUS + '</td>';
                            html += '<td>' + item.CREATEDATE + '</td>';
                            html += '<td>';

                            html += '<button title="查看" class="btn btn-info btn-outline" type="button" onclick="javascript:userCommand(\'view\',\'' + item.USERID + '\',\'\');">View</button>&nbsp;&nbsp;';
                            html += '<button title="编辑" class="btn btn-success btn-outline" type="button"  onclick="javascript:userCommand(\'mod\',\'' + item.USERID + '\',\'\');">Edit</button>&nbsp;&nbsp;';
                            if (item.state != '删除') {
                                html += '<button title="删除" class="btn btn-red btn-outline" type="button"  onclick="javascript:userCommand(\'del\',\'' + item.USERID + '\',\'' + item.USERNAME + '\');">Delete</button>';
                            }
                            html += '</td>';
                            html += '</tr>';
                        }
                        $('#tabResult').html(html);
                        //pager2
                        JSPager.totalRecord = json.totalRecord;
                        JSPager.doPager = Search;
                        JSPager.initPager('pager1');
                    }
                    catch (e) {
                        $('#tabResult').html('<tr class="tr_loading"><td colspan="8">' + e.message + '</td></tr>');
                        JSPager.resetPager('pager1');
                    }
                }
            });
        }
        function userCommand(cmd, obj,name) {
            switch (cmd) {
                case "add":
                    window.parent.showDialog('Add User', '../system/usersitem.aspx', 650, 350, function (res) {
                        if (res == window.ST_OK) {
                            $("#ddpStatus").attr("value", "normal");
                            $('#btnSearch').click();

                        }
                    });
                    break;
                case "view":
                    window.parent.showDialog('人员浏览', '../system/usersitem.aspx?id=' + obj + '&ro=1', 650, 350, null);
                    break;
                case "mod":
                    window.parent.showDialog('人员修改', '../system/usersitem.aspx?id=' + obj, 650, 350, function (res) {
                        if (res == window.ST_OK) {
                            $("#ddpStatus").attr("value", "正常");
                            $('#btnSearch').click();
                        }
                    });
                    break;
                case "del":
                    window.parent.qmconfirm(
                         '警告',
                         '确认继续删除么？',
                         function (res) {
                             if (res == 'ok') {
                                 $.ajax({
                                     url: "../system/sysajax.ashx",
                                     data: 'cmd=userdel&uid=' + obj + '&name='+name+'&r=' + Math.random(),
                                     method: 'get',
                                     dataType: 'html',
                                     success: function (html) {
                                         if (html == ST_OK) {
                                             $('#btnSearch').click();
                                         }
                                     }
                                 });
                             }
                         },
                         400,
                         200
                     );
                    break;
                default:
                    break;
            }
        }

        function RoleSelect() {
            window.parent.showDialog('角色选择', 'system/roleselect.aspx', 260, 220, function (res) {
                if (res == 'clear' || res == 'close') {
                    $('#txtRole').val('');
                    $('#hidRole').val('');
                } else {
                    var ary = res.split(SPLIT);
                    $('#txtRole').val(ary[1]);
                    $('#hidRole').val(ary[0]);
                }
            });
        }

    </script>
</body>
</html>
