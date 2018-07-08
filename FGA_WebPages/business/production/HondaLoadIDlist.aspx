<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HondaLoadIDlist.aspx.cs" Inherits="FGA_PLATFORM.business.production.HondaLoadIDlist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/plugins/datatables/jquery.dataTables.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />

    <script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
   <script>
       function savedata(LoadID, Quantity, CustomerName, CustomerAddress) {
           if (confirm("Confirm?")) {
               window.parent.ymPrompt.doHandler(LoadID, true);
               window.parent.$('#P1').html('<h1>' + Quantity + '</h1>');
               window.parent.$('#P2').html('<h2>CustomerName:' + CustomerName + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ShipTo:' + CustomerAddress + '</h2>');
               window.parent.$('#txtAdd').val(Quantity);

               //重新选择后界面其他元素置空
               window.parent.$('#Text1').val("");
               window.parent.$('#Text2').val("");
               window.parent.$('#Text3').val("");
               window.parent.$('#Text4').val("");
               window.parent.$('#_rev').val("");
               window.parent.$('#_qty').val("");
               window.parent.$('#partlist tr:not(:first)').remove();
           }
       }
   </script>
</head>
<body>
   <form id="form1"  runat="server">
        <input type="hidden" runat="server" id="pno"/>
        <table style="width:850px;height: 530px" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover dataTables-example dataTable">
           
            <thead>
                <tr>
                    <th>LoadID</th>
                    <th>CustomerName</th>
                    <th>CustomerAddress</th>
                    <th>ShipDate</th>
                    <th>BatchNO</th>
                    <th>Quantity</th>
                    <th>Creater</th>
                    <th>Createdate</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                        <tr onclick="savedata('<%# Eval("LoadID")%>','<%# Eval("Quantity")%>','<%# Eval("CustomerName")%>','<%# Eval("CustomerAddress")%>')">
                            <td><%# Eval("LoadID") %></td>
                            <td><%# Eval("CustomerName") %></td>
                            <td><%# Eval("CustomerAddress") %></td>
                            <td><%# Eval("ShipDate") %></td>
                            <td><%# Eval("BatchNO") %></td>
                            <td><%# Eval("Quantity") %></td>
                            <td><%# Eval("Creater") %></td>
                            <td><%# Eval("Createdate") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </form>
</body>
</html>
