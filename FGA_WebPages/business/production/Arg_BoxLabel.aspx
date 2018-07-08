<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Arg_BoxLabel.aspx.cs" Inherits="FGA_PLATFORM.business.production.Arg_BoxLabel" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ContainerLabel</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../css/style.css" rel="stylesheet" />
<!--弹消息窗样式-->
<link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />

<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	

<script src="http://www.jq22.com/jquery/jquery-migrate-1.2.1.min.js"></script>
<script src="../../javascript/jquery.jqprint-0.3.js"></script>
<script src="../../javascript/jquery.qrcode.min.js"></script>
<script src="../../javascript/jquery-barcode-2.0.1.js"></script>

<script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
</object> 

<%--<script>
    function myrefresh() {

        window.location.reload();

        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/autoRefresh",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    alert(data.d);
                }
            }
        });
    }

    setTimeout('myrefresh()', 10000); //指定1秒刷新一次

</script>--%>

</head>

<body>

<div class="col-md-10" style="width:615px; height:600px">
				<div  class="panel-body filter-wrapper" style="height:75px;position:absolute;width: 600px"> 
					<form class="form-inline" >
						
						<div class="form-group" >
							<label class="form-label" style="margin-top:-20px">PartNO</label>
							<input type="text" id="_ipn" placeholder="input"  style="color: black; height:30px;width:100px;"/>	
						</div>	
						
						<div class="form-group">	
							<label class="form-label" style="margin-top:-20px">Date(from)</label> 
							<div id="date-popup" class="input-group date"> 
								<input type="text" id="_fdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;"/>
								<span class="input-group-addon"><i class="fa fa-calendar" ></i></span> 
							</div>
						</div>
						<div class="form-group">	
							<label class="form-label" style="margin-top:-20px">Date(to)</label> 
							<div id="date-popup1" class="input-group date">
								<input type="text" id="_tdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;"/> 
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
							</div>
						</div>
						<div style=" margin-left:450px; margin-top:-50px;">	
							<input type ="button" id ="_query" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:60px" onclick="queryData()" name="query" value="Query"   />
                        </div>	
                        <div style="margin-left:450px; margin-top:10px; ">	
                         <input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:60px" onclick="viewDetails()" name="View" value="View"   />
                           </div>
                        <div style="margin-left:510px; margin-top:-60px; ">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:60px"  onclick="printLabel()" name="print" value="Print" />
						</div>

                        <div style="margin-left:510px; margin-top:10px; ">	
                        <input type ="button" id = "_rrpt" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:60px" onclick="cancelLabel()" name="cancel" value="Cancel"   />
                           </div>
					</form>
				</div>
				
				<div class=" table-responsive" style="overflow:scroll;margin-top:80px; height:330px;width:600px;">
					<table class="table-bordered table-hover" id ="editable" >
						<thead >
							<tr >
                                <th>*</th>
                                <th>RN</th>
                                <th>PartNo</th>
                                <th>BoxType</th>
                                <th>OrderQty</th>
                                <th>FinishQty</th>
                                <th>Div</th>
                                <th>Location</th>
                                <th>ShipDate</th>
                                <th>CrateStatus</th>
                                <th>LabelNo</th>
								<th>BarcodeNo</th>
                                <th>InvoiceNo</th>
								<th>BoxNo</th>
								<th>Creator</th>
								<th>CreateDate</th>
                                <th>UpdateUser</th>
								<th>UpdateDate</th>
                                <th>Item ID</th>
							</tr>
						</thead>
                        
						<tbody id ="tby1" style="white-space:nowrap">
							
						</tbody>
					</table>

				</div>

                <div class=" table-responsive" style="overflow:scroll;margin-top:5px; height:260px;width:600px;">
					<table class="table table-striped table-bordered table-hover" id ="editable2" >
						<thead >
							<tr >
                                <th>*</th>
								<th>RN</th>
                                <th>BarcodeNO</th>
                                <th>PartNO</th>
								<th>Location</th>
								<th>Creator</th>
								<th>CreateDate</th>
							</tr>
						</thead>
                        
						<tbody id ="tby2" style="white-space:nowrap">
							
						</tbody>
					</table>
				</div>

                
 
                <div style="margin-top:5px; height:200px;width:600px;">             
              
               <table id ="_partialbox"  border="1" style="white-space:nowrap;table-layout:fixed" id ="Table2" >
              
                    <tr> 
                        <td colspan="6" >     
               <img src="../../mouldifi-v-2.0/images/logo.jpg" style="height:60px; " />   </td></tr>
               <tr>
                      <td style="font-weight:bold;"><p></p>Order Number<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Delivery Date<p></p></td>
                      <td style="font-weight:bold;"><p></p>Packing Method<p></p></td>
                      <td style="font-weight:bold;"><p></p>Location<p></p></td>
                      <th colspan="2" rowspan="2" id ="partb">111</th>
                    </tr>
                    <tr>
                      <td align="center"><p id="P1" style="font-size:larger; font-weight:bold">*</p></td>
                      <td align="center"><p id="P2" style="font-size:larger;">*</p></td>
                      <td align="center"><p id="P3" style="font-size:larger;">*</p></td>
                      <td align="center"><p id="P4" style="font-size:larger;">*</p></td>                  
                    </tr>
                     <tr>
                        
                      <td style="font-weight:bold;" ><p></p>FYG PART No.<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Pallet Qty<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Partial Qty<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Load Qty<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Creator<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Create Date<p></p></td>
                  </tr>
                   <tr>
                      <td align="center"><p  id ="P5" style="font-size:larger;font-weight:bold">*</p></td>
                      <td id="P6" align="center" ></td>
                      <td id="P7" align="center"></td>
                      
                      <td id="P8" align="center"></td>
                      <td id="P9" align="center"></td>
                      <td id="P10" align="center"></td>
                      
                  </tr>
                   <tr>
                      <td style="font-weight:bold;" ><p></p>Corner Tape<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Height<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Cusion Block<p></p></td>
                      <td style="font-weight:bold;" ><p></p><p></p></td>
                      <td style="font-weight:bold;" ><p></p><p></p></td>
                      <td style="font-weight:bold;" ><p></p><p></p></td>

                   </tr>
                   <tr>
                      <td id="P11" align="center">*</td>
                      <td id="P12" align="center" ></td>
                      <td id="P13" align="center" ></td>
                      <td id="P14" align="center"></td>
                      <td id="P15" align="center" ></td>
                      <td id="P16" align="center" ></td>

                   </tr>
                  <tr>
                    <td colspan="6" >

                    <textarea id = "detail" style="width:600px;height: 60px; border-left:0px solid;border-right:0px solid;border-top:0px solid;border-bottom:0px solid" >
                        
                    </textarea>
                    </td>
                  </tr>
                 
                </table></div>
                
</div>	


