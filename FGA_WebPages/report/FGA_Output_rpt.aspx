<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FGA_Output_rpt.aspx.cs" Inherits="FGA_PLATFORM.report.FGA_Output_rpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<meta http-equiv="refresh" content="20"> 
<title>Produce Report</title>
<!-- Site favicon -->
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<!-- /site favicon -->
<meta http-equiv="refresh" content="600"/>
<!-- Entypo font stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<!-- /entypo font stylesheet -->

<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->

<!-- /bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/plugins/chartist/chartist.min1.css" rel="stylesheet"/>
<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- /bootstrap stylesheet min version -->

<!-- Mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<!-- /mouldifi core stylesheet -->


</head>
<body>


<div class="page-container">

  <!-- Page Sidebar -->
 
  <!-- /page sidebar -->
  
  <!-- Main container -->
  <div class="main-container">
  
	
	
	
	<!-- Filter wrapper -->
	<div class="row filter-wrapper" id="filter-box">
			
	<div  class="col-lg-4">
	<script>
		    function CurentTime() {
		        var now = new Date();
		        var hh = now.getHours();
		        var mm = now.getMinutes();
		        var ss = now.getTime() % 60000;
		        ss = (ss - (ss % 1000)) / 1000;
		        var clock = hh + ':'; if (mm < 10) clock += '0'; clock += mm + ':'; if (ss < 10) clock += '0'; clock += ss; return (clock);
		    }
		    function refreshCalendarClock() { document.all.calendarClock4.innerHTML = CurentTime(); }
		    document.write('<font id="calendarClock4" style="color:white; font-size:80px; Line-Height=100%"></font>');
		    setInterval('refreshCalendarClock()', 1000);
	</script>		
				
	</div>
			<font id="shift" style="font-size: 72px"></font>
  				<div class="col-lg-8" >
  				<script>

  				    if (new Date().getHours() < 15 && new Date().getHours() >= 7) {
  				        document.getElementById("shift").innerHTML = "1st Shift"
  				    }
  				    if (new Date().getHours() >= 15 && new Date().getHours() < 23) {
  				        document.getElementById("shift").innerHTML = "2nd Shift"
  				    }

  				    if (new Date().getHours() < 7 || new Date().getHours() >= 23) {
  				        document.getElementById("shift").innerHTML = "3rd Shift"
  				    }

  					</script>
  					
  				</div>

		
		
	</div>
	<!-- /filter wrapper -->
	
	<!-- Main content -->
    <div class="main-content">
	
		
			<div class="col-md-12">
			
				<!-- Card grid view -->
				<div class="cards-container box-view grid-view">
					<div class="row">						
						<div class="col-lg-3 col-sm-6 ">
						
							<!-- Card -->
							<div class="card">
							
								<!-- Card header -->
								<div class="card-header">
									
									<div >
										
										
										<select id = "s1" style="width:100%; font-size: 45px; color:#00b8ce; border:0px;">
											
											<option >F260_BL3A</option>
											<option >F260_BL3B</option>
											<option >F260_BL3C</option>
											<option >F260(Bracket1)</option>
											<option >F260(Bracket1A)</option>
											<option >F260(Bracket3)</option>
											<option >F260(Bracket3A)</option>
											<option >F260(Bracket7)</option>
											<option >F260(Bracket7A)</option>
											<option selected>NULL</option>
										</select>
									</div>
								</div>
								<!-- /card header -->
								
								<!-- Card content -->
								<div id = "p1" >
                                     <h1 style="text-align:center; color:black;font-weight: 700;">NULL</h1>
								</div>
								<!-- /card content -->
						<!-- panel body --> 
						
								<div class="canvas-chart" >
									<canvas id="barChart" height="200"></canvas>
								</div>	
							</div>
						</div>
						<div class="col-lg-3 col-sm-6 ">
						<div class="card">
							
								<!-- Card header -->
								<div class="card-header">
									
									<div >
										<select id = "s2" style="width:100%; font-size: 45px; color:#00b8ce; border:0px;">
											<option >F260_BL3B</option>
											<option >F260_BL3A</option>
											
											<option >F260_BL3C</option>
											<option >F260(Bracket1)</option>
											<option >F260(Bracket1A)</option>
											<option >F260(Bracket3)</option>
											<option >F260(Bracket3A)</option>
											<option >F260(Bracket7)</option>
											<option >F260(Bracket7A)</option>
											<option selected>NULL</option>
										</select>
									</div>
								</div>
								<!-- /card header -->
								
								<!-- Card content -->
								<div  id = "p2">
                                     <h1 style="text-align:center; color:black;font-weight: 700;">NULL</h1>
								</div>
								<!-- /card content -->
						<!-- panel body --> 
						
								<div class="canvas-chart" >
									<canvas id="barChart1" height="200"></canvas>
								</div>	
							</div>
							
							
						</div>

						<div class="col-lg-3 col-sm-6 ">
							<div class="card">
							
								<!-- Card header -->
								<div class="card-header">
									
									<div >
										
										
										<select id="s3" style="width:100%; font-size: 45px; color:#00b8ce; border:0px;">
											<option >F260_BL3C</option>
											<option >F260_BL3A</option>
											<option >F260_BL3B</option>
											<option >F260(Bracket1)</option>
											<option >F260(Bracket1A)</option>
											<option >F260(Bracket3)</option>
											<option >F260(Bracket3A)</option>
											<option >F260(Bracket7)</option>
											<option >F260(Bracket7A)</option>
											<option selected>NULL</option>
										</select>
									</div>
								</div>
								<!-- /card header -->
								
								<!-- Card content -->
								<div id = "p3">
                                    <h1 style="text-align:center; color:black;font-weight: 700;">NULL</h1>
								</div>
								<!-- /card content -->
						<!-- panel body --> 
						
								<div class="canvas-chart" >
									<canvas id="barChart2" height="200"></canvas>
								</div>	
							</div>
							
						</div>
						
						<div class="col-lg-3 col-sm-6 ">
							<div class="card">
							
								<!-- Card header -->
								<div class="card-header">
									
									<div >
										
										<font style=" font-size: 45px; color:#00b8ce">Total</font>
									</div>
								</div>
								<!-- /card header -->
								
								<!-- Card content -->
								<div id="tp">

								</div>
								<!-- /card content -->
						<!-- panel body --> 
						
								<div class="canvas-chart" >
									<canvas id="barChartTotal" height="200"></canvas>
								</div>	
							</div>
							
						</div>
					
				</div>
				<!-- /card grid view -->
				
			</div>
		</div>	
		
		<div>
		<div class="col-lg-6 col-sm-6 ">
			<div class="panel panel-default">
					<div class="panel-heading clearfix"> 
							
								<!-- Card header -->
								<div class="panel-title" style="font-size: 35px; color:#00b8ce;">Weekly Total</div> 
								<!-- /card header -->
					</div>		
								
						<!-- panel body --> 				
								<div class="panel-body"   > 
									<div id="ct-chart4"  style="height:200px; "></div>
								</div> 	
			</div>
		</div>
		</div>
	 
	  	<div class="col-lg-6 col-sm-6 ">
					<div class="panel panel-default">
						<div class="panel-heading clearfix"> 
							<div class="panel-title" style="font-size: 35px; color:#00b8ce;">Work Logs</div> 
							<ul class="panel-tool-options"> 
								<li><a data-rel="collapse" href="#"><i class="icon-down-open"></i></a></li>
								<li><a data-rel="reload" href="#"><i class="icon-arrows-ccw"></i></a></li>
							</ul>  
						</div> 
						<!-- panel body --> 
						<div class="panel-body"> 
						<textarea  style="width:100%; height:195px; font-size: 30px; color:#000000; border:0px;" type="text" size="20" style="background-color:#FFFFFF"
        					onfocus="style.backgroundColor='#3b8bba'"
        					onblur="style.backgroundColor='#FFFFFF'">Please input records here....</textarea>
						</div> 
					</div> 
		</div>
		</div>		
	  <!-- /main content -->
	  
  </div>
  <!-- /main container -->
  
