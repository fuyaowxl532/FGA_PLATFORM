<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyITAssets.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.MyITAssets" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>My IT Assets</title>

<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
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

#left{
  width: 15%;
  height:100%;
  background-color:azure;
  float: left;
}

#right{
  width: 85%;
  height:100%;
  margin-left:15.5%;
  background-color:floralwhite;
}

</style>

</head>
<body style="overflow: hidden;background-color:aqua">

    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Assets Managemant=> My IT Assets</div>

    <div style=" width: 100%;height:100%;">
          <!--Left Area-->
        <div id="left">

		    <div class="user-view" style="margin-left:25%;margin-top:50px;">
			    <div class="user-avatar">
				    <img title="" alt="" class="img-circle avatar" src="../../mouldifi-v-2.0/images/pic.png">
			    </div>
			    <div class="user-detail">
				    <p id="puser"></p>
				    <p id="pdept"></p>
			    </div>
		    </div>
        </div>
        <!--Right Area-->
        <div id="right">

            <!--Assets List-->
            <div id='table-cont' style ="width:100%">
                <table id ="editable"  class="table table-condensed" style ="width:100%">
	                <thead>
		                <tr>
                            <th style ="background-color:floralwhite;color:black;text-align:left">NO</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">Asset</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">IT_AssetNO</th>
						    <th style ="background-color:floralwhite;color:black;text-align:left">FIN_AssetNo</th>
						    <th style ="background-color:floralwhite;color:black;text-align:left">Issue_Date</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">Status</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">MacNo</th>   
                            <th style ="background-color:floralwhite;color:black;text-align:left">Note</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">AssetKey</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">Creator</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">CreateDate</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">UpdatedBy</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">UpdatedDate</th>
                            <th style ="background-color:floralwhite;color:black;text-align:left">Opt</th>
		                </tr>
	                </thead>
	                <tbody id ="tby" style="background-color:white; font-family:Arial, Helvetica, sans-serif""></tbody>
                                   
                </table>
        </div>

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
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script type="text/javascript">

    $(document).ready(function () {

        $.ajax({
            type: "Post",
            url: "MyITAssets.aspx/getUserInfo",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {


                $('#puser').html('<h5>'+data.d.substr(data.d.indexOf("@") + 1, data.d.indexOf("&") - data.d.indexOf("@") - 5)+'</h5>');
                $('#pdept').html(data.d.substr(data.d.indexOf("&") + 1));
            }
        });

        $.ajax({
            type: "Post",
            url: "MyITAssets.aspx/SearchData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {

                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        var issueDate;
                        var updatedate;

                        if (json[i].Issue_Date.indexOf("-") == 0)
                            issueDate = "";
                        else
                            issueDate = new Date(parseInt(json[i].Issue_Date)).toLocaleString();

                        if (json[i].UpdateDate.indexOf("-") == 0)
                            updatedate = "";
                        else
                            updatedate = new Date(parseInt(json[i].UpdateDate)).toLocaleString();
                        
                        slct = slct + '<tr>' +
                            '<td>' + (i + 1) + '</td> ' +
                            '<td>' + json[i].AssetName + '</td> ' +
                            '<td>' + json[i].IT_AssetNO + '</td> ' +
                            '<td>' + json[i].FIN_AssetNO + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                            '<td> ' + json[i].Status + '</td> ' +
                            '<td>' + json[i].MacAddress + '</td> ' +
                            '<td>' + json[i].Note + '</td> ' +
                            '<td>' + json[i].AssetKey + '</td> ' +
                            '<td>' + json[i].Creator + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                            '<td>' + json[i].UpdateBy + '</td> ' +
                            '<td>' + json[i].UpdateBy + '</td> ';

                        if (json[i].IsCheck == 1) {
                            slct = slct + '<td><button title="Scrap" class="btn btn-blue  btn-sm" type="button"  onclick="javascript:CheckAsset(\'' + json[i].AssetKey + '\',\'1\');"><i class="icon-check"></i></button></td></tr>';
                        }
                        else {
                            slct = slct + '<td><button title="Scrap" class="btn btn-red  btn-sm" type="button"  onclick="javascript:CheckAsset(\'' + json[i].AssetKey + '\',\'0\');"><i class="icon-check"></i></button></td></tr>';
                        }

                        
                    }
                    $("#tby").html(slct);

                }
                else {
                    $('#tby').html('<tr><td colspan="15">no data</td></tr>');
                }
            }
        });
    });

    function queryData() {
        $.ajax({
            type: "Post",
            url: "MyITAssets.aspx/SearchData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {

                if (data.d != "") {
                    var json = $.parseJSON(data.d);
                    var slct = "";
                    for (var i = 0; i < json.length; i++) {

                        var issueDate;
                        var updatedate;

                        if (json[i].Issue_Date.indexOf("-") == 0)
                            issueDate = "";
                        else
                            issueDate = new Date(parseInt(json[i].Issue_Date)).toLocaleString();

                        if (json[i].UpdateDate.indexOf("-") == 0)
                            updatedate = "";
                        else
                            updatedate = new Date(parseInt(json[i].UpdateDate)).toLocaleString();
                        
                        slct = slct + '<tr>' +
                            '<td>' + (i + 1) + '</td> ' +
                            '<td>' + json[i].AssetName + '</td> ' +
                            '<td>' + json[i].IT_AssetNO + '</td> ' +
                            '<td>' + json[i].FIN_AssetNO + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].Issue_Date)).toLocaleString() + '</td> ' +
                            '<td> ' + json[i].Status + '</td> ' +
                            '<td>' + json[i].MacAddress + '</td> ' +
                            '<td>' + json[i].Note + '</td> ' +
                            '<td>' + json[i].AssetKey + '</td> ' +
                            '<td>' + json[i].Creator + '</td> ' +
                            '<td>' + new Date(parseInt(json[i].CreateDate)).toLocaleString() + '</td> ' +
                            '<td>' + json[i].UpdateBy + '</td> ' +
                            '<td>' + json[i].UpdateBy + '</td> ';

                        if (json[i].IsCheck == 1) {
                            slct = slct + '<td><button title="Scrap" class="btn btn-blue  btn-sm" type="button"  onclick="javascript:CheckAsset(\'' + json[i].AssetKey + '\',\'1\');"><i class="icon-check"></i></button></td></tr>';
                        }
                        else {
                            slct = slct + '<td><button title="Scrap" class="btn btn-red  btn-sm" type="button"  onclick="javascript:CheckAsset(\'' + json[i].AssetKey + '\',\'0\');"><i class="icon-check"></i></button></td></tr>';
                        }

                        
                    }
                    $("#tby").html(slct);

                }
                else {
                    $('#tby').html('<tr><td colspan="15">no data</td></tr>');
                }
            }
        });
    }

    function CheckAsset(obj,isCheck) {

        // window.showDialog('Asset Policy', 'AssetPolicy.aspx', 1000, 600, function (res) {
        //            if (res == window.ST_OK) {

        //            }
        //});

        if (isCheck == '0') {
            $.ajax({
            type: "Post",
            url: "MyITAssets.aspx/checkassetInfo",
            data: "{assetKey:'" + obj + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {

                alert("success");
                queryData();
            }
            });
        }
        
    }

</script>

       
</body>
</html>
