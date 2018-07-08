<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rolepower.aspx.cs" Inherits="FGA_PLATFORM.system.rolepower" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>角色权限分配</title>
    <!--bootstrap-->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <!--字体图标-->
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <!--弹消息窗样式-->
    <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <!--菜单树样式-->
    <link href="../javascript/z_tree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <!--站内样式-->
    <link href="../css/style.css" rel="stylesheet" />
    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->

    <!-- Bootstrap stylesheet min version -->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .breadcrumbs {
            background-color: #f5f5f5;
            border-bottom: 1px solid #fff;
        }

        .bottom {
            background: url(../../images/bottom_bg.jpg) repeat-x;
            width: 100%;
            height: 45px;
            line-height: 50px;
            margin: 0 auto;
            text-align: center;
            color: #565656;
            margin-top: 10px;
            font-size: 14px;
            bottom: 0;
            position: fixed;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <div class="divcontent">
        <div class="divmain">
            <div class="tab">
                <%--<div class="title">
                     <div class="title_2">权限管理</div><span class="right">
                        <a href="javascript:saveRolePowers();"><i class="icon-save"></i>&nbsp;保存当前配置&nbsp;&nbsp;&nbsp;</a>
                    </span>
                 </div>--%>
                <%--<div class='breadcrumbs'>
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
                        <span>角色权限分配</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>--%>
                <div class="head"><i class="fa fa-wrench"></i>&nbsp;&nbsp;系统管理 /&nbsp;<i class="fa fa-share-alt"></i>&nbsp;角色权限分配</div>
                <div class="head">
                           <span class="right";>
                        <a id="savepw" href="javascript:saveRolePowers();"><i class="icon-save"></i>&nbsp;保存当前配置&nbsp;&nbsp;&nbsp;</a>
                    </span>             
                </div>   
                <div class="content">
                    <div class="tabcontainer left">
                        <div class="tab">
                            <div class="head2"><i class="icon-user-md"></i>&nbsp;&nbsp;角色</div>
                            <div>
                                <ul id="treeRole" class="ztree">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tabcontainer left"> 
                        <div class="tab">
                            <div class="head2"><i class="icon-user-md"></i>&nbsp;&nbsp;权限</div>
                            <div>
                                <ul id="treePower" class="ztree">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="clear">
                    </div>
                </div>
            </div>  
        </div>
    </div>
    </form>
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    
        <script src="../javascript/artDialog/dialog-min.js"  type="text/javascript"></script>
    <link  href="../javascript/artDialog/ui-dialog.css"   rel="stylesheet" />

    <!-- 菜单树 -->
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js"></script>
    <!-- 弹消息窗 -->
    <script src="../javascript/ymPrompt/ymPrompt.js"></script>
    <!-- 公共js -->
    <script src="../javascript/common.js"></script>
    <!--验证-->
    <script src="../javascript/ValidationCheck.js"></script>
    <script type="text/javascript">
        var zTreeRole, zTreePower;
        //settings
        var settingRole = {
            view: {
                selectedMulti: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            check: {
                enable: false
            },
            callback: {
                onClick: onRoleClick
            }
        };
        var settingPower = {
            data: {
                simpleData: {
                    enable: true
                }
            },
            check: {
                enable: true
            }
        };
        //init tree
        $(document).ready(function () {
            initRoleTree();
            initPowerTree();
        });
        function initRoleTree() {
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=treerole&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                success: function (json) {
                    if (json == null || json.length <= 0)
                        return;
                    var roleNodes = json;
                    $.fn.zTree.init($("#treeRole"), settingRole, roleNodes);
                    zTreeRole = $.fn.zTree.getZTreeObj("treeRole");
                    zTreeRole.expandAll(true);
                }
            });
        }
        function initPowerTree() {
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=treepoweronlymenu&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                success: function (json) {
                    if (json == null || json.length <= 0)
                        return;
                    var powerNodes = json;
                    $.fn.zTree.init($("#treePower"), settingPower, powerNodes);
                    zTreePower = $.fn.zTree.getZTreeObj("treePower");
                    zTreePower.expandAll(true);
                }
            });
        }
        function onRoleClick(event, treeId, treeNode) {
            if (treeNode.tag.length <= 0) {
                zTreeRole = $.fn.zTree.getZTreeObj("treeRole");
                zTreeRole.cancelSelectedNode(treeNode);
            } else {
                zTreePower.checkAllNodes(false);
                var roleid = treeNode.id;
                $.ajax({
                    url: "sysajax.ashx",
                    data: 'cmd=rolepower&rid=' + roleid + '&r=' + Math.random(),
                    method: 'get',
                    dataType: 'html',
                    success: function (html) {
                        if (html != null && html.length > 0) {
                            var ary = html.split(SPLIT);
                            for (var i = 0; i < ary.length; i++) {
                                var nodes = zTreePower.getNodesByParam("id", ary[i], null);
                                if (nodes.length > 0) {
                                    var pnode = nodes[0];
                                    zTreePower.checkNode(pnode, true, false);
                                }
                            }
                        }
                    }
                });
            }
        };
        function saveRolePowers() {
            var sltRole = zTreeRole.getSelectedNodes();
            if (sltRole == null || sltRole.length <= 0) {
                //qmalert('提示', '请先选中一个角色，再在模块列表中勾选配置模块！', 400, 150);
                //showTopMessage('提示:请先选中一个角色，再在模块列表中勾选配置模块！', '40px', '100%');
                AutoClose("savepw", "请先选中一个角色，再在模块权限列表中勾选配置权限!", "bottom left");
                return;
            }
            sltRole = sltRole[0];
            var powerids = '';
            var powernames = ''
            var powers = zTreePower.getCheckedNodes(true);
            if (powers != null && powers.length > 0) {
                for (var i = 0; i < powers.length; i++) {
                    powerids += powers[i].id + SPLIT_NM;
                    powernames += powers[i].name + SPLIT_NM;
                }
            }
            window.parent.qmconfirm(
                '确认',
                '确认将选中模块权限分配给角色【' + sltRole.name + '】吗？',
                function (res) {
                    if (res == window.ST_OK) {
                        $.ajax({
                            url: "sysajax.ashx",
                            data: 'cmd=rolepowerset&rid=' + sltRole.id + '&powers=' + encodeURI(powerids) + '&rname=' + sltRole.name + '&powernames=' + powernames + '&r=' + Math.random(),
                            method: 'get',
                            dataType: 'html',
                            success: function (html) {
                                if (html == window.ST_OK) {
                                    //qmalert('提示', '角色模块指定成功！', 400, 150);
                                    //showTopMessage('提示:角色模块指定成功!', '40px', '100%');
                                    AutoClose("savepw", "角色模块权限指定成功!", "bottom left");
                                }
                            }
                        });
                    }
                },
                400,
                160
            );
        }
    </script>
</body>
</html>
