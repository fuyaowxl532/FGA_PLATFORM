<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InterPlant_TransferMobile.aspx.cs" Inherits="FGA_PLATFORM.business.inventory.InterPlant_TransferMobile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   <title>Inter-Plant Recetion</title>

<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->
<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
<link href="../../css/style.css" rel="stylesheet" />
<!--弹消息窗样式-->
<link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<!-- jquery脚本库-->
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<!--验证-->
<script src="../../javascript/ValidationCheck.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

#left{
  width: 60%;
  height:900px;
  float: left;
  display: table;
}

#right{
   margin-left:61%;
   width: 40%;
}

td{  
  text-overflow: ellipsis;  
  overflow: hidden;  
  white-space: nowrap;  
  font-family: Verdana;
} 

</style>

</head>
<body style="overflow: hidden;">
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> InterPlant-Transfer=> InterPlant Reception</div>

    <!--<div class="col-md-10" style="height:95px;position:relative;width: 920px; ">-->
        
    <div id="left">
        <!--Filter-->
        <div style="background-color:gold">
        <div class="filter-wrapper" style="float:left; height:75px; width:70%;margin-right:30px;" id="filter-box">
                <div class="form-inline" style="margin-top: -10px">
                    <div class="form-group">
							<label class="form-label">Transfer No</label>
							<input id = "transno" type="text" placeholder="input"  style="color: black; height:30px;width:100px; "/>	
						</div>
						<div class="form-group" >
							<label class="form-label"style="margin-left:-25px">ToLocation</label>
							<input type="text" id="Text2" placeholder="input"  style="color: black; height:30px;width:100px;margin-left:-25px"/>	
						</div>	
                        <div class="form-group" style="margin-left:-35px;">
					        <label class="form-label">Status</label>
					        <select class="select2" id ="status" style="width:120px">
						        <option value="All">All</option>
						        <option value="Pending">Pending</option>
                                <option>Completed</option>
				                <option>Reject</option>
				                <option>Cancel</option>
					        </select>
				        </div>
                </div>
        </div>

        <div style="background-color:#00BACE; margin-left:71%; height:75px; width:29%;">
            <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:30%;height:80%;margin-left:5%" onclick="onReceive()" name="Confirm" value = "Confirm"   /> 
			<input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce;width:30%;height:80%;margin-left:5%" onclick="onReject()"  name="Reject"  value = "Reject" />
	    </div>
        </div>
        <!--交接表头-->
        <div  style="width:100%; height:1000px; margin-top:5px;overflow-y:scroll;overflow-x:hidden">
            <table id ="editable1"  class="table table-condensed">
	            <thead>
		            <tr>
                         <th style ="background-color:floralwhite;color:black;text-align:left">*</th>
                                <th style ="background-color:floralwhite;color:black;text-align:left">NO</th>
                                <th style ="background-color:floralwhite;color:black;text-align:left">TransferNo</th>
						        <th style ="background-color:floralwhite;color:black;text-align:left">Location</th>
                                <th style ="background-color:floralwhite;color:black;text-align:left">Status</th>
						        <th style ="background-color:floralwhite;color:black;text-align:left">Creator</th>
						        <th style ="background-color:floralwhite;color:black;text-align:left">CreateDate</th>
		            </tr>
	            </thead>
	            <tbody id ="tby" style="background-color:white; font-family:Arial, Helvetica, sans-serif""></tbody>
                                   
             </table>
        </div>

    </div>
	    
    <div id="right">
        <div class="filter-wrapper" style="background: #00BACE;height:75px;">
            <h1 style="font-weight:bold;">Transfer Details:</h1>
        </div>
         <!--交接详细记录-->
	    <div  style="height:1000px; margin-top:5px;overflow-y:scroll;overflow-x:hidden">
			<table id ="editable2" class="table table-condensed">
				<thead >
					<tr>
						<th style ="background-color:black;color:floralwhite;text-align:left">SerialNo</th>
						<th style ="background-color:black;color:floralwhite;text-align:left">PartNo</th>
						<th style ="background-color:black;color:floralwhite;text-align:left">Quantity</th>
                        <th style ="background-color:black;color:floralwhite;text-align:left">Opt</th>
					</tr>
				</thead>
				<tbody id ="tby2" style="background-color:yellowgreen"></tbody>
			</table>
	    </div>	
    </div>

