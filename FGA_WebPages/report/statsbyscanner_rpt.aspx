<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="statsbyscanner_rpt.aspx.cs" Inherits="FGA_PLATFORM.report.statsbyscanner_rpt" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>title</title>
    <link href="../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />
    <link href="../css/style/mystyle.css" rel="stylesheet" />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
    <!-- Font awesome stylesheet -->
    <link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- /font awesome stylesheet -->

    <!-- Bootstrap stylesheet min version -->
    <link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        td,th
        {
            border-right: 1px solid #e1dddd;
            text-align: left !important;
            height:10px;
        }

        th
        {
            background-color:green;
            color:white;
        }

        tr:nth-child(even)
        {
            background-color: #ccc;
        }

        body{overflow-x:auto;overflow-y:auto;}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top">
            <div align="center" style="height: 5px"></div>
            <div style="width: 30%; float: left; height: 30px">
                PeriodName:
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="70px">
                    <asp:ListItem Selected="True">2016</asp:ListItem>
                    <asp:ListItem>2017</asp:ListItem>
                    <asp:ListItem>2018</asp:ListItem>
                    <asp:ListItem>2019</asp:ListItem>
                    <asp:ListItem>2020</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary" />&nbsp;
            
            <asp:Button ID="btnexport" runat="server" Text="Export" OnClick="btnexport_Click" CssClass="btn btn-success" />
        
           
             </div>
        <div align="center" style="height: 20px"></div>
        <div>
             <div style="text-align:left;">   
            <webdiyer:AspNetPager ID="AspNetPagerAskAnswer" runat="server"   
            AlwaysShow="True" FirstPageText="First" LastPageText="Last" NextPageText="Next"   
            onpagechanged="AspNetPagerAskAnswer_PageChanged" PrevPageText="Previous"   
            PageSize="200">
            </webdiyer:AspNetPager>  
            </div>  
            <table>
                <thead>
                    <tr>
                        <th>PERIOD_NAME</th>
                        <th>SERIAL_NO</th>
                        <th>PART_NO</th>
                        <th>LOCATION</th>
                        <th>QUANTITY</th>
                        <th>ACTUAL_QUANTITY</th> 
                        <th>DIFFERENCE</th> 
                        <th>AREACODE</th> 
                        <th>CREATER</th>
                        <th>CREATETIME</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("PERIOD_NAME")%></td>
                                <td><%# Eval("SERIALNO")%></td>
                                <td><%# Eval("PARTNO")%></td>
                                <td><%# Eval("LOCATION")%></td>
                                <td><%# Eval("QUANTITY")%></td>
                                <td><%# Eval("ACTUALQTY")%></td>
                                <td><%# Eval("DIFFERENCE")%></td>
                                <td><%# Eval("AREACODE")%></td>
                                <td><%# Eval("CREATER")%></td>
                                <td><%# Eval("CREATETIME")%></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            
        </div>
    </form>
</body>
</html>
