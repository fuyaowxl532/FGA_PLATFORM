<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userselect.aspx.cs" Inherits="FGA_PLATFORM.system.userselect" ValidateRequest="false" EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>用户选择</title>
    <!--bootstrap-->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!--字体图标-->
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <!--弹消息窗样式-->
    <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
    <link href="../javascript/z_tree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <!--站内样式-->
    <link href="../css/style.css" rel="stylesheet" />
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js" type="text/javascript"></script>
    <script src="../javascript/common.js" type="text/javascript"></script>
    
    
    <script type="text/javascript">
        var isMuti = <%=MutiCheck %>;
        var zTree;
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
                enable: isMuti
            } ,
            callback: {
                onClick: onUserClick
            }
        };
        function onUserClick(event, treeId, treeNode) {
            if(isMuti){
                zTree = $.fn.zTree.getZTreeObj("treeUser");
                zTree.cancelSelectedNode(treeNode);
            }else{
                var tag = treeNode.tag;
                if(tag==null || tag=='')
                    zTree.cancelSelectedNode(treeNode);
            }
        }
        function initTree() {
            $.ajax({
                url: "sysajax.ashx",
                data: 'cmd=treeuser&r=' + Math.random(),
                method: 'get',
                dataType: 'json',
                success: function (json) {
                    if (json == null || json.length <= 0)
                        return;
                    if(isMuti){
                        for (var i = 0; i < json.length; i++) {
                            var tag = json[i].tag;
                            if(tag.length<=0)
                                json[i].nocheck=true;
                        }
                    }
                    var zNodes = json;
                    $.fn.zTree.init($("#treeUser"), setting, zNodes);
                    zTree = $.fn.zTree.getZTreeObj("treeUser");
                    zTree.expandAll(true);
                }
            });
        }
        //init tree
        $(document).ready(function () {
            initTree();
        });
        function selectUser(){
            var res = '';
            if(!isMuti){
                var sltNode = zTree.getSelectedNodes();
                if (sltNode == null || sltNode.length <= 0) {
                    showTopMessage('请先选中一个用户节点！','40px','100%');
                    
                    return;
                }
                sltNode = sltNode[0];
                //alert(sltNode.tag);
                res = sltNode.id + SPLIT + sltNode.name;
            }else{
                var sltNode = zTree.getCheckedNodes(true);
                if (sltNode == null || sltNode.length <= 0) {
                    showTopMessage('请先勾选要指定用户节点！','40px','100%');
                    return;
                }
                var names='',ids='';
                for (var i = 0; i < sltNode.length; i++) {
                    ids += (sltNode[i].id + SPLIT2);
                    names += (sltNode[i].name + SPLIT2); 
                }
                ids = ids.substring(0,ids.length-1);
                names = names.substring(0,names.length-1);
                res = ids + SPLIT +names;
            }
            window.parent.ymPrompt.doHandler(res);
        }
    </script>
</head>
<body style="overflow: hidden;">
    <div class="content_main">
        <div class="divmain">
            <ul id="treeUser" class="ztree" style="height:350px;overflow-y:scroll;" >
            </ul>
        </div>
    </div>
    <div class="divbottom">
        <input type="button" value="确定" class="button" onclick="selectUser();" />
        <input type="button" value="清空" class="button" onclick="window.parent.ymPrompt.doHandler('clear');" />
    </div>
</body>
</html>