</div>
<!-- /page container -->


<!--Load JQuery-->
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/bootstrap.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/metismenu/jquery.metisMenu.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery-ui.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery.blockUI.js"></script>
<script src="../../mouldifi-v-2.0/js/functions.js"></script>
<!--ChartJs-->
<script src="../../mouldifi-v-2.0/js/plugins/chartjs/Chart.min.js"></script>
<!--Chartlist Charts-->
<script src="../../mouldifi-v-2.0/js/plugins/chartist/chartist.min.js"></script>

<script type="text/javascript">
    
    //全局变量传入产量参数
    var twk1    = "0";
    var twk2    = "0";
    var twk3    = "0";
    var twtotal = "0";
    var wk1     = "0";
    var wk2     = "0";
    var wk3     = "0";
    var wtotal  = "0";
    var st1     = "0";
    var st2     = "0";
    var st3     = "0";

    //加载页面
    $(function () {

        //获取当前用户可访问的workcenter
        $.ajax({
            type: "Post",
            url: "FGA_Output_rpt.aspx/getWorkCenter",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);

                    for (var i = 0; i < json.length; i++) {
                        if (i == 0)
                        {
                            $('#s1').val(json[i].WORKCENTER);
                            twk1 = 400;
                            wk1 = json[i].QUANTITY;
                            $('#p1').html('<h1 style="text-align:center; color:black;font-weight: 700;">' + wk1 + '</h1>');
                        }
                        if (i == 1)
                        {
                            $('#s2').val(json[i].WORKCENTER);
                            twk2 = 400;
                            wk2 = json[i].QUANTITY;
                            $('#p2').html('<h1 style="text-align:center; color:black;font-weight: 700;">' + wk2 + '</h1>');
                        }
                        if (i == 2)
                        {
                            $('#s3').val(json[i].WORKCENTER);
                            twk3 = 400;
                            wk3 = json[i].QUANTITY;
                            $('#p3').html('<h1 style="text-align:center; color:black;font-weight: 700;">' + wk3 + '</h1>');
                        }
                    }

                    //总产量
                    wtotal = parseInt(wk1) + parseInt(wk2) + parseInt(wk3);
                    twtotal = parseInt(twk1) + parseInt(twk2) + parseInt(twk3);
                    $('#tp').html('<h1 style="text-align:center; color:black;font-weight: 700;">' + wtotal + '</h1>');
                }
            }
        });

        //获取当前workcenter对应的周产量
        $.ajax({
            type: "Post",
            url: "FGA_Output_rpt.aspx/getWeekData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);

                    for (var i = 0; i < json.length; i++) {
                        if (i == 0)
                            st1 = json[i].QUANTITY;
                        if (i == 1)
                            st2 = json[i].QUANTITY;
                        if (i == 2)
                            st3 = json[i].QUANTITY;
                    }
                }
            }
        });

    });

</script>
<script src="../../mouldifi-v-2.0/js/plugins/chartjs/chartjs-script1.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/chartist/chartist-script1.js"></script>
</body>
</html>