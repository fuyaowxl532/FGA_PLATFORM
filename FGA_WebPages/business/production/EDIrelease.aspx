<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDIrelease.aspx.cs" Inherits="FGA_PLATFORM.business.production.EDIrelease" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<title>EDI_Release</title>
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
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   

<style type="text/css">
th
  {
  background-color:black;
  color:white;
  }
</style>

</head>

<body  style="overflow: hidden;">

<div class="page-container">
 
    	<div class="row filter-wrapper visible-box" id="filter-box">
		<div class="col-lg-8">
			
			<form class="form-inline">
				<div class="form-group">
					<label class="form-label">Customer Code</label>
					<input class="form-control" id = "_orderno" type="text" placeholder="input" style="color: black; height:30px;width:150px;" />	
				</div>
				<div class="form-group">
					<label class="form-label">Ship To</label>
					<input class="form-control" id = "_partno" type="text" placeholder="input" style="color:black;height:30px;width:150px;"/>
				</div>
				<div class="form-group">
					<label class="form-label">ShipDate_To</label>
					<input class="form-control" id = "_materialno" type="text" placeholder="input" style="color:black;height:30px;width:150px;"/>
				</div>

				<div class="form-group" style="position:fixed;top:22px"  >
				  <input type="button" class="btn btn-primary btn-sm" name="search" style="background:white;color:#00b8ce" value="Search" onclick="SearchData()" />
                </div>

                <div class="form-group" style="position:fixed;top:55px" >
                  <input type="button" class="btn btn-primary btn-sm" name="export" style="background:white;color:#00b8ce" value="RELEASE" onclick=" releaseData()" />
			    </div>

			</form>
       </div>
	</div>
	<!-- /table -->
	
		<div style="width:100%;position:absolute;height:80%;overflow:auto;margin-left: 0px;float:left;margin-top:10px;">
			
							<div class="table-responsive">
								<table id = "editable" class="table table-striped table-bordered table-hover dataTables-example" >
									<thead>
										<tr>
                                     	<th>#</th>
                                        <th>ROW</th>
			                            <th>CstName</th>
			                            <th>CstAddress</th>
			                            <th>CstPartNo</th>
			                            <th>PartNo</th>
                                        <th>DueDate</th>
			                            <th>ShipDate</th>
			                            <th>Quantity</th>
                                        <th>StandardQty</th>
			                            <th>LotNo</th>
                                        <th>BatchNo</th>
                                        <th>JobSequence </th>
                                        <th>CstPartRev</th>
                                        <th>OrderNo</th>
                                        <th>RowID</th>
										</tr>
									</thead>
									<tbody id ="tby"></tbody>
								</table>
							</div>
						</div>				
</div>

<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

<script src="../../javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

    //查询初始化界面需要release的信息
    function SearchData() {
        $("#editable tr:not(:first)").remove();
        $.ajax({
            type: "Post",
            url: "EDIrelease.aspx/SearchData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                   var json = $.parseJSON(data.d);
                   var slct = "";
                   for (var i = 0; i < json.length; i++) {
                       slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                           '<td> ' + (i + 1) + '</td> ' +
                           '<td> ' + json[i].customer_name + '</td> ' +
                           '<td> ' + json[i].Customer_Address_Code + '</td> ' +
                           '<td> ' + json[i].Customer_Part_No + '</td> ' +
                           '<td> ' + json[i].part_no + '</td> ' +
                           '<td> ' + new Date(parseInt(json[i].Due_Date)).toLocaleString() + '</td> ' +
                           '<td> ' + new Date(parseInt(json[i].Ship_Date)).toLocaleString() + '</td> ' +
                           '<td> ' + json[i].Quantity + '</td> ' +
                           '<td> ' + json[i].Standard_Quantity + '</td> ' +
                           '<td> ' + json[i].Lot_No + '</td> ' +
                           '<td> ' + json[i].BATCH_NO + '</td> ' +
                           '<td> ' + json[i].JOB_SEQUENCE + '</td> ' +
                           '<td> ' + json[i].Customer_Part_Revision + '</td> ' +
                           '<td> ' + json[i].ORDER_NO + '</td> ' +
                           '<td> ' + json[i].EDI_RowID + '</td> ' +
                       '</tr>';
                   }

                   $("#tby").html(slct);
                }
            }
        });
    }

    //release数据
    function releaseData() {

        var data = [];
        var inputs = document.getElementById("editable").getElementsByTagName("input");
        var cell = new Array("customer_name", "Customer_Address_Code", "Customer_Part_No", "Customer_Part_Revision",
            "Part_No", "Part_Name", "Due_Date", "Ship_Date", "Quantity", "Order_No", "Lot_No", "Batch_No", "Job_Sequence", "EDI_Key",
            "EDI_Action", "EDI_Status", "Docname", "Standard_Quantity");

        for (var i = 0; i < inputs.length; i++) {
            var row = {};

            if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    var checkedRow = inputs[i];
                    var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;
                    //循环列
                    row.customer_name = tds[2].innerHTML;
                    row.Customer_Address_Code = tds[3].innerHTML;
                    row.Customer_Part_No = tds[4].innerHTML;
                    row.Part_No = tds[5].innerHTML;
                    row.Due_Date = tds[6].innerHTML;
                    row.Ship_Date = tds[7].innerHTML;
                    row.Quantity = parseInt(tds[8].innerHTML);
                    row.Standard_Quantity = parseInt(tds[9].innerHTML);
                    row.Lot_No = tds[10].innerHTML;
                    row.Batch_No = tds[11].innerHTML;
                    row.Job_Sequence = parseInt(tds[12].innerHTML);
                    row.Customer_Part_Revision = tds[13].innerHTML;
                    row.Order_No = tds[14].innerHTML;
                    row.EDI_RowID = tds[15].innerHTML;

                    data.push(row);
                }
               
            }
        }

        var jsondata = JSON.stringify(data);
        $.ajax({
            type: "post",
            url: "EDIrelease.aspx/releaseData",
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


