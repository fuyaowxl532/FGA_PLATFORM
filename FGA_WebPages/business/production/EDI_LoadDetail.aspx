<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDI_LoadDetail.aspx.cs" Inherits="FGA_PLATFORM.business.production.EDI_LoadDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="overflow:auto">
<head runat="server">
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<title>EDI_LoadDetail</title>
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<!-- /site favicon -->

<!-- Entypo font stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<!-- /entypo font stylesheet -->

<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->

<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- /bootstrap stylesheet min version -->     

<!-- Mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<!-- /mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>

</head>
<body >
	
<div class="main-container">
            <div class="panel-body filter-wrapper" style="height:95px;position:relative;width: 1250px; "> 
			<form class="form-inline" >
						<div class="form-group">
							<label class="form-label">LoadID</label>
							<input type="text" placeholder="input"  style="color: black; height:30px;width:100px; "/>	
						</div>
						<div class="form-group" >
							<label class="form-label"style="margin-left:-25px">ShipTo</label>
							<input type="text" id="Text2" placeholder="input"  style="color: black; height:30px;width:100px;margin-left:-25px"/>	
						</div>	
						<div class="form-group">
							<label class="form-label"style="margin-left:-25px">Status</label>
							<input type="text" id="Text3" placeholder="input"  style="color: black; height:30px;width:100px;margin-left:-25px"/>
						</div>	
						<div class="form-group">	
							<label class="form-label"style="margin-left:-25px">Date(from)</label> 
							<div id="Div1" class="input-group date"> 
								<input type="text" id="Text4" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;margin-left:-25px"/>
								<span class="input-group-addon"><i class="fa fa-calendar" ></i></span> 
							</div>
						</div>
						<div class="form-group">	
							<label class="form-label"style="margin-left:-25px">Date(to)</label> 
							<div id="Div2" class="input-group date">
								<input type="text" id="Text5" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;margin-left:-25px"/> 
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
							</div>
						</div>
						<div class="form-group" style="position:relative; margin-top:-30px">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px" onclick="queryData()" name="search" value="Search"   />
                        </div>	
                        
                          <div class="form-group"style="position:relative; margin-left:670px; margin-top:-35px">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce;width:68px;" onclick="rework()" name="rework" value="ReWork" />
						</div>

						
					</form>

				
			</div>
                
				
			<div style="height:400px;width:1255px;overflow-y:scroll;overflow-x:hidden">

					<table id = "editable1" class="table-striped table-bordered table-hover" style="overflow:scroll;margin-top:10px; width:1220px;position:relative;height:150px; ">
						<thead >
							<tr>
                                <th>#</th>
                                <th>RN</th>
                                <th>LoadID</th>
								<th>CustomerAddress</th>
                                <th>DueDate</th>
								<th>ShipDate</th>
								<th>Quantity</th>
                                <th>SerialNO</th>
                                <th>LoadStatus</th>
								<th>Creator</th>
								<th>CreateDate</th>
							</tr>
						</thead>
                        
						<tbody id ="tbody1" >
					
						</tbody>
					</table>
				</div>
					

			<div class="col-md-12  " style="margin-left:-15px; width:1270px; height:400px; margin-top:5px;overflow-y:scroll;overflow-x:hidden">
				
				<div class="form-group table-responsive" >

					<table class="table-striped table-bordered table-hover" id ="editable2" style="overflow-y:auto;margin-top:10px; width:1220px;">
						<thead >
							<tr>
                                <th>CustomerName</th>
								<th>CustomerAddress</th>
								<th>CustomerPartNo</th>
								<th>PartNo</th>
								<th>DueDate</th>
								<th>ShipeDate</th>
                                <th>Order_No</th>
								<th>Lot_No</th>
								<th>BatchNo</th>
                                <th>StandardQuantity</th>
								<th>Quantity</th>
								<th>Job_Sequence</th>
                                <th>EDI_RowID</th>
							</tr>
						</thead>
                        
						<tbody id ="tby" >
							
						</tbody>
					</table>
				</div>
			</div>		

			<!-- /filter wrapper -->
		
		<!-- Main content -->

</div>

<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

