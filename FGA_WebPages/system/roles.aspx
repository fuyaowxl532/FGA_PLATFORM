<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="roles.aspx.cs" Inherits="FGA_PLATFORM.system.roles" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>角色管理</title>
    <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link href="../css/style/mystyle.css" rel="stylesheet" />
<link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
     <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->

    <!-- Bootstrap stylesheet min version -->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <script src="../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../javascript/common.js" type="text/javascript"></script>
    <script src="../javascript/sysattach.js" type="text/javascript"></script>
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
   <div class="head"><i class="fa fa-wrench"></i>&nbsp;&nbsp;系统管理 /&nbsp;<i class="fa fa-user"></i>&nbsp;角色管理</div>
<div class="Box">
  <div class="outsideBox">
     
     <input name="" id="txtRoleName" type="text" value="" placeholder="输入角色名称..." class="txtAll"/>
  </div>
  <div class="outsideBox">
     
     <input name="" id="ddpStatus" type="text" value="正常" class="txtAll" style="cursor:not-allowed" disabled="disabled"/>
     <input name="" type="button" class="listBtn" style="left:190px"/>
     <ul class="boxContent" style="display:none">
        <li><a href="javascript:void(0)">删除</a></li>
         <li><a href="javascript:void(0)">正常</a></li>
         <li><a href="javascript:void(0)">禁用</a></li>
     </ul>
  </div>
  <div class="outsideBox outBox2" id="btnSearch" style="cursor:pointer">
     <div class="insideBox insideBox2"><img src="../images/condition_icon3.png"/></div>
     <input name="" type="button" value="搜索" class="search">
  </div>
  <div class=" " style="float:right; margin-right:1%;">
  <div class="outsideBox outBox4">
     <div class="insideBox insideBox4"><img src="../images/condition_icon6.png"></div>
     <input name="" type="button" value="添加角色" onclick="javascript: userCommand('add');" class="search" style="cursor:pointer"/>
  </div>
  </div>
  <div class="clear"></div>
</div>
<div class="clear"></div>
<table class="bordered">
    <thead>
    <tr>    
        <th width=30%>&nbsp;角色名称</th>
        <th width=30%>角色状态</th>
        <th width=40%>操作</th>
    </tr>
    </thead>
    <tbody id="tabResult">
     </tbody>
      
    
   
</table>
    <div class="pagination" id="pager1">
     </div>
    <%--<script src="../javascript/JSPagerDarkstyle.js"></script>--%>
    <script src="../javascript/JSPager.js"></script>
    <script src="../javascript/DateOperate.js"></script>
    <script>
        var state = {
            '删除': '0',
            '正常': '1',
            '禁用': '2'
        };
        /* 页面加载 */
        $(document).ready(function () {
            $(".listBtn").click(function () {
                var isplay = $(".boxContent").css('display');
                if (isplay!='none')
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
            $('#tabResult').html('<tr class="tr_loading"><td colspan="8"><img src="/images/loading.gif" alt="" />数据加载中...</td></tr>');
            var curstate = state[$.trim($("#ddpStatus").val())];
            $.ajax({
                type: "post",
                url: "roles.aspx/DoUsersSearch",
                data: "{name:'" + $.trim($("#txtRoleName").val()) + "',status:'" + curstate + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
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
                        var results = json.rolelist;
                        for (var i = 0; i < results.length; i++) {
                            var item = results[i];
                            if(i%2==0)
                                html += '<tr>';
                            else
                                html += '<tr class="highlight">';
                            html += '<td><span title="' + item.rname + '">&nbsp;' + item.rname + '</span></td>';
                            html += '<td>' + item.state + '</td>';
                            html+='<td>';                    
                            html += '<a title="查看" href="javascript:userCommand(\'view\',\'' + item.rid + '\',\'\');"><img src="../images/icon7.png" />查看</a>&nbsp;&nbsp;';
                            html += '<a title="编辑" href="javascript:userCommand(\'mod\',\'' + item.rid + '\',\'\');"><img src="../images/icon9.png" />编辑</a>&nbsp;&nbsp;';
                            if (item.state != '删除') {
                                html += '<a title="删除" href="javascript:userCommand(\'del\',\'' + item.rid + '\',\'' + item.rname + '\');"><img src="../images/icon10.png" />删除</a>';
                            }
                            html+='</td>';
                            html+='</tr>';
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
                    window.parent.showDialog('角色新增', 'system/rolesitem.aspx', 450, 270, function (res) {
                        if (res == window.ST_OK) {
                            $('#btnSearch').click();
                        }
                    });
                    break;
                case "view":
                    window.parent.showDialog('角色浏览', 'system/rolesitem.aspx?id=' + obj + '&ro=1', 450, 270, null);
                    break;
                case "mod":
                    window.parent.showDialog('角色修改', 'system/rolesitem.aspx?id=' + obj, 450, 270, function (res) {
                        if (res == window.ST_OK) {
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
                                    data: 'cmd=treeroledel&rid=' + obj + '&rname='+name+'&r=' + Math.random(),
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
    </script>

</body>
</html>
