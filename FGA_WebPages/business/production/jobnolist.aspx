<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jobnolist.aspx.cs" Inherits="FGA_PLATFORM.business.production.jobnolist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />

    <script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
   <script>
       function savedata(jobno,itemcode) {
           if (confirm("Confirm?")) {
               window.parent.ymPrompt.doHandler(jobno+","+itemcode, true);
           }
       }
   </script>
</head>
<body>
    <form id="form1"  runat="server">
        <input type="hidden" runat="server" id="pno"/>
        <table style="width:550px;height: 530px" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
           
            <thead>
                <tr>
                    <th>JobNO</th>
                    <th>ItemCode</th>
                    <th>ItemName</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                        <tr onclick="savedata('<%# Eval("JobNO")%>','<%# Eval("ItemCode")%>')">
                            <td width="20%" class="tRight"><%# Eval("JobNO") %></td>
                            <td width="20%" class="tRight"><%# Eval("ItemCode") %></td>
                            <td width="20%" class="tRight"><%# Eval("ItemName") %></td>
                            <td width="20%" class="tRight"><%# Eval("Quantity") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </form>
</body>
</html>