<div id ="_dboxLabel" class="col-md-2">
       
                <div  style="width:600px;height:600px">             
              
           <table  border="1" style="white-space:nowrap;table-layout:fixed" id ="boxLabel" >
              
                    <tr> 
                        <td colspan="10" >     
               <img src="../../mouldifi-v-2.0/images/logo.jpg" style="height:80px; " />   </td></tr>
               <tr>
                      <td style="font-weight:bold;"><p></p>Order Number<p></p></td>
                      <td style="font-weight:bold;"><p></p>Customer<p></p></td>
                      <td style="font-weight:bold;"><p></p>Delivery Date<p></p></td>
                      <td style="font-weight:bold;"><p></p>Packing Method<p></p></td>
                      <th colspan="6" rowspan="2" id ="Bbid">111</th>
                    </tr>
                    <tr>
                      <td align="center"><p id="orderid" style="font-size:larger; font-weight:bold">*</p></td>
                      <td align="center"><p id="custid" style="font-size:larger;flex-align:center">*</p></td>
                      <td align="center"><p id="shipid" style="font-size:larger;flex-align:center">*</p></td>
                      <td align="center"><p id="boxtypid" style="font-size:larger;flex-align:center">*</p></td>                     
                    </tr>
                     <tr>
                      <td style="font-weight:bold; "><p></p>FYG PART No.<p></p></td>   
                      <td style="font-weight:bold;" ><p></p>Base<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Pallet QTY<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Load QTY<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Accessory Quantity<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Corner Tape<p></p></td> 
                      <td style="font-weight:bold;" ><p></p>Height<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Cusion Block<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Creator<p></p></td>
                      <td style="font-weight:bold;" ><p></p>Create Date<p></p></td>
                  </tr>
                   <tr>
                      <td align="center"><p  id ="partid" style="font-size:larger;font-weight:bold">*</p></td>
                      <td id="b01"align="center" ></td>
                      <td id="b02" align="center"></td>
                      <td id="b09" align="center"></td>  <!--new add-->
                      <td id="b03"align="center"></td>
                      <td id="b04"align="center" ></td>
                      <td id="b05"align="center"></td>
                      <td id="b06" align="center"></td>
                      <td id="b07" align="center"></td>
                      <td id="b08"align="center"></td> 
                     
                  </tr>
                   <tr>
                      <th>Component Part</th>
                      <th>Accessory Part Type</th>
                      <th>Accessory Part</th>
                      <th>Accessory Part Type</th>
                      <th colspan="3" ></th>
                      <td >C</td>
                      <td id="c01" ></td>
                      <td ></td>
                  </tr>
                  <tr>
                      <td id ="f01" ></td>
                      <td id ="t01" ></td>
                      <td id ="f05" ></td>
                      <td id ="t05" ></td>
                      <td colspan="3" rowspan="4" ></td>
                      <td>Antenna</td>
                      <td id="c02"></td>
                      <td></td>
                  </tr>
                  <tr>
                      <td id ="f02"></td>
                      <td id ="t02" ></td>
                      <td id ="f06"></td>
                      <td id ="t06"></td>
                      <td>Rain sensor</td>
                      <td id="c03" ></td>
                      <td></td>
                  </tr>
                   <tr>
                      <td id ="f03" ></td>
                      <td id ="t03" ></td>
                      <td id ="f07"></td>
                      <td id ="t07" ></td>
                      <td>Lace</td>
                      <td id="c04" ></td>
                      <td></td>
                  </tr>
                  <tr>
                      <td id ="f04" ></td>
                      <td id ="t04"></td>
                      <td id ="f08" ></td>
                      <td id ="t08" ></td>
                      <td>3M Lace</td>
                      <td id="c05" ></td>
                      <td></td>
                  </tr>
                  <tr>
                      <td colspan="4" style="font-weight: bold;" >Unloader--1st Piece：</td>
                      <td colspan="6" style="font-weight: bold;" >No. of Pcs in Crate:</td>
                      
                  </tr>
                  <tr>
                      <td colspan="10" style="font-weight: bold; " align="center">ARG Packaging: Leading with Excellence by Doing it Right the First Time!</td>
                      
                      
                  </tr>
                  <tr>
                      <td colspan="4" style=" font-weight:bold;"> Packer Inspection:</td>
                      
                      <td colspan="6" style=" font-weight:bold;"> *Inspection should take less than 45 seconds</td>
                  </tr>
                  <tr>
                      <td colspan="4" >Pallet Qty</td>
                      
                      <td colspan="6" ></td>
                      
                  </tr>
                 <tr>
                      <td colspan="4">Crate Type</td>
                      
                      <td colspan="6" style=" font-weight:bold">Packer:</td>
                     
                  </tr>
                   <tr>
                      <td colspan="4">Crate Size</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Confirm Part # on Trademark, Label, and Packing List match</td>
                      
                      <td colspan="6" style=" font-weight:bold">Shift:</td>
                  </tr>
                  <tr>
                      <td colspan="4">TBL(1st/last piece): use flashlight</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Glass is aligned well</td>
                     
                      <td colspan="6" style=" font-weight:bold">Date:</td>
                  </tr>
                  <tr>
                      <td colspan="4">Glass doesn't touch bottom of crate</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Glass is not touching other glass</td>
                     
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Glass is centered in crate</td>
                      
                      <td colspan="6" style=" font-weight:bold">Packing Method Verified in Barcode:</td>
                  </tr>
                  <tr>
                      <td colspan="4">Spacer size and alignment are correct</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Brackets are all alike, aligned, and not touching glass</td>
                      
                      <td colspan="6" style=" font-weight:bold">Shift:</td>
                  </tr>
                  <tr>
                       <td colspan="4">Lace is all alike, aligned, and properly installed</td>
                      
                      <td colspan="6" ></td>
                  </tr>
                  <tr>
                      <td colspan="4">No Brackets or Lace are misiing</td>
                     
                      <td colspan="6" style=" font-weight:bold" >Date:</td>
                  </tr>
                  <tr>
                      <td colspan="4">Crate is not defective</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">PVB removed </td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Tape firmly secure</td>
         
                      <td colspan="6" style=" font-weight:bold">Notes pertaining to this crate:</td>
                  </tr>
                  <tr>
                      <td colspan="4">Antenna connectors are secure</td>
                    
                      <td colspan="6"></td>
                  </tr>
                   <tr>
                      <td colspan="4">Debris removed from crate</td>
                    
                 
                      <td colspan="6"></td>
                  </tr>
                   <tr>
                      <td colspan="4" style=" font-weight:bold">Steel:</td>
                    
                      <td colspan="6"></td>
                  </tr>
                   <tr>
                      <td colspan="4">Old label removed</td>
                      
                     
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Green/Purple sticker removed</td>
                     
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Pins are properly placed, locked, and/or positioned</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Back spine properly assembled</td>
                      
                   
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4" style=" font-weight:bold">Wood:</td>
          
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4">Foam block placement</td>
                      
                      <td colspan="6"></td>
                  </tr>
                  <tr>
                      <td colspan="4" >Crate doesn't not lean</td>
                      
                      
                      <td colspan="6"></td>
                      </tr>
                  <tr>
                      <td colspan="10" style="background:black"><p></p></td>
                      
                     
                  </tr>
                  <tr>
                      <td colspan="10" style=" font-weight:bold">NO MIXED GLASS! NO WRONG LABELS!</td>
                      
                     
                  </tr>
                  <tr>
                      <td colspan="10">If identified defects cannot be easily and quickly fixed, notify responsible Supervisor/Coordinator to be addressed immediatley.</td>
                      
                     
                  </tr>
                  <tr>
                      
                      <td colspan="10">Logistics must be a priority; glass must continue to flow to the warehouse--Packing is not a glass storage faciliy</td>
                  </tr>
                  <tr>
                      
                      <td colspan="10">Put good glass in CRATES. Deliver finished glass to Customer--swiftly!</td>
                  </tr>
                  <tr>
                       <td colspan="10">NOTICE: Packers are accountable for ensuring no mixed glass or wrong labeld go to Staging/Customer.</td>
                  </tr>
                   <!-- <tr>
                    <td colspan="10" style="background:black"><p></p></td>  
                  
                  </tr> -->
                </table></div>
</div>


