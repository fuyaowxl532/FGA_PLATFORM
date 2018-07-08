<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="roleselect.aspx.cs" Inherits="FGA_PLATFORM.system.roleselect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>角色选择</title>
    <!--bootstrap-->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
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
            <div class="content">
                <ul id="treeDemo" class="ztree">
                </ul>
                <div style="text-align: center;">
                    <input type="button" value="确定" class="btn btn-primary" onclick="selectRole();" />
                    <input type="button" value="取消" class="btn btn-default" onclick="window.parent.ymPrompt.doHandler('clear');" />
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
               }
           };

           function initTree() {
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=treerole&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                success: function (json) {
                    if (json == null || json.length <= 0)
                        return;
                    var zNodes = json;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    zTree = $.fn.zTree.getZTreeObj("treeDemo");
                    zTree.expandAll(true);
                }
            });
        }
        //init tree
        $(document).ready(function () {
            initTree();
        });
        function selectRole() {
            var sltNode = zTree.getSelectedNodes();
            if (sltNode == null || sltNode.length <= 0) {
                showTopMessage('请先某个角色！', "40px", "100%");
                return;
            }
            sltNode = sltNode[0];
            var res = sltNode.id + SPLIT + sltNode.name;
            window.parent.ymPrompt.doHandler(res);
        }
    </script>
</body>
</html>
