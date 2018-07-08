<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContainerTranscation.aspx.cs" Inherits="FGA_PLATFORM.business.inventory.ContainerTranscation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
<title>FGAContainer Transcation</title>
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
<!-- jquery脚本库 -->
<script src="../../javascript/jquery-3.1.0.min.js"></script>
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
<body  style="overflow: hidden;">
<input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
<div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> Container Management=> Container Transcation</div>

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
				<label class="form-label">Barcode</label>
				<input class="form-control" id = "_barcode" type="text" placeholder="input" style="color:black;height:30px;width:110px;"/>
			</div>
             
            <div class="form-group">
				<label class="form-label">Type#</label>
				<input class="form-control" id = "_typeno" type="text" placeholder="input" style="color:black;height:30px;width:100px;"/>
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

            <div class="form-group">
				<label class="form-label">DR</label>
				<select id ="_dr" style="color: black; height:30px;width:60px;">
                    <option>All</option>
                    <option>0</option>
                    <option>1</option>
				</select>
			</div>

            <div class="form-group">	
						<label class="form-label" >Date(from)</label> 
						<div id="date-popup" class="input-group date"> 
							<input type="text" id="_fdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;"/>
							<span class="input-group-addon"><i class="fa fa-calendar" ></i></span> 
						</div>
		    </div>
		    <div class="form-group">	
			    <label class="form-label">Date(to)</label> 
			    <div id="date-popup1" class="input-group date">
				    <input type="text" id="_tdtxt" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;"/> 
				    <span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
			    </div>
		    </div>
             
        </form>

        <div class="form-group" style="position:fixed;top:80px;left:1400px">
            <input type="button" class="btn btn-primary btn-sm" name="export" style="background:white;color:#00b8ce" value="Export" onclick="$('#editable').tableExport({ type: 'excel', tableName: 'OEM_IR', escape: 'false' })" />
		</div>

        <div class="form-group" style="position:fixed;top:50px;left:1400px">
			<input type="button" class="btn btn-primary btn-sm" id ="btnSearch" name ="search" style="background:white;color:#00b8ce" value="Search" onclick="SearchData()" />
        </div>

			
    </div>
</div>

<div class='table-cont' id='table-cont' style="width:100%;margin-left: 0px;float:left;" >
		<table id = "editable"  class="table  table-bordered table-hover dataTables-example">
			<thead>
				<tr>
                <th style ="background-color:black;color:white;text-align:left">RN</th>
			    <th style ="background-color:black;color:white;text-align:left">TranscationID</th>          
                <th style ="background-color:black;color:white;text-align:left">Barcode</th>
                <th style ="background-color:black;color:white;text-align:left">CustomerPartNO</th>
                <th style ="background-color:black;color:white;text-align:left">CustomerCode</th>
                <th style ="background-color:black;color:white;text-align:left">ContainerType</th>
                <th style ="background-color:black;color:white;text-align:left">Type#</th>
                <th style ="background-color:black;color:white;text-align:left">Status</th>  
                <th style ="background-color:black;color:white;text-align:left">BOL#</th>
                <th style ="background-color:black;color:white;text-align:left">SerialNO</th>
                <th style ="background-color:black;color:white;text-align:left">Transcation User</th>   
                <th style ="background-color:black;color:white;text-align:left">Transcation Time</th>  
                <th style ="background-color:black;color:white;text-align:left">dr</th>
				</tr>
			</thead>
			<tbody id ="tby"  style="background-color:white">

			</tbody>
		</table>
</div>	
<!-- 分页 -->
<div class="clear"></div>
<div class="pagination" id="pager1"></div>
	  
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
            JSPager.currentIndex = 1;
            JSPager.pageSize = $('#hidPageSize').val();
            SearchData();
        });
        //加载自动检索
        $('#btnSearch').click();
    });

    //查询界面
    function SearchData() {

        $("#editable tr:not(:first)").remove();
       
        var sn      = $("#_ct").val();                 //Container Type
        var pn      = $("#_ccode").val();              //Customer Code
        var typeno  = $("#_typeno").val();             //typeno
        var barcode = $("#_barcode").val();            //Barcode
        var status  = $("#sloc").val();                //status
        var bol     = $("#_bol").val();                //bol
        var dr = $("#_dr").val();                      //dr
        var ftime =  $("#_fdtxt").val();               //fromDate
        var ttime =  $("#_tdtxt").val();               //toDate

        if (ftime != "" && ttime == "") {
            alert("Please input Date(to)!");
            return;
        }
        if (ftime == "" && ttime != "") {
            alert("Please input Date(from)!");
            return;
        }

        $.ajax({
            type: "Post",
            url: "ContainerTranscation.aspx/SearchData",
            data: "{containertype:'" + sn + "',customercode:'" + pn + "',typeno:'" + typeno + "',barcodeno:'" + barcode + "',status:'" + status + "',bol:'" + bol + "',dr:'" + dr + "',ftime:'"+ftime+"',ttime:'"+ttime+"',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";

                    for (var i = 0; i < json.length; i++) {
                        slct = slct + '<tr>' +
                            '<td> ' + json[i].Indexs + '</td> ' +
                            '<td> ' + json[i].TranscationID + '</td> ' +
                            '<td> ' + json[i].Barcode + '</td> ' +
                            '<td> ' + json[i].CustomerPartNO + '</td> ' +
                            '<td> ' + json[i].CustomerCode + '</td> ' +
                            '<td> ' + json[i].ContainerType + '</td> ' +
                            '<td> ' + json[i].TypeNO + '</td> ' +
                            '<td> ' + json[i].Status + '</td> ' +
                            '<td>'  + json[i].ReceiptNO + '</td> ' +
                            '<td> ' + json[i].SerialNO + '</td> ' +
                            '<td> ' + json[i].TranscationUser + '</td> ' +
                            '<td> ' + new Date(parseInt(json[i].TranscationTime)).toLocaleString() + '</td> ' +
                            '<td> ' + json[i].dr + '</td> ' 
                            '</tr>';
                       
                    }
                    $("#tby").html(slct);

                    //pager2
                    JSPager.totalRecord = json[0].Recordcnt;
                    JSPager.doPager = SearchData;
                    JSPager.initPager('pager1');
                }
            }
        });
    }
</script>
</body>
</html>