<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="../../javascript/JSPager.js"></script>

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
        $('#year-view').datepicker({
            startView: 2,
            keyboardNavigation: false,
            forceParse: false,
            format: "mm/dd/yyyy"
        });
    });
    

    //查询 
    //add by it-wxl 05/04/2017
    function queryData() {
        $("#editable tr:not(:first)").remove();
        
        var _pn = $("#_ipn").val();        //本厂编号
        var _fdate = $("#_fdtxt").val();   //交付日期F
        var _tdate = $("#_tdtxt").val();   //交付日期T

        if (_fdate != "" && _tdate == "") {
            alert("Please input date!");
            return;
        }
        if (_fdate == "" && _tdate != "") {
            alert("Please input date!");
            return;
        }

        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/SearchData",
            data: "{pncode:'" + _pn + "',fdate:'" + _fdate + "',tdate:'" + _tdate + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                         //时间转换
                        var sdate = new Date(parseInt(json[i].ShipmentDate)).toLocaleString();
                        var cdate;
                        var udate;
                        if (json[i].BLCreatetime.indexOf("-") == 0)
                            cdate = "";
                        else
                            cdate = new Date(parseInt(json[i].BLCreatetime)).toLocaleString();

                        if (json[i].UpdateDate.indexOf("-") == 0)
                            udate = "";
                        else
                            udate = new Date(parseInt(json[i].UpdateDate)).toLocaleString();
       

                        if (json[i].BoxLabel != "") {

                            var table = document.getElementById("editable");
                            var nextIndex = table.rows.length;
                            var nextRow = table.insertRow(nextIndex);
                            nextRow.onclick = function () { PieceOfPart(this) }; //为每行增加单击事件  
                            if (json[i].OrderQuantity - json[i].Quantity ==0)
                                nextRow.bgColor = "yellowgreen";
                            else
                                nextRow.bgColor = "Yellow";

                            nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
                            nextRow.insertCell(1).innerHTML = nextIndex;
                            nextRow.insertCell(2).innerHTML = json[i].PartNO;
                            nextRow.insertCell(3).innerHTML = json[i].BoxType;
                            nextRow.insertCell(4).innerHTML = json[i].OrderQuantity;
                            nextRow.insertCell(5).innerHTML = json[i].Quantity;
                            nextRow.insertCell(6).innerHTML = (json[i].OrderQuantity - json[i].Quantity);
                            nextRow.insertCell(7).innerHTML = json[i].Location;
                            nextRow.insertCell(8).innerHTML = sdate.substring(0, sdate.indexOf(","));
                            nextRow.insertCell(9).innerHTML = json[i].CrateStatus;
                            nextRow.insertCell(10).innerHTML = json[i].LabelNO;
                            nextRow.insertCell(11).innerHTML = json[i].BoxLabel;
                            nextRow.insertCell(12).innerHTML = json[i].InvoiceNO;
                            nextRow.insertCell(13).innerHTML = json[i].BoxNO;
                            nextRow.insertCell(14).innerHTML = json[i].BLCreator;
                            nextRow.insertCell(15).innerHTML = cdate;
                            nextRow.insertCell(16).innerHTML = json[i].Updator;
                            nextRow.insertCell(17).innerHTML = udate;
                            nextRow.insertCell(18).innerHTML = json[i].ItemID;
                        }
                        else
                        {
                            var table = document.getElementById("editable");
                            var nextIndex = table.rows.length;
                            var nextRow = table.insertRow(nextIndex);
                            nextRow.onclick = function () { PieceOfPart(this) }; //为每行增加单击事件  
                            nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
                            nextRow.insertCell(1).innerHTML = nextIndex;
                            nextRow.insertCell(2).innerHTML = json[i].PartNO;
                            nextRow.insertCell(3).innerHTML = json[i].BoxType;
                            nextRow.insertCell(4).innerHTML = json[i].OrderQuantity;
                            nextRow.insertCell(5).innerHTML = json[i].Quantity;
                            nextRow.insertCell(6).innerHTML = (json[i].OrderQuantity - json[i].Quantity);
                            nextRow.insertCell(7).innerHTML = json[i].Location;
                            nextRow.insertCell(8).innerHTML = sdate.substring(0, sdate.indexOf(","));
                            nextRow.insertCell(9).innerHTML = json[i].CrateStatus;
                            nextRow.insertCell(10).innerHTML = json[i].LabelNO;
                            nextRow.insertCell(11).innerHTML = json[i].BoxLabel;
                            nextRow.insertCell(12).innerHTML = json[i].InvoiceNO;
                            nextRow.insertCell(13).innerHTML = json[i].BoxNO;
                            nextRow.insertCell(14).innerHTML = json[i].BLCreator;
                            nextRow.insertCell(15).innerHTML = cdate;
                            nextRow.insertCell(16).innerHTML = json[i].Updator;
                            nextRow.insertCell(17).innerHTML = udate;
                            nextRow.insertCell(18).innerHTML = json[i].ItemID;
                        }
                    }

                }
            }
        });
    }

    //加载单片事件
    function PieceOfPart(column) {

        //查询LOADDETAIL
        var ld = column.innerHTML;
        var part;
        //获取Part
        if (ld.indexOf("FYG") > -1)
        {
            if (ld.indexOf("RACK") > -1)
            {
                part = ld.substring(ld.indexOf("FYG"), ld.indexOf("RACK") - 9);
            }
            if (ld.indexOf("WOOD") > -1) {
                part = ld.substring(ld.indexOf("FYG"), ld.indexOf("WOOD") - 9);
            }
            
        }

        if (ld.indexOf("FGA") > -1 && ld.indexOf("FGA") < 80)
        {
            if (ld.indexOf("RACK") > -1) {
                part = ld.substring(ld.indexOf("FGA"), ld.indexOf("RACK") - 9);
            }
            if (ld.indexOf("WOOD") > -1) {
                part = ld.substring(ld.indexOf("FGA"), ld.indexOf("WOOD") - 9);
            }
        }
        
        queryDetail(part);
    }

    //加载单片信息
    function queryDetail(transfno) {

        $("#editable2 tr:not(:first)").remove();
        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/getPiecePart",
            data: "{partNo:'" + transfno + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                        var slct = "";
                        var cdate;
                        for (var i = 0; i < json.length; i++) {

                            if (json[i].Createtime.indexOf("-") == 0)
                                cdate = "";
                            else
                                cdate = new Date(parseInt(json[i].Createtime)).toLocaleString()

                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td> ' + (i + 1) + '</td> ' +
                                '<td> ' + json[i].BarcodeNO + '</td> ' +
                                '<td> ' + json[i].PartNO + '</td> ' +
                                '<td> ' + json[i].Location + '</td> ' +
                                '<td> ' + json[i].Creater + '</td> ' +
                                '<td>'  + cdate + '</td> ' +
                                '</tr>';
                        }
                        $("#tby2").html(slct);
                    }
            }
        });
    }

    //预览箱牌信息
    function viewDetails() {
        //查看前清空界面数据
        $('#f01').html("");
        $('#t01').html("");
        $('#f02').html("");
        $('#t02').html("");
        $('#f03').html("");
        $('#t03').html("");
        $('#f04').html("");
        $('#t04').html("");
        $('#f05').html("");
        $('#t05').html("");
        $('#f06').html("");
        $('#t06').html("");
        $('#f07').html("");
        $('#t07').html("");
        $('#f08').html("");
        $('#t08').html("");

        $('#c01').html("");
        $('#c02').html("");
        $('#c03').html("");
        $('#c04').html("");
        $('#c05').html("");

        var inputs = document.getElementById("editable").getElementsByTagName("input");

        for (var i = 0; i < inputs.length; i++) {
            
            var row = {};

            if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    
                    var checkedRow = inputs[i];
                    var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;

                    var value = "";//条码号

                    var invno = jQuery.trim(tds[12].innerHTML);
                    var boxno = jQuery.trim(tds[13].innerHTML);
                    var partNO = jQuery.trim(tds[2].innerHTML);
                    var boxtype = jQuery.trim(tds[3].innerHTML);
                    var labelid = jQuery.trim(tds[10].innerHTML);
                    var itemid = jQuery.trim(tds[18].innerHTML);
                    var shipdate = tds[7].innerHTML;
                    var orderQty = tds[4].innerHTML;

                    //基本信息
                    $('#orderid').html(invno + "-" + boxno);
                    $('#shipid').html(shipdate);
                    $('#boxtypid').html(boxtype);
                    $('#labelid').html(labelid);
                    $('#partid').html(partNO);
                    $('#b02').html(orderQty); 

                    //获取产品附件信息
                    $.ajax({
                        type: "Post",
                        url: "Arg_BoxLabel.aspx/getPartAcc",
                        data: "{pncode:'" + partNO + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                var json = $.parseJSON(data.d);
                                $('#b03').html(json.length);

                                for (i = 0; i < json.length; i++) {
                                    if (i == 0) {
                                        $('#f01').html(json[0].Component_Part);
                                        $('#t01').html(json[0].Component_Type);
                                    }
                                    if (i == 1) {
                                        $('#f02').html(json[1].Component_Part);
                                        $('#t02').html(json[1].Component_Type);
                                    }
                                    if (i == 2) {
                                        $('#f03').html(json[2].Component_Part);
                                        $('#t03').html(json[2].Component_Type);
                                    }
                                    if (i == 3) {
                                        $('#f04').html(json[3].Component_Part);
                                        $('#t04').html(json[3].Component_Type);
                                    }
                                    if (i == 4) {
                                        $('#f05').html(json[4].Component_Part);
                                        $('#t05').html(json[4].Component_Type);
                                    }
                                    if (i == 5) {
                                        $('#f06').html(json[5].Component_Part);
                                        $('#t06').html(json[5].Component_Type);
                                    }
                                    if (i == 6) {
                                        $('#f07').html(json[6].Component_Part);
                                        $('#t07').html(json[6].Component_Type);
                                    }
                                    if (i == 7) {
                                        $('#f08').html(json[7].Component_Part);
                                        $('#t08').html(json[7].Component_Type);
                                    }

                                }
                            }
                        }
                    });

                    //获取产品属性
                    $.ajax({
                        type: "Post",
                        url: "Arg_BoxLabel.aspx/getPartInfos",
                        data: "{pncode:'" + partNO + "',pnum:'" + orderQty + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                var json = data.d;
                                var high = json.substr(4, json.indexOf("gasket") - 4);
                                var gasket = json.substr(json.indexOf("gasket") + 6, json.indexOf("corner") - json.indexOf("gasket") - 6);
                                var corner = json.substr(json.indexOf("corner") + 6, json.indexOf("base") - json.indexOf("corner") - 6);
                                var base = json.substr(json.indexOf("base") + 4);


                                $('#b01').html(base);    //底座编码
                                $('#b04').html(corner);  //包角模式
                                $('#b05').html(high);    //箱高
                                $('#b06').html(gasket);  //垫片规格
                            }
                            else {
                                alert("error!");
                            }

                        }
                    });

                    //获取包边模式
                    $.ajax({
                        type: "Post",
                        url: "Arg_BoxLabel.aspx/getPartEdge",
                        data: "{pncode:'" + partNO + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                var json = $.parseJSON(data.d);
                                for (i = 0; i < json.length; i++) {
                                    //判断包边模式
                                    if (json[i].EdgeType == "Antenna") {
                                        $('#c02').html("N");
                                    }
                                    if (json[i].EdgeType == "Rain Sensor") {
                                        $('#c03').html("R");
                                    }
                                    if (json[i].EdgeType == "Lace") {
                                        $('#c04').html("L");
                                    }
                                    if (json[i].EdgeType == "3M Lace") {
                                        $('#c05').html("A");
                                    }
                                }
                            }
                            else {
                                $('#c01').html("C");
                            }
                        }
                    });

                    return;
                }
            }
        }

    }

    //打印箱牌
    //ZPL
    //add by it-wxl 09212017
    function prtlabelzpl() {

    }

    //打印箱牌
    //箱牌   当BoxLabel未空
    //半箱   当BoxLabel已创建

    function printLabel() {

        var roel;
        //获取当前用户角色
        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/getRoleInfos",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var role = data.d;
                    if (role != "ARGPackagingMag" && role != "Admin" && role != "ARGBoxLabelPrinter") {
                        alert("You don't have permission!");
                        return;
                    }
                    else
                    {

                        //查看前清空界面数据
                        $('#f01').html("");
                        $('#t01').html("");
                        $('#f02').html("");
                        $('#t02').html("");
                        $('#f03').html("");
                        $('#t03').html("");
                        $('#f04').html("");
                        $('#t04').html("");
                        $('#f05').html("");
                        $('#t05').html("");
                        $('#f06').html("");
                        $('#t06').html("");
                        $('#f07').html("");
                        $('#t07').html("");
                        $('#f08').html("");
                        $('#t08').html("");

                        $('#c01').html("");
                        $('#c02').html("");
                        $('#c03').html("");
                        $('#c04').html("");
                        $('#c05').html("");

                        $('#P1').html("");
                        $('#P2').html("");
                        $('#P3').html("");
                        $('#P4').html("");
                        $('#P5').html("");
                        $('#P6').html("");
                        $('#P7').html("");
                        $('#P8').html("");
                        $('#P9').html("");

                        var inputs = document.getElementById("editable").getElementsByTagName("input");

                        for (var i = 0; i < inputs.length; i++) {
                            var row = {};

                            if (inputs[i].type == "checkbox") {
                                if (inputs[i].checked && inputs[i].name == "cb1") {
                                    var checkedRow = inputs[i];
                                    var tr = checkedRow.parentNode.parentNode;
                                    var tds = tr.cells;

                                    var value = "";  //条码号
                                    var print = "";  //打印机名称

                                    var invno = jQuery.trim(tds[12].innerHTML);
                                    var boxno = jQuery.trim(tds[13].innerHTML);
                                    var OrderNumber = invno + "-" + boxno;
                                    var partNO = jQuery.trim(tds[2].innerHTML);
                                    var boxtype = jQuery.trim(tds[3].innerHTML);
                                    var labelid = jQuery.trim(tds[10].innerHTML);
                                    var itemid = jQuery.trim(tds[18].innerHTML);
                                    var shipdate = tds[8].innerHTML;
                                    var orderQty = tds[4].innerHTML;
                                    var boxlabel = tds[11].innerHTML;
                                    var loc = tds[7].innerHTML;
                                    var pqty = tds[5].innerHTML;
                                    var C1 = "";
                                    var N2 = "";
                                    var R3 = "";
                                    var L4 = "";
                                    var A5 = "";
                                    var high   = "";
                                    var gasket = "";
                                    var corner = "";
                                    var base = "";
                                    var brack = "";
                                    var baseqty = 0;

                                    var bom1 = "";
                                    var bom2 = "";
                                    var bom3 = "";
                                    var bom4 = "";
                                    var bom5 = "";
                                    var bom6 = "";
                                    var bom7 = "";
                                    var bom8 = "";

                                    var bomt1 = "";
                                    var bomt2 = "";
                                    var bomt3 = "";
                                    var bomt4 = "";
                                    var bomt5 = "";
                                    var bomt6 = "";
                                    var bomt7 = "";
                                    var bomt8 = "";

                                    var Line = "Initial";
                                    var Unloader1 = "system1";
                                    var Unloader2 = "system2";
                                    var Unloader3;
                                    var Unloader4;



                                    //箱牌
                                    if (boxlabel == "") {

                                        //设置打印数量
                                        //提示信息显示单片信息
                                        //输入值<= (订单数量-单片)
                                        var lqty_f;
                                        var wipqty_f = 0;
                                        var wipinfo_f;


                                        //获取单片信息
                                        var inputs = document.getElementById("editable2").getElementsByTagName("input");

                                        for (var i = 0; i < inputs.length; i++) {
                                            var row_f = {};

                                            if (inputs[i].type == "checkbox") {
                                                if (inputs[i].checked && inputS[i].name == "cb1") {
                                                    wipqty_f++;
                                                }
                                            }
                                        }

                                        lqty_f = orderQty - wipqty_f;

                                        //获取打印数量
                                        var tall_f;
                                        var tall_f = prompt("Please input load quantity." + '\n' + "Order Quantity:" + orderQty
                                            + '\n' + "Wip Quantity:" + wipqty_f + '\n' + "Valid Quantity Range:" + "(0~" + lqty_f + ")", lqty_f);

                                        if (tall_f != null)
                                        {
                                            if (parseInt(tall_f) <= lqty_f && parseInt(tall_f) >= 0)
                                            {
                                                //基本信息
                                                $('#orderid').html(invno + "-" + boxno);
                                                $('#shipid').html(shipdate);
                                                $('#boxtypid').html(boxtype);
                                                $('#labelid').html(labelid);
                                                $('#partid').html(partNO);
                                                $('#b02').html(orderQty);
                                                //获取产品附件信息
                                                $.ajax({
                                                    type: "Post",
                                                    url: "Arg_BoxLabel.aspx/getPartAcc",
                                                    data: "{pncode:'" + partNO + "'}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    async: false,
                                                    success: function (data) {
                                                        if (data.d != "") {
                                                            var json = $.parseJSON(data.d);
                                                            baseqty = json.length;

                                                            for (i = 0; i < json.length; i++) {
                                                                if (i == 0) {
                                                                    bom1  = json[0].Component_Part;
                                                                    //bomt1 = json[0].Component_Type;
                                                                    $('#f01').html(json[0].Component_Part);
                                                                    $('#t01').html(json[0].Component_Type);

                                                                }
                                                                if (i == 1) {
                                                                    bom2 = json[1].Component_Part;
                                                                    //bomt2 = json[1].Component_Type;
                                                                    $('#f02').html(json[1].Component_Part);
                                                                    $('#t02').html(json[1].Component_Type);

                                                                }
                                                                if (i == 2) {
                                                                    bom3 = json[2].Component_Part;
                                                                    //bomt3 = json[2].Component_Type;
                                                                    $('#f03').html(json[2].Component_Part);
                                                                    $('#t03').html(json[2].Component_Type);

                                                                }
                                                                if (i == 3) {
                                                                    bom4 = json[3].Component_Part;
                                                                    //bomt4 = json[3].Component_Type;
                                                                    $('#f04').html(json[3].Component_Part);
                                                                    $('#t04').html(json[3].Component_Type);

                                                                }
                                                                if (i == 4) {
                                                                    bom5 = json[4].Component_Part;
                                                                    //bomt5 = json[4].Component_Type;
                                                                    $('#f05').html(json[4].Component_Part);
                                                                    $('#t05').html(json[4].Component_Type);

                                                                }
                                                                if (i == 5) {
                                                                    bom6 = json[5].Component_Part;
                                                                    //bomt6 = json[5].Component_Type;
                                                                    $('#f06').html(json[5].Component_Part);
                                                                    $('#t06').html(json[5].Component_Type);

                                                                }
                                                                if (i == 6) {
                                                                    bom7 = json[6].Component_Part;
                                                                    //bomt7 = json[6].Component_Type;
                                                                    $('#f07').html(json[6].Component_Part);
                                                                    $('#t07').html(json[6].Component_Type);

                                                                }
                                                                if (i == 7) {
                                                                    bom8 = json[7].Component_Part;
                                                                    //bomt8 = json[7].Component_Type;
                                                                    $('#f08').html(json[7].Component_Part);
                                                                    $('#t08').html(json[7].Component_Type);

                                                                }

                                                            }
                                                        }
                                                    }
                                                });
                                                //获取产品属性
                                                $.ajax({
                                                    type: "Post",
                                                    url: "Arg_BoxLabel.aspx/getPartInfos",
                                                    data: "{pncode:'" + partNO + "',pnum:'" + orderQty + "'}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    async: false,
                                                    success: function (data) {
                                                        if (data.d != "") {
                                                            var json = data.d;

                                                            high = json.substr(4, json.indexOf("gasket") - 4);
                                                            gasket = json.substr(json.indexOf("gasket") + 6, json.indexOf("corner") - json.indexOf("gasket") - 6);
                                                            corner = json.substr(json.indexOf("corner") + 6, json.indexOf("base") - json.indexOf("corner") - 6);
                                                            base = json.substr(json.indexOf("base") + 4, json.indexOf("brack") - json.indexOf("base") - 4);
                                                            brack = json.substr(json.indexOf("brack") + 5);

                                                            if (brack != "" && boxtype.toUpperCase().indexOf("RACK") > -1)
                                                                boxtype = brack;

                                                            $('#b01').html(base);    //底座编码
                                                            $('#b04').html(corner);  //包角模式
                                                            $('#b05').html(high);    //箱高
                                                            $('#b06').html(gasket);  //垫片规格
                                                            $('#b09').html(tall_f);  //本次打印数量
                                                        }
                                                        else {
                                                            alert("error!");
                                                        }

                                                    }
                                                });
                                                //获取包边模式
                                                $.ajax({
                                                    type: "Post",
                                                    url: "Arg_BoxLabel.aspx/getPartEdge",
                                                    data: "{pncode:'" + partNO + "'}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    async: false,
                                                    success: function (data) {
                                                        if (data.d != "") {
                                                            var json = $.parseJSON(data.d);
                                                            for (i = 0; i < json.length; i++) {
                                                                //判断包边模式
                                                                if (json[i].EdgeType == "Antenna") {
                                                                    N2 = "N";
                                                                    $('#c02').html("N");
                                                                }
                                                                if (json[i].EdgeType == "Rain Sensor") {
                                                                    R3 = "R";
                                                                    $('#c03').html("R");
                                                                }
                                                                if (json[i].EdgeType == "Lace") {
                                                                    L4 = "L";
                                                                    $('#c04').html("L");
                                                                }
                                                                if (json[i].EdgeType == "3M Lace") {
                                                                    A5 = "A";
                                                                    $('#c05').html("A");
                                                                }
                                                            }
                                                        }
                                                        else {
                                                            C1 = "C";
                                                            $('#c01').html("C");
                                                        }
                                                    }
                                                });

                                                //获取当前用户打印机
                                                $.ajax({
                                                    type: "Post",
                                                    url: "Arg_BoxLabel.aspx/getPrinter",
                                                    data: "",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    async: false,
                                                    success: function (data) {
                                                        if (data.d != "") {
                                                            print = data.d;
                                                        }
                                                        else {
                                                            print = "ZDesigner_ARGPackingSlip_OldOfice";
                                                        }
                                                    }
                                                });


                                                //获取条码号
                                                $.ajax({
                                                    type: "Post",
                                                    url: "Arg_BoxLabel.aspx/getBoxLabel",
                                                    data: "{itemid:'" + itemid + "',invoiceno:'" + invno + "',pncode:'" + partNO + "',orderqty:" + orderQty + ",finqty:" + (parseInt(tall_f) + parseInt(wipqty_f)) + "}",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    async: false,
                                                    success: function (data) {
                                                        if (data.d != "") {
                                                            value = data.d.substr(4, data.d.indexOf("username") - 4);
                                                            var username = data.d.substr(data.d.indexOf("username") + 8, data.d.indexOf("cdate") - data.d.indexOf("username") - 8);
                                                            var cdate = data.d.substr(data.d.indexOf("cdate") + 5);

                                                            var time1 = cdate.substring(0, cdate.indexOf(" "));

                                                            var time2 = cdate.substr(cdate.indexOf(" "));

                                                            if (value != "") {
                                                                if (value == "1") {
                                                                    alert("Please create sales-order first");      //提示存在正式订单还未创建箱牌
                                                                    return;
                                                                }
                                                                if (value == "2") {

                                                                    alert("Existing earlier sales-order");      //提示存在3天前的订单还未创建箱牌
                                                                    return;
                                                                }
                                                                if (value == "3") {

                                                                    alert("Existing partial box");      //提示存在3天前的订单还未创建箱牌
                                                                    return;
                                                                }

                                                                if (value != "1" && value != "2" && value != "3") {

                                                                    //整箱箱牌
                                                                    var LODOP;
                                                                    var lodop;

                                                                    LODOP = getLodop();
                                                                    LODOP.SET_PRINTER_INDEXA(print);

                                                                    var boxlabel = "^XA" +
                                                                        "^FO736,8^GB0,1192,4^FS" +
                                                                        "^FO8,8^GB792,0,4^FS" +
                                                                        "^FO8,8^GB0,1192,4^FS" +
                                                                        "^FO8,1200^GB792,0,4^FS" +
                                                                        "^FO800,8^GB0,1192,4^FS" +
                                                                        "^FO200,8^GB0,1072,4^FS" +
                                                                        "^FO160,8^GB0,1072,4^FS" +
                                                                        "^FO40,8^GB0,1192,4^FS" +
                                                                        "^FO80,8^GB0,688,4^FS" +
                                                                        "^FO40,320^GB696,0,4^FS" +
                                                                        "^FO40,440^GB696,0,4^FS" +
                                                                        "^FO40,560^GB696,0,4^FS" +
                                                                        "^FO40,696^GB696,0,4^FS" +
                                                                        "^FO40,896^GB520,0,4^FS" +
                                                                        "^FO40,1080^GB400,0,4^FS" +
                                                                        "^FO120,8^GB0,1072,4^FS" +
                                                                        "^FO264,8^GB0,1192,4^FS" +
                                                                        "^FO360,8^GB0,1192,4^FS" +
                                                                        "^FO440,8^GB0,1192,4^FS" +
                                                                        "^FO560,8^GB0,1192,4^FS" +
                                                                        "^FO630,696^GB0,504,4^FS" +
                                                                        "^FO264,800^GB176,0,4^FS" +
                                                                        "^FO40,960^GB224,0,4^FS" +
                                                                        "^FO80,896^GB0,184,4^FS" +
                                                                        "^FO16,24^A0R,24,32^FDNote:^FS" +
                                                                        "^FO640,24^A0R,32,40^FDOrderNumber^FS" +
                                                                        "^FO736,24^A0R,64,104^FDARGPackingSlip^FS" +
                                                                        "^FO280,24^A0R,40,40^FD" + partNO + "^FS" +
                                                                        "^FO392,24^A0R,32,40^FDFYGPartNo.^FS" +
                                                                        "^FO464,24^A0R,40,35^FD" + OrderNumber + "^FS" +
                                                                        "^FO224,24^A0R,32,40^FDPart#^FS" +
                                                                        "^FO560,790^A0R,70,60^FDID:" + value + "^FS" +
                                                                        "^FO645,750^BCR,80,N,N,N^FD" + value + "^FS" +
                                                                        "^FO664,328^A0R,32,32^FDDelivery^FS" +
                                                                        "^FO664,448^A0R,32,32^FDPacking^FS" +
                                                                        "^FO624,328^A0R,32,32^FDDate^FS" +
                                                                        "^FO624,448^A0R,32,32^FDMethod^FS" +
                                                                        "^FO464,335^A0R,20,20^FD" + shipdate + "^FS";
                                                                        var barBoxtype; 
                                                                        if (boxtype =="Rack-B")
                                                                            barBoxtype = "^FO464,450^A0R,30,30^FD" + boxtype + "^FS";
                                                                        else
                                                                            barBoxtype = "^FO464,450^A0R,45,45^FD" + boxtype + "^FS";

                                                                        var barcode2 = "^FO464,576^A0R,44,48^FD" + orderQty + "^FS" +
                                                                        "^FO664,568^A0R,32,32^FDCrateQty^FS" +
                                                                        "^FO400,336^A0R,32,32^FDMirror^FS" +
                                                                        "^FO400,448^A0R,32,32^FDLoadQty^FS" +
                                                                        "^FO480,712^A0R,32,32^FDCornerTape^FS" +
                                                                        "^FO480,1000^A0R,44,48^FD" + corner + "^FS" +
                                                                        "^FO400,808^A0R,32,32^FDHeight^FS" +
                                                                        "^FO400,704^A0R,32,32^FDSpacer^FS" +
                                                                        "^FO300,336^A0R,25,25^FD" + base + "^FS" +
                                                                        "^FO280,456^A0R,44,48^FD" + tall_f + "^FS" +
                                                                        "^FO280,600^A0R,30,30^FD" + baseqty +"^FS" +
                                                                        "^FO280,730^A0R,45,45^FD" + gasket + "^FS" +
                                                                        "^FO280,808^A0R,45,45^FD" + high + "^FS" +
                                                                        "^FO280,936^A0R,20,20^FD" + username + "^FS" +
                                                                        "^FO128,712^A0R,24,32^FDUnloader:^FS" +
                                                                        "^FO168,40^A0R,24,32^FD" + bom1 + "^FS" +
                                                                        "^FO400,912^A0R,32,32^FDLineAuditor:^FS" +
                                                                        "^FO168,344^A0R,24,32^FD" + bomt1 + "^FS" +
                                                                        "^FO168,720^A0R,24,32^FD"+Line+"^FS" +
                                                                        "^FO400,1088^A0R,32,32^FDCreate^FS" +
                                                                        "^FO400,568^A0R,32,32^FDAccessory^FS" +
                                                                        "^FO368,568^A0R,32,32^FDQty^FS" +
                                                                        "^FO368,1088^A0R,32,32^FDDate^FS" +
                                                                        "^FO280,1088^A0R,20,20^FD" + time2 + "^FS" +
                                                                        "^FO310,1088^A0R,20,20^FD" + time1 + "^FS" +
                                                                        "^FO232,328^A0R,24,24^FDAccessory^FS" +
                                                                        "^FO208,328^A0R,24,24^FDPartType^FS" +
                                                                        "^FO224,448^A0R,32,40^FDPart#^FS" +
                                                                        "^FO232,568^A0R,24,24^FDAccessory^FS" +
                                                                        "^FO208,568^A0R,24,24^FDPartType^FS" +
                                                                        "^FO224,712^A0R,32,40^FDLine^FS" +
                                                                        "^FO80,712^A0R,25,25^FD" + Unloader1 + "^FS" +
                                                                        "^FO50,712^A0R,25,25^FD" + Unloader2 +"^FS" +
                                                                        "^FO128,40^A0R,24,32^FD" + bom2 + "^FS" +
                                                                        "^FO128,344^A0R,24,32^FD" + bomt2 + "^FS" +
                                                                        "^FO128,448^A0R,24,32^FD" + bom6 + "^FS" +
                                                                        "^FO128,568^A0R,24,32^FD" + bomt6 + "^FS" +
                                                                        "^FO168,448^A0R,24,32^FD" + bom5 + "^FS" +
                                                                        "^FO168,568^A0R,24,32^FD" + bomt5 + "^FS" +
                                                                        "^FO88,40^A0R,24,32^FD" + bom3 + "^FS" +
                                                                        "^FO88,344^A0R,24,32^FD" + bomt3 + "^FS" +
                                                                        "^FO88,568^A0R,24,32^FD" + bomt7 + "^FS" +
                                                                        "^FO88,448^A0R,24,32^FD" + bom7 + "^FS" +
                                                                        "^FO48,40^A0R,24,32^FD" + bom4 + "^FS" +
                                                                        "^FO48,344^A0R,24,32^FD" + bomt4 + "^FS" +
                                                                        "^FO48,448^A0R,24,32^FD" + bom8 + "^FS" +
                                                                        "^FO48,568^A0R,24,32^FD" + bomt8 + "^FS" +
                                                                        "^FO216,920^A0R,40,40^FDC^FS" +
                                                                        "^FO160,920^A0R,40,40^FDN^FS" +
                                                                        "^FO120,920^A0R,40,40^FDR^FS" +
                                                                        "^FO80,920^A0R,40,40^FDL^FS" +
                                                                        "^FO40,920^A0R,40,40^FDA^FS" +
                                                                        "^FO216,1000^A0R,40,40^FD" + C1 + "^FS" +
                                                                        "^FO160,1000^A0R,40,40^FD" + N2 + "^FS" +
                                                                        "^FO120,1000^A0R,40,40^FD" + R3 + "^FS" +
                                                                        "^FO80,1000^A0R,40,40^FD" + L4 + "^FS" +
                                                                        "^FO40,1000^A0R,40,40^FD" + A5 + "^FS^XZ";

                                                                        var partiallable = boxlabel + barBoxtype + barcode2;

                                                                        LODOP.SEND_PRINT_RAWDATA(partiallable);

                                                                    //var render = "css";
                                                                    //var btype = "code128";
                                                                    //var settings = {
                                                                    //    output: render,
                                                                    //    bgColor: "#FFFFFF",
                                                                    //    color: "#000000",
                                                                    //    barWidth: "1",
                                                                    //    barHeight: "50",
                                                                    //    moduleSize: "5",
                                                                    //    posX: "20",
                                                                    //    posY: "10",
                                                                    //    addQuietZone: true
                                                                    //};

                                                                    //$('#b07').html(username);
                                                                    //$('#b08').html(cdate);

                                                                    //$("#Bbid").html("").show().barcode(value, btype, settings);

                                                                    //更新界面，打印
                                                                    queryData();
                                                                    
                                                                    //$("#boxLabel").jqprint();
                                                                }
                                                            }
                                                            else {
                                                                alert("You are offline,please print again!");
                                                                return;
                                                            }
                                                        }

                                                        else {
                                                            alert("You are offline,please print again!");
                                                            return;
                                                        }
                                                    }
                                                });
                                            }
                                        }
                                    }
                                    else
                                    //半箱
                                    {
                                        //设置打印数量
                                        //提示信息显示半箱及单片的信息
                                        //输入值<= (订单数量-半箱+单片)
                                        var lqty;
                                        var wipqty = 0;
                                        var wipinfo = "";
                                        var tl = 0;

                                        //获取单片信息
                                        var inputs = document.getElementById("editable2").getElementsByTagName("input");

                                        for (var i = 0; i < inputs.length; i++) {
                                            var row = {};

                                            if (inputs[i].type == "checkbox") {
                                                if (inputs[i].checked && inputs[i].name == "cb1") {
                                                    var checkedRow = inputs[i];
                                                    var tr = checkedRow.parentNode.parentNode;
                                                    var tds = tr.cells;

                                                    
                                                    wipqty++;
                                                    wipinfo = wipinfo + jQuery.trim(tds[2].innerHTML) + "--" + jQuery.trim(tds[4].innerHTML) + "      ||   ";
                                                }
                                            }
                                        }
                                        //获取单片库位信息

                                        lqty = orderQty - pqty - wipqty;

                                        if (lqty >= 0) {

                                            if (lqty != 0) {
                                                var tall = prompt("Please input load quantity." + '\n' + "Order Quantity:" + orderQty
                                                    + '\n' + "PartialBox Quantity:" + pqty + '\n' + "Wip Quantity:" + wipqty + '\n' + "Valid Quantity Range:" + "(0~" + lqty + ")", lqty);
                                                
                                                if (tall != null)
                                                {
                                                    if (parseInt(tall) <= lqty && parseInt(tall) >= 0) {

                                                        tl = parseInt(tall) + parseInt(pqty) + parseInt(wipqty);

                                                        //获取产品属性
                                                        $.ajax({
                                                            type: "Post",
                                                            url: "Arg_BoxLabel.aspx/getPartInfos",
                                                            data: "{pncode:'" + partNO + "',pnum:'" + orderQty + "'}",
                                                            contentType: "application/json; charset=utf-8",
                                                            dataType: "json",
                                                            async: false,
                                                            success: function (data) {
                                                                if (data.d != "") {
                                                                    var json = data.d;
                                                                    var high = json.substr(4, json.indexOf("gasket") - 4);
                                                                    var gasket = json.substr(json.indexOf("gasket") + 6, json.indexOf("corner") - json.indexOf("gasket") - 6);
                                                                    var corner = json.substr(json.indexOf("corner") + 6, json.indexOf("base") - json.indexOf("corner") - 6);
                                                            
                                                                    $('#P11').html(corner);  //包角模式
                                                                    $('#P12').html(high);    //箱高
                                                                    $('#P13').html(gasket);  //垫片规格
                                                                }
                                                            }
                                                        });

                                                        //获取半箱箱牌
                                                        $.ajax({
                                                            type: "Post",
                                                            url: "Arg_BoxLabel.aspx/setPartialBoxLabel",
                                                            data: "{itemid:'" + itemid + "',orderqty:" + orderQty + ",finqty:" + tl+ "}",
                                                            contentType: "application/json; charset=utf-8",
                                                            dataType: "json",
                                                            async: false,
                                                            success: function (data) {
                                                                if (data.d != "") {
                                                                    var code = data.d.substr(4, data.d.indexOf("username") - 4);
                                                                    var username = data.d.substr(data.d.indexOf("username") + 8, data.d.indexOf("cdate") - data.d.indexOf("username") - 8);
                                                                    var cdate = data.d.substr(data.d.indexOf("cdate") + 5);
                                                                    if (code == "1")
                                                                    {
                                                                        //界面赋值
                                                                        $("#P1").html(invno + "-" + boxno);
                                                                        $("#P2").html(shipdate);
                                                                        $("#P3").html(boxtype);
                                                                        $("#P4").html(loc);
                                                                        $("#P5").html(partNO);
                                                                        $("#P6").html(orderQty);
                                                                        $("#P7").html(pqty);
                                                                        $("#P8").html(parseInt(tall) + parseInt(wipqty));
                                                                        $("#P9").html(username);
                                                                        $("#P10").html(cdate);

                                                                        var render = "css";
                                                                        var btype = "code128";
                                                                        var settings = {
                                                                            output: render,
                                                                            bgColor: "#FFFFFF",
                                                                            color: "#000000",
                                                                            barWidth: "1",
                                                                            barHeight: "50",
                                                                            moduleSize: "5",
                                                                            posX: "20",
                                                                            posY: "10",
                                                                            addQuietZone: true
                                                                        };

                                                                        $("#partb").html("").show().barcode(boxlabel, btype, settings);
                                                                        $('#detail').html(wipinfo);

                                                                        //更新界面
                                                                        queryData();
                                                                        //取消半箱
                                                                        //$("#_partialbox").jqprint();
                                                                    }
                                                                   
                                                                }
                                                            }
                                                        });
                                                    }
                                                    else
                                                    {
                                                        alert("Value not in the range!");
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            alert("Load quantity > OrderQty");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    alert("login error!");
                }
            }
        });

    }

    //重复打印
    function reprtLabel() {
        var roel;
        //获取当前用户角色
        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/getRoleInfos",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var role = data.d;
                    if (role != "ARGPackagingMag" && role != "Admin") {
                        alert("You don't have permission!");
                        return false;
                    }
                    else {

                        //查看前清空界面数据
                        $('#f01').html("");
                        $('#t01').html("");
                        $('#f02').html("");
                        $('#t02').html("");
                        $('#f03').html("");
                        $('#t03').html("");
                        $('#f04').html("");
                        $('#t04').html("");
                        $('#f05').html("");
                        $('#t05').html("");
                        $('#f06').html("");
                        $('#t06').html("");
                        $('#f07').html("");
                        $('#t07').html("");
                        $('#f08').html("");
                        $('#t08').html("");

                        $('#c01').html("");
                        $('#c02').html("");
                        $('#c03').html("");
                        $('#c04').html("");
                        $('#c05').html("");

                        var inputs = document.getElementById("editable").getElementsByTagName("input");

                        for (var i = 0; i < inputs.length; i++) {
                            var row = {};

                            if (inputs[i].type == "checkbox") {
                                if (inputs[i].checked && inputs[i].name == "cb1") {
                                    var checkedRow = inputs[i];
                                    var tr = checkedRow.parentNode.parentNode;
                                    var tds = tr.cells;

                                    var value = "";//条码号

                                    var invno = jQuery.trim(tds[12].innerHTML);
                                    var boxno = jQuery.trim(tds[13].innerHTML);
                                    var partNO = jQuery.trim(tds[2].innerHTML);
                                    var boxtype = jQuery.trim(tds[3].innerHTML);
                                    var labelid = jQuery.trim(tds[10].innerHTML);
                                    var itemid = jQuery.trim(tds[18].innerHTML);
                                    var shipdate = tds[7].innerHTML;
                                    var orderQty = tds[4].innerHTML;

                                    //基本信息
                                    $('#orderid').html(invno + "-" + boxno);
                                    $('#shipid').html(shipdate);
                                    $('#boxtypid').html(boxtype);
                                    $('#labelid').html(labelid);
                                    $('#partid').html(partNO);
                                    $('#b02').html(orderQty);

                                    //获取产品附件信息
                                    $.ajax({
                                        type: "Post",
                                        url: "Arg_BoxLabel.aspx/getPartAcc",
                                        data: "{pncode:'" + partNO + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: false,
                                        success: function (data) {
                                            if (data.d != "") {
                                                var json = $.parseJSON(data.d);
                                                $('#b03').html(json.length);

                                                for (i = 0; i < json.length; i++) {
                                                    if (i == 0) {
                                                        $('#f01').html(json[0].Component_Part);
                                                        $('#t01').html(json[0].Component_Type);
                                                    }
                                                    if (i == 1) {
                                                        $('#f02').html(json[1].Component_Part);
                                                        $('#t02').html(json[1].Component_Type);
                                                    }
                                                    if (i == 2) {
                                                        $('#f03').html(json[2].Component_Part);
                                                        $('#t03').html(json[2].Component_Type);
                                                    }
                                                    if (i == 3) {
                                                        $('#f04').html(json[3].Component_Part);
                                                        $('#t04').html(json[3].Component_Type);
                                                    }
                                                    if (i == 4) {
                                                        $('#f05').html(json[4].Component_Part);
                                                        $('#t05').html(json[4].Component_Type);
                                                    }
                                                    if (i == 5) {
                                                        $('#f06').html(json[5].Component_Part);
                                                        $('#t06').html(json[5].Component_Type);
                                                    }
                                                    if (i == 6) {
                                                        $('#f07').html(json[6].Component_Part);
                                                        $('#t07').html(json[6].Component_Type);
                                                    }
                                                    if (i == 7) {
                                                        $('#f08').html(json[7].Component_Part);
                                                        $('#t08').html(json[7].Component_Type);
                                                    }

                                                }
                                            }
                                        }
                                    });

                                    //获取产品属性
                                    $.ajax({
                                        type: "Post",
                                        url: "Arg_BoxLabel.aspx/getPartInfos",
                                        data: "{pncode:'" + partNO + "',pnum:'" + orderQty + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: false,
                                        success: function (data) {
                                            if (data.d != "") {
                                                var json = data.d;
                                                var high = json.substr(4, json.indexOf("gasket") - 4);
                                                var gasket = json.substr(json.indexOf("gasket") + 6, json.indexOf("corner") - json.indexOf("gasket") - 6);
                                                var corner = json.substr(json.indexOf("corner") + 6, json.indexOf("base") - json.indexOf("corner") - 6);
                                                var base = json.substr(json.indexOf("base") + 4);


                                                $('#b01').html(base);    //底座编码
                                                $('#b04').html(corner);  //包角模式
                                                $('#b05').html(high);    //箱高
                                                $('#b06').html(gasket);  //垫片规格
                                            }
                                            else {
                                                alert("error!");
                                            }

                                        }
                                    });

                                    //获取包边模式
                                    $.ajax({
                                        type: "Post",
                                        url: "Arg_BoxLabel.aspx/getPartEdge",
                                        data: "{pncode:'" + partNO + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: false,
                                        success: function (data) {
                                            if (data.d != "") {
                                                var json = $.parseJSON(data.d);
                                                for (i = 0; i < json.length; i++) {
                                                    //判断包边模式
                                                    if (json[i].EdgeType == "Antenna") {
                                                        $('#c02').html("N");
                                                    }
                                                    if (json[i].EdgeType == "Rain Sensor") {
                                                        $('#c03').html("R");
                                                    }
                                                    if (json[i].EdgeType == "Lace") {
                                                        $('#c04').html("L");
                                                    }
                                                    if (json[i].EdgeType == "3M Lace") {
                                                        $('#c05').html("A");
                                                    }
                                                }
                                            }
                                            else {
                                                $('#c01').html("C");
                                            }
                                        }
                                    });

                                    //获取条码号
                                    $.ajax({
                                        type: "Post",
                                        url: "Arg_BoxLabel.aspx/getBoxLabel",
                                        data: "{itemid:'" + itemid + "',invoiceno:'" + invno + "',pncode:'" + partNO + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: false,
                                        success: function (data) {
                                            if (data.d != "") {
                                                value = data.d.substr(4, data.d.indexOf("username") - 4);
                                                var username = data.d.substr(data.d.indexOf("username") + 8, data.d.indexOf("cdate") - data.d.indexOf("username") - 8);
                                                var cdate = data.d.substr(data.d.indexOf("cdate") + 5);

                                                if (value == "1") {
                                                    alert("Please create sales-order first");      //提示存在正式订单还未创建箱牌
                                                    return;
                                                }
                                                if (value == "2") {

                                                    alert("Existing earlier sales-order");         //提示存在3天前的订单还未创建箱牌
                                                    return;
                                                }
                                                if (value != "1" && value != "2") {

                                                    var render = "css";
                                                    var btype = "code128";
                                                    var settings = {
                                                        output: render,
                                                        bgColor: "#FFFFFF",
                                                        color: "#000000",
                                                        barWidth: "1",
                                                        barHeight: "50",
                                                        moduleSize: "5",
                                                        posX: "20",
                                                        posY: "10",
                                                        addQuietZone: true
                                                    };

                                                    $('#b07').html(username);
                                                    $('#b08').html(cdate);

                                                    $("#Bbid").html("").show().barcode(value, btype, settings);

                                                    //更新界面，打印
                                                    queryData();
                                                    $("#boxLabel").jqprint();
                                                }
                                            }

                                            else {
                                                alert("You are offline,please login again!");
                                                return;
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    }
                }
                else {
                    alert("login error,please login again!");
                }
            }
        });

    }


    //取消箱牌
    function cancelLabel() {

        var roel;
        //获取当前用户角色
        $.ajax({
            type: "Post",
            url: "Arg_BoxLabel.aspx/getRoleInfos",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var role = data.d;
                    if (role != "ARGPackagingMag" && role != "Admin" && role != "ARGBoxLabelPrinter") {
                        alert("You don't have permission!");
                        return;
                    }
                    else {
                        var inputs = document.getElementById("editable").getElementsByTagName("input");

                        for (var i = 0; i < inputs.length; i++) {
                            var row = {};

                            if (inputs[i].type == "checkbox") {
                                if (inputs[i].checked && inputs[i].name == "cb1") {
                                    var checkedRow = inputs[i];
                                    var tr = checkedRow.parentNode.parentNode;
                                    var tds = tr.cells;

                                    var itemid = jQuery.trim(tds[18].innerHTML);;

                                    //取消箱牌
                                    $.ajax({
                                        type: "Post",
                                        url: "Arg_BoxLabel.aspx/cancelBoxLabel",
                                        data: "{itemid:'" + itemid + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        async: false,
                                        success: function (data) {
                                            if (data.d != "") {
                                                if (data.d == "0")
                                                    alert("Succeed!");
                                                    queryData();
                                            }
                                        }
                                    });

                                }
                            }
                        }
                    }
                }
            }
        });
        
    }

</script>

</body>
</html>