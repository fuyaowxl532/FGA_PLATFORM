<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainScreen.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.MainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>IT Asset MainScreen</title>

<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
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
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet">
<!-- jquery脚本库 -->
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

<script  type="text/javascript">
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
        var loc = '<option value="All" >All</option>';
        $.ajax({
            type: "post",
            url: "MainScreen.aspx/getDepartment",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);

                    for (var i = 0; i < json.length; i++) {
                        loc = loc + '<option>' + json[i].Department + '</option>';
                    }

                    $('#_department').html(loc);
                }
            }
        });

    });
</script>

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
  max-height: 80%;
  overflow: auto;
  background: #ddd;
  margin: 5px 5px;
  box-shadow: 0 0 1px 3px #ddd;
}
 
td{  
  text-overflow: ellipsis;  
  overflow: hidden;  
  white-space: nowrap;  
  font-family: Verdana;
} 
</style>

</head>
<body style="overflow: hidden;">

<input type="hidden" id="hidPageSize" value='<%= pagesize %>' />
<div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Assets Managemant=> IT Assets Detail</div>
<!-- Page container #00BACE -->
<div style="background-color:gold">   
	<%--<div class="header-secondary " style="margin-top:-20px; margin-left:-10px;">
                <a href="javascript:;" class="file" style="background-color:white;color:black;font-weight:bold;top:9px">IMPORT
                        <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
				<button class="btn btn-primary btn-xs"  onclick="$('#editable').tableExport({ type: 'excel', tableName: 'OEM_Order', escape: 'false' })">EXPORT</button>
	</div>--%>
	<!-- /secondary header -->
	<!-- Filter wrapper -->
	<div class="filter-wrapper" style="height:75px; width:100%; margin-top:-5px;margin-bottom:5px;margin-right:30px;" id="filter-box">
		
			<div class="form-inline" style="margin-top: -10px">
                <div class="form-group">
					<label class="form-label">First_Name</label>
					<input type="text" id = "_fn" placeholder="input" style="color: black; height:30px;width:100px"/>	
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">Last_Name</label>
					<input type="text" id = "_ln" placeholder="input" style="color: black; height:30px;width:100px"/>	
				</div>

                <div class="form-group" style="margin-left:-35px;">
					    <label class="form-label">Department</label>
					    <select class="select2" id ="_department" style="width:180px">
						       
					    </select>
				</div>
                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">S/N</label>
					<input type="text"  id ="itserialno" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
				<div class="form-group" style="margin-left:-35px;">
					<label class="form-label">IT_AssetNO</label>
					<input type="text"  id ="itassetno" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
                <div class="form-group" style="margin-left:-35px;">
					<label class="form-label">FIN_AssetNO</label>
					<input type="text"  id ="finasseetno" placeholder="input" style="color: black; height:30px;width:150px"/>
				</div>
                 <div class="form-group" style="margin-left:-35px;">
					    <label class="form-label">Status</label>
					    <select class="select2" id ="_sts" style="width:120px">
						    <option value="All" >All</option>
                            <option value="Idle" >Idle</option>
                            <option value="InUse" >InUse</option>
                            <option value="Damage" >Damage</option>
                            <option value="Scrapped" >Scrapped</option>
                            <option value="Missing" >Missing</option>
					    </select>
				</div>
				
				<div class="form-group" style="margin-left:-35px;"> 
					<label class="form-label">IssueDate(From)</label> 
					
					<div id="date-popup" class="input-group date"> 
					<input type="text" id = "_fdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
                    </div>
                <div class="form-group"style="margin-left:-35px;"> 
                    <label class="form-label">IssueDate(To)</label> 
					
					<div id="date-popup1" class="input-group date"> 
					<input type="text" id ="_tdate"  data-format="D, dd MM yyyy" class="form-control" style="width:120px"/> 
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
						</div>
					 
				</div>

                <div class="checkbox">
					 <label><input type="checkbox" id ="cbdii" checked="checked"/> Display IT Inventory</label>
				</div>
			</div>
		
	</div>
	
	<div class=" form-inline" style="background-color:#00BACE">
		<div>
              <button title ="Search"   class="btn btn-primary btn-xs" id ="btnSearch"    onclick ="queryData()">Search</button>
              <button title ="Return"   class="btn btn-primary btn-xs" id ="btnReturn"    onclick ="onAction('Return')">Return</button>
              <button title ="Transfer" class="btn btn-primary btn-xs" id ="btnTransfer"  onclick ="onAction('Transfer')">Transfer</button>
              <button title ="Damage"   class="btn btn-primary btn-xs" id ="btnDamage"    onclick ="onAction('Damage')">Damage</button>
              <button title ="Scrapped" class="btn btn-primary btn-xs" id ="btnScrapped"  onclick ="onAction('Scrapped')">Scrapped</button>
              <button title ="Missing"  class="btn btn-primary btn-xs" id ="btnMissing"   onclick ="onAction('Missing')">Missing</button>
              <button title ="Export"   class="btn btn-primary btn-xs" id ="btnExport"    onclick ="queryData()">Export</button>
        </div>
	</div>
