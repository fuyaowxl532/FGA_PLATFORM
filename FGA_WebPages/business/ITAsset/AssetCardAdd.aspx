<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetCardAdd.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetCardAdd" %>

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

<style>
    #success{display:none;width:500px;height:40px;
    padding:5px;position:relative;top:0px;left:50px;
    background-color:yellow;}
</style>

</head>
<body  style="overflow: hidden;">

<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading clearfix">
						 <button title ="Back" class="btn btn-blue" id ="btnBack"    onclick ="backToCard()">Back</button>
					</div>
					<div class="panel-body">
						 <form class="form-horizontal">
						 	<div class="form-group"> 
							 	<label class="col-sm-2 control-label">Category</label> 
								<div class="col-sm-10"> 
									<select class="form-control" id ="ctg" onchange ="onSelectModel()"> 
									
									</select>
								</div> 
							</div>
							<div class="line-dashed"></div>
                            <div class="form-group">
							<label class="col-sm-2 control-label">Asset Model</label>
                            <div class="col-sm-10">
								<select class="form-control" id="assetname"  onchange ="onDisplayInfos()"> 
								</select>
								<span class="help-block m-b-none" id="brand"></span>
                            </div>
                             </div>
                            <div class="form-group"> 
							<label class="col-sm-2 control-label">Configuration Infos</label> 
							<div class="col-sm-10"> 
								<input type="text" id ="cinfos" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
							<div class="line-dashed"></div>
                            <div class="form-group"> 
							<label class="col-sm-2 control-label">IT_AssetNO</label> 
							<div class="col-sm-10"> 
								<input type="text" id = "IT_AssetNO" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
                            <div class="form-group"> 
							<label class="col-sm-2 control-label">FIN_AssetNO</label> 
							<div class="col-sm-10"> 
								<input type="text" id = "Fin_AssetNO" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
							<div class="line-dashed"></div>
                            <div class="form-group"> 
							<label class="col-sm-2 control-label">S/N</label> 
							<div class="col-sm-10"> 
								<input type="text"  id = "sn" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
							<div class="line-dashed"></div>                            <div class="form-group"> 
							<label class="col-sm-2 control-label">MAC ID</label> 
							<div class="col-sm-10"> 
								<input type="text"  id = "macid" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
							<div class="line-dashed"></div>                            <div class="form-group"> 
							<label class="col-sm-2 control-label">Insurance Date</label> 
							<div class="col-sm-10"> 
								<input type="text" placeholder="Placeholder" class="form-control"/> 
							</div> 
							</div>
							<div class="line-dashed"></div>                            <div class="form-group"> 
							<label class="col-sm-2 control-label">Note</label> 
							<div class="col-sm-10"> 
								<textarea placeholder="Textarea"  id = "note" class="form-control"></textarea> 
							</div> 
							</div>
							<div class="line-dashed"></div>
						</form>
                        <div class="col-sm-offset-2 col-sm-10"> 
							<button class="btn btn-default" id="btnadd" onclick="Save()">Add</button> 
                            <span id="success"></span>
						</div> 
					</div>
				</div>
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
            url: "AssetCardAdd.aspx/LoadCategory",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct = '<option></option>';
                    json = $.parseJSON(json);

                    for (var i = 0; i < json.length; i++) {

                        ct = ct + '<option>' + json[i].Category + '</option>';
                    }

                    $('#ctg').html(ct);
                }
            }
        });

    });

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

    function Save() {
        var row = {};
        row.AssetName = $('#assetname').val();
        row.Category = $('#ctg').val();
        row.Brand = $('#brand').html();
        row.IT_AssetNO = $('#IT_AssetNO').val();
        row.FIN_AssetNO = $('#Fin_AssetNO').val();
        row.MacAddress = $('#macid').val();
        row.AssetConfig = $('#cinfos').val();
        row.SerialNO = $('#sn').val();
        row.Note = $('#note').val();


        var jsondata = JSON.stringify(row);

        $.ajax({
            type: "post",
            url: "AssetCardAdd.aspx/addAssetCard",
            data: "{data:'" + jsondata + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '0') {

                    $('#success').html("Successsful!Asset Key: " + json);
                    $('#success').show();
                    showModal();
                }
            }
        });
    }

    function backToCard() {
        location.href = "AssetsCard.aspx";
    }

    function onSelectModel() {

        var category = $('#ctg  option:selected').val();

        //设置Asset Model值列表
        //Load Category,Model
        $.ajax({
            type: "post",
            url: "AssetCardAdd.aspx/changeModelList",
            data: "{category:'" + category + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct = '<option></option>';
                    json = $.parseJSON(json);
                    for (var i = 0; i < json.length; i++) {

                        ct = ct + '<option>' + json[i].CateModel + '</option>';
                    }

                    $('#assetname').html(ct);
                }
            }
        });
    }

    function onDisplayInfos() {

        var cateModel = $('#assetname  option:selected').val();
        //设置Brand,Configuration
        $.ajax({
            type: "post",
            url: "AssetCardAdd.aspx/displayAssetInfos",
            data: "{cateModel:'" + cateModel + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    var ct;
                    json = $.parseJSON(json);

                    $('#brand').html(json[0].Brand);
                    $('#cinfos').val(json[0].AssetConfig);
                }
            }
        });
    }
</script>
</body>
</html>
