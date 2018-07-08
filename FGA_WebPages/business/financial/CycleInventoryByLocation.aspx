<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CycleInventoryByLocation.aspx.cs" Inherits="FGA_PLATFORM.business.financial.CycleInventoryByLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>CycleInventoryByLocation</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
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
<!-- jquery脚本库 -->
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

</head>

<body>
   <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Financial=> Cycle Inventory Menu=> Cycle Status By Location</div>
   
   <div class="filter-wrapper" style="height: 75px; width:100%; margin-top:-5px;margin-bottom:5px;margin-right:30px;" id="filter-box">
		
	    <div class="form-inline" style="margin-top: -10px">
				<div class="form-group">
					<label class="form-label">CycleNO</label>
					<input type="text" id = "cycleno" placeholder="input" style="color: black; height:30px;width:100px"/>	
				</div>
                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Status</label>
					<select class="select2" id ="status" style="width:150px">
						<option value="All">All</option>
						<option>In Process</option>
				        <option>Completed</option>
					</select>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Location</label>
					<input type="text" id = "loc" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
				
				<div class="form-group"style="margin-left:-35px;"> 
					<label class="form-label">StartDate(from)</label> 
					
					<div id="date-popup" class="input-group date"> 
					<input type="text" id = "fdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
                </div>

                <div class="form-group"style="margin-left:-35px;"> 
                    <label class="form-label">StartDate(to)</label> 
					
					<div id="date-popup1" class="input-group date"> 
					<input type="text" id ="tdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
				</div>

            	<div class="form-group" style="position:relative; margin-top:-30px">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:75px" onclick="queryData()" name="search" value="Search"   />
                </div>	
                        
                <div class="form-group"style="position:relative; margin-left:-120px; margin-top:30px">	
					<input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce;width:140px;" onclick="doCycle()" name="Cycle Inventory" value="Cycle Inventory" />
			    </div>

			</div>

   </div>

   <!--Main Container-->
   <div>			
       <div style="height:400px;overflow-y:scroll;overflow-x:hidden">
			<table id = "editable1" class="table  table-bordered table-hover dataTables-example" style="overflow:scroll;margin-top:10px;position:relative;height:150px; ">
				<thead >
					<tr>
                        <th style ="background-color:black;color:white;text-align:left">#</th>
                        <th style ="background-color:black;color:white;text-align:left">RN</th>
                        <th style ="background-color:black;color:white;text-align:left">CycleNO</th>
						<th style ="background-color:black;color:white;text-align:left">Location</th>
                        <th style ="background-color:black;color:white;text-align:left">Status</th>
						<th style ="background-color:black;color:white;text-align:left">StartBy</th>
						<th style ="background-color:black;color:white;text-align:left">StartDate</th>
                        <th style ="background-color:black;color:white;text-align:left">CompleteBy</th>
                        <th style ="background-color:black;color:white;text-align:left">CompleteDate</th>
					</tr>
				</thead>
                        
				<tbody id ="tby1" >
					
				</tbody>
			</table>
	    </div>

       <div style="height:400px; margin-top:5px;overflow-y:scroll;overflow-x:hidden">
				
			<table id ="editable2" class="table  table-bordered table-hover dataTables-example" style="overflow-y:auto;margin-top:10px;">
				<thead >
					<tr>
                        <th style ="background-color:black;color:white;text-align:left">CycleID</th>
						<th style ="background-color:black;color:white;text-align:left">SerialNO</th>
						<th style ="background-color:black;color:white;text-align:left">PartNo</th>
                        <th style ="background-color:black;color:white;text-align:left">PartName</th>
                        <th style ="background-color:black;color:white;text-align:left">Operation</th>
                        <th style ="background-color:black;color:white;text-align:left">Location</th>
						<th style ="background-color:black;color:white;text-align:left">Quantity</th>
						<th style ="background-color:black;color:white;text-align:left">ActualQty</th>
                        <th style ="background-color:black;color:white;text-align:left">Creator</th>
						<th style ="background-color:black;color:white;text-align:left">CreateDate</th>
					</tr>
				</thead>
                        
				<tbody id ="tby2" ></tbody>
			</table>
	    </div>	
</div>

<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script type="text/javascript" src="../../javascript/jquery-clock-timepicker.min.js"></script>

