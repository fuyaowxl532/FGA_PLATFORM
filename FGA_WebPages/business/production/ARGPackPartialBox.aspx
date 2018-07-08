<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARGPackPartialBox.aspx.cs" Inherits="FGA_PLATFORM.business.production.ARGPackPartialBox" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>ArgPackPartialBox</title>

<!-- Site favicon -->
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
</head>
<body>
    <div >
		<div class="main-container" >

			

			<div class="col-md-3  "  style="position:absolute;width:320px; margin-left:-15px; ">

				<div class=" filter-wrapper" style="height:100px; width:320px; position:fixed" > 

						<div>
							<label >BarcodeNO</label>
							<input type="text" id = "barcode" placeholder="input" style="color: black; height:30px;width:100px;" onkeydown="return AddBarcodeNO(event)"/>	

							<button class="btn btn-primary  btn-add" onclick="SaveData()" style="background-color: white;color: #00b8ce; height:30px; width:70px;margin-left: 25px;">InBound</button>
						</div>

						<div class="form-group">
							<label style="margin-top: 15px" >Location</label>

							<select id ="sloc" style="color: black; height:30px;width:100px; margin-bottom: 5px; margin-left:13px" >
							</select>

							<button class="btn  btn-default btn-sm btn-add" style="background-color: white;color: #00b8ce; height:30px; width:70px;margin-left: 25px;position: relative; margin-bottom: 5px" onclick ="FinishData()">Finish</button>
						</div>
					
				<div class="form-inline">
					<textarea readonly id = "Barcode_Infos" style="background-color:black; margin-left: -10px; width: 320px;height: 600px"></textarea>
				</div>
				</div>
				
			</div>

			<div class="col-md-10  " style="margin-left:330px; width:900px; ">
				<div class="panel-body filter-wrapper" style="height:95px;position:fixed;width: 850px"> 
					<form class="form-inline" >
						<div class="form-group">
							<label class="form-label">BarcodeNO</label>
							<input type="text" id="_ibn"  placeholder="input"  style="color: black; height:30px;width:80px; "/>	
						</div>
						<div class="form-group" >
							<label class="form-label"style="margin-left:-30px">PartNO</label>
							<input type="text" id="_ipn" placeholder="input"  style="color: black; height:30px;width:80px;margin-left:-25px"/>	
						</div>	
						<div class="form-group">
							<label class="form-label"style="margin-left:-30px">Location</label>
							<input type="text" id="_iloc" placeholder="input"  style="color: black; height:30px;width:80px;margin-left:-25px"/>
						</div>	
						<div class="form-group">
							<label class="form-label"style="margin-left:-30px">Date(from)</label> 
							<div id="date-popup" class="input-group date"> 
								<input type="text" id="_fdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:80px;margin-left:-30px"/>
								<span class="input-group-addon"><i class="fa fa-calendar" ></i></span> 
							</div>
						</div>
						<div class="form-group">	
							<label class="form-label"style="margin-left:-30px">Date(to)</label> 
							<div id="date-popup1" class="input-group date">
								<input type="text" id="_tdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:80px;margin-left:-30px"/> 
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
							</div>
						</div>
                        <div class="form-group">
					        <label class="form-label"style="margin-left:-30px">Status</label>
					        <select id = "" style="color: black;width:90px;height:30px;margin-left:-30px">
						        <option value="All" >All</option>
						        <option>Release</option>
						        <option>In process</option>
						        <option>Closed</option>
					        </select>
				        </div>
						<div class="form-group" style="margin-left:675px; margin-top:-105px">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px" onclick="queryData()" name="query" value="Query"   />
                        </div>	
                        <div class="form-group"style=" margin-left:675px; margin-top:-85px">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce" onclick="$('#editable').tableExport({ type: 'excel', tableName: 'ARG_PartialBox', escape: 'false' })" name="export" value="Export" />
						</div>
                         <div class="form-group"style="margin-left:750px;margin-top:-180px ">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce" onclick="delData()" name="del" value="Delete" />
						</div>
                        <!-- 还没设置的按钮 -->
                        <div class="form-group"style="position:relative; margin-left:750px;margin-top:-157px ">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce" onclick="" name="del" value="selAll" />
						</div>
						
					</form>
				</div>
				<div class=" table-responsive" >
					<table class="table table-striped table-bordered table-hover" id ="editable" style="overflow-y:auto;margin-top:100px; width:850px;">
						<thead >
							<tr>
                                <th>*</th>
								<th>No</th>
								<th>BarcodeNO</th>
								<th>PartNO</th>
                                <th>BoxType</th>
                                <th>Location</th>
                                <th>BoxStatus</th>
								<th>OrderQty</th>
                                <th>Quantity</th>
                                <th>Div</th>
								<th>Creater</th>
								<th>CreateDate</th>
							</tr>
						</thead>
                        
						<tbody id ="tby" >
							
						</tbody>
					</table>
				</div>
			</div>		

			<!-- /filter wrapper -->
		</div>
		<!-- Main content -->

	</div>
	<!-- /page container -->

    <!-- Input Mask-->
    <script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <!-- Select2-->
    <script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
    <!--Bootstrap ColorPicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!--Bootstrap DatePicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
	<script type="text/javascript">

	    //定义全局data
	    var bpNO = "0";
	    var wipinfo  = [];

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
            
            //初始化location
            var loc = '<option value="All" >NULL</option>';

            for (var j = 0; j < 9; j++) {
                loc = loc + '<option>' + "A" + (j + 1) + '</option>';
            }
            for (var j = 0; j < 10; j++) {
                loc = loc + '<option>' + "B" + (j + 1) + '</option>';
            }
            for (var j = 0; j < 16; j++) {
                loc = loc + '<option>' + "C" + (j + 1) + '</option>';
            }
            for (var j = 0; j < 17; j++) {
                loc = loc + '<option>' + "D" + j + '</option>';
            }
            for (var j = 0; j < 21; j++) {
                loc = loc + '<option>' + "E" + (j + 1) + '</option>';
            }
            for (var j = 0; j < 3; j++) {
                loc = loc + '<option>' + "Y" + (j + 1) + '</option>';
            }

	        $('#sloc').html(loc);

	    });

        //扫描单片标签
	    function AddBarcodeNO(e)
	    {
	        var key = e.which;

	        if (key == 13) {
	            var bp = $('#barcode').val();
	            var bi = $('#Barcode_Infos').val();
	            //按照条码号获取单片Part信息
	            if (bpNO.indexOf(bp) <= 0) {
	                $.ajax({
	                    type: "Post",
	                    url: "ARGPackPartialBox.aspx/getBarcodeInfo",
	                    data: "{data:'" + bp + "'}",
	                    contentType: "application/json; charset=utf-8",
	                    dataType: "json",
	                    async: false,
	                    success: function (data) {
	                        if (data.d != "") {
	                            var row = {};
	                            var bis = bp + "   " + data.d + "      Added" + '\n' + bi;

	                            row.BarcodeNO = bp;
	                            row.PartNO = data.d;

	                            wipinfo.push(row);
	                            bpNO = bpNO + "." + bp

	                            $('#Barcode_Infos').html(bis);
	                        }
	                        else {
	                            alert("Barcode is Wrong!");
	                        }
	                    }
	                });
	            }
	            else {
	                alert("Barcode is repeat!");
	            }
	            
	            $('#barcode').focus();
	            $('#barcode').val("");
	        }
	       
	    }

	    //查询 
	    //add by it-wxl 05/04/2017
	    function queryData() {
	        $("#editable tr:not(:first)").remove();

	        var _bn    = $("#_ibn").val();        //条码号
	        var _pn    = $("#_ipn").val();        //本厂编号
	        var _loc   = $("#_iloc").val();       //库位
	        var _fdate = $("#_fdtxt").val();      //交付日期F
	        var _tdate = $("#_tdtxt").val();      //交付日期T

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
	            url: "ARGPackPartialBox.aspx/SearchData",
	            data: "{bncode:'" + _bn + "',pncode:'" + _pn + "',location:'" + _loc + "',fdate:'" + _fdate + "',tdate:'" + _tdate + "'}",
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            async: true,
	            success: function (data) {
	                if (data.d != "") {
	                    var json = $.parseJSON(data.d);
	                    var slct = "";
                        for (var i = 0; i < json.length; i++) {

	                        slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>'+
                                           '<td> ' + (i + 1) + '</td> ' +
                                           '<td> ' +json[i].BarcodeNO+ '</td> ' +
                                           '<td> ' + json[i].PartNO + '</td> ' +
                                           '<td> ' + json[i].BoxType + '</td> ' +
                                           '<td> ' + json[i].Location + '</td> ' +
                                           '<td> ' + json[i].BoxStatus + '</td> ' +
                                           '<td> ' + json[i].OrderQty + '</td> ' +
                                           '<td> ' + json[i].Quantity + '</td> ' +
                                           '<td> ' + (json[i].OrderQty - json[i].Quantity) + '</td> ' +
                                           '<td> ' +json[i].Creator+ '</td> ' +
                                           '<td>' + new Date(parseInt(json[i].Createtime)).toLocaleString() + '</td> ' +
                                          '</tr>';
	                    }
	                    $("#tby").html(slct);
	                }
	            }
	        });
	    }

	    //删除界面数据 add by it-wxl 20/06/2017
	    function delData() {
	        var data = [];
	        var inputs = document.getElementById("editable").getElementsByTagName("input");

	        for (var i = 0; i < inputs.length; i++) {
	            var row = {};

	            if (inputs[i].type == "checkbox") {
	                if (inputs[i].checked && inputs[i].name == "cb1") {
	                    var checkedRow = inputs[i];
	                    var tr = checkedRow.parentNode.parentNode;
	                    var tds = tr.cells;
	                    //循环列
	                    row.BarcodeNo = tds[2].innerHTML;
	                    data.push(row);
	                }
	            }
	        }

	        var jsondata = JSON.stringify(data);
	        $.ajax({
	            type: "post",
	            url: "ARGPackPartialBox.aspx/deleteData",
	            data: "{data:'" + jsondata + "'}",
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            async: true,
	            success: function (data) {
	                if (data.d == "1") {
	                    alert("success");
	                    //release成功后刷新界面
	                    queryData();
	                }
	                else
	                    alert("fail");
	            }
	        });
	    }

	    //单片入库 
	    //add by it-wxl 05/01/2017
	    function SaveData() {
	        var sl = $('#sloc').val();
            if (sl != "All") {
                var tall = prompt("Please input load quantity:");
                if (tall !=null)
                {
                    var jsondata = JSON.stringify(wipinfo);

                    $.ajax({
                        type: "post",
                        url: "ARGPackPartialBox.aspx/SaveScanRecord",
                        data: "{data:'" + jsondata + "',location:'" + sl + "',fqty:'" + tall+"'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == "1") {
                                alert("success!");
                                //清空界面数据
                                $('#Barcode_Infos').html("");
                                wipinfo = [];
                            }
                        }
                    });
                }
	        }
	        else {
	            alert("Please select a location!");
	        }
	    }

	    //单片出库 
	    //add by it-wxl 05/08/2017
	    function FinishData() {

            var r = confirm("Are you sure send?");
            if (r == true)
            {
                var jsondata = JSON.stringify(wipinfo);
                $.ajax({
                    type: "post",
                    url: "ARGPackPartialBox.aspx/outOfArea",
                    data: "{data:'" + jsondata + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("success!");
                            //清空界面数据
                            $('#Barcode_Infos').html("");
                            wipinfo = [];
                        }
                    }
                });
            } 
	    }


	</script>
</body>
</html>
