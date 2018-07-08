<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="powertabletree.aspx.cs" Inherits="FGA_PLATFORM.system.powertabletree" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />
    <link href="../css/style/mystyle.css" rel="stylesheet" />
    <!--treetable-->
    <%--<link href="../javascript/treeTablev1.4.2/demo/style/demo.css" rel="stylesheet" />--%>
    <%--<link href="../javascript/treeTablev1.4.2/script/treeTable/vsStyle/jquery.treeTable.css" rel="stylesheet" />--%>
    <link href="../javascript/treeTablev1.4.2/script/treeTable/default/jquery.treeTable.css" rel="stylesheet" />
    <script src="../javascript/treeTablev1.4.2/script/treeTable/jquery.treeTable.js"></script>
        <!--cookie操作-->
        <script src="../javascript/CookieSet.js"></script>
        <script src="../javascript/MyBusiness/getSkin.js"></script>
    <style>
        .bordered td, .bordered th {
            text-align: left;
        }
    </style>
</head>
<body>
    <div class='breadcrumbs'>
        <div class='inner'>
            <ul class='cf'>
                <li>
                    <a>
                        <span>1</span>
                        <span>系统管理</span>
                    </a>
                </li>
                <li>
                    <a class='active'>
                        <span>2</span>
                        <span>权限管理</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
    <div id="tableResult">
    </div>
    <%--<table class="bordered" id="tabledata" style='font: 12px/1 "微软雅黑","宋体";'>
        <thead>
            <tr>
                <th width="25%">&nbsp;权限名称</th>
                <th width="25%">URL</th>
                  <th width="10%">是否显示</th>
                <th width="25%">描述</th>
                <th width="15%">操作</th>
            </tr>
        </thead>
        <tbody id="tabResult">
        </tbody>
    </table>--%>
    <script type="text/ecmascript">
        var tablehead = '<table class="bordered" id="tabledata" style=\'font:12px/1 "微软雅黑","宋体"\'>' +
                        '<thead>' +
                        '<tr>' +
                        '<th width="25%">&nbsp;权限名称</th>' +
                        '<th width="25%">URL</th>' +
                        '<th width="10%">是否菜单</th>' +
                        '<th width="25%">描述</th>' +
                        '<th width="15%">操作</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody id="tabResult">';
        var tableend = '</tbody></table>';
        /* 页面加载 */
        $(document).ready(function () {
            //加载自动检索
            initTree();
        });
        function initTree() {
            $('#tableResult').html(tablehead +'<tr class="tr_loading"><td colspan="4"><img src="/images/loading.gif" alt="" />数据加载中...</td></tr>'+ tableend);
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=powertreetable&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                async: true,
                success: function (json) {
                    try {
                        $('#tableResult').html('');
                        if (json == "") {
                            $('#tableResult').html(tablehead + '未查询到相关数据！' + tableend);
                            return;
                        }

                        var html = '';
                        html += tablehead;
                        var results = json.zlist;
                        for (var i = 0; i < results.length; i++) {
                            var item = results[i];
                            var dd = '';
                            dd = item.pid == "0" ? "" : "pId=\"" + item.pId + "\"";
                            if (i % 2 != 0) {
                                html += '<tr class="highlight" id=\'' + item.id + '\'' + dd + ' >';
                            }
                            else
                                html += '<tr id=\'' + item.id + '\'' + dd + ' >';
                            html += '<td>' + item.name + '</td>';
                            var param = item.url == '' ? '暂无' : item.url;
                            html += '<td>' + param + '</td>';
                            html += '<td>' + (item.bz=="0"?"菜单":"非菜单") + '</td>';
                            param = item.des == '' ? '暂无' : item.des;
                            html += '<td>' + param + '</td>';
                            html += '<td>';
                            html += '<a title="添加" href="javascript:operatefun(\'add\',\'' + item.id + '\');"><img src="../images/icon21.png">添加</a>&nbsp;&nbsp;';

                            html += '<a title="编辑" href="javascript:operatefun(\'mod\',\'' + item.id + '\');"><img src="../images/icon9.png">编辑</a>';

                            html += '</td>';
                            html += '</tr>';
                        }
                        html += tableend;
                        $('#tableResult').html(html);
                        setTree();
                    }
                    catch (e) {
                        $('#tableResult').html(tablehead + '<tr class="tr_loading"><td colspan="8">' + e.message + '</td></tr>' + tableend);
                    }
                }
            });
        }
        function setTree() {
            var tbhtml = "";
            var option = {
                //theme: 'vsStyle',
                theme: 'default',
                expandLevel: 3,//展开深度
                beforeExpand: function ($treeTable, id) {
                    if ($('.' + id, $treeTable).length) { return; }
                },
                onSelect: function ($treeTable, id) {

                    //window.console && console.log('onSelect:' + id);

                }
            };
            $('#tabledata').treeTable(option);
        }
        function operatefun(opertype, id) {
            switch (opertype) {
                case "add":
                    window.parent.showDialog('添加权限', 'system/poweritem.aspx?pcode=' + id, 560, 380, function (res) {
                        if (res != 'close') {
                            initTree();
                        }
                    });
                    break;
                case "mod":
                    window.parent.showDialog('编辑权限', 'system/poweritem.aspx?code=' + id, 560, 380, function (res) {
                        if (res != '' && res != 'close') {
                            initTree();
                        }
                    });
                    break;
                default:
                    break;
            }
        }
    </script>
</body>
</html>
