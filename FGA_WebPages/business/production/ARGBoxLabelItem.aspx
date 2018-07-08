<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARGBoxLabelItem.aspx.cs" Inherits="FGA_PLATFORM.business.production.ARGBoxLabelItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User Detail infos</title>
    <!--站内样式-->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
    <!--弹消息窗样式-->
   <%-- <link href="../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />--%>
    <!--菜单树样式-->
    <link href="../javascript/z_tree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <!-- 弹消息窗 -->
    <%--<script src="../javascript/ymPrompt/ymPrompt.js"></script>--%>
    <!--验证-->
   <%-- <script src="../javascript/ValidationCheck.js"></script>--%>
    <!-- jquery脚本库 -->
    <script src="../javascript/jquery-3.1.0.min.js"></script>
    <!-- 公共js -->
     <script src="../javascript/artDialog/dialog-min.js"  type="text/javascript"></script>
    <!--特殊字符验证-->
    <script src="../javascript/MyBusiness/StrCheck.js"></script>
    <link  href="../javascript/artDialog/ui-dialog.css"   rel="stylesheet" />

    <script src="../javascript/common.js"></script>
    <script src="../javascript/validate.js"></script>
    <!-- 菜单树 -->
    <script src="../javascript/z_tree/js/jquery.ztree.all-3.5.js"></script>
    <!--日期控件-->
    <script src="../javascript/My97DatePicker/WdatePicker.js"></script>
    <link href="../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <link href="../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
    <style>
        .txtAllJump1 {
            width: 200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" autocomplete="off">
        <table height="157" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
            <tr>
                <td width="15%" class="tRight">username<span class="tip">*</span></td>
                <td width="35%">
                    <div class="outsideBox">
                        <asp:TextBox ID="txtLoginId" runat="server" CssClass="form-control" MaxLength="40"></asp:TextBox>
                        </div>
                   
                </td>
                <td width="15%" class="tRight">EMAIL<span class="tip">*</span></td>
                <td width="35%"><asp:TextBox ID="txtemail" runat="server" CssClass="form-control" MaxLength="4"></asp:TextBox></td>
            </tr>
            <tr>
                <td width="15%" class="tRight">password</td>
                <td width="35%">
                    <asp:Button ID="btnPassword" runat="server" CssClass="btn btn-default" style="" Text="Default:000000"
                                    OnClick="OnPasswordReset" />
                </td>
                <td width="15%" class="tRight">role<span class="tip">*</span></td>
                <td width="35%"><asp:DropDownList ID="ddlRole" runat="server" DataTextField="rname" DataValueField="rid" CssClass="form-control" style="width:200px;height:37px">
                                     </asp:DropDownList></td>
            </tr>
            <tr>
                <td width="15%" class="tRight">TEL<span class="tip">*</span></td>
                <td width="35%">
                    <div class="outsideBox">
                    <asp:TextBox ID="txtPhone1" runat="server" CssClass="form-control" MaxLength="40"></asp:TextBox>
                       </div>
                </td>
                <td width="15%" class="tRight">ACTIVEDATE</td>
                <td width="35%">
                    <div class="outsideBox">
                    <asp:TextBox ID="txtsendstarttime" runat="server" CssClass="form-control"  MaxLength="30" placeholder="select..." onfocus="WdatePicker({skin:'default',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
                        </div></td>
            </tr>
            <tr>
                <td width="15%" class="tRight">status</td>
                <td width="35%">
                    <asp:DropDownList ID="ddpStatus" runat="server" CssClass="form-control" style="width:200px;height:37px">

                                    <asp:ListItem Value="0">delete</asp:ListItem>
                                    <asp:ListItem Value="1" Selected="True">normal</asp:ListItem>
                                    <asp:ListItem Value="2">disable</asp:ListItem>
                                </asp:DropDownList>
                </td>
                <td width="15%" class="tRight">createdate</td>
                <td width="35%">
                    <div class="outsideBox">
                    <asp:TextBox ID="txtCreatetime" runat="server" CssClass="form-control" MaxLength="30" ReadOnly="true"></asp:TextBox>
                        </div>
                        </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server"  Text=" OK " OnClientClick="return saveCheck();" OnClick="OnBtnSaveClick" CssClass="btn btn-primary" />
                                <input type="button" class="btn btn-red"   value=" CLOSE " onclick="window.parent.ymPrompt.doHandler('close', true);" />
                </td>
            </tr>
        </table>
    </form>


    <script type="text/javascript">
        function initValidation() {
            var formValidation = new FormValidation("form1", "1");
            formValidation.addFieldValInfo("txtLoginId", new RequiredStrValidator("登录名"));
            formValidation.addFieldValInfo("ddlDept", new RequiredStrValidator("部门名称"));
            formValidation.addFieldValInfo("ddlRole", new RequiredStrValidator("角色"));
            formValidation.addFieldValInfo("txtFullname", new RequiredStrValidator("姓名"));
            formValidation.addFieldValInfo("txtAge", new IntegerValidator("年龄", 1, 100));
            return formValidation;
        }
        function saveCheck() {
          
            if ($.trim($("#txtLoginId").val()) == "") {
                AutoClose("txtLoginId", "登录名不能为空!", "bottom left");
                return false;
            }
            else if (!filterSqlStr($.trim($("#txtLoginId").val()))) {
                AutoClose("txtLoginId", "登录名含有特殊字符!", "bottom left");
                return false;
            }
            if ($.trim($("#ddlRole").val()) == "") {
                AutoClose("ddlRole", "角色不能为空!", "bottom left");
                return false;
            }
            
            if ($.trim($("#txtPhone1").val()) != "" && !isMobile($.trim($("#txtPhone1").val()))) {
                AutoClose("txtPhone1", "手机号码错误!", "bottom left");
                return false;
            }
            
        }


        function RoleSelect() {
            window.parent.showDialog('角色选择', 'roleselect.aspx', 260, 220, function (res) {
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
