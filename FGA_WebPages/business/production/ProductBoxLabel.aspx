<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductBoxLabel.aspx.cs" Inherits="FGA_PLATFORM.business.production.ProductBoxLabel" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme">
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3">
<title>ARG ProductLabel</title>
<script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
</object> 

<!-- Site favicon -->
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<!-- /site favicon -->

<!-- Entypo font stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet">
<!-- /entypo font stylesheet -->

<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
<!-- /font awesome stylesheet -->

<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
<!-- /bootstrap stylesheet min version -->     

<!-- Mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet">
<!-- /mouldifi core stylesheet -->

<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet">
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet">
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet">


</head>
<body>

<!-- Page container -->
  <!-- /page sidebar -->
  <!-- Main container -->
  <div>
  
	<div class="header-secondary " style="margin-top:-30px; margin-left:-10px">
		
			
				<button class="btn btn-primary btn-sm btn-add" onclick="queryData()">QUERY</button>
				<button class="btn btn-primary btn-sm btn-add">RESET</button>
				<button class="btn btn-primary btn-sm btn-add">IMPORT</button>
				<button class="btn btn-primary btn-sm btn-add">EXPORT</button>
				<button class="btn  btn-default btn-sm btn-add">CancellInv</button>
				<button class="btn  btn-default btn-sm btn-add">InvAdjust</button>
				<button class="btn  btn-default btn-sm btn-add">ExpTallySheet</button>
			
		
	</div>
	<!-- /secondary header -->
	
	<!-- Filter wrapper -->
	<div class="filter-wrapper" style="height: 85px; width:1250px; margin-bottom:5px; margin-right:30px" id="filter-box">
		
			<div class="form-inline" style="margin-top: -10px">
				<div class="form-group">
					<label class="form-label">InvoiceNO</label>
					<input type="text" placeholder="input" style="color: black; height:30px;width:80px">	
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">SerialNO</label>
					<input type="text" placeholder="input" style="color: black; height:30px;width:80px">
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">PartNO</label>
					<input type="text" id ="pn" placeholder="input" style="color: black; height:30px;width:150px">
				</div>
				
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Box  Type</label>
					<select class="select2 " style="width:90px">
						<option value="All" selected>All</option>
						<option>Rack</option>
						<option>Wood</option>
					</select>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Factory</label>
					<select class="select2 " style="width:80px">
						<option value="All" selected>All</option>
						<option>F1</option>
						<option>F2</option>
                        <option>F3</option>
                        <option>F4</option>
					</select>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">BoxMethod</label>
					<select class="select2 " style="width:120px">
						<option value="All" selected>All</option>
						<option>Receiving</option>
						<option>Sending</option>
					</select>
				</div>
				
				<div class="form-group"style="margin-left:-35px;"> 
					<label class="form-label">ShipmentDate(from)</label> 
					
					<div id="date-popup" class="input-group date"> 
					<input type="text" data-format="D, dd MM yyyy" class="form-control" style="width:100px"> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
                    </div>
                <div class="form-group"style="margin-left:-35px;"> 
                    <label class="form-label">ShipmentDate(to)</label> 
					
					<div id="date-popup1" class="input-group date"> 
					<input type="text" data-format="D, dd MM yyyy" class="form-control" style="width:100px"> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
					 
				</div>
				
				<!---<div class="form-group">
					<label class=" form-label">Total Box: </label>
					<label class=" form-label">Selected: </label>
					
				</div>
				<div class="form-group">
					<label class=" form-label">Total PCS: </label>
					<label class=" form-label">Selected: </label>
				</div>
			</form>
				<div class="form-group" style="margin-top:-15px">
					<testarea style="background-color:grey; color:black">Gray: InvReserve</testarea>
					<testarea style="background-color:yellow; color:black">Yellow: waitingInBound</testarea>
					<testarea style="background-color:green; color:black">Green:InBound</testarea>
					<testarea style="background-color:red; color:black">Delivery</testarea>
					<testarea style="background-color:blue; color:black">InvAdjust</testarea>
				</div>!--->
				
			</div>
		
	</div>
	
	 <div class=" form-inline" >
			
				
					<div>
						
					
					<button class=" btn btn-primary btn-sm btn-add"style="width:55px" >SetAll</button>
					<button class="btn btn-primary btn-sm btn-add" style="width:70px">Delete</button>
					<button class="btn btn-primary btn-sm btn-add"style="width:80px">uInvoiveNo</button>
					<input type="text" style="width:137px">	
					<button class="btn btn-primary btn-sm btn-add" onclick="crtBarcode()">CrtBarcode</button>
					<select class="form-control input-sm" id ="pselect">
					</select>
				
				

				
					<label >Only:</label>
							<input type="checkbox" id="All">
							<label for="admin">All</label>
							<input type="checkbox" id="UnPrinting">
							<label for="operator">UnPrinting</label>
							<input type="checkbox" id="wInBound">
							<label for="customer">wInBound</label>
							<input type="checkbox" id="InBound">
							<label for="customer">InBound</label>
							<input type="checkbox" id="InvReserve">
							<label for="customer">InvReserve</label>
							<input type="checkbox" id="InvAdjust">
							<label for="customer">InvAdjust</label>
							<input type="checkbox" id="InvOrder">
							<label for="customer">InvOrder</label>
						
				</div>
				<div class="form-group" style="margin-top:-10px">
				 
					<button class="btn btn-primary btn-sm btn-add"style="width:55px">Save</button>
					<button class="btn btn-primary btn-sm btn-add" style="width:70px">InvCheck</button>
					<button class="btn btn-primary btn-sm btn-add"style="width:80px">uShipDate</button>
					
					<div id="Div1" class="input-group date"> 
						<input type="text" data-format="D, dd MM yyyy" class="form-control" style="width:100px"> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
					</div>
					
					<button class="btn btn-primary btn-sm btn-add">CreatLabel</button>
					<button class="btn btn-primary btn-sm btn-add">CXLCreate</button>
					<button class="btn btn-primary btn-sm btn-add">printLabel</button>
					<button class="btn btn-primary btn-sm btn-add">Reprint</button>
				
				
					<ul class="pagination"> 
									<li><a href="#"><i class="icon-left-open-mini"></i></a></li> 
									<li><a href="#">1</a></li> 
									<li class="active"><a href="#">2</a></li> 
									<li><a href="#">3</a></li> 
									<li class="disabled"><a href="#">4</a></li> 
									<li><a href="#">5</a></li> 
									<li><a href="#"><i class="icon-right-open-mini"></i></a></li> 
					<select class="form-control input-sm">
						<option>10000 Records</option>
						<option>5000 Records</option>
						<option>100 Records</option>
					</select>
					</ul> 
				
				

				</div>
			
		
		<!-- /list header -->
		
		
		
			<div class=" row col-md-12">

						
							   <div class="table-responsive" style="height:430px;width:1250px; overflow:scroll">  
								<table id = "editable" class="table table-striped table-bordered table-hover " >
									<thead>
										<tr>
                                            <th>*</th>
                                            <th>BoxNo</th>
                                            <th>SerialNO</th>
                                            <th>InvoiceNO</th>
											<th>PartNO</th>
											<th>Quantity</th>
                                            <th>InBoundQTY</th>
                                            <th>LabelNO</th>
											<th>InvQTY(pcs)</th>
                                            <th>InvQTY(box)</th>
											<th>BoxType</th>
											<th>BoxCount</th>
                                            <th>BoxMethod</th>
                                            <th>ShipmentDate</th>
                                            <th>CustName</th>   <!-- /请注意！这个改了 -->
                                            <th>LabelNO</th>
                                            <th>PO</th>
                                            <th>BarcodeNUM</th>
                                            <th>Factory</th>
                                            <th>AreaCode</th>
                                            <th>OutBoundDate</th>
                                            <th>Status</th>
                                            <th>CustomerSN</th>
                                            <th>SO</th>
                                            <th>CustomerNo</th>
                                            <th>BatchNo</th>
                                            <th>DestinyPort</th>
                                            <th>InvCheck</th>
                                            <th>InboundDate</th>
                                            <th>OrderDate</th>
                                            <th>Length</th>
                                            <th>Width</th>
                                            <th>InboundUser</th>
                                            <th>LastEditUser</th>
                                            <th>TargetOrg</th>
                                            <th>TargetAreaCode</th>
                                            <th>TargetBinCode</th>
                                            <th>ShipmentAreaCode</th>
                                            <th>ShipmentBinCode</th>
                                            <th>ShipmentStatus</th>
                                            <th>YYstatus</th>
                                            <th>BoxYYstatus</th>
                                            <th>BarCode</th>
                                            <th>Factory1</th>
                                            <th>Factory2</th>
                                            <th>CreateUser</th>
                                            <th>CreateDate</th>
                                            <th>OrderType</th>


										</tr>
									</thead>
									<tbody id ="tby">
									
									</tbody>
									
								</table>
							
							</div>		
				
			</div>
		</div>	
		
		
		
	 
	  <!-- /main content -->
	  
  </div>
  <!-- /main container -->
  

