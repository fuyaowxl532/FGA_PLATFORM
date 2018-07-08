<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARGOrderList.aspx.cs" Inherits="FGA_PLATFORM.business.production.ARG.LabelManagement.ARGOrderList" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme">
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3">
<title>ARG ProductLabel</title>
<script type="text/javascript" language="javascript" src="../../../../javascript/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
</object> 
<link href="../../../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../../../css/style/mystyle.css" rel="stylesheet" />
<link href="../../../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
<link href="../../../../css/style.css" rel="stylesheet" />
<link href="../../../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<link href="../../../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="../../../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
<link href="../../../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet">
<script src="../../../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<script src="../../../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../../../javascript/common.js" type="text/javascript"></script>
<script src="../../../../javascript/My97DatePicker/WdatePicker.js"></script>
<script src="../../../../javascript/ValidationCheck.js"></script>
<script src="../../../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

.table-cont{
  max-height: 75%;
  overflow: auto;
  background: #ddd;
  margin: 5px 5px;
  box-shadow: 0 0 1px 3px #ddd;
}
thead{
  background-color: #ddd;
}
 
td{  
  text-overflow: ellipsis;  
  overflow: hidden;  
  white-space: nowrap;  
} 

</style>

</head>
<body style="overflow:hidden">
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> ARG Order Management=> ARG Order List</div>
    <input type="hidden" id="hidPageSize" value='<%= pagesize %>' />

    <!--Master button-->
	<div class="header-secondary " style="margin-top:-10px; margin-left:-10px">

	    <button class="btn btn-primary btn-sm btn-add" onclick="queryData()">QUERY</button>
        <button class="btn btn-primary btn-sm btn-add">Delete</button>
	    <button class="btn btn-primary btn-sm btn-add">RESET</button>
	    <button class="btn btn-primary btn-sm btn-add">IMPORT</button>
	    <button class="btn btn-primary btn-sm btn-add">EXPORT</button>
	    <button class="btn btn-primary btn-sm btn-add">ExpTallySheet</button>

	</div>

    <!--Filter-->
	<div class="filter-wrapper" style="height: 85px;margin-bottom:5px; margin-right:30px" id="filter-box">
		
		<div class="form-inline" style="margin-top: -10px">
			<div class="form-group">
				<label class="form-label">InvoiceNO</label>
				<input type="text" id= "ino" placeholder="input" style="color: black; height:30px;width:100px">	
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
				<label class="form-label">BoxType</label>
				<select class="select2 " style="width:90px">
					<option value="All" selected>All</option>
					<option>RACK</option>
					<option>WOOD</option>
				</select>
			</div>
			<div class="form-group" style="margin-left:-35px;">
				<label class="form-label">IsMixed</label>
				<select class="select2 " style="width:120px">
					<option value="All" selected>All</option>
					<option>Y</option>
					<option>N</option>
				</select>
			</div>
			<div class="form-group"style="margin-left:-35px;"> 
				<label class="form-label">ShipmentDate(from)</label> 
					
				<div id="date-popup" class="input-group date"> 
				<input type="text" id ="fdate" data-format="D, dd MM yyyy" class="form-control" style="width:100px"> 
					<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
					</div>
                </div>
            <div class="form-group"style="margin-left:-35px;"> 
                <label class="form-label">ShipmentDate(to)</label> 
					
				<div id="date-popup1" class="input-group date"> 
				<input type="text" id ="tdate"  data-format="D, dd MM yyyy" class="form-control" style="width:100px"> 
					<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
					</div>
					 
			</div>
            <div class="form-group" style="margin-left:-35px;">
				<label class="form-label">Page Record</label>
				<select class="select2" id ="precord" style="width:100px" onchange="changePageSize()">
                        <option value="100">100</option>
				        <option value="200">200</option>
				        <option value="500" selected>500</option>
				        <option value="1000">1000</option>
                        <option value="2000">2000</option>
                        <option value="5000">5000</option>
				</select>
			</div>

		</div>
	</div>

    <!--Second button-->
    <div>
        <div>
			<button class=" btn btn-primary btn-sm btn-add"style="width:55px" >Select All</button>
			<button class="btn btn-primary btn-sm btn-add" style="width:70px">Delete</button>
			<button class="btn btn-primary btn-sm btn-add"style="width:80px">uInvoiveNo</button>
			<input type="text" style="width:137px">	
			<button class="btn btn-primary btn-sm btn-add" onclick="crtBarcode()">CrtBarcode</button>

			<label >Only:</label>
			<input type="checkbox" id="All">
			<label for="All">All</label>
			<input type="checkbox" id="UnPrinting">
			<label for="UnPrinting">UnPrinting</label>
			<input type="checkbox" id="wInBound">
			<label for="wInBound">wInBound</label>
			<input type="checkbox" id="InBound">
			<label for="InBound">InBound</label>
			<input type="checkbox" id="InvReserve">
			<label for="InvReserve">InvReserve</label>
			<input type="checkbox" id="Shipped">
			<label for="Shipped">Shipped</label>
						
		</div>
	    <div style="margin-top:10px">
			<button class="btn btn-primary btn-sm btn-add" style="width:70px">InvCheck</button>
			<button class="btn btn-primary btn-sm btn-add">CreatLabel</button>
			<button class="btn btn-primary btn-sm btn-add">CXLCreate</button>
			<button class="btn btn-primary btn-sm btn-add">printLabel</button>
			<button class="btn btn-primary btn-sm btn-add">Reprint</button>

		</div>
    </div>
	
    <!--Table-->
    <div class='table-cont' id='table-cont' style="width:100%;margin-left: 0px;float:left;" >
        <table class="table  table-bordered table-hover dataTables-example" id ="editable">
						<thead>
							<tr>
                                <th style ="background-color:black;color:white;text-align:left">*</th>
                                <th style ="background-color:black;color:white;text-align:left">BoxNo</th>
                                <th style ="background-color:black;color:white;text-align:left">OrderNo</th>
                                <th style ="background-color:black;color:white;text-align:left">SerialNO</th>
                                <th style ="background-color:black;color:white;text-align:left">InvoiceNO</th>
                                <th style ="background-color:black;color:white;text-align:left">SubInvNO</th>
								<th style ="background-color:black;color:white;text-align:left">PartNO</th>
                                <th style ="background-color:black;color:white;text-align:left">BoxType</th>
                                <th style ="background-color:black;color:white;text-align:left">InBoundQTY</th>
                                <th style ="background-color:black;color:white;text-align:left">ShipmentDate</th>
								<th style ="background-color:black;color:white;text-align:left">OrderStatus</th>
                                <th style ="background-color:black;color:white;text-align:left">ConvertSign</th>
								<th style ="background-color:black;color:white;text-align:left">BoxMethod</th>
                                <th style ="background-color:black;color:white;text-align:left">BoxCount</th>
                                <th style ="background-color:black;color:white;text-align:left">Location</th>
                                <th style ="background-color:black;color:white;text-align:left">BarCode</th>
                                <th style ="background-color:black;color:white;text-align:left">LabelNO</th>
                                <th style ="background-color:black;color:white;text-align:left">Quantity</th>
                                <th style ="background-color:black;color:white;text-align:left">OrderDate</th>
                                <th style ="background-color:black;color:white;text-align:left">PO</th>
                                <th style ="background-color:black;color:white;text-align:left">InvCheck</th>
                                <th style ="background-color:black;color:white;text-align:left">Status</th>
                                <th style ="background-color:black;color:white;text-align:left">CustomerNO</th>
                                <th style ="background-color:black;color:white;text-align:left">CustName</th>
                                <th style ="background-color:black;color:white;text-align:left">IntBoundDate</th>
                                <th style ="background-color:black;color:white;text-align:left">InBoundUser</th>
                                <th style ="background-color:black;color:white;text-align:left">OutBoundDate</th>
                                <th style ="background-color:black;color:white;text-align:left">LastEditUser</th>
                                <th style ="background-color:black;color:white;text-align:left">LastEditDate</th>
                                <th style ="background-color:black;color:white;text-align:left">OrderType</th>
                                <th style ="background-color:black;color:white;text-align:left">OrderKey</th>
                                <th style ="background-color:black;color:white;text-align:left">Creator</th>
                                <th style ="background-color:black;color:white;text-align:left">CreateDate</th>

							</tr>
						</thead>
						<tbody id ="tby"></tbody>
				</table>
	</div>

    <div class="clear"></div>
    <div class="pagination" id="pager1" style="position:relative;top:-25px;"></div>

