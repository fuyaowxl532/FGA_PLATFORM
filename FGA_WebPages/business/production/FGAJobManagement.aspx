<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FGAJobManagement.aspx.cs" Inherits="FGA_PLATFORM.business.production.FGAJobManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<title>Job Manage</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<link rel='shortcut icon' type='image/x-icon' href='../../images/favicon.ico' />
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../css/style.css" rel="stylesheet" />
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<script src="../../javascript/ValidationCheck.js"></script>


<style type="text/css">
th
  {
  background-color:black;
  color:white;

  }
</style>
</head>
<body style="overflow: hidden;">

<input type="hidden" id="hidPageSize" value='<%= pagesize %>' />

<div id="PTitle">
    <i class="icon-tools"></i>&nbsp;&nbsp;Production=> Container Management=> Container List
</div>
<!-- Page container -->
    <!--/Query-->
	<div class="row filter-wrapper visible-box" id="filter-box">
		<div class="col-lg-12">
			
			<form class="form-inline">
				<div class="form-group">
					<label class="form-label">Container Type</label>
					<input class="form-control" id = "_ct" type="text" placeholder="input" style="color: black; height:30px;width:150px;" />	
				</div>
				<div class="form-group">
					<label class="form-label">Customer Code</label>
					<input class="form-control" id = "_ccode" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
				</div>
				<div class="form-group">
					<label class="form-label">Part SerialNO</label>
					<input class="form-control" id = "_psn" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
				</div>

                <div class="form-group">
					<label class="form-label">Customer PartNO</label>
					<input class="form-control" id = "_cp" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
				</div>

                <div class="form-group">
					<label class="form-label">Type#</label>
					<input class="form-control" id = "_typeno" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
				</div>

                <div class="form-group">
					<label class="form-label">BarcodeNO</label>
					<input class="form-control" id = "_barcode" type="text" placeholder="input" style="color:black;height:30px;width:110px;"/>
				</div>

                <div class="form-group">
					<label class="form-label">BOL#</label>
					<input class="form-control" id = "_bol" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
				</div>

                <div class="form-group">
					<label class="form-label">Status</label>
					<select id ="sloc" style="color: black; height:30px;width:100px;">
                        <option>All</option>
                        <option>Empty</option>
                        <option>In Use</option>
                        <option>Shipped</option>
					</select>
				</div>
          
                <div class="form-group" style="position:absolute; top:35px;left:1220px"  >
				  <input type="button" id="btnSearch" class="btn btn-primary btn-sm" name="search" style="background:white;color:#00b8ce" value="Search" onclick="SearchData()" />
                </div>

			</form>
       </div>
	</div>


	<!-- /table -->
	<div style="width:100%;height:80%;overflow:auto;margin-left: 0px;margin-top:5px;">
			
							<div class="table-responsive">
								<table id = "editable" class=" table table-bordered table-hover">
									<thead>
										<tr>
                                        <th style="text-align:left;">*</th>
                                        <th style="text-align:left;">RN</th>
			                            <th style="text-align:left;">ContainerType</th>          
                                        <th style="text-align:left;">CustomerCode</th>
                                        <th style="text-align:left;">Program</th>   
                                        <th style="text-align:left;">PartSerialNO</th>  
                                        <th style="text-align:left;">CustomerPartNO</th>  
                                        <th style="text-align:left;">Type#</th>
                                        <th style="text-align:left;">Status</th>
                                        <th style="text-align:left;">Barcode</th>
                                        <th style="text-align:left;">ContainerNO</th>
                                        <th style="text-align:left;">BOL#</th>
                                        <th style="text-align:left;">Active</th>
                                        <th style="text-align:left;">LastEditTime</th>
                                        <th style="text-align:left;">LastEditUser</th>
                                        <th style="text-align:left;">Creator</th>
                                        <th style="text-align:left;">CreateDate</th>
										</tr>
									</thead>
									<tbody id ="tby">

									</tbody>
								</table>
                               
							</div>
						</div>	
    


    <!-- 分页 -->
    <div class="clear"></div>
    <div class="pagination" id="pager1">
    </div>

<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>


