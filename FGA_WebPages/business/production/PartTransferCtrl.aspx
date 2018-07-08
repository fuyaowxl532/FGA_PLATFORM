<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PartTransferCtrl.aspx.cs" Inherits="FGA_PLATFORM.business.production.PartTransferCtrl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>PartTransferCtrl</title>
     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
     <link rel="stylesheet" href="/resources/demos/style.css">
     <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
     <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#_fdtxt").datepicker();
            $("#_tdtxt").datepicker();
        });
     </script>

    <style>
		body{ color: rgb(119, 119, 119); background-color:#EEEEEE;}
        thead
        {

            background:#F6F6E6;
            color:black;
        }
        input
        {
            background-color:white;
        }
        .btn
        {
            background:#006DC5;
            color:#E6C5CC;
            width:1000px;
            height:30px;
        }
        .head
        {
            width:650px;
            margin-left:0px;
        }
        .center
        {
            border-style:solid;
            border-width:2px;
            border-color:#4A81AA;
            width:900px;
        }
        #editable
        {
            width:900px;
            background-color:#F6F6E6;
        }

        .block
        {
            height:10px;
            width:900px;
        }
        label
        {
            color:black;
            font-size:small;
        }
        #_dttxt,#_user
        {
            position:relative;
            left:19px;
        }
        #_usertxt
        {
            position:relative;
            left:53px;
        }
        .btnl
        {
            border:1px solid;
            border-color:#006DC5;
            border-radius:2px;
            position:relative;
            background-color:#006DC5;
            font-size:12px;
            font-weight:600;
        }
        #_syn
        {
            position:relative;
            left:355px;
            background-color:#2212f8;
            font-weight:700;
        }
        th{border:solid #4A81AA; border-width:0px 0px 0px 1px;}

        td{border:solid #4A81AA; border-width:1px 0px 0px 1px;color:black}

        tr:nth-child(even)
        {
            background-color:white;
        }
        
    </style>
    
</head>
<body>
        <input type="button" class="btnl" name="add" value="Add" onclick="addRows()"/>
        <input type="button" class="btnl" name="del" value="Delete"/>
        <input type="button" class="btnl" name="save" value="Save" onclick="saveData()"/>
        <input type="button" class="btnl" name="qry" value="Query" onclick ="SearchData()"/>

        <div class ="block"></div>

        <div class ="center">
            <table id="editable"> 
	            <thead>
		            <tr>
                        <th>*</th>    
                        <th>NO</th>   
			            <th>Organization</th>          
                        <th>Operation</th>
                        <th>Transaction</th>
                        <th>From_LOC</th>
                        <th>To_LOC</th>
                        <th>TransferType</th>
                        <th>Creater</th>
			            <th style="width:20%">CreateDate</th>
		            </tr>
	            </thead>
	            <tbody></tbody>
	        </table>
        </div>


     <script type="text/javascript" >
         var serialNO = null;

         function inRow() {
             var table = document.getElementById("editable");
             var nextIndex = table.rows.length;
             var nextRow = table.insertRow(nextIndex);
             nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" checked/>';;
             nextRow.insertCell(1).innerHTML = nextIndex;
             nextRow.insertCell(2).innerHTML = null;
             nextRow.insertCell(3).innerHTML = null;
             nextRow.insertCell(4).innerHTML = null;
             nextRow.insertCell(5).innerHTML = null;
             nextRow.insertCell(6).innerHTML = null;
             nextRow.insertCell(7).innerHTML = null
             nextRow.insertCell(8).innerHTML = null;
             nextRow.insertCell(9).innerHTML = null;
             $("#editable tr").last().find("td").eq(2).html('<select id ="oid" style="width:100px;">' +
                        '<option value="F1">F1</option>' +
                        '<option value="F2">F2</option>' +
                        '<option value="F3">F3</option>' +
                        '<option value="F4">F4</option>' +
                        '</select>');
             $("#editable tr").last().find("td").eq(3).html('<input type="text"  style="border:none;width:100%;height:100%"/>');
             $("#editable tr").last().find("td").eq(4).html('<select id ="tid" style="width:80px;">' +
                        '<option value="IM1301">IM1301</option>' +
                        '<option value="IM1302">IM1302</option>' +
                        '</select>');
             $("#editable tr").last().find("td").eq(5).html('<input type="text"  style="border:none;width:100%;height:100%"/>');
             $("#editable tr").last().find("td").eq(6).html('<input type="text"  style="border:none;width:100%;height:100%"/>');
             $("#editable tr").last().find("td").eq(7).html('<select id ="sid" style="width:100px;">' +
                        '<option value="Direct">Direct</option>' +
                        '<option value="Indirect">Indirect</option>' +
                        '</select>');
             $("#editable tr").last().find("td").eq(1).find("input").focus();
         }

         //增加行时返回当前用户及时间
         function addRows() {

             inRow();
             $.ajax({
                 type: "Post",
                 url: "PartTransferCtrl.aspx/getUser",
                 data: "",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 async: true,
                 success: function (data) {
                     if (data.d != "") {
                         var myDate = new Date();
                         var date = myDate.toLocaleString();
                         $("#editable tr").last().find("td").eq(8).html(data.d);
                         $("#editable tr").last().find("td").eq(9).html(date);
                     }
                 }
             });
         }

         //查询数据
         function SearchData() {

             $("#editable tr:not(:first)").remove();

             $.ajax({
                 type: "Post",
                 url: "PartTransferCtrl.aspx/SearchData",
                 data: "",
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 async: true,
                 success: function (data) {
                     if (data.d != "") {
                         var json = $.parseJSON(data.d);
                         for (var i = 0; i < json.length; i++) {

                             var table = document.getElementById("editable");
                             var nextIndex = table.rows.length;
                             var nextRow = table.insertRow(nextIndex);
                             nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
                             nextRow.insertCell(1).innerHTML = nextIndex;
                             nextRow.insertCell(2).innerHTML = json[i].ORGANIZATION;
                             nextRow.insertCell(3).innerHTML = json[i].OPERATION;
                             nextRow.insertCell(4).innerHTML = json[i].TRANSACTIONTYPE;
                             nextRow.insertCell(5).innerHTML = json[i].FLOC;
                             nextRow.insertCell(6).innerHTML = json[i].TLOC;
                             nextRow.insertCell(7).innerHTML = json[i].TRANSFERTYPE;
                             nextRow.insertCell(8).innerHTML = json[i].Creater;
                             nextRow.insertCell(9).innerHTML = new Date(parseInt(json[i].CreateDate)).toLocaleString();
                         }
                     }
                 }
             });
         }

         //保存数据
         function saveData() {
             if (confirm("Are you sure save data?")) {
                 var data = [];
                 var t = document.getElementById("editable");

                 for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
                     var row = {};

                     row.ORGANIZATION = $("#editable tr").eq(i).find("td").eq(2).find("select").val();
                     row.OPERATION = $("#editable tr").eq(i).find("td").eq(3).find("input").val();
                     row.TRANSACTIONTYPE = $("#editable tr").eq(i).find("td").eq(4).find("select").val();
                     row.FLOC = $("#editable tr").eq(i).find("td").eq(5).find("input").val();
                     row.TLOC = $("#editable tr").eq(i).find("td").eq(6).find("input").val();
                     row.TRANSFERTYPE = $("#editable tr").eq(i).find("td").eq(7).find("select").val();
                     row.Creater = t.rows[i].cells[8].innerHTML;
                     row.CreateDate = t.rows[i].cells[9].innerHTML;

                     data.push(row);

                 }
                 var jsondata = JSON.stringify(data);
                 $.ajax({
                     type: "post",
                     url: "PartTransferCtrl.aspx/saveData",
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
         }

         function del(obj) {
             javascript: alert('Do you want to delete it?');
             var table = obj.parentNode.parentNode.parentNode;
             table.deleteRow(obj.parentNode.parentNode.parentNode.rowIndex);
         }
	</script> 
</body>
</html>
