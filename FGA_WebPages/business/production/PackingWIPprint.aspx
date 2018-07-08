<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackingWIPprint.aspx.cs" Inherits="FGA_PLATFORM.business.production.PackingWIPprint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>PackingWIPPrint</title>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>

<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
</object> 

</head>
<body>
<div class="main-container" >
  <div class="col-md-12 " style=" width:1200px; margin-top:15px"> 
    
   
    <div class=" table-responsive col-md-9" >
					<table class="table-striped table-bordered table-hover" id ="editable" style="overflow-y:auto;width:850px;height:30px">
						<thead >
							<tr>
                                
								<th>PartNO</th>
								<th>Quantity</th>
								<th>Creater</th>
								<th>CreateDate</th>
							</tr>
						</thead>
                        
						<tbody id ="tby" >
							
						</tbody>
					</table>
   </div>
     <button class="btn btn-primary btn-sm btn-add col-md-1" onclick="queryData()">Print</button>  
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

        //测试箱牌
        function queryData() {

            var LODOP;
            LODOP = getLodop();
            LODOP.SET_PRINTER_INDEX(-1);
            var orderNum  = 'aa';
            var BoxMethod = 'aa';
            var BoxType   = 'aa';
            var shipdate  = 'aa';
            var OrderQty  = 'aa';

            var TL = "^XA^FO5,5^GB780,1170,3^FS" + //方框
                "^FO195,5^GB0,1170,3^FS" +        //横线
                "^FO395,5^GB0,1170,3^FS" +        //横线
                "^FO595,5^GB0,1170,3^FS" +        //横线
                "^FO95,470^A0B,50,50^FDDelivery Batch^FS" +        //固定文本(Delivey Batch)
                "^FO292,900^A0B,45,45^FDHonda Lot:^FS" +           //固定文本(Honda Lot)
                "^FO420,1070^A0B,20,20^FDBatch#(T)^FS" +           //固定文本(Batch#(T))
                "^FO625,1039^A0B,20,20^FDLot#SPLR(1T)^FS" +        //固定文本(lOT#splr(1T))
                "^FO292,150^A0B,40,40^FD" + orderNum + "^FS" +         //LOT NO
                "^FO420,745^A0B,40,40^FD" +BoxMethod+ "^FS" +        //BATCH NO
                "^FO625,700^A0B,40,40^FD" +BoxType+ "^FS" +                                       //DA NO
                "^FO495,688^BCB,85,N,N,N^FDT" +shipdate+ "^FS" +    //BATCH BARCODE
                "^FO675,650^BCB,85,N,N,N^FD1T" +OrderQty+ "^FS" +                                  //DA BARCODE
                "^XZ";


             //LODOP.SEND_PRINT_RAWDATA(TL);
             //<iframe id="reportFrame" src="http://localhost:8080/FGAReport/ReportServer?reportlet=e.cpt&op=write&__bypagesize__=false" width = "100%" height = "100%"></iframe>
        }

    </script>

  
</body>
</html>