<script type="text/javascript">
    /* 页面加载 */
    $(document).ready(function () {
        //按钮事件
        $('#btnSearch').click(function () {
            JSPager.currentIndex = 1;
            JSPager.pageSize = $('#hidPageSize').val();
            SearchData();
        });
        //加载自动检索
        $('#btnSearch').click();
    });

    //导入
    var rABS = false; //是否将文件读取为二进制字符串
    function importf(obj) {//导入
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
                var jsondata = JSON.stringify(json);
                $.ajax({
                    type: "post",
                    url: "FGAJobManagement.aspx/saveDataImport",
                    data: "{data:'" + jsondata + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("success");
                        }
                        else
                            alert("fail");
                    }
                });

            }
            if (rABS) reader.readAsBinaryString(f);
            else reader.readAsArrayBuffer(f);
        }
    }
    function fixdata(data) {
        var o = "", l = 0, w = 10240;
        for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
        o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
        return o;
    }


    //查询界面
    function SearchData() {

        $('#tby').html('');
        $('#tby').html('<tr class="tr_loading"><td colspan="8"><img src="../../images/loading.gif" alt="" />Loading...</td></tr>');
       
        var sn = $("#_ct").val();           //Container Type
        var pn = $("#_ccode").val();        //Customer Code
        var sts = $("#_psn").val();         //Part SerialNO
        var cp = $("#_cp").val();           //Customer PartNO
        var typeno = $("#_typeno").val();   //typeno
        var barcode = $("#_barcode").val(); //Barcode
        var status = $("#sloc").val();      //Status

        $.ajax({
            type: "Post",
            url: "FGAJobManagement.aspx/SearchData",
            data: "{containertype:'" + sn + "',customercode:'" + pn + "',serialno:'" + sts + "',partno:'" + cp + "',typeno:'" + typeno + "',barcodeno:'" + barcode + "',status:'" + status + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    //加载数据时增加颜色
                    //"In Use"  黄色
                    //"Empty"   白色
                    //"Shipped" 灰色
                    for (var i = 0; i < json.length; i++) {
                        var editdate;
                        if (json[i].LastUpdateDate == "-2208970800000")
                            editdate = "";
                        else
                            editdate = new Date(parseInt(json[i].LastUpdateDate)).toLocaleString();



                        if (json[i].Status == "In Use")
                        {
                            slct = slct + '<tr bgcolor="#FFFF00"><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td> ' + json[i].Indexs + '</td> ' +
                                '<td> ' + json[i].ContainerType + '</td> ' +
                                '<td> ' + json[i].CustomerCode + '</td> ' +
                                '<td> ' + json[i].Program + '</td> ' +
                                '<td> ' + json[i].PartSerialNO + '</td> ' +
                                '<td> ' + json[i].CustomerPartNO + '</td> ' +
                                '<td> ' + json[i].TypeNO + '</td> ' +
                                '<td>'  + json[i].Status + '</td> ' +
                                '<td> ' + json[i].Barcode + '</td> ' +
                                '<td> ' + json[i].ContainerNO + '</td> ' +
                                '<td> ' + json[i].ReceiptNO + '</td> ' +
                                '<td> ' + json[i].Active + '</td> ' +
                                '<td> ' + editdate + '</td> ' +
                                '<td> ' + json[i].LastEditUser + '</td> ' +
                                '<td> ' + json[i].Creator + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '</tr>';
                        }

                        if (json[i].Status == "Shipped") {
                            slct = slct + '<tr bgcolor="#6D6F70"><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td><font color="white"> ' + json[i].Indexs + '</td> ' +
                                '<td><font color="white"> ' + json[i].ContainerType + '</td> ' +
                                '<td><font color="white"> ' + json[i].CustomerCode + '</td> ' +
                                '<td><font color="white"> ' + json[i].Program + '</td> ' +
                                '<td><font color="white"> ' + json[i].PartSerialNO + '</td> ' +
                                '<td><font color="white"> ' + json[i].CustomerPartNO + '</td> ' +
                                '<td><font color="white"> ' + json[i].TypeNO + '</td> ' +
                                '<td><font color="white" >' + json[i].Status + '</td> ' +
                                '<td><font color="white"> ' + json[i].Barcode + '</td> ' +
                                '<td><font color="white"> ' + json[i].ContainerNO + '</td> ' +
                                '<td><font color="white"> ' + json[i].ReceiptNO + '</td> ' +
                                '<td><font color="white"> ' + json[i].Active + '</td> ' +
                                '<td><font color="white"> ' + editdate + '</td> ' +
                                '<td><font color="white"> ' + json[i].LastEditUser + '</td> ' +
                                '<td><font color="white"> ' + json[i].Creator + '</td> ' +
                                '<td><font color="white"> ' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '</tr>';
                        }

                        if (json[i].Status == "Empty") {
                            slct = slct + '<tr bgcolor="#F8FAFB"><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td> ' + json[i].Indexs + '</td> ' +
                                '<td> ' + json[i].ContainerType + '</td> ' +
                                '<td> ' + json[i].CustomerCode + '</td> ' +
                                '<td> ' + json[i].Program + '</td> ' +
                                '<td> ' + json[i].PartSerialNO + '</td> ' +
                                '<td> ' + json[i].CustomerPartNO + '</td> ' +
                                '<td> ' + json[i].TypeNO + '</td> ' +
                                '<td>'  + json[i].Status + '</td> ' +
                                '<td> ' + json[i].Barcode + '</td> ' +
                                '<td> ' + json[i].ContainerNO + '</td> ' +
                                '<td> ' + json[i].ReceiptNO + '</td> ' +
                                '<td> ' + json[i].Active + '</td> ' +
                                '<td> ' + editdate + '</td> ' +
                                '<td> ' + json[i].LastEditUser + '</td> ' +
                                '<td> ' + json[i].Creator + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '</tr>';
                        }
                       
                    }
                    $("#tby").html(slct);

                    //pager2
                    JSPager.totalRecord = 247;
                    JSPager.doPager = SearchData;
                    JSPager.initPager('pager1');
                }
            }
        });
    }
</script>
</body>
</html>
