<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reasoncode.aspx.cs" Inherits="FGA_PLATFORM.business.production.reasoncode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />

    <script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../../javascript/common.js"></script>
   <script>
       function savedata(Reason, ReasonDesc) {
           if (confirm("Confirm?")) {
               var pno = $("#pno").val();
               var workcenter = GetQueryString('workcenter');
               $.ajax({
                   type: "Post",
                   url: "reasoncode.aspx/UpdateSqrd",
                   data: "{Reason:'" + Reason + "',ReasonDesc:'" + ReasonDesc + "',pno:'" + pno + "',workcenter:'" + workcenter + "'}",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: true,
                   success: function (data) {
                       if (data.d == "1") {
                           //alert('success');
                           window.parent.ymPrompt.doHandler('ok', true);
                       }
                   }
               });
           }
       }
   </script>
</head>
<body>
    <form id="form1" height="130" width="30" runat="server">
        <input type="hidden" runat="server" id="pno"/>
        <table height="130" width="30" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
            <!--<tr>
                <td width="20%" class="tRight">reason</td>
                <td width="80%">

                       <asp:DropDownList ID="ddlreason" runat="server" DataTextField="rname" DataValueField="rid" CssClass="form-control" style="width:200px;margin-left:10px;height:37px">
                                     </asp:DropDownList>

                </td>
            </tr>


            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server" Text=" OK "  OnClick="OnBtnSaveClick" CssClass="btn btn-primary" />
                    <input type="button" class="btn btn-red" value=" Cancel " onclick="window.parent.ymPrompt.doHandler('close', true);" />
                </td>
            </tr>-->
            <thead>
                <tr>
                    <th>Reason</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                        <tr onclick="savedata('<%# Eval("Reason")%>','<%# Eval("ReasonDesc")%>')">
                            <td width="20%" class="tRight"><%# Eval("Reason") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </form>
</body>
</html>
