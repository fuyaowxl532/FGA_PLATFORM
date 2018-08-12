<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobStatusUpdate.aspx.cs" Inherits="FGA_PLATFORM.business.production.JobStatusUpdate" %>

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
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> Job Manager=> JobStatusUpdate</div>
    <div class="row" style="margin-top:2px">
		 <div class="col-lg-8">
			 <div class="form-inline">
				<a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:13px;height:30px">IMPORT
                <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
                <button class="btn btn-primary btn-sm" id ="btnSearch"  style="height:30px" onclick ="SearchData()">Search</button>
                <button class="btn btn-primary btn-sm" id ="btnExe" style="height:30px" onclick ="ExecuteData()">Execute</button>

                <img style="display:none" id ="imgId"src="../../images/loading.gif" alt="" />
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
                    <th style ="background-color:black;color:white;text-align:left">JobNO</th>
                    <th style ="background-color:black;color:white;text-align:left">JobStatus</th>
                    <th style ="background-color:black;color:white;text-align:left">Creator</th>
			        <th style ="background-color:black;color:white;text-align:left">CreateDate</th>
                    <th style ="background-color:black;color:white;text-align:left">CompletedDate</th>
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

    $(document).ready(function () {
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
                        url: "JobStatusUpdate.aspx/saveDataImport",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d == "1") {
                                alert("Successfully imported");
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

        $.ajax({
            type: "Post",
            url: "JobStatusUpdate.aspx/SearchData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                           var cdate =""
                           if (json[i].CompletedDate.indexOf("-") == 0)
                                cdate = "";
                           else
                                cdate = new Date(parseInt(json[i].CompletedDate)).toLocaleString();

                            slct = slct + '<tr>' +
                                '<td> ' + (i+1) + '</td> ' +
                                '<td> ' + json[i].JobNO + '</td> ' +
                                '<td> ' + json[i].JobStatus + '</td> ' +
                                '<td> ' + json[i].Creator + '</td> ' +
                                '<td> ' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                                '<td> ' + cdate + '</td> ' +
                                '</tr>';
                        }
                    }

                    $("#tby").html(slct);
                }
        });

    }

    //合并EDI数据
    function ExecuteData() {

        $('#imgId').show();

        $.ajax({
            type: "Post",
            url: "JobStatusUpdate.aspx/updateStatus",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                    SearchData();
                 }

                 $('#imgId').hide();
            }
        });
    }
    
</script>

</body>
</html>

