<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bomcostdata.aspx.cs" Inherits="FGA_PLATFORM.business.financial.bomcostdata" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>BomCostData</title>
    <link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
    <!--<link id="pageskinstyle" href="../css/style/style_gray.css" rel="stylesheet" />-->
    <link href="../../css/style/mystyle.css" rel="stylesheet" />
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../css/style.css" rel="stylesheet" />
    <link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
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

        .top input
        {
            float:left;
            margin-right:10px;
        }
        .fixedtop
        {
           position: fixed; 
           background-color:white;
           z-index:999;    
        }
        .content
        {
           padding-top:115px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="fixedtop">
        <div class="top" style="width:100%">
             <asp:Button ID="btnadd"    runat="server" Text="Add"  CssClass="btn btn-primary" OnClick="btnadd_Click" />&nbsp;
             <asp:Button ID="btndel"    runat="server" Text="Delete"  CssClass="btn btn-success" OnClick="btndel_Click" />&nbsp;
             <asp:Button ID="btnedit"   runat="server" Text="Edit"  CssClass="btn btn-primary" OnClick="btnedit_Click" />&nbsp;
             <asp:Button ID="btnsave"   runat="server" Text="Save"  CssClass="btn btn-success" OnClick="btnsave_Click" />&nbsp;
             <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" CssClass="btn btn-primary" />&nbsp;        
             <asp:Button ID="btnrefresh" runat="server"  Text="Refresh"  CssClass="btn btn-success" OnClick="btnrefresh_Click" />&nbsp;
             <input id="btnimport" type="button" value="Import" class="btn btn-success" onclick="importexcel()" />&nbsp;
             <asp:Button ID="btnexport"  runat="server"  Text="Export"   OnClick ="btnexport_Click" CssClass="btn btn-primary" />&nbsp;
           
             <input type="file"  id="file"/>
        </div>
        <div align="center" style="height: 20px;clear:both"></div>
       
             <div style="text-align:center;">   
            <webdiyer:AspNetPager ID="AspNetPagerAskAnswer" runat="server"   
            AlwaysShow="True" FirstPageText="First" LastPageText="Last" NextPageText="Next"   
            onpagechanged="AspNetPagerAskAnswer_PageChanged" PrevPageText="Previous"   
            PageSize="200">
            </webdiyer:AspNetPager>   
            <br />   
            </div>
        </div>

            <div class="content">
            <table>
                <thead style="">
                        <tr>
                            <th>PERIOD_NAME</th>
                            <th>BUILDING_CODE</th>
                            <th>PART_NO</th>
                            <th>OPERATION_NO</th>
                            <th>CONTAINER_STATUS</th>
                            <th>ONHAND_QTY</th>
                            <th>CREATEUSER</th>
                            <th>CREATEDATE</th>
                        </tr>
                    </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("PERIOD_NAME")%></td>
                                <td><%# Eval("BUILDING_CODE")%></td>
                                <td><%# Eval("PART_NO")%></td>
                                <td><%# Eval("OPERATION_NO")%></td>
                                <td><%# Eval("CONTAINER_STATUS")%></td>
                                <td><%# Eval("ONHAND_QTY")%></td>
                                <td><%# Eval("CREATEUSER")%></td>
                                <td><%# Eval("CREATEDATE")%></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <div class="clear"></div>
           
        </div>
    </form>
     <script src="../../javascript/jquery-3.1.0.min.js"></script>
     <script src="../../mouldifi-v-2.0/css/jquery-3.1.0.min.js"></script>

      <script>
          $(function () {
              function initTableCheckbox() {
                  var $thr = $('table thead tr');
                  var $checkAllTh = $('<th><input type="checkbox" id="checkAll" name="checkAll" /></th>');
                  /*将全选/反选复选框添加到表头最前，即增加一列*/
                  $thr.prepend($checkAllTh);
                  /*“全选/反选”复选框*/
                  var $checkAll = $thr.find('input');
                  $checkAll.click(function (event) {
                      /*将所有行的选中状态设成全选框的选中状态*/
                      $tbr.find('input').prop('checked', $(this).prop('checked'));
                      /*并调整所有选中行的CSS样式*/
                      if ($(this).prop('checked')) {
                          $tbr.find('input').parent().parent().addClass('warning');
                      } else {
                          $tbr.find('input').parent().parent().removeClass('warning');
                      }
                      /*阻止向上冒泡，以防再次触发点击操作*/
                      event.stopPropagation();
                  });
                  /*点击全选框所在单元格时也触发全选框的点击操作*/
                  $checkAllTh.click(function () {
                      $(this).find('input').click();
                  });
                  var $tbr = $('table tbody tr');
                  var $checkItemTd = $('<td><input type="checkbox" name="checkItem" /></td>');
                  /*每一行都在最前面插入一个选中复选框的单元格*/
                  $tbr.prepend($checkItemTd);
                  /*点击每一行的选中复选框时*/
                  $tbr.find('input').click(function (event) {
                      /*调整选中行的CSS样式*/
                      $(this).parent().parent().toggleClass('warning');
                      /*如果已经被选中行的行数等于表格的数据行数，将全选框设为选中状态，否则设为未选中状态*/
                      $checkAll.prop('checked', $tbr.find('input:checked').length == $tbr.length ? true : false);
                      /*阻止向上冒泡，以防再次触发点击操作*/
                      event.stopPropagation();
                  });
                  /*点击每一行时也触发该行的选中操作*/
                  $tbr.click(function () {
                      $(this).find('input').click();
                  });
              }
              initTableCheckbox();
          });
          function importexcel() {
              $("#btnimport").attr("disabled", "disabled");
              var file = $("#file")[0].files[0];  //文件对象
              fileNum = $("#file")[0].files[0].length;
              name = file.name;   //文件名
              size = file.size;     //总大小

              //构造一个表单，FormData是HTML5新增的
              var form = new FormData();
              form.append("data", file);  
              form.append("name", name);
              //Ajax提交
              $.ajax({
                  url: "../../ajaxHandle/GlobalHandle.ashx?opertype=importexcel",
                  type: "POST",
                  data: form,
                  async: true,        //异步
                  processData: false,  //很重要，告诉jquery不要对form进行处理
                  contentType: false,  //很重要，指定为false才能形成正确的Content-Type
                  success: function (data) {
                      alert(data);
                  }
              });
          }
        </script>  

</body>
</html>