<!-- /page container -->

<!--Load JQuery-->
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <!-- Input Mask-->
    <script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <!-- Select2-->
    <script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
    <!--Bootstrap ColorPicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!--Bootstrap DatePicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

	<script  type="text/javascript">

	//定义全局data
	var barcodeinfo = [];

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
        var snum = "<option>1</option>";
        for(var i =2;i<=100;i++)
        {
            snum =snum + '<option>'+i+'</option>';
        }
        //加载crtbarcode数量
        $('#pselect').html(snum);
    });


    //查询 
    //add by it-wxl 05/04/2017
    function queryData() {
        $("#editable tr:not(:first)").remove();
        var _pn = $("#pn").val();        //本厂编号

        $.ajax({
            type: "Post",
            url: "ProductBoxLabel.aspx/SearchData",
            data: "{itemcode:'" + _pn + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td> ' +
                                       '<td> ' + json[i].ItemID + '</td> ' +
                                       '<td> ' + json[i].PartNO + '</td> ' +
                                       '<td> ' + json[i].SerialNO + '</td> ' +
                                       '<td> ' + json[i].LabelNO + '</td> ' +
                                       '<td> ' + json[i].InvoiceNO + '</td> ' +
                                       '<td> ' + json[i].BoxType + '</td> ' +
                                       '<td> ' + json[i].OrderQuantity + '</td> ' +
                                       '<td> ' + json[i].InBoundQty + '</td> ' +
                                       '<td> ' + json[i].Creater + '</td> ' +
                                       '<td>' + new Date(parseInt(json[i].Createtime)).toLocaleString() + '</td> ' +
                                      '</tr>';
                    }
                    $("#tby").html(slct);
                }
            }
        });
    }

	//创建单片标签
    //标签内容：Partno barcode 
	//add by IT-WXL 05/08/2017
    function crtBarcode() {

        var inputs = document.getElementById("editable").getElementsByTagName("input");
        var pnum = $('#pselect').val();
        var LODOP;
        LODOP = getLodop();
        LODOP.SET_PRINTER_INDEX(-1);

        for (var i = 0; i < inputs.length; i++) {
            var row = {};

            if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    var checkedRow = inputs[i];
                    var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;
                    
                    var partNO = tds[2].innerHTML;
                    for (var j = 0; j < pnum; j++) {
                        //获取条码号
                        $.ajax({
                            type: "Post",
                            url: "ProductBoxLabel.aspx/getBarcodeNO",
                            data: "",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                if (data.d != "") {
                                    var bn = data.d;
                                    var bn1 = "A" + bn.substr(0,8);
                                    var bn2 = "A" + bn.substr(9, 8);;

                                    var row1 = {};
                                    var row2 = {};

                                    row1.BarcodeNO = bn1;
                                    row1.PartNO = partNO;
                                    barcodeinfo.push(row1);
                                    row2.BarcodeNO = bn2;
                                    row2.PartNO = partNO;
                                    barcodeinfo.push(row2);

                                    var mydate = new Date();

                                    //////大标签纸
                                    //zpl = "^XA^FO10,20^A0,45,45^FD" + partNO + "^FS" +
                                    //      "^FO70,60^BA,75,N,N,N^FD" + bn1 + "^FS" +
                                    //      "^FO30,140^A0,18,18^FD" + bn1 + "^FS" +
                                    //      "^FO150,140^A0,18,18^FD" + mydate.toLocaleString() + "^FS" +
                                    //      "^FO430,20^A0,45,45^FD" + partNO + "^FS" +
                                    //      "^FO490,60^BA,75,N,N,N^FD" + bn2 + "^FS" +
                                    //      "^FO450,140^A0,18,18^FD" + bn2 + "^FS" +
                                    //      "^FO570,140^A0,18,18^FD" + mydate.toLocaleString() + "^FS" +

                                    //      "^XZ";

                                    zpl = "^XA^FO10,5^A0,25,25^FD" + partNO + "^FS" +
                                          "^FO20,25^BA,50,N,N,N^FD" + bn1 + "^FS" +
                                          "^FO20,80^A0,12,12^FD" + bn1 + "^FS" +
                                          "^FO100,80^A0,10,10^FD" + mydate.toLocaleString() + "^FS" +
                                          "^XZ";
                                    LODOP.SEND_PRINT_RAWDATA(zpl);
                                }
                            }
                        });
                    }

                    //标签打印后同步到数据库
                    //add by it-wxl 05-09-2017
                    var jsondata = JSON.stringify(barcodeinfo);
                    $.ajax({
                        type: "post",
                        url: "ProductBoxLabel.aspx/SaveData",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == "1") {
                                alert("success!");
                                //清空界面数据
                                barcodeinfo = [];
                            }
                        }
                    });
                }
            }
        }
       
    }


</script>
</body>
</html>
