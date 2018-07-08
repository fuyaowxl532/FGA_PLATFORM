<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fga_IR_rpt.aspx.cs" Inherits="FGA_PLATFORM.report.fga_IR_rpt" %>

<!DOCTYPE html> 

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>OEM_IR_rpt</title>
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
</head>
<body style="overflow: hidden;">
<input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
    <!-- Page container -->
<div class="page-container">
 
	<div class="row filter-wrapper visible-box" id="filter-box">
		<div class="col-lg-12">
			
			<form class="form-inline">
				<div class="form-group">
					<label class="form-label">SerialNO</label>
					<input class="form-control" id = "_serialno" type="text" placeholder="input" style="color: black; height:30px;width:60px;" />	
				</div>
				<div class="form-group">
					<label class="form-label">PartNO</label>
					<input class="form-control" id = "_partno" type="text" placeholder="input" style="color:black;height:30px;width:60px;"/>
				</div>
				<div class="form-group">
					<label class="form-label">Factory</label>
					<select id = "_factory" class="form-control" style='width:80px;height:30px'>
						<option value="All" >All</option>
						<option>F1</option>
						<option>F2</option>
						<option>F3</option>
                        <option>F4</option>
					</select>
				</div>
				<div class="form-group" >
					<label class="form-label" >KeyCenter</label>
					<select id = "Select" class="form-control" style='width:80px;height:30px'>
						<option value="All" >All</option>
						<option>China</option>
						<option>consigned代销</option>
                        <option>DB4</option>
						<option>DBX</option>
                        <option>EPBL</option>
						<option>EPBL assembly</option>
                        <option>EPBT1</option>
						<option>EPBT2</option>
                        <option>FBT</option>
						<option>Rack</option>
                        <option>GBF</option>
						<option>PU</option>
                        <option>PVC</option>
						<option>Semi-tempered</option>
					</select>
				</div>
				
				<div class="form-group"> 
					<label class="form-label" >CreatDate_From</label> 
					
					<div id="date-popup" class="input-group date"> 
					<input class="form-control"id = "_fdate" type="text" data-format="D, dd MM yyyy" style="width:60px;height:30px" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
                 </div>
                <div class="form-group"> 
                    <label class="form-label">CreatDate_To</label> 
					<div id="date-popup1" class="input-group date">
					<input class="form-control"id ="_tdate"  type="text" data-format="D, dd MM yyyy" style="width:60px;height:30px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
					</div>
				
               
				<div class="form-group" style="position:fixed;top:22px"  >
				  <input type="button" id ="btnSearch"  class="btn btn-primary btn-sm" name="search" style="background:white;color:#00b8ce" value="Search" onclick="SearchData()" />
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
			                            <th>SerialNO</th>          
                                        <th>PartNO</th>
                                        <th>Factory</th>   
                                        <th>KeyCenter</th>  
                                        <th>From_LOC</th>
                                        <th>To_LOC</th>
			                            <th>Quantity</th>
                                        <th>Creater</th>
			                            <th>CreateDate</th>
                                        <th>Type</th>
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

        //按钮事件
        $('#btnSearch').click(function () {
            $('#precord').val($('#hidPageSize').val()); 
            JSPager.currentIndex = 1;
            JSPager.pageSize = $('#hidPageSize').val();
            SearchData();
        });

    });

    //查询界面
    function SearchData() {

        $("#editable tr:not(:first)").remove();

        var pn    = $("#_partno").val();       //本厂编号
        var ft    = $("#_factory").val();      //工厂
        var kct   = $("#Select").val();        //关键工作中心
        var sn    = $("#_serialno").val();     //SerialNO
        var sts   = $("#Select2").val();       //状态
        var fdate = $("#_fdate").val();        //进仓日期F
        var tdate = $("#_tdate").val();        //进仓日期T

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
            url: "fga_IR_rpt.aspx/SearchData",
            data: "{serialno:'" + sn + "',status:'" + sts + "',partno:'" + pn + "',factory:'" + ft + "',keycenter:'" + kct + "',fdate:'" + fdate + "',tdate:'" + tdate + "'}",
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
                                    '<td> ' + json[i].SerialNO + '</td> ' +
                                    '<td> ' + json[i].PartNO + '</td> ' +
                                    '<td> ' + json[i].Organization + '</td> ' +
                                    '<td> ' + json[i].KeyCenter + '</td> ' +
                                    '<td> ' + json[i].Location + '</td> ' +
                                    '<td> ' + json[i].TLoc + '</td> ' +
                                    '<td> ' + json[i].Quantity + '</td> ' +
                                    '<td> ' + json[i].Creater + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' +
                                    '<td> ' + json[i].IRType + '</td> ' +
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