<script src="../../../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script type="text/javascript" src="../../../../javascript/jquery-clock-timepicker.min.js"></script>

<link href="../../../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../../../javascript/JSPager.js"></script>
<script src="../../../../javascript/DateOperate.js"></script>

	<script  type="text/javascript">

	//定义全局data
    var barcodeinfo = [];
    $('#precord').val($('#hidPageSize').val()); 
    JSPager.currentIndex = 1;
    JSPager.pageSize = $('#hidPageSize').val();

    window.onload = function(){
    var tableCont = document.querySelector('#table-cont')
    /**
    * scroll handle
    * @param {event} e -- scroll event
    */
    function scrollHandle (e){
    console.log(this)
    var scrollTop = this.scrollTop;
    this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
    }

    tableCont.addEventListener('scroll',scrollHandle)
    }

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

        var ino = $("#ino").val();        //本厂编号
        var pn  = $("#pn").val();         //本厂编号
        var fdate = $("#fdate").val();    //发运日期From
        var tdate = $("#tfate").val();    //发运日期To

        $.ajax({
            type: "Post",
            url: "ARGOrderList.aspx/SearchData",
            data: "{invoiceno:'" + ino + "',itemcode:'" + pn + "',fdate:'" + fdate + "',tdate:'" + tdate + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td> ' +
                                       '<td> ' + json[i].BoxNO + '</td> ' +
                                       '<td> ' + json[i].OrderNO + '</td> ' +
                                       '<td> ' + json[i].SerialNO + '</td> ' +
                                       '<td> ' + json[i].InvoiceNO + '</td> ' +
                                       '<td> ' + json[i].SubInvNO + '</td> ' +
                                       '<td> ' + json[i].PartNO + '</td> ' +
                                       '<td> ' + json[i].BoxType + '</td> ' +
                                       '<td> ' + json[i].InBoundQTY + '</td> ' +
                                       '<td>' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                                      '</tr>';
                    }

                    $("#tby").html(slct);
                }
            }
        });
    }

    //页面自定义条数
    function changePageSize() {

         JSPager.currentIndex = 1;
         JSPager.pageSize = $('#precord').val();
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
