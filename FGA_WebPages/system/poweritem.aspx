<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poweritem.aspx.cs" Inherits="FGA_PLATFORM.system.poweritem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>PrivilegeInfo</title>
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <!--弹消息窗样式-->
   <%-- <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />--%>
    <!--菜单树样式-->
    <link href="../javascript/z_tree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
     <script src="../javascript/jquery-3.1.0.min.js"></script>
     <script src="../javascript/artDialog/dialog-min.js"  type="text/javascript"></script>
    <link  href="../javascript/artDialog/ui-dialog.css"   rel="stylesheet" />

     <script type="text/javascript">

         function saveCheck() {

             if ($.trim($("#txtName").val()) == "") {
                 AutoClose("txtName", "Privilege name is empty!, "bottom left");
                 return false;
             }
             else if (!filterSqlStr($.trim($("#txtName").val()))) {
                 AutoClose("txtName", "权限名称含有特殊字符!", "bottom left");
                 return false;
             }
             if (!filterSqlStr($.trim($("#txtDescription").val()))) {
                 AutoClose("txtDescription", "说明含有特殊字符!", "bottom left");
                 return false;
             }
             

         }
    </script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <table height="157" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
            <tr>
                <td width="20%" class="tRight">权限名称<span class="tip">*</span></td>
                <td width="80%">
                    <div class="outsideBox">
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="30"></asp:TextBox>
                        </div>
                   
                </td>
            </tr>
            <tr>
                <td width="20%" class="tRight">Url地址</td>
                <td width="80%">
                    <div class="outsideBox">
                    <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" MaxLength="200"></asp:TextBox>
                       </div>
                </td>
            </tr>
            <tr>
                <td width="20%" class="tRight">描述</td>
                <td width="80%">
                    <div class="outsideBox">
                          <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" MaxLength="250" TextMode="MultiLine" Rows="3"></asp:TextBox>
                         </div>
                </td>
            </tr>
             <tr>
                <td width="20%" class="tRight">是否菜单</td>
                <td width="80%">
                   <div style="margin: 10px 0 10px 10px;">
                        <asp:RadioButton ID="rdoYes" runat="server" GroupName="s" />是 &nbsp; &nbsp; &nbsp;
                           <asp:RadioButton ID="rdoNo" runat="server" Checked="true"  GroupName="s"  />否
                         </div>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server" Text=" 确 定 " OnClientClick="return saveCheck();" OnClick="OnBtnSaveClick" CssClass="btn btn-primary" />
                            <input type="button" class="btn btn-red" value=" 关 闭 " onclick="window.parent.ymPrompt.doHandler('close', true);" />
                </td>
            </tr>
        </table>
    </form>
    <!-- jquery脚本库 -->

    <!-- 菜单树 -->
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js"></script>
    <!-- 弹消息窗 -->
   <%-- <script src="../javascript/ymPrompt/ymPrompt.js"></script>--%>
    <!-- 公共js -->
    <script src="../javascript/common.js"></script>
    <!--特殊字符验证-->
    <script src="../javascript/MyBusiness/StrCheck.js"></script>
    <!--验证-->
   <%-- <script src="../javascript/ValidationCheck.js"></script>--%>
   
</body>
</html>
