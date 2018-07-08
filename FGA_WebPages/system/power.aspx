<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="power.aspx.cs" Inherits="FGA_PLATFORM.system.power" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Privilege Managament</title>
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
</head>
<body>
    <div class="divcontent">
        <div class="divmain">
            <div class="tab">
                <div class="head"><i class="icon-cogs"></i>&nbsp;&nbsp;SYSTEMADMIN &nbsp;<i class="icon-angle-right"></i>&nbsp;PrivilegeMAG</div>
                 <%--<div class="title">
                     <div class="title_2">PrivilegeMAG</div>
                 </div>--%>
                <div class="content">
                    <ul id="treeDemo" class="ztree">
                    </ul>
                    <div id="rMenu">
                        <ul>
                            <li id="Li1" onclick="addnode();">
                                <img src="../images/add.png" />AddPrivilege</li>
                            <li id="Li2" onclick="modifynode();">
                                <img src="../images/mod.png" />EditPrivilege</li>
                            <li id="Li3" onclick="deletenode();">
                                <img src="../images/del.png" />DelPrivilege</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    <!-- 菜单树 -->
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js"></script>
    <!-- 弹消息窗 -->
    <script src="../javascript/ymPrompt/ymPrompt.js"></script>
    <!-- 公共js -->
    <script src="../javascript/common.js"></script>
    <script type="text/javascript">
        var zTree, rMenu;
        var editpw=<%=editpw%>;
        //settings
        var setting = {
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
                onRightClick: OnRightClick
            }
        };
        //right click
        function OnRightClick(event, treeId, treeNode) {
            if (editpw == "0") {
                showTopMessage("Warming:you have not the privilege!", "40px", "100%");
                return;
            }
            if (treeNode == null)
                return;
            zTree.selectNode(treeNode);
            var code = treeNode.id;
            if (code.length <= 3) {
                $("#m_del").hide();
            } else {
                $("#m_del").show();
            }
            $("#rMenu ul").show();
            rMenu.css({ "top": pointerY(event) + "px", "left": pointerX(event) + "px", "visibility": "visible" });
            $("body").bind("mousedown", onBodyMouseDown);
        }

        function onBodyMouseDown(event) {
            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
                rMenu.css({ "visibility": "hidden" });
            }
        }
        //add node
        function addnode() {
            var sltNode = zTree.getSelectedNodes();
            if (sltNode == null || sltNode.length <= 0)
                return;
            sltNode = sltNode[0];
            rMenu.css({ "visibility": "hidden" });
            window.parent.showDialog('AddPrivilege', 'system/poweritem.aspx?pcode=' + sltNode.id, 460, 370, function (res) {
                if (res != 'close') {
                    var ary = res.split(SPLIT);
                    if (ary.length == 2) {
                        var icon = "../images/folder.png";
                        var newNode = { id: ary[0], pId: sltNode.id, name: ary[1], tag: "", icon: icon };
                        zTree.addNodes(sltNode, newNode);
                    }
                }
            });
        }
        //modify node
        function modifynode() {
            var sltNode = zTree.getSelectedNodes();
            if (sltNode == null || sltNode.length <= 0)
                return;
            sltNode = sltNode[0];
            rMenu.css({ "visibility": "hidden" });
            window.parent.showDialog('EditPrivilege', 'system/poweritem.aspx?code=' + sltNode.id, 460, 370, function (res) {
                if (res != '' && res != 'close') {
                    var ary = res.split(SPLIT);
                    if (ary.length == 2) {
                        var icon = "../images/floder.png";
                        sltNode.name = ary[1];
                        zTree.updateNode(sltNode);
                    }
                }
            });
        }
        
        function initTree() {
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=treepower&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                success: function (json) {
                    if (json == null || json.length <= 0)
                        return;
                    var zNodes = json;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    zTree = $.fn.zTree.getZTreeObj("treeDemo");
                    zTree.expandAll(true);
                    rMenu = $("#rMenu");
                }
            });
        }

        //event.clientX和event.clientY获取的鼠标位置是相对于当前屏幕的，而不考虑页面的滚动条所滚动的距离。 
        //此方向是获取滚动情况下，鼠标的点击坐标
        function pointerX(event) {
            return event.pageX || (event.clientX + (document.documentElement.scrollLeft || document.body.scrollLeft));
        }

        function pointerY(event) {
            return event.pageY || (event.clientY + (document.documentElement.scrollTop || document.body.scrollTop));
        }

        //init tree
        $(document).ready(function () {
            initTree();
        });
    </script>
</body>
</html>
