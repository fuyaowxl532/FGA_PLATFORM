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
<body style="overflow:hidden">
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> SmallLot=> EDICtrlCenter</div>
    <div class="header-secondary " style="margin-top:-20px; margin-left:-10px;">
                <a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:9px">IMPORT
                        <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
                <button class="btn btn-primary btn-sm" id ="btnSearch"  onclick ="MergeData()">MergeData</button>
	</div>
    <!-- /table -->
    <div class='table-cont' id='table-cont' style="width:100%;margin-left: 0px;float:left;" >
        <table class="table  table-bordered table-hover dataTables-example" id ="editable">
	        <thead>
		        <tr>
                    <th style ="background-color:black;color:white;text-align:left">No</th>
                    <th style ="background-color:black;color:white;text-align:left">Customer</th>
			        <th style ="background-color:black;color:white;text-align:left">ShipTO</th>
			        <th style ="background-color:black;color:white;text-align:left">CustomerPN</th>
			        <th style ="background-color:black;color:white;text-align:left">Part Rev</th>
                    <th style ="background-color:black;color:white;text-align:left">PartNO</th>
                    <th style ="background-color:black;color:white;text-align:left">PartName</th>
                    <th style ="background-color:black;color:white;text-align:left">DueDate</th>
                    <th style ="background-color:black;color:white;text-align:left">ShipDate</th>
			        <th style ="background-color:black;color:white;text-align:left">Quantity</th>
			        <th style ="background-color:black;color:white;text-align:left">OrderNO</th>
                    <th style ="background-color:black;color:white;text-align:left">LotNO</th>
                    <th style ="background-color:black;color:white;text-align:left">BatchNO</th>
                    <th style ="background-color:black;color:white;text-align:left">JobSequence</th>
                    <th style ="background-color:black;color:white;text-align:left">EDIKey</th>
                    <th style ="background-color:black;color:white;text-align:left">EDIAction</th>
			        <th style ="background-color:black;color:white;text-align:left">EDIStatus</th>
			        <th style ="background-color:black;color:white;text-align:left">Docname</th>
                    <th style ="background-color:black;color:white;text-align:left">StandardQty</th>
                    <th style ="background-color:black;color:white;text-align:left">Creator</th>
			        <th style ="background-color:black;color:white;text-align:left">CreateDate</th>
		        </tr>
	        </thead>
	        <tbody id ="tby" style="background-color:white"></tbody>
                                   
        </table>
    </div>
   		   

<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.12/xlsx.full.min.js"></script>
<script src="../../javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

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
                if (data.d != "") {
                 
                }
            }
        });
    }
    
</script>

</body>
</html>
