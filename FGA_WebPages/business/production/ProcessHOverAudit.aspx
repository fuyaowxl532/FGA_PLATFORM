<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessHOverAudit.aspx.cs" Inherits="FGA_PLATFORM.business.production.ProcessHOverAudit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ProcessHOverConfirm</title>
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
        .btn
        {
            background:#006DC5;
            color:#E6C5CC;
            width:1000px;
            height:30px;
        }
        .head
        {
            border-style:solid;
            border-width:2px;
            border-color:#4A81AA;
            background:#F6F6E6;
            width:700px;
            margin-left:140px;
        }
        .center
        {
            border-style:solid;
            border-width:2px;
            border-color:#4A81AA;
            width:1500px;
        }
        #editable
        {
            width:1500px;
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
            left:240px;
            background-color:#006DC5;
            font-size:12px;
            font-weight:600;
        }
        #sid
        {
            position:relative;
            left:50px;
        }
        #_lbn
        {
            position:relative;
            left:65px;
        }
         #_bn
        {
            position:relative;
            left:82px;
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
     <div>
        <div class ="head" style="padding:5px;">
             <label id = "_org" for= "floc">From_Location:</label> <input type="text" id = "_fltxt" size="10"/>
             <label id = "_opt" for= "tloc">To_Location:</label><input type="text" id = "_tltxt" size="10"/>
          
             <label id = "Label1" for= "fddate">Date:</label>
             <input type="text" id = "_fdtxt" size="10"/>
             <label id = "Label2" for= "tddate">To</label>
             <input type="text" id = "_tdtxt" size="10"/>
             <p></p>
             <label id = "Label3" for= "sts">Status:</label><select id ="sid">
                        <option value="In Progress">In Progress</option>
                        <option value="Finish">Finish</option>
                        <option value="Reject">Reject</option>
                        <option value="Both">Both</option>
                        </select>

             <label id = "_lbn" for= "bn">BatchNO:</label><input type="text" id = "_bn" size="10"/>

             <input type="button" class="btnl" name="search" value="Search" onclick="SearchData()" />
             <input type="button" class="btnl" name="confirm" value="Confirm" onclick="ConfirmData()" />
             <input type="button" class="btnl" name="reject" value="Reject" onclick="RejectData()" />
        </div>

         <div class ="block"></div>

        <div class ="center">
            <table id="editable"> 
	            <thead>
		            <tr>
                        <th>*</th>
                        <th>No</th>
                        <th>Organization</th>    
			            <th>SerialNO</th>          
                        <th>PartNO</th>
                        <th>Operation</th>
                        <th>From_LOC</th>
                        <th>To_LOC</th>
			            <th>Quantity</th>
                        <th>Transaction</th>
                        <th>BatchNO</th>
                        <th>Status</th>
                        <th>Creator</th>
			            <th>CreateDate</th>
                        <th>Receiver</th>
			            <th>ReceptionDate</th>
		            </tr>
	            </thead>
	            <tbody></tbody>
	        </table>
         </div>
    </div>

    <script type="text/javascript">

    //查询界面
        function SearchData() {

        $("#editable tr:not(:first)").remove();
        var floc  = $("#_fltxt").val();
        var tloc  = $("#_tltxt").val();
        var sts   = $("#sid").val();
        var fdate = $("#_fdtxt").val();
        var tdate = $("#_tdtxt").val();
        var bn    = $("#_bn").val();

        if (fdate != "" && tdate == "") {
            alert("Please input date!");
            return;
        }
        if (fdate == "" && tdate != "") {
            alert("Please input date!");
            return;
        }



        $.ajax({
            type: "Post",
            url: "ProcessHOverAudit.aspx/SearchData",
            data: "{batchno:'" + bn + "',status:'" + sts + "',floc:'" + floc + "',tloc:'" + tloc + "',fdate:'" + fdate + "',tdate:'" + tdate + "'}",
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
                        nextRow.insertCell(2).innerHTML = json[i].Organization;
                        nextRow.insertCell(3).innerHTML = json[i].SerialNO;
                        nextRow.insertCell(4).innerHTML = json[i].PartNO;
                        nextRow.insertCell(5).innerHTML = json[i].OperationNo;
                        nextRow.insertCell(6).innerHTML = json[i].Location;
                        nextRow.insertCell(7).innerHTML = json[i].TLoc;
                        nextRow.insertCell(8).innerHTML = json[i].Quantity;
                        nextRow.insertCell(9).innerHTML = json[i].TransactionType;
                        nextRow.insertCell(10).innerHTML = json[i].BatchNO;
                        nextRow.insertCell(11).innerHTML = json[i].ContainerStatus; 

                        nextRow.insertCell(12).innerHTML = json[i].Creater;
                        nextRow.insertCell(13).innerHTML = new Date(parseInt(json[i].Createdate)).toLocaleString();
                        nextRow.insertCell(14).innerHTML = json[i].Creater;
                        nextRow.insertCell(15).innerHTML = new Date(parseInt(json[i].Createdate)).toLocaleString();
                    }
                }
            }
        });
        }

        //确认
        function ConfirmData() {
            var data = [];
            var inputs = document.getElementById("editable").getElementsByTagName("input");

            for (var i = 0; i < inputs.length; i++) {
                var row = {};

                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked && inputs[i].name == "cb1") {
                        var checkedRow = inputs[i];
                        var tr = checkedRow.parentNode.parentNode;
                        var tds = tr.cells;
                        //循环列
                        row.SerialNO = tds[3].innerHTML;
                        row.Location = tds[6].innerHTML;
                        row.TLoc = tds[7].innerHTML;

                        if (tds[11].innerHTML == "In Progress")
                        {
                            data.push(row);
                        }
                    }
                }
            }

            var jsondata = JSON.stringify(data);
            $.ajax({
                type: "post",
                url: "ProcessHOverAudit.aspx/confirmData",
                data: "{data:'" + jsondata + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d == "1") {
                        alert("success");
                        //release成功后刷新界面
                        SearchData();

                    }
                    else
                        alert("fail");
                }
            });
        }

        //驳回
        function RejectData() {
            var data = [];
            var inputs = document.getElementById("editable").getElementsByTagName("input");

            for (var i = 0; i < inputs.length; i++) {
                var row = {};

                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked && inputs[i].name == "cb1") {
                        var checkedRow = inputs[i];
                        var tr = checkedRow.parentNode.parentNode;
                        var tds = tr.cells;
                        //循环列
                        row.SerialNO = tds[3].innerHTML;
                        row.Location = tds[6].innerHTML;
                        row.TLoc = tds[7].innerHTML;

                        if (tds[11].innerHTML == "In Progress") {
                            data.push(row);
                        }
                    }
                }
            }

            var jsondata = JSON.stringify(data);
            $.ajax({
                type: "post",
                url: "ProcessHOverAudit.aspx/rejectData",
                data: "{data:'" + jsondata + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d == "1") {
                        alert("success");
                        //release成功后刷新界面
                        SearchData();

                    }
                    else
                        alert("fail");
                }
            });
        }
    </script>
</body>
</html>