</div>
    
<!-- /table class="table  table-bordered table-hover dataTables-example" -->
<div class='table-cont' id='table-cont' style="margin-left:0px">
    <table id ="editable"  class="table table-condensed">
	    <thead>
		    <tr>
                 <th style ="background-color:floralwhite;color:black;text-align:left">*</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">NO</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Employee</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Asset</th>
						<th style ="background-color:floralwhite;color:black;text-align:left">Category</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">S/N</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">IT_AssetNO</th>
						<th style ="background-color:floralwhite;color:black;text-align:left">FIN_AssetNo</th>
						<th style ="background-color:floralwhite;color:black;text-align:left">Issue_Date</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Return_Date</th>
						<th style ="background-color:floralwhite;color:black;text-align:left">Dept.</th>
						<th style ="background-color:floralwhite;color:black;text-align:left">Manager</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Status</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">MacNo</th>   
                        <th style ="background-color:floralwhite;color:black;text-align:left">Brand</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Note</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">PlexID</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">AssetKey</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">Creator</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">CreateDate</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">UpdatedBy</th>
                        <th style ="background-color:floralwhite;color:black;text-align:left">UpdatedDate</th>
		    </tr>
	    </thead>
	    <tbody id ="tby" style="background-color:white; font-family:Arial, Helvetica, sans-serif""></tbody>
                                   
    </table>