<script src="../../javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

	//查询初始化界面需要release的信息
	function queryData() {
	    $("#editable1 tr:not(:first)").remove();
	    $("#editable2 tr:not(:first)").remove();
	    $.ajax({
	        type: "Post",
	        url: "EDI_LoadDetail.aspx/SearchData",
	        data: "",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d != "") {
	                var json = $.parseJSON(data.d);
	                for (var i = 0; i < json.length; i++) {

	                    var table = document.getElementById("editable1");
	                    var nextIndex = table.rows.length;
	                    var nextRow = table.insertRow(nextIndex);
	                    nextRow.onclick = function () { getColumnDetail(this) }; //为每行增加单击事件  
	                    nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
	                    nextRow.insertCell(1).innerHTML = nextIndex;
	                    nextRow.insertCell(2).innerHTML = json[i].LoadID;
	                    nextRow.insertCell(3).innerHTML = json[i].CustomerAddress;
	                    nextRow.insertCell(4).innerHTML = new Date(parseInt(json[i].ShipDate)).toLocaleString();
	                    nextRow.insertCell(5).innerHTML = new Date(parseInt(json[i].ShipDate)).toLocaleString();
                        nextRow.insertCell(6).innerHTML = json[i].Quantity;
                        nextRow.insertCell(7).innerHTML = json[i].SerialNO;
	                    nextRow.insertCell(8).innerHTML = json[i].LoadStatus;
	                    nextRow.insertCell(9).innerHTML = json[i].Creator;
	                    nextRow.insertCell(10).innerHTML = new Date(parseInt(json[i].CreateDate)).toLocaleString();

	                }
	            }
	        }
	    });
	}

	function queryDetail(loadid) {

	    $("#editable2 tr:not(:first)").remove();
	    $.ajax({
	        type: "Post",
	        url: "EDI_LoadDetail.aspx/SearchDetail",
	        data: "{data:'" + loadid + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d != "") {
	                var json = $.parseJSON(data.d);
	                for (var i = 0; i < json.length; i++) {

	                    var table = document.getElementById("editable2");
	                    var nextIndex = table.rows.length;
	                    var nextRow = table.insertRow(nextIndex);
	                    nextRow.insertCell(0).innerHTML = json[i].customer_name;
	                    nextRow.insertCell(1).innerHTML = json[i].Customer_Address_Code;
	                    nextRow.insertCell(2).innerHTML = json[i].Customer_Part_No;
	                    nextRow.insertCell(3).innerHTML = json[i].part_no;
	                    nextRow.insertCell(4).innerHTML = new Date(parseInt(json[i].Due_Date)).toLocaleString();
	                    nextRow.insertCell(5).innerHTML = new Date(parseInt(json[i].ShipDate)).toLocaleString();
	                    nextRow.insertCell(6).innerHTML = json[i].ORDER_NO;
	                    nextRow.insertCell(7).innerHTML = json[i].Lot_No;
	                    nextRow.insertCell(8).innerHTML = json[i].BATCH_NO;
	                    nextRow.insertCell(9).innerHTML = json[i].Standard_Quantity;
	                    nextRow.insertCell(10).innerHTML = json[i].Quantity;
	                    nextRow.insertCell(11).innerHTML = json[i].JOB_SEQUENCE;
	                    nextRow.insertCell(12).innerHTML = json[i].LoadStatus;
	                }
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

	    //查询LOADDETAIL
	    var ld = column.innerHTML;
	    queryDetail(ld.substr(ld.indexOf("FGA"), 9))

	}

	//rework功能
	function rework() {
	    var data = [];
	    var inputs = document.getElementById("editable1").getElementsByTagName("input");

	    for (var i = 0; i < inputs.length; i++) {
	        var row = {};

	        if (inputs[i].type == "checkbox") {
	            if (inputs[i].checked && inputs[i].name == "cb1") {
	                var checkedRow = inputs[i];
	                var tr = checkedRow.parentNode.parentNode;
	                var tds = tr.cells;
	                //循环列
	                row.LoadID = tds[2].innerHTML;

	                data.push(row);
	            }
	        }
	    }

	    var jsondata = JSON.stringify(data);
	    $.ajax({
	        type: "post",
	        url: "EDI_LoadDetail.aspx/reWork",
	        data: "{data:'" + jsondata + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d == "1") {
	                alert("success");
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
