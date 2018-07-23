<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OEM_OrderTracking.aspx.cs" Inherits="FGA_PLATFORM.business.production.OEM_OrderTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>OEM_Order Tracking System</title>

<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->
<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
<link href="../../css/style.css" rel="stylesheet" />
<!--弹消息窗样式-->
<link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<!-- jquery脚本库-->
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<!--验证-->
<script src="../../javascript/ValidationCheck.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
.file {
    position: relative;
    display: inline-block;
    background:#00BACE ;
    border: 1px solid #00BACE;
    border-radius: 2px;
    height:25px;
    padding: 4px 12px;
    overflow: hidden;
    color: #00b8ce;
    text-decoration: none;
    text-indent: 0;
    line-height: 18px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
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
.time { display:inline-block; font-size:26px; text-align:center; width:86px; height:30px;}

</style>
</head>
<body style="overflow:hidden">
<input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
<div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> OEM_ORDER=> OEM_OrderTracking</div>
<!-- Page container #00BACE -->
<div>   
	<div class="header-secondary " style="margin-top:-20px; margin-left:-10px;">
				<button class="btn btn-primary btn-sm" id ="btnSearch"  onclick ="SearchData()">Search</button>
                <!--<button class="btn btn-primary btn-sm" id ="btnSave"    onclick ="EditData()">Save</button>
				    <button class="btn btn-primary btn-sm">Delete</button>
                -->
                <button class="btn btn-primary btn-sm" id= "del" onclick="DeleteData()">Delete</button>
                <a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:9px">IMPORT
                        <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
				<button class="btn btn-primary btn-sm"  onclick="$('#editable').tableExport({ type: 'excel', tableName: 'OEM_Order', escape: 'false' })">EXPORT</button>
	</div>
	<!-- /secondary header -->
	<!-- Filter wrapper -->
	<div class="filter-wrapper" style="height: 75px; width:100%; margin-top:-5px;margin-bottom:5px;margin-right:30px;" id="filter-box">
		
			<div class="form-inline" style="margin-top: -10px">
				<div class="form-group">
					<label class="form-label">OrderNO</label>
					<input type="text" id = "_orderno" placeholder="input" style="color: black; height:30px;width:100px"/>	
				</div>
                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">OrderType</label>
					<select class="select2" id ="ordertype" style="width:150px">
						<option value="All">All</option>
						<option>Mass production</option>
				        <option>Sample</option>
				        <option>Service part</option>
					</select>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">PartNO</label>
					<input type="text" id = "_partno" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Customer</label>
					<input type="text"  id ="_cst" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Factory</label>
					<select class="select2" id= "factory" style="width:80px">
						<option value="All">All</option>
						<option>F1</option>
						<option>F2</option>
                        <option>F3</option>
					</select>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">OrderStatus</label>
					<select class="select2" id ="qselect" style="width:150px">
						<option value="All">All</option>
						<option>OrderGeneration</option>
				        <option>OrderRegister</option>
				        <option>OrderConfirm</option>
				        <option>OrderRelease</option>
                        <option>OrderClose</option>
                        <option>OrderCancel</option>
					</select>
				</div>
				<div class="form-group"style="margin-left:-35px;"> 
					<label class="form-label">ShipmentDate(from)</label> 
					
					<div id="date-popup" class="input-group date"> 
					<input type="text" id = "_fdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
                    </div>
                <div class="form-group"style="margin-left:-35px;"> 
                    <label class="form-label">ShipmentDate(to)</label> 
					
					<div id="date-popup1" class="input-group date"> 
					<input type="text" id ="_tdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
					 
				</div>

                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Creator</label>
					<select class="select2" id ="pcreator" style="width:130px" onchange="SearchData()">
                          <option value="All">All</option>
						  <option value="fy.amiller">fy.amiller</option>
				          <option value="fy.hoh">fy.hoh</option>
				          <option value="fy.kdierker">fy.kdierker</option>
				          <option value="fy.nsmith2">fy.nsmith2</option>
                          <option value="fy.tli">fy.tli</option>
                          <option value="fy.xtang">fy.xtang</option>
					</select>
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
	
	<div class=" form-inline" >
		<div>
		    <input type="button" id ="selAll" value = "Select All" class=" btn btn-primary btn-sm btn-add" style="width:100px;height:30px" onclick="onSelected()" />
            <button class=" btn btn-primary btn-sm btn-add" id = "uptshippingdate" style="width:140px;height:30px" onclick="onAction('Pshippingdate')" >Upt_ShippingDate</button>
            <div id="date-popup2" class="input-group date"> 
			    <input type="text" id= "shppingdate" data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
			    <span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
		    </div>
            <input class="time" id = "ptime" value="12:00" type="text" onchange="console.log('Time changed')" />
		    <button class="btn btn-primary btn-sm btn-add" id = "uorderqty" style="width:130px;height:30px" onclick="onAction('Porderqty')">Upt_OrderQTY</button>
		    <input type="text" id= "_orderqty" style="width:130px;height:30px"/>	
		    <button class="btn btn-primary btn-sm btn-add" id = "ustatus" style="height:30px" onclick="onAction('Pstatus')">Upt_OrderStatus</button>
		    <select class="select2 "  id ="pselect"  style="width:160px;height:30px">
                <option>OrderGeneration</option>
				<option>OrderRegister</option>
				<option>OrderConfirm</option>
				<option>OrderRelease</option>
                <option>OrderClose</option>
                <option>OrderCancel</option>
		    </select>
        </div>

	</div>
    
</div>
    
<!-- /table -->
<div class='table-cont' id='table-cont' style="width:100%;margin-left: 0px;float:left;" >
    <table class="table  table-bordered table-hover dataTables-example" id ="editable">
	    <thead>
		    <tr>
                <th style ="background-color:black;color:white;text-align:left">*</th>
                <th style ="background-color:black;color:white;text-align:left"></th>
			    <th style ="background-color:black;color:white;text-align:left">OrderNo</th>
                <!--<th style ="background-color:black;color:white;text-align:left">OrderType</th>-->
			    <th style ="background-color:black;color:white;text-align:left">PartNo</th>
			    <th style ="background-color:black;color:white;text-align:left">OrderQty</th>
                <th style ="background-color:black;color:white;text-align:left">BoxNum</th>
                <th style ="background-color:black;color:white;text-align:left">InBoundQty</th>
                <th style ="background-color:black;color:white;text-align:left">UnInBoundQty</th>
                <th style ="background-color:black;color:white;text-align:left">UnInBoundBox</th>
			    <th style ="background-color:black;color:white;text-align:left">PlanningDate</th>
			    <th style ="background-color:black;color:white;text-align:left">ShipmentDate</th>
                <th style ="background-color:black;color:white;text-align:left">OrderStatus</th>
                <th style ="background-color:black;color:white;text-align:left">StandardQty</th>
                <th style ="background-color:black;color:white;text-align:left">ContainerType</th>
                <th style ="background-color:black;color:white;text-align:left">Customer</th>
                <th style ="background-color:black;color:white;text-align:left">Program</th>
			    <th style ="background-color:black;color:white;text-align:left">Organization</th>
			    <th style ="background-color:black;color:white;text-align:left">Notes</th>
                <th style ="background-color:black;color:white;text-align:left">LastEditUser</th>
                <th style ="background-color:black;color:white;text-align:left">LastEditDate</th>
                <th style ="background-color:black;color:white;text-align:left">OrderKey</th>
                <th style ="background-color:black;color:white;text-align:left">Creator</th>
			    <th style ="background-color:black;color:white;text-align:left">CreateDate</th>
		    </tr>
	    </thead>
	    <tbody id ="tby" style="background-color:white"></tbody>
                                   
    </table>
</div>
<div class="clear"></div>
<!-- 分页 -->
<div class="pagination" id="pager1" style="position:relative;top:-25px;"></div>

<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.12/xlsx.full.min.js"></script>
<script type="text/javascript" src="../../javascript/jquery-clock-timepicker.min.js"></script>

<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script>

  var role  = '<%= role %>';
  var puser = '<%= pusername %>';
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

     $(document).ready(function() {
	  $('.time').clockTimePicker({});
	});

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

        //加载自动检索
        $('#btnSearch').click();

        //设置按钮权限
        if (role == 'Sales') {

        }
        if (role == 'Planner') {
            $("#del").attr("disabled", "true");  
            $("#uptshippingdate").attr("disabled", "true"); 
            $("#uorderqty").attr("disabled", "true");
        }


    });

    //导入
    var rABS = false; //是否将文件读取为二进制字符串
    function importf(obj) {
        //导入
        if (!obj.files) { return; }
        var f = obj.files[0];
        {
            var reader = new FileReader();
            var name = f.name;
            reader.onload = function (e) {
                var data = e.target.result;
                var wb;
                if (rABS) {
                    wb = XLSX.read(data, { type: 'binary' });
                } else {
                    var arr = fixdata(data);
                    wb = XLSX.read(btoa(arr), { type: 'base64' });
                }
                //获取界面数据
                var json = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
                //数据校验
                //OrderQty,StandardQty不能为空，且能整除
                var orderqty;
                var standardqty;
                var pcheck = "0";

                for (var i = 0; i < json.length; i++) {
                    orderqty = json[i].OrderQuantity;
                    standardqty = json[i].StandardQuantity;

                    if (orderqty == undefined || standardqty == undefined) {
                        alert("Please check excel."+'\n'+"OrderQuantity and StandardQuantity can't be null.Row: "+(i+2));
                        pcheck = "1";
                        return;
                    }
                    else {
                        if (orderqty == "0" || standardqty == "0") {
                            alert("Please check excel."+'\n'+"OrderQuantity and StandardQuantity can't be zero.Row: "+(i+2));
                            pcheck = "1";
                            return;
                        }
                        else {
                            if (orderqty % standardqty != 0) {
                                alert("Please check excel."+'\n'+"StandardQuantity is an aliquant part of OrderQuantity.Row: "+(i+2));
                                pcheck = "1";
                                return;
                            }
                        }
                    }
                }

                if (pcheck =="0")
                {
                    $("#tby").html('<tr class="tr_loading"><td colspan="20"><img src="../../images/loading.gif" alt="" />Importing...</td></tr>');

                    var jsondata = JSON.stringify(json);
                    $.ajax({
                        type: "post",
                        url: "OEM_OrderTracking.aspx/saveDataImport",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d == "1") {
                                SearchData();
                                alert("Success");
                            }
                            else
                                alert("fail");
                        }
                    });
                }
            }
           
            if (rABS) reader.readAsBinaryString(f);
            else reader.readAsArrayBuffer(f);
        }

        $("#_import").val("");
    }

    function fixdata(data) {
        var o = "", l = 0, w = 10240;
        for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
        o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
        return o;
    }

    //对excel数据做简单校验
    //add by it-wxl 20180403
    function validateImport() {
    }

    //全选、反选
    //Add by IT-WXL   20180327
    function onSelected() {

        var flag = true;
        var btnVal = $('#selAll').val();
        if (btnVal == "Select All") {
           
            var cb = $("input[type=checkbox]");
            for (var i = 0; i < cb.length; i++) {
                cb[i].checked = flag;
            }
            flag = !flag;
            $('#selAll').val('Inverse');
        }
        else {
              var flag = true;
              var cb = $("input[type=checkbox]");
              for(var i = 0; i < cb.length; i++) {
                cb[i].checked = !flag;
            }
            $('#selAll').val('Select All');
        }
    }

    //界面查询数据
    function SearchData() {

        $("#editable tr:not(:first)").remove();
        $('#selAll').val('Select All');

        var _orderno  = $("#_orderno").val();    //订单号
        var ordertype = $("#ordertype").val();   //订单号
        var _partno   = $("#_partno").val();     //本厂编号
        var _factory  = $("#factory").val();     //工厂
        var _cst      = $("#_cst").val();        //客户
        var _status   = $("#qselect").val();     //状态
        var _creator  = $("#pcreator").val();    //创建人
        var _fdate    = $("#_fdate").val();      //交付日期F
        var _tdate    = $("#_tdate").val();      //交付日期T

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
            url: "OEM_OrderTracking.aspx/SearchData",
            data: "{creator:'"+_creator+"',orderno:'" + _orderno + "',ordertype:'" + ordertype + "',partno:'" + _partno + "',factory:'" + _factory + "',status:'"+_status+"',cst:'" + _cst + "',fdate:'" + _fdate + "',tdate:'" + _tdate + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        if (json[i].UnInBoundBox == "0") {
                            slct = slct + '<tr style="background-color:green"><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td> ' + json[i].Indexs + '</td> ' +
                                '<td> ' + json[i].OrderNO + '</td> ' +
                                //'<td> ' + json[i].OrderType + '</td> ' +
                                '<td> ' + json[i].PartNO + '</td> ' +
                                '<td> ' + json[i].OrderQuantity + '</td> ' +
                                '<td> ' + json[i].OrderQuantity / json[i].StandardQuantity + '</td> ' +
                                '<td> ' + json[i].InBoundQty + '</td> ' +
                                '<td> ' + json[i].UnInBoundQty + '</td> ' +
                                '<td> ' + json[i].UnInBoundBox + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].PlanningDate)).toLocaleString() + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                                '<td> ' + json[i].OrderStatus + '</td> ' +
                                '<td> ' + json[i].StandardQuantity + '</td> ' +
                                '<td> ' + json[i].ContainerType + '</td> ' +
                                '<td> ' + json[i].Customer + '</td> ' +
                                '<td> ' + json[i].Program + '</td> ' +
                                '<td> ' + json[i].Organization + '</td> ' +
                                '<td> ' + json[i].Notes + '</td> ' +
                                '<td> ' + json[i].LastEditUser + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].LastEditTime)).toLocaleString() + '</td> ' +
                                '<td> ' + json[i].OrderKey + '</td> ' +
                                '<td> ' + json[i].Creater + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' +
                                '</tr>';
                        }
                        else {
                            if (json[i].InBoundQty != "0") {
                                slct = slct + '<tr style="background-color:yellow"><td><input type="checkbox" name = "cb1" /></td>' +
                                    '<td> ' + json[i].Indexs + '</td> ' +
                                    '<td> ' + json[i].OrderNO + '</td> ' +
                                    //'<td> ' + json[i].OrderType + '</td> ' +
                                    '<td> ' + json[i].PartNO + '</td> ' +
                                    '<td> ' + json[i].OrderQuantity + '</td> ' +
                                    '<td> ' + json[i].OrderQuantity / json[i].StandardQuantity + '</td> ' +
                                    '<td> ' + json[i].InBoundQty + '</td> ' +
                                    '<td> ' + json[i].UnInBoundQty + '</td> ' +
                                    '<td> ' + json[i].UnInBoundBox + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].PlanningDate)).toLocaleString() + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                                    '<td> ' + json[i].OrderStatus + '</td> ' +
                                    '<td> ' + json[i].StandardQuantity + '</td> ' +
                                    '<td> ' + json[i].ContainerType + '</td> ' +
                                    '<td> ' + json[i].Customer + '</td> ' +
                                    '<td> ' + json[i].Program + '</td> ' +
                                    '<td> ' + json[i].Organization + '</td> ' +
                                    '<td> ' + json[i].Notes + '</td> ' +
                                    '<td> ' + json[i].LastEditUser + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].LastEditTime)).toLocaleString() + '</td> ' +
                                    '<td> ' + json[i].OrderKey + '</td> ' +
                                    '<td> ' + json[i].Creater + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' +
                                    '</tr>';
                            }
                            else {
                                slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                    '<td> ' + json[i].Indexs + '</td> ' +
                                    '<td> ' + json[i].OrderNO + '</td> ' +
                                    //'<td> ' + json[i].OrderType + '</td> ' +
                                    '<td> ' + json[i].PartNO + '</td> ' +
                                    '<td> ' + json[i].OrderQuantity + '</td> ' +
                                    '<td> ' + json[i].OrderQuantity / json[i].StandardQuantity + '</td> ' +
                                    '<td> ' + json[i].InBoundQty + '</td> ' +
                                    '<td> ' + json[i].UnInBoundQty + '</td> ' +
                                    '<td> ' + json[i].UnInBoundBox + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].PlanningDate)).toLocaleString() + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].ShipmentDate)).toLocaleString() + '</td> ' +
                                    '<td> ' + json[i].OrderStatus + '</td> ' +
                                    '<td> ' + json[i].StandardQuantity + '</td> ' +
                                    '<td> ' + json[i].ContainerType + '</td> ' +
                                    '<td> ' + json[i].Customer + '</td> ' +
                                    '<td> ' + json[i].Program + '</td> ' +
                                    '<td> ' + json[i].Organization + '</td> ' +
                                    '<td> ' + json[i].Notes + '</td> ' +
                                    '<td> ' + json[i].LastEditUser + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].LastEditTime)).toLocaleString() + '</td> ' +
                                    '<td> ' + json[i].OrderKey + '</td> ' +
                                    '<td> ' + json[i].Creater + '</td> ' +
                                    '<td> ' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' +
                                    '</tr>';
                            }
                        }
                      
                    }

                    $("#tby").html(slct);

                    //pager2
                    JSPager.totalRecord =  json[0].RecordCnt;
                    JSPager.doPager = SearchData;
                    JSPager.initPager('pager1');
                }
            }
        });
    }

    //Get Order VO
    var getOrderVO = function getOrderVOs() {
       
        var data = [];
        var nodate = true;
        var inputs = document.getElementById("editable").getElementsByTagName("input");

        for (var i = 0; i < inputs.length; i++) {
             var row = {};
	        if (inputs[i].type == "checkbox") {
	            if (inputs[i].checked && inputs[i].name == "cb1") {
	                var checkedRow = inputs[i];
	                var currRow = checkedRow.parentNode.parentNode.rowIndex;
	                var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;

                    row.OrderKey      = trim(tds[20].innerHTML);
                    row.OrderStatus   = trim(tds[11].innerHTML);
                    row.ShipmentDate  = trim(tds[10].innerHTML);
                    row.PlanningDate  = trim(tds[9].innerHTML);
                    row.OrderQuantity = trim(tds[4].innerHTML);
                    row.InBoundQty    = trim(tds[6].innerHTML);

                    data.push(row);
                    nodate = false;
	            }
            }
        }

        if (nodate) {
            alert("You havn't select any record!");
            return;
        }

        return data;
    }

    //Get selOrderKeys 
    var selOrderKeys = function getOrderKeys() {

        var orderkeys = '0';
        var orderVos = getOrderVO();
        if (orderVos.length > 0) {
            for (var i = 0; i < orderVos.length; i++)
            {
                orderkeys = orderkeys + "," +trim(orderVos[i].OrderKey);
            }
        }

        return orderkeys;
    }

    //Delete date
    //add by it-wxl  2018-03-29
    function DeleteData() {

        var orderids = selOrderKeys();
        //Only OrderGeneration can be delete.
        var orderVos = getOrderVO();
        if (orderVos.length > 0) {
            for (var i = 0; i < orderVos.length; i++)
            {
                if (trim(orderVos[i].OrderStatus) != "OrderGeneration") {
                    alert("Only those orders can be deleted that under OrderGeneration status!");
                    return;
                }
            }
        }

        if (confirm("Do you want to delete these records?")) {
            $.ajax({
	                type: "post",
	                url: "OEM_OrderTracking.aspx/DeleteRecords",
	                data: "{orderkeys:'"+orderids+"'}",
	                contentType: "application/json; charset=utf-8",
	                dataType: "json",
	                async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                            SearchData();
                        }
	                }
	        });
        }
    }

    //Update Action
    //Salers:OrderGeneration、OrderRegister、OrderCancel
    //Planner:OrderConfirm、OrderRelease、OrderClose
    function onAction(btnAction) {
        
        var orderids = selOrderKeys();
        var pvalue;
        var changeItem;
        if (btnAction == "Pshippingdate") {
            var time =  $('#ptime').val() + ":00";
            pvalue = $('#shppingdate').val() +" " +time;

            changeItem = "Shipping Date";
        }
        if (btnAction == "Porderqty") {
            pvalue = $('#_orderqty').val();
            changeItem = "Order Quantity";
        } 
        if (btnAction == "Pstatus") {
            pvalue = $('#pselect').val();
            //用户状态权限
            if (role == "Sales") {
                if (pvalue != "OrderGeneration" && pvalue != "OrderRegister") {
                    alert("You have not permission!");
                    return;
                }
            }
            if (role == "Planner") {
                if (pvalue == "OrderGeneration" || pvalue == "OrderRegister") {
                    alert("You have not permission!");
                    return;
                }
            }
            //状态验证
            //add by it-wxl 20180403
            var vdata = ValidateStatus(pvalue);
            if (vdata == "1") {
                return;
            }

            changeItem = "Order Status";
        }

        if (confirm("Do you want to change "+changeItem+"?")) {
            $.ajax({
	                type: "post",
	                url: "OEM_OrderTracking.aspx/OnAction",
	                data: "{opt:'"+btnAction+"',orderkeys:'"+orderids+"',pstatus:'"+pvalue+"'}",
	                contentType: "application/json; charset=utf-8",
	                dataType: "json",
	                async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                            SearchData();
                        }
	                }
	        });
        }

        
    }

    //页面自定义条数
    function changePageSize() {

         JSPager.currentIndex = 1;
         JSPager.pageSize = $('#precord').val();
         SearchData();
    }

    //更新状态验证
    //获取选择的行状态
    /////OrderGeneration => OrderRegister
    /////OrderRegister   => OrderGeneration
    /////OrderConfirm    => OrderRegister
    /////OrderRelease    => OrderConfirm
    /////OrderClose      => OrderConfirm,OrderRelease
    /////OrderCancel     => OrderGeneration,OrderRegister
    function ValidateStatus(pvalue) {

        var orderVos = getOrderVO();
        var vaild    = 0;

        if (pvalue == "OrderGeneration") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderRegister") {
                    alert("Only OrderRegister can be changed to OrderGeneration"+'\n'+"Please check selected orders");
                    vaild = "1";
                }
            }
        }
        if (pvalue == "OrderRegister") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderGeneration") {
                    alert("Only OrderGeneration can be changed to OrderRegister"+'\n'+"Please check selected orders");
                    vaild = "1";
                }
            }
        }
        if (pvalue == "OrderConfirm") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderRegister") {
                    alert("Only OrderRegister can be changed to OrderConfirm"+'\n'+"Please check selected orders");
                    vaild = "1";
                }
            }
        }
        if (pvalue == "OrderRelease") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderConfirm") {
                    alert("Only OrderConfirm can be changed to OrderRelease"+'\n'+"Please check selected orders");
                     vaild = "1";
                }
            }
        }
        if (pvalue == "OrderClose") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderConfirm" && trim(orderVos[i].OrderStatus) != "OrderRelease") {
                    alert("Only OrderConfirm and OrderRelease can be changed to OrderClose"+'\n'+"Please check selected orders");
                    vaild = "1";
                }
            }
        }
        if (pvalue == "OrderCancel") {
            for (var i = 0; i < orderVos.length; i++) {
                if (trim(orderVos[i].OrderStatus) != "OrderGeneration" && trim(orderVos[i].OrderStatus) != "OrderRegister") {
                    alert("Only OrderGeneration and OrderRegister can be changed to OrderCancel"+'\n'+"Please check selected orders");
                    vaild = "1";
                }
            }
        }

        return vaild;
    }

    //去左空格; 
    function ltrim(s){ 
        return s.replace( /^\s*/, ""); 
    } 
    //去右空格; 
    function rtrim(s){ 
        return s.replace( /\s*$/, ""); 
    } 
    //去左右空格; 
    function trim(s){ 
        return rtrim(ltrim(s)); 
    }

</script>
</body>
</html>
