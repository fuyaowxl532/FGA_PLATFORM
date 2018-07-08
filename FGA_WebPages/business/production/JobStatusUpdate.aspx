<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobStatusUpdate.aspx.cs" Inherits="FGA_PLATFORM.business.production.JobStatusUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>JOBNO STATIS UPDATE</title>
     <script src="../../javascript/jquery-1.11.1.min.js"></script>

<style>
    table
    {
        table-layout:fixed;
        left: 0px;
    }
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
        top: 0px;
        width: 1040px;
        height: 50px;
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
                <input id="btnimport" type="button" value="Import"   onclick="importexcel()" />&nbsp; 
                <asp:Button ID="btnquery" runat="server"  Text="Query" OnClick="btnquery_Click" />&nbsp;
                <input id="btnsubmit" type="button" value="Execute"    onclick="execute()" />&nbsp;
                <input id="btnclear"  type="button" value="Clear"      onclick="clr()" />&nbsp;

                <input type="file"  id="file"/>
                <asp:CheckBox ID="cbCompleted" runat="server" Height="10px" Text="Display Completed JobNO" />
        </div>
    </div> 

    <div class="content">
      <table id ="editable">
                <thead style="">
                    <tr>
                        <th width ="50px">JobNO</th>
                        <th width ="80px">JobKey</th>
                        <th width ="150px">PartNO</th>
                        <th width ="100px">PartName</th>
                        <th width ="150px">PartGroup</th>
                        <th width ="100px">DueDate</th>
                        <th width ="80px">JobStatus</th>
                        <th width ="50px">Note</th>
                        <th width ="80px">Creater</th>
                        <th width ="150px">CreateDate</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("JOBNO")%></td>
                                 <td><%# Eval("JOBKEY")%></td>
                                <td><%# Eval("PARTNO")%></td>
                                <td><%# Eval("PARTNAME")%></td>
                                <td><%# Eval("PARTGROUP")%></td>
                                <td><%# Eval("DUEDATE")%></td>
                                <td><%# Eval("JOBSTATUS")%></td>
                                <td><%# Eval("NOTE")%></td>
                                <td><%# Eval("CREATER")%></td>
                                <td><%# Eval("CREATEDATE")%></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
        </table>
          <div class="clear"></div>
    </div>
    </form>

    <script>   
             
        function importexcel() {
            //$("#btnimport").attr("disabled", "disabled");
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
                url: "../../ajaxHandle/GlobalHandle.ashx?opertype=JobnoimpExcel",
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

     //更新界面数据
     function validate() {
         var t = document.getElementById("editable");
         var trseq = document.getElementById("editable").rows.length;
         var jn = "4436";
         $.ajax({
             type: "Post",
             url: "JobStatusUpdate.aspx/vaildate",
             data: "{jobno:'" + jn + "'}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: true,
             success: function (data) {
                 if (data.d == "1") {
                     alert("success");
                 }
                 else
                     alert("fail");
             }
         });

     }

     //封装界面数据传后台处理
     function execute() {
         var data = [];
         var t = document.getElementById("editable");
         var trseq = document.getElementById("editable").rows.length;
         for (var i = 1; i < trseq; i++) {
             var row = {};
             var _js = null;
             var _note = null;
       
             _js = t.rows[i].cells[6].innerHTML;
             _note = t.rows[i].cells[7].innerHTML;

             row.JobNO = t.rows[i].cells[0].innerHTML;

             if(_note == "")
               data.push(row);

         }
         var jsondata = JSON.stringify(data);
         $.ajax({
             type: "post",
             url: "JobStatusUpdate.aspx/updateStatus",
             data: "{data:'" + jsondata + "'}",
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             async: true,
             success: function (data) {
                 if (data.d == "1") {
                     alert("success");
                 }
                 else
                     alert("fail");
             }
         });
     }

     //清空界面数据
     function clr() {
        $("#editable tr:not(:first)").remove();
     }


   </script>  
</body>
</html>
