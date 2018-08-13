<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetCardDetail.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetCardDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Asset Card Detail</title>

<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/colorpicker/bootstrap-colorpicker.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/nouislider/nouislider.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet" />
</head>
<body style="background-color:limegreen">

<input type="hidden" id="hidPageSize" value='<%=_assetKey%>' />
<div class="panel panel-default">
     
				<div class="panel-heading clearfix">
					<h3 class="panel-title" id= "assetKey" style='margin-left: 360px; font-size: 25px; font-weight: bold'>Asset Key:</h3>
                  
				</div>
        
				<div class="panel-body" style="height:480px">
						<div class="form-group">
							<label for="Category">Category</label>
							<select id = "ctg" style="width:250px; margin-left: 30px" onchange ="onSelectModel()"></select>
	                        <label for="assetmodel" style="margin-left: 200px">Asset Model</label>
							<select id = "assetname" style="width:250px; margin-left: 30px"></select>
						</div>

						<div class='form-group'>
							<label for="Fin_AssetNO" >FIN_AssetNO</label>
							<input type="text"  id="Fin_AssetNO" style='width:250px; margin-left: 9px '/>
							<label for="IT_AssetNO" style="margin-left: 200px">IT_AssetNO</label>
							<input type="text"  id="IT_AssetNO"  style='width:250px; margin-left: 9px '/>
						</div>

						<div class='form-group'>
                            <label for="serial number">S/N</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
							<input type="text"  id="serialno" style='width:250px; margin-left: 35px'/>
							<label for="MACID"  style="margin-left: 200px">MAC ID</label>
							<input type="text"  id="MACID" style='width:250px; margin-left: 50px '/>
						</div>

						<div class='form-group'>
                            <label for="InBoundDate">InBoundDate</label>
							<input id='date-popup' type="text"  data-format="D, dd MM yyyy" style='width:250px; margin-left: 7px '/>
							<span  style="width: 10px; margin-left: 10px"></span> 
							<label for="Insur_Date"  style="margin-left: 200px">Insurance Date</label>
							<input id='date-popup1'  type="text" data-format="D, dd MM yyyy" style='width:250px; margin-left: 3px '/>
							<span  style="width: 10px; margin-left: 10px"></span>
						</div>
							<div class='form-group'>
							<label for="Creator" >Creator</label>
							<input type="text"  id="Creator" style='width:250px; margin-left: 47px '/>
							<label  style="margin-left: 200px">Create Date</label>
							<input id='date-popup2'  type="text" data-format="D, dd MM yyyy" style='width:250px; margin-left: 17px '/>
							<span  style="width: 10px; margin-left: 10px"></span>
							</div>
						<div class='form-group'>
							<label style="">Note</label></div>
						<div>	
							<textarea id = "note" style="margin-top: -40px; margin-left: 95px;margin-bottom: 10px;width: 795px; height: 80px"></textarea> 
						</div>
							  
				        <button type="submit" class="btn btn-primary" onclick="update()"><i class="glyphicon glyphicon-floppy-disk"></i></button>
                        <span id="success" style="background-color:yellow"></span>
				</div>
</div>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/bootstrap.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/metismenu/jquery.metisMenu.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery-ui.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/blockui-master/jquery.blockUI.js"></script>
<!--nouiSlider-->
<script src="../../mouldifi-v-2.0/js/plugins/nouislider/nouislider.min.js"></script>
<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

<script  type="text/javascript">
    $(document).ready(function () {

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

        $(".select2").select2();
        $(".select2-placeholer").select2({
            allowClear: true
        });

        //Load Category,Model
        $.ajax({
            type: "post",
            url: "AssetCardDetail.aspx/LoadCategory",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct;
                    json = $.parseJSON(json);
                    for (var i = 0; i < json.length; i++) {

                        ct = ct + '<option>' + json[i].Category + '</option>';
                    }

                    $('#ctg').html(ct);
                }
            }
        });

        //Load Category,Model
        $.ajax({
            type: "post",
            url: "AssetCardDetail.aspx/LoadAssetModel",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct;
                    json = $.parseJSON(json);
                    for (var i = 0; i < json.length; i++) {

                        ct = ct + '<option>' + json[i].CateModel + '</option>';
                    }

                    $('#assetname').html(ct);
                }
            }
        });

        Search();

    });

    function Search() {
        var key = $('#hidPageSize').val();

        $.ajax({
            type: "post",
            url: "AssetCardDetail.aspx/Search",
            data: "{assetKey:'" + key + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    json = $.parseJSON(json);
                    $('#assetKey').html('Asset Key:' + json[0].AssetKey);
                    $("#ctg").find("option:contains('" + json[0].Category + "')").attr("selected", true);
                    $("#assetname").find("option:contains('" + json[0].AssetName + "')").attr("selected", true);
                    $('#Fin_AssetNO').val(json[0].FIN_AssetNO);
                    $('#IT_AssetNO').val(json[0].IT_AssetNO);
                    $('#MACID').val(json[0].MacAddress);
                    $('#InBoundDate').val(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#date-popup1').val(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#serialno').val(json[0].SerialNO);
                    $('#Creator').val(json[0].Creator);
                    $('#date-popup2').val(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#note').val(json[0].Note);
                }

            }
        });
    }
    var clearFlag = 0;
    var count     = 1;
    var showModal = function () {
        clearFlag = self.setInterval("autoClose()", 1000);//每过一秒调用一次autoClose方法
    }
    var autoClose = function () {
        if (count > 0) {
            $("#time").html(count + " seconds before next scan allowed");
            count--;
        } else if (count <= 0) {
            window.clearInterval(clearFlag);
            $('#success').hide();
        }
    }

    function update() {
        var key = $('#hidPageSize').val();
        var row = {};
        row.AssetName = $('#assetname').val();
        row.Category = $('#ctg').val();
        row.Brand = $('#brand').val();
        row.IT_AssetNO = $('#IT_AssetNO').val();
        row.FIN_AssetNO = $('#Fin_AssetNO').val();
        row.MacAddress = $('#MACID').val();
        row.InBoundDate = $('#InBoundDate').val();
        row.Note = $('#note').val();
        row.SerialNO = $('#serialno').val();

        var jsondata = JSON.stringify(row);

        $.ajax({
            type: "post",
            url: "AssetCardDetail.aspx/UpdateAssetCard",
            data: "{assetKey:'" + key + "',data:'" + jsondata + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json == "1") {
                      $('#success').html("Update Successsfully!");
                      $('#success').show();
                      showModal();
                }

            }
        });
    }

    function onSelectModel() {

        var category = $('#ctg  option:selected').val();

        //设置Asset Model值列表
        //Load Category,Model
        $.ajax({
            type: "post",
            url: "AssetCardDetail.aspx/changeModelList",
            data: "{category:'" + category + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct;
                    json = $.parseJSON(json);
                    for (var i = 0; i < json.length; i++) {

                        ct = ct + '<option>' + json[i].CateModel + '</option>';
                    }

                    $('#assetname').html(ct);
                }
            }
        });
    }

</script>
</body>
</html>
