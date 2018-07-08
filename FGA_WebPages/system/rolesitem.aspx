<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rolesitem.aspx.cs" Inherits="FGA_PLATFORM.system.RolesItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>人员管理</title>
    <!--站内样式-->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <!--弹消息窗样式-->
    <%--<link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />--%>
    <!--菜单树样式-->
    <link href="../javascript/z_tree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
   
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
     <!-- 弹消息窗 -->
    <%--<script src="../javascript/ymPrompt/ymPrompt.js"></script>--%>
    <!-- 公共js -->
    <script src="../javascript/common.js"></script>
    <!--特殊字符验证-->
    <script src="../javascript/MyBusiness/StrCheck.js"></script>
    <!-- 菜单树 -->
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js"></script>

     <script src="../javascript/artDialog/dialog-min.js"  type="text/javascript"></script>
    <link  href="../javascript/artDialog/ui-dialog.css"   rel="stylesheet" />

    <style>
        .txtAllJump1 {
            width: 300px;
        }
    </style>
    <script type="text/javascript">
       

        function saveCheck() {
           
            if ($.trim($("#txtRoleName").val()) == "") {
                AutoClose("txtRoleName", "角色名称不能为空!", "bottom left");
                return false;
            }
            else if (!filterSqlStr($.trim($("#txtRoleName").val()))) {
                AutoClose("txtRoleName", "角色名称含有特殊字符!", "bottom left");
                return false;
            }
           
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <div>
            <table height="157" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
            <tr>
                <td width="20%" class="tRight">角色名称<span class="tip">*</span></td>
                <td width="80%">
                    <div class="outsideBox">
                    <asp:TextBox ID="txtRoleName" runat="server" MaxLength="40" CssClass="form-control"></asp:TextBox>
                        </div>
                   
                </td>
            </tr>
            <tr>
                <td width="20%" class="tRight">角色状态<span class="tip">*</span></td>
                <td width="80%">
                          <asp:DropDownList ID="ddpStatus" runat="server" style="height:37px" CssClass="form-control">
                                    <asp:ListItem Selected="True" Value="1">正常</asp:ListItem>
                                    <asp:ListItem Value="2">禁用</asp:ListItem>
                                    <asp:ListItem Value="0">删除</asp:ListItem>
                                </asp:DropDownList>
                </td>
            </tr>
            
            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClientClick="return saveCheck();"  Text=" 确 定 " OnClick="OnBtnSaveClick" />
                                <input type="button" class="btn btn-red" value=" 关 闭 " onclick="window.parent.ymPrompt.doHandler('close', true);" />
                </td>
            </tr>
        </table>
        </div>
    </form>
</body>
</html>