<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script type="text/javascript">

    $(document).ready(function () {
        $(".select2").select2();
        $('#datepicker').datepicker({
            keyboardNavigation: false,
            forceParse: false,
            todayHighlight: true
        });
        $('#date-popup').datepicker({
            keyboardNavigation: false,
            forceParse: false,
            todayHighlight: true
        });
        $('#date-popup1').datepicker({
            keyboardNavigation: false,
            forceParse: false,
            todayHighlight: true
        });
        $('#date-popup2').datepicker({
            keyboardNavigation: false,
            forceParse: false,
            todayHighlight: true
        });
        $('#year-view').datepicker({
            startView: 2,
            keyboardNavigation: false,
            forceParse: false,
            format: "mm/dd/yyyy"
        });
    });

	//查询初始化界面需要release的信息
	function queryData() {
	    $("#editable1 tr:not(:first)").remove();
        $("#editable2 tr:not(:first)").remove();
        var cn = $('#cycleno').val();
        var loc = $('#loc').val();
        var sts = $('#status').val();
        var fd  = $('#fdate').val();
        var td  = $('#tdate').val();

	    $.ajax({
	        type: "Post",
	        url: "CycleInventoryByLocation.aspx/SearchData_H",
	        data:"{cycleno:'" + cn + "',  location:'" + loc + "', status:'" + sts + "',  fdate:'" + fd + "',  tdate:'" + td + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        if (json[i].CycleStatus == "In Process") {
                             slct = slct + '<tr onclick="getColumnDetail(this)"><td><input type="checkbox" name = "cb1" /></td>' +
                            '<td>' + (i+1) + '</td> ' +
                            '<td>' + json[i].CycleNO + '</td> ' +
                            '<td>' + json[i].Location + '</td> ' +
                            '<td style="background-color:yellow">' + json[i].CycleStatus + '</td> ' +
                            '<td>' + json[i].StartBy + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].StartDate)).toLocaleString() + '</td> ' +
                            '<td>' + json[i].CompleteBy + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].CompleteDate)).toLocaleString() + '</td> ' +
                            '</tr>';
                        }

                        if (json[i].CycleStatus == "Completed") {
                             slct = slct + '<tr onclick="getColumnDetail(this)"><td><input type="checkbox" name = "cb1" /></td>' +
                            '<td>' + (i+1) + '</td> ' +
                            '<td>' + json[i].CycleNO + '</td> ' +
                            '<td>' + json[i].Location + '</td> ' +
                            '<td style="background-color:green">' + json[i].CycleStatus + '</td> ' +
                            '<td>' + json[i].StartBy + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].StartDate)).toLocaleString() + '</td> ' +
                            '<td>' + json[i].CompleteBy + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].CompleteDate)).toLocaleString() + '</td> ' +
                            '</tr>';
                        }
                        
                    }
                     $("#tby1").html(slct);
	            }
	        }
	    });
	}

	function queryDetail(cycleno) {

	    $("#editable2 tr:not(:first)").remove();
	    $.ajax({
	        type: "Post",
	        url: "CycleInventoryByLocation.aspx/SearchDetail",
	        data: "{data:'" + cycleno + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
	                for (var i = 0; i < json.length; i++) {

	                     slct = slct + '<tr>' +
                            '<td>' + json[i].CycleRowID + '</td> ' +
                            '<td>' + json[i].SerialNO + '</td> ' +
                            '<td>' + json[i].PartNO + '</td> ' +
                            '<td>' + json[i].PartName + '</td> ' +
                            '<td>' + json[i].OperationCode + '</td> ' +
                            '<td>' + json[i].Location + '</td> ' +
                            '<td>' + json[i].Quantity + '</td> ' +
                            '<td>' + json[i].ActualQty + '</td> ' +
                            '<td>' + json[i].Creator + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].Createtime)).toLocaleString() + '</td> ' +
                            '</tr>';
                    }

                     $("#tby2").html(slct);
	            }
	        }
	    });
	}

	function getColumnDetail(column) {

	    var sTable = document.getElementById("editable1")
	    for (var i = 1; i < sTable.rows.length; i++)
	    {
	        if (sTable.rows[i] != column) 
	        {
	            sTable.rows[i].bgColor = "#ffffff";
	        }
	        else {
	            sTable.rows[i].bgColor = "#F2F5A9";
	        }
	    }

	    //查询LOADDETAIL并选中改行
        var ld = column.innerHTML;
        var cycleno = ld.substr(ld.indexOf("INV"), 8);
        queryDetail(cycleno);

        //var aa = $("#editable1 tr").eq(column.rowIndex).find("td").eq(0).find("input");

        //$("#editable1 tr").eq(column.rowIndex).find("td").eq(0).find("input").attr("checked", "checked");

	}

	//继续盘点
    function doCycle() {

        var inputs  = document.getElementById("editable1").getElementsByTagName("input");
        var status  = "";
        var cycleno = "";
        var count   = 0; 
        //检测只能选择一行且状态为:In Process
        for (var i = 0; i < inputs.length; i++) {

	        if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    count++;
	                var checkedRow = inputs[i];
	                var currRow = checkedRow.parentNode.parentNode.rowIndex;
	                var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;

                    status  =  tds[4].innerHTML;
                    cycleno =  tds[2].innerHTML;
	            }

	        }
        }

        if (count == 1) {
            if (status == "In Process") {
                location.href = "statsByscanner.aspx?cycleno="+cycleno;
            }
            else {
                alert("Only \"In Process\" row can be selected!");
            }
        }
        else {
             alert("Only one row can be selected!");
        }
    }

    //function onSelect() {

    //    var vl = $("#editable1 tr").eq(obj.parentNode.rowIndex).find("td").eq(0).find("input").attr("checked", checked);
    //}

</script>
</body>
</html>