<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

<script type="text/javascript">

    var details;

    $(document).ready(function () {

        $(".select2").select2();
        $("#status").find("option:contains('Pending')").attr("selected", true);
        queryData();

    });

    //查询 
    //add by it-wxl 05/04/2017
    function queryData() {
        $("#editable1 tr:not(:first)").remove();

        var _pn = $("#transno").val();              //交接单号

     
        $.ajax({
            type: "Post",
            url: "InterPlant_TransferMobile.aspx/SearchData",
            data: "{transferNO:'" + _pn + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        slct = slct + '<tr onclick = "getColumnDetail(this)">' +
                           '<td><input type="checkbox" name = "cb1" /></td> ' +
                           '<td> ' + (i + 1) + '</td> ' +
                           '<td> ' + json[i].TransferNO + '</td> ' +
                           '<td> ' + json[i].T_Location + '</td> ' +
                           '<td> ' + json[i].Transtatus + '</td> ' +
                           '<td> ' + json[i].Creator + '</td> ' +
                           '<td> ' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                           '</tr>';
                    }

                    $("#tby").html(slct);
                }
            }
        });
    }

    function queryDetail(transfno) {

        $("#editable2 tr:not(:first)").remove();
        $.ajax({
            type: "Post",
            url: "InterPlant_TransferMobile.aspx/getDetail",
            data: "{transferNO:'" + transfno + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var dt = "";
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr>' +
                            '<td> ' + json[i].SerialNO + '</td> ' +
                            '<td> ' + json[i].PartNO + '</td> ' +
                            '<td> ' + json[i].Quantity + '</td> ' +
                            '<td><i class="icon-cancel-circled" onclick = "onRemovePart()"></i>' +
                            '</tr>';

                        if (i % 2 == 0)
                            dt = dt + json[i].serialno + "          " + json[i].partno + "             " + "*" + json[i].quantity;
                        else
                            dt = dt + "                     ||                       " + json[i].serialno + "          " + json[i].partno + "             " + "*" + json[i].quantity + '\n';

                    }

                    $("#tby2").html(slct);
                }
            }
        });
    }


    function getColumnDetail(column) {

        var sTable = document.getElementById("editable1")
        for (var i = 1; i < sTable.rows.length; i++) {
            if (sTable.rows[i] != column) {
                sTable.rows[i].bgColor = "#ffffff";
            }
            else {
                sTable.rows[i].bgColor = "#F2F5A9";
            }
        }

        //查询LOADDETAIL
        var ld = column.innerHTML;
        queryDetail(ld.substr(ld.indexOf("TRF"), 9))

    }

    function onReceive() {

        if (confirm("Confirm?")) {
            var inputs = document.getElementById("editable1").getElementsByTagName("input");
            var status = "";
            var trfno = "";
            var location = "";
            var count = 0;

            //检测只能选择一行且状态为:Pending
            for (var i = 0; i < inputs.length; i++) {

                if (inputs[i].type == "checkbox") {
                    if (inputs[i].checked && inputs[i].name == "cb1") {
                        count++;
                        var checkedRow = inputs[i];
                        var currRow = checkedRow.parentNode.parentNode.rowIndex;
                        var tr = checkedRow.parentNode.parentNode;
                        var tds = tr.cells;

                        trfno = trim(tds[2].innerHTML);
                        status = trim(tds[5].innerHTML);
                        location = trim(tds[4].innerHTML);
                    }
                }
            }

            if (count == 1) {
                if (status == "Pending") {
                    $.ajax({
                        type: "Post",
                        url: "InterPlant_TransferMobile.aspx/onActionReceive",
                        data: "{transferNO:'" + trfno + "',location:'" + location + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d != "") {

                                alert(data.d);
                            }
                        }
                    });
                }
                else {
                    alert("Only \"Pending\" row can be selected!");
                }
            }
            else {
                alert("Only one row can be selected!");
            }
        }
    }

    function onRemovePart() {
        alert('aaaa');
    }

    //去左空格; 
    function ltrim(s) {
        return s.replace(/^\s*/, "");
    }
    //去右空格; 
    function rtrim(s) {
        return s.replace(/\s*$/, "");
    }
    //去左右空格; 
    function trim(s) {
        return rtrim(ltrim(s));
    }

    </script>
</body>
</html>