</div>
     <div class="clear"></div>
    <!-- 分页 -->
     <div class="pagination" id="pager1" style="position:relative;top:-25px;">
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
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script  type="text/javascript">

    window.onload = function () {
        var tableCont = document.querySelector('#table-cont')
        /**
        * scroll handle
        * @param {event} e -- scroll event
        */
        function scrollHandle(e) {
            console.log(this)
            var scrollTop = this.scrollTop;
            this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
        }

        tableCont.addEventListener('scroll', scrollHandle)
    }

    $(document).ready(function () {

        //Enter Query Information
        $(document).keydown(function (event) {
            if (event.keyCode == 13) {
                queryData();
            }
        });

        //按钮事件
        $('#btnSearch').click(function () {
            JSPager.currentIndex = 1;
            JSPager.pageSize = $('#hidPageSize').val();
            queryData();
        });

        //加载自动检索
        //$('#btnSearch').click();
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
                    url: "MainScreen.aspx/saveDataImport",
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
            for (var i = 0; i < cb.length; i++) {
                cb[i].checked = !flag;
            }
            $('#selAll').val('Select All');
        }
    }
    //查询 
    //add by it-wxl 05/04/2017
    function queryData() {

        $('#tby').html('');
        $('#tby').html('<tr class="tr_loading"><td colspan="15"><img src="../../images/loading.gif" alt="" />Loading...</td></tr>');

        var pactive = "0";

        var fn = $('#_fn').val();
        var ln = $('#_ln').val();
        var dn = $('#_department').val();
        var sn = $('#itserialno').val();
        var itno = $('#itassetno').val();
        var finno = $('#finasseetno').val();
        var sts = $('#_sts').val();
        var fd = $('#_fdate').val();
        var td = $('#_tdate').val();

        var cbdii = "0";
        if ($('#cbdii').is(':checked')) {
            cbdii = "1";
        }
        else {
            cbdii = "0";
        }

        $.ajax({
            type: "Post",
            url: "MainScreen.aspx/SearchData",
            data: "{sn:'" + sn + "',fn:'" + fn + "',ln:'" + ln + "',department:'" + dn + "',itno:'" + itno + "',finno:'" + finno + "',status:'" + sts + "',fd:'" + fd + "',td:'" + td + "',ITInv:'" + cbdii + "',CurrentPageIndex:'" + JSPager.currentIndex + "',PageSize:'" + JSPager.pageSize + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        var issueDate;
                        var returnDate;
                        var updatedate;

                        if (json[i].Issue_Date.indexOf("-") == 0)
                            issueDate = "";
                        else
                            issueDate = new Date(parseInt(json[i].Issue_Date)).toLocaleString();

                        if (json[i].Return_Date.indexOf("-") == 0)
                            returnDate = "";
                        else
                            returnDate = new Date(parseInt(json[i].Return_Date)).toLocaleString();

                        if (json[i].UpdateDate.indexOf("-") == 0)
                            updatedate = "";
                        else
                            updatedate = new Date(parseInt(json[i].UpdateDate)).toLocaleString();

                        if (json[i].Status == "InUse") {
                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + json[i].First_Name + ' ' + json[i].Last_Name + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                                '<td>' + returnDate + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].Manager + '</td> ' +
                                '<td style ="background-color:yellowgreen;"> ' + json[i].Status + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '<td>' + json[i].AssetKey + '</td> ' +
                                '<td>' + json[i].Creator + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + updatedate + '</td> '
                            '</tr>';
                        }
                        if (json[i].Status == "Idle") {
                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + json[i].First_Name + ' ' + json[i].Last_Name + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                                '<td>' + returnDate + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].Manager + '</td> ' +
                                '<td style ="background-color:Blue;color:white"> ' + json[i].Status + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '<td>' + json[i].AssetKey + '</td> ' +
                                '<td>' + json[i].Creator + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + updatedate + '</td> '
                            '</tr>';
                        }
                        if (json[i].Status == "Damage") {
                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + json[i].First_Name + ' ' + json[i].Last_Name + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                                '<td>' + returnDate + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].Manager + '</td> ' +
                                '<td style ="background-color:yellow;"> ' + json[i].Status + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '<td>' + json[i].AssetKey + '</td> ' +
                                '<td>' + json[i].Creator + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + updatedate + '</td> '
                            '</tr>';
                        }
                        if (json[i].Status == "Scrapped") {
                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + json[i].First_Name + ' ' + json[i].Last_Name + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                                '<td>' + returnDate + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].Manager + '</td> ' +
                                '<td style ="background-color:gray;"> ' + json[i].Status + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '<td>' + json[i].AssetKey + '</td> ' +
                                '<td>' + json[i].Creator + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + updatedate + '</td> '
                            '</tr>';
                        }
                        if (json[i].Status == "Missing") {
                            slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + json[i].First_Name + ' ' + json[i].Last_Name + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                                '<td>' + returnDate + '</td> ' +
                                '<td>' + json[i].Department + '</td> ' +
                                '<td>' + json[i].Manager + '</td> ' +
                                '<td style ="background-color:red;"> ' + json[i].Status + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].PlexID + '</td> ' +
                                '<td>' + json[i].AssetKey + '</td> ' +
                                '<td>' + json[i].Creator + '</td> ' +
                                '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + updatedate + '</td> '
                            '</tr>';
                        }
                    }
                    $("#tby").html(slct);

                    //pager2
                    JSPager.totalRecord = json[0].RecordCnt;
                    JSPager.doPager = queryData;
                    JSPager.initPager('pager1');
                }
                else {
                    $('#tby').html('<tr><td colspan="15">no data</td></tr>');
                }
            }
        });
    }


    //Get AssetKey
    var getKeys = function getAssetKeys() {

        var inputs = document.getElementById("editable").getElementsByTagName("input");
        var data = [];
        var jsondata;

        for (var i = 0; i < inputs.length; i++) {

            if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    var row = {};
                    var checkedRow = inputs[i];
                    var currRow = checkedRow.parentNode.parentNode.rowIndex;
                    var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;

                    row.AssetKey = tds[17].innerHTML;

                    if (row.AssetKey != "") {
                        data.push(row);
                    }
                }

            }
        }

        if (data.length > 0) {
            jsondata = JSON.stringify(data);
        }

        return jsondata;
    }

    function onAction(ptype) {

        //Return
        if (ptype == "Return") {
            if (confirm("Return?")) {

                var assetkeys = getKeys();

                $.ajax({
                    type: "post",
                    url: "MainScreen.aspx/doAction",
                    data: "{assetkeys:'" + assetkeys + "',ptype:'" + ptype + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                        }
                    }
                });
            }
        }

        //Transfer
        if (ptype == "Transfer") {

            var assetkeys = getKeys();
            window.parent.showDialog('Employee', 'business/ITAsset/AssetTransfer.aspx?id=' + assetkeys, 600, 530, function (res) {
                if (res == window.ST_OK) {
                    queryData();
                }
            });
        }

        if (ptype == "Damage") {
            if (confirm("Damage?")) {

                var assetkeys = getKeys();

                $.ajax({
                    type: "post",
                    url: "MainScreen.aspx/doAction",
                    data: "{assetkeys:'" + assetkeys + "',ptype:'" + ptype + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                        }
                    }
                });
            }
        }

        if (ptype == "Scrapped") {
            if (confirm("Scrapped?")) {

                var assetkeys = getKeys();

                $.ajax({
                    type: "post",
                    url: "MainScreen.aspx/doAction",
                    data: "{assetkeys:'" + assetkeys + "',ptype:'" + ptype + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                        }
                    }
                });
            }
        }

        if (ptype == "Missing") {
            if (confirm("Missing?")) {

                var assetkeys = getKeys();

                $.ajax({
                    type: "post",
                    url: "MainScreen.aspx/doAction",
                    data: "{assetkeys:'" + assetkeys + "',ptype:'" + ptype + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d == "1") {
                            alert("Successful");
                        }
                    }
                });
            }
        }

        queryData();
    }

</script>
</body>
</html>
