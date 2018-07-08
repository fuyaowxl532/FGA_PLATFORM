<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FIFO_Period_ctrl.aspx.cs" Inherits="FGA_PLATFORM.business.production.FIFO_Period_ctrl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ProcessUserCtrl</title>
     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
     <link rel="stylesheet" href="/resources/demos/style.css"/>
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
        .head
        {
            width:650px;
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
    <form id="form1" runat="server">
     <div>
        <div class ="head" style="padding:5px;">
             <input type="button" class="btnl" name="add" value="Add" onclick="addRows()"/>
             <input type="button" class="btnl" name="del" value="Delete"/>
             <input type="button" class="btnl" name="save" value="Save" onclick="saveData()"/>
             <input type="button" class="btnl" name="qry" value="Query" onclick="SearchData()"/>
        </div>

         <div class ="block"></div>

        <div class ="center">
            <table id="editable"> 
	            <thead>
		            <tr>
			            <th style="width:20%">PartType</th>          
                        <th style="width:10%">Day</th>
                        <th style="width:20%">Notes</th>
                        <th style="width:10%">Creater</th>
			            <th style="width:20%">CreateDate</th>
		            </tr>
	            </thead>
	            <tbody></tbody>
	        </table>
         </div>
    </div>
    </form>

    <script type="text/javascript" >
        var serialNO = null;

        function inRow() {
            var table = document.getElementById("editable");
            var nextIndex = table.rows.length;
            var nextRow = table.insertRow(nextIndex);
            nextRow.insertCell(0).innerHTML = null;
            nextRow.insertCell(1).innerHTML = null;
            nextRow.insertCell(2).innerHTML = null;
            nextRow.insertCell(3).innerHTML = null;
            nextRow.insertCell(4).innerHTML = null;
          
            $("#editable tr").last().find("td").eq(0).html('<select id ="pt" style="width:100px;">' +
                        '<option value="F1">RA.A</option>' +
                        '<option value="F2">RA.V</option>' +
                        '<option value="F3">BB</option>' +
                        '</select>');
            $("#editable tr").last().find("td").eq(1).html('<input type="text"  style="border:none;width:100%;height:100%"/>');
            $("#editable tr").last().find("td").eq(2).html('<input type="text"  style="border:none;width:100%;height:100%"/>');
            $("#editable tr").last().find("td").eq(0).find("input").focus();
        }

        //增加一行,返回当前用户及时间
        function addRows() {

            inRow();
            $.ajax({
                type: "Post",
                url: "ProcessUserCtrl.aspx/getUser",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {
                        var myDate = new Date();
                        var date = myDate.toLocaleString();
                        $("#editable tr").last().find("td").eq(6).html(data.d);
                        $("#editable tr").last().find("td").eq(7).html(date);
                    }
                }
            });
        }

        //查询数据
        function SearchData() {

            $("#editable tr:not(:first)").remove();

            $.ajax({
                type: "Post",
                url: "ProcessUserCtrl.aspx/SearchData",
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
                            nextRow.insertCell(2).innerHTML = json[i].USERNAME;
                            nextRow.insertCell(3).innerHTML = json[i].ORGANIZATION;
                            nextRow.insertCell(4).innerHTML = json[i].OPERATION;
                            nextRow.insertCell(5).innerHTML = json[i].TRANSACTIONTYPE;
                            nextRow.insertCell(6).innerHTML = json[i].Creater;
                            nextRow.insertCell(7).innerHTML = new Date(parseInt(json[i].CreateDate)).toLocaleString();
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

                    row.USERNAME = $("#editable tr").eq(i).find("td").eq(2).find("input").val();
                    row.ORGANIZATION = $("#editable tr").eq(i).find("td").eq(3).find("select").val();
                    row.OPERATION = $("#editable tr").eq(i).find("td").eq(4).find("input").val();
                    row.TRANSACTIONTYPE = $("#editable tr").eq(i).find("td").eq(5).find("select").val();
                    row.Creater = t.rows[i].cells[6].innerHTML;
                    row.CreateDate = t.rows[i].cells[7].innerHTML;

                    data.push(row);

                }
                var jsondata = JSON.stringify(data);
                $.ajax({
                    type: "post",
                    url: "ProcessUserCtrl.aspx/saveData",
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

        //删除数据
        function del(obj) {
            javascript: alert('Do you want to delete it?');
            var table = obj.parentNode.parentNode.parentNode;
            table.deleteRow(obj.parentNode.parentNode.parentNode.rowIndex);
        }
	</script> 
</body>
</html>
