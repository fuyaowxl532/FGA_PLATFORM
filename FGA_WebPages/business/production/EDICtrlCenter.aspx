<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDICtrlCenter.aspx.cs" Inherits="FGA_PLATFORM.business.production.EDICtrlCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>EDI Control Center</title>
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
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> SmallLot=> EDICtrlCenter</div>
<%--    <div class="header-secondary " style="margin-top:-20px; margin-left:-10px;">
                
                <a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:9px">IMPORT
                        <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
                <button class="btn btn-primary btn-sm" id ="btnSearch"  onclick ="SearchData()">Search</button>
                <button class="btn btn-primary btn-sm" id ="btnMerge"   onclick ="MergeData()">MergeData</button>
                <button class="btn btn-primary btn-sm" id ="btnExport"  onclick ="$('#editable').tableExport({ type: 'excel', tableName: 'OEM_IR', escape: 'false' })">Export</button>

	</div>--%>

    <div class="row" style="margin-top:2px">
		 <div class="col-lg-8">
			 <div class="form-inline">
                <label style="color:black;font-weight:bold;height:20px">Ship Date</label> 

				<div class="form-group">
                    <div id="date-popup" class="input-group date"> 
					<input type="text" id = "_fdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
				    </div>
				</div>
				<div class="form-group">
				    <div id="date-popup1" class="input-group date"> 
					<input type="text" id ="_tdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
				    </div>
				</div>
				<a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:13px;height:30px">IMPORT
                <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
                <button class="btn btn-primary btn-sm" id ="btnSearch"  style="height:30px" onclick ="SearchData()">Search</button>
                <button class="btn btn-primary btn-sm" id ="btnMerge"   style="height:30px" onclick ="MergeData()">MergeData</button>
                <button class="btn btn-primary btn-sm" id ="btnExport"  style="height:30px" onclick ="$('#editable').tableExport({ type: 'excel', tableName: 'Small Lot Orders', escape: 'false' })">Export</button>
               
			</div>
			
        </div>
	    </div>

    <!-- /table -->
    <div style="width:100%;height:85%;overflow:auto;margin-left: 0px;float:left;margin-top:2px;">
							<div class="table-responsive">
								<table id = "editable" class="table table-bordered" >
	        <thead>
		        <tr>
                    <th style ="background-color:black;color:white;text-align:left">No</th>
                    <th style ="background-color:black;color:white;text-align:left">Group</th>
                    <th style ="background-color:black;color:white;text-align:left">Customer_Name</th>
			        <th style ="background-color:black;color:white;text-align:left">Customer_Address_Code</th>
			        <th style ="background-color:black;color:white;text-align:left">Customer_Part_NO</th>
			        <th style ="background-color:black;color:white;text-align:left">Customer_Part_Revision</th>
                    <th style ="background-color:black;color:white;text-align:left">Part_NO</th>
                    <th style ="background-color:black;color:white;text-align:left">Part_Name</th>
                    <th style ="background-color:black;color:white;text-align:left">Due_Date</th>
                    <th style ="background-color:black;color:white;text-align:left">Ship_Date</th>
			        <th style ="background-color:black;color:white;text-align:left">Quantity</th>
			        <th style ="background-color:black;color:white;text-align:left">Order_NO</th>
                    <th style ="background-color:black;color:white;text-align:left">Lot_NO</th>
                    <th style ="background-color:black;color:white;text-align:left">Batch_NO</th>
                    <th style ="background-color:black;color:white;text-align:left">Job_Sequence</th>
                    <th style ="background-color:black;color:white;text-align:left">Standard_Quantity</th>
                    <th style ="background-color:black;color:white;text-align:left">Creator</th>
			        <th style ="background-color:black;color:white;text-align:left">CreateDate</th>
		        </tr>
	        </thead>
	        <tbody id ="tby" style="background-color:white"></tbody>
                                   
       </table>
							</div>
						</div>		
   		   

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
<script type="text/javascript">
    var islock = '<%= isLocked %>';

    $(document).ready(function () {

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

          //设置按钮权限
        if (islock == 'Yes') {
            $("#_import").attr("disabled", "true");
        }
        if (islock == 'No') {
            $("#_import").removceAttr("disabled");
        }

        SearchData();
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

                if (true)
                {
                    $("#tby").html('<tr class="tr_loading"><td colspan="20"><img src="../../images/loading.gif" alt="" />Importing...</td></tr>');

                    var jsondata = JSON.stringify(json);
                    $.ajax({
                        type: "post",
                        url: "EDICtrlCenter.aspx/saveDataImport",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d == "1") {
                                alert("Import Successfully!");
                                SearchData();
                            }
                            else {
                                alert("Import failed");
                                $("#tby").html('');
                            }
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

    //Query
    function SearchData() {
        $("#editable tr:not(:first)").remove();

        //var _fdate = $("#_fdate").val();      //交付日期F
        //var _tdate = $("#_tdate").val();      //交付日期T

        //if (_fdate == "" || _tdate == "") {
        //    alert("Please input ship date!");
        //    return;
        //}

        $.ajax({
            type: "Post",
            url: "EDICtrlCenter.aspx/SearchData",
            //data: "{fdate:'" + _fdate + "',tdate:'" + _tdate + "'}",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr>' +
                            '<td> ' + (i + 1) + '</td> ';

                        if (i == 0) {
                               slct = slct + '<td style="background-color:yellow;"> ' + json[i].MasterID + '</td>';
                           }
                           else {
                               if (json[i].MasterID != json[i - 1].MasterID) {
                                   slct = slct + '<td style="background-color:yellow;"> ' + json[i].MasterID + '</td>';
                               }
                               else {
                                    slct = slct + '<td> ' + json[i].MasterID + '</td>';
                               }
                        }

                        slct = slct + '<td> ' + json[i].Customer_Name + '</td> ' +
                                '<td> ' + json[i].Customer_Address_Code + '</td> ' +
                                '<td> ' + json[i].Customer_Part_NO + '</td> ' +
                                '<td> ' + json[i].Customer_Part_Revision + '</td> ' +
                                '<td> ' + json[i].Part_NO + '</td> ' +
                                '<td> ' + json[i].Part_Name + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].Due_Date)).toLocaleString() + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].Ship_Date)).toLocaleString() + '</td> ' +
                                '<td> ' + json[i].Quantity + '</td> ' +
                                '<td> ' + json[i].Order_NO + '</td> ' +
                                '<td> ' + json[i].Lot_NO + '</td> ' +
                                '<td> ' + json[i].Batch_NO + '</td> ' +
                                '<td> ' + json[i].Job_Sequence + '</td> ' +
                                '<td> ' + json[i].Standard_Quantity + '</td> ' +
                                '<td> ' + json[i].Creator + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].Createdate)).toLocaleString() + '</td> ' +
                                '</tr>';
                        }
                    }

                    $("#tby").html(slct);
                }
        });

    }

    //合并EDI数据
    function MergeData() {
        $.ajax({
            type: "Post",
            url: "EDICtrlCenter.aspx/MergeData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d == "1") {
                    SearchData();
                    alert("Merge successfully!");
                }
            }
        });
    }
    
</script>

</body>
</html>
