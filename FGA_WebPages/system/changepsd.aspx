<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changepsd.aspx.cs" Inherits="FGA_PLATFORM.system.changepsd" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Change Password</title>
    <link href="../mouldifi-v-2.0/css/style.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->


</head>
<body>
    <form id="form1" runat="server">
       <%-- <ol class="breadcrumb breadcrumb-2"> 
				<li><a href="javascript:void(0)" style="cursor:default"><i class="fa fa-home"></i>SystemAdmin</a></li> 
				<li class="active"><strong>ChangePwd</strong></li> 
			</ol>--%>
        <div class="head"><i class="fa fa-wrench"></i>&nbsp;&nbsp;SystemAdmin /&nbsp;<i class="fa fa-key"></i>&nbsp;ChangePwd</div>
        <table class="table table-striped table-bordered table-hover dataTables-example dataTable">
            <tr class="highlight">
                <td style="text-align: right; padding-right: 2px; width: 15%">Current Password：</td>
                <td style="text-align: left; padding-left: 5px;">
                    <div class="outsideBox">
                        <asp:TextBox ID="txtcurrent" runat="server" CssClass="form-control" MaxLength="30" TextMode="Password"></asp:TextBox></div>
                </td>
            </tr>
            <tr class="">
                <td style="text-align: right; padding-right: 2px; width: 15%">New Password:</td>
                <td style="text-align: left; padding-left: 5px;">
                    <div class="outsideBox">
                        <asp:TextBox ID="txtnew" runat="server" CssClass="form-control" MaxLength="30" TextMode="Password"></asp:TextBox></div>
                </td>
            </tr>
            <tr class="highlight">
                <td style="text-align: right; padding-right: 2px; width: 15%">Confirm New Password:</td>
                <td style="text-align: left; padding-left: 5px;">
                    <div class="outsideBox">
                        <asp:TextBox ID="txtnew2" runat="server" CssClass="form-control" MaxLength="30" TextMode="Password"></asp:TextBox></div>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 2px; width: 15%"></td>
                <td style="text-align: left; padding-left: 5px;">
                    <asp:Button ID="btnSub" runat="server" CssClass="btn btn-primary" Style="margin: 6px auto" Text="Submit" OnClick="OnBtnSubClick" OnClientClick="return saveCheck();" /></td>
            </tr>
        </table>
        <script src="../javascript/jquery-3.1.0.min.js"></script>
        <script src="../bootstrap/js/bootstrap.min.js"></script>
        <%-- <script src="../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>--%>
        <script src="../javascript/common.js" type="text/javascript"></script>
        <%--<script src="../javascript/ValidationCheck.js"></script>--%>

        <script src="../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
        <link href="../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
        <!--cookie操作-->
        <script src="../javascript/CookieSet.js"></script>
        <script src="../javascript/MyBusiness/getSkin.js"></script>
        <script src="../javascript/MyBusiness/StrCheck.js"></script>

        <script type="text/javascript">
            function initValidation() {
                //var formValidation = new FormValidation("form1", "1");
                //formValidation.addFieldValInfo("txtcurrent", new RequiredStrValidator("当前密码"));
                //formValidation.addFieldValInfo("txtnew", new RequiredStrValidator("新密码"));
                //formValidation.addFieldValInfo("txtnew2", new RequiredStrValidator("新密码确认"));
                //return formValidation;
            }
            function saveCheck() {
                //if (checkFormData(initValidation())) {
                //    return true;
                //}
                //return false;
                if ($.trim($("#txtcurrent").val()) == "") {
                    AutoClose("txtcurrent", "Current Password is empty!", "right");
                    //showTopMessage('当前密码不能为空!', '40px', '100%');
                    return false;
                }
                if ($.trim($("#txtnew").val()) == "") {
                    AutoClose("txtnew", "New Password is empty!", "right");
                    //showTopMessage('新密码不能为空!', '40px', '100%');
                    return false;
                }
                else if (!filterSqlStr($.trim($("#txtnew").val()))) {
                    AutoClose("txtnew", "New Password contains special charaters!", "right");
                    return false;
                }
                if ($.trim($("#txtnew2").val()) == "") {
                    AutoClose("txtnew2", "Confirm New Password is empty!", "right");
                    //showTopMessage('新密码确认不能为空!', '40px', '100%');
                    return false;
                }
                if ($.trim($("#txtnew").val()) != $.trim($("#txtnew2").val())) {
                    AutoClose("txtnew2", "New Password and Confirm Password fileds don't match!", "right");
                    //showTopMessage('两次密码不一致!', '40px', '100%');
                    return false;
                }

            }
        </script>
    </form>
</body>
</html>

