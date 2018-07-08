<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FGA_BomMaterialARG_rpt.aspx.cs" Inherits="FGA_PLATFORM.report.FGA_BomMaterialARG_rpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>ARGBomMaterial</title>
<!-- Site favicon -->
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<!-- /site favicon -->

<!-- Entypo font stylesheet -->
<link href="../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<!-- /entypo font stylesheet -->

<!-- Font awesome stylesheet -->
<link href="../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->

<!-- Bootstrap stylesheet min version -->
<link href="../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- /bootstrap stylesheet min version -->     

<!-- Mouldifi core stylesheet -->
<link href="../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<!-- /mouldifi core stylesheet -->
<link href="../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
th
  {
  background-color:black;
  color:white;
  }
</style>

</head>
<body style="overflow: hidden;">
    <!-- Page container -->
<div class="page-container">
 
	<div class="row filter-wrapper visible-box" id="filter-box">
		<div class="col-lg-12">
			
			<form class="form-inline">
				<div class="form-group">
					<label class="form-label">OrderNO</label>
					<input class="form-control" id = "_orderno" type="text" placeholder="input" style="color: black; height:30px;width:150px;" />	
				</div>
				<div class="form-group">
					<label class="form-label">PartNO</label>
					<input class="form-control" id = "_partno" type="text" placeholder="input" style="color:black;height:30px;width:150px;"/>
				</div>
				<div class="form-group">
					<label class="form-label">MaterialNO</label>
					<input class="form-control" id = "_materialno" type="text" placeholder="input" style="color:black;height:30px;width:150px;"/>
				</div>

				<div class="form-group" style="position:fixed;top:22px"  >
				  <input type="button" class="btn btn-primary btn-sm" name="search" style="background:white;color:#00b8ce" value="Search" onclick="SearchData()" />
                </div>

                <div class="form-group" style="position:fixed;top:55px" >
                  <input type="button" class="btn btn-primary btn-sm" name="export" style="background:white;color:#00b8ce" value="Export" onclick="$('#editable').tableExport({ type: 'excel', tableName: 'OEM_IR', escape: 'false' })" />
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
                                        <th>No</th>
			                            <th>OrderNO</th>          
                                        <th>PartNO</th>
                                        <th>ShipmentDate</th>
                                        <th>Quantity</th>   
                                        <th>Component_Part</th>  
                                        <th>MateialQty</th>  
                                        <th>Unit</th>
										</tr>
									</thead>
									<tbody id ="tby">

									</tbody>
								</table>
							</div>
						</div>				
		</div>
	 
 


<!-- Input Mask-->
<script src="../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

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

    //查询界面
    function SearchData() {

        $("#editable tr:not(:first)").remove();
       
        var sn = $("#_orderno").val();      //订单号
        var pn = $("#_partno").val();       //本厂编号
        var sts   = $("#_materialno").val();   //物料编号

        $.ajax({
            type: "Post",
            url: "FGA_BomMaterialARG_rpt.aspx/SearchData",
            data: "{orderno:'" + sn + "',itemcode:'" + pn + "',material:'" + sts + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr>' +
                            '<td> ' + (i + 1) + '</td> ' +
                            '<td> ' + json[i].BatchNO + '</td> ' +
                            '<td> ' + json[i].PartNO + '</td> ' +
                            '<td> ' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                            '<td> ' + json[i].Quantity + '</td> ' +
                            '<td> ' + json[i].OperationCode + '</td> ' +
                            '<td> ' + json[i].MaterialQty + '</td> ' +
                            '<td> ' + json[i].ContainerType + '</td> '
                        '</tr>';
                    }
                    $("#tby").html(slct);
                }
            }
        });
    }
</script>
</body>
</html>
