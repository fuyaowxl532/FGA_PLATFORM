<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetCardDetail.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetCardDetailView" %>

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

<style type="text/css">
    .labelsty {

    }
</style>
</head>
<body style="background-color:lightskyblue">

<input type="hidden" id="hidPageSize" value='<%=_assetKey%>' />
<div class="panel panel-default">
     
				<div class="panel-heading clearfix">
					<h3 class="panel-title" id= "assetKey" style='margin-left: 360px; font-size: 25px; font-weight: bold'>Asset Key:</h3>
                  
				</div>
        
				<div class="panel-body" style="height:480px">
						<div class="form-group">
							<label for="Category">Category：</label>
                            <label class="labelsty" id="ctg"></label>
	                        <label for="assetmodel" style="margin-left: 200px">Asset Model：</label>
                            <label class="labelsty" id="assetname"></label>
						</div>

						<div class='form-group'>
							<label for="Fin_AssetNO" >FIN_AssetNO：</label>
                            <label class="labelsty" id="Fin_AssetNO"></label>
							<label for="IT_AssetNO" style="margin-left: 200px">IT_AssetNO：</label>
                              <label class="labelsty" id="IT_AssetNO"></label>
						</div>

						<div class='form-group'>
                            <label for="serial number">S/N：</label>
                            <label class="labelsty" id="serialno"></label>
							<label for="MACID"  style="margin-left: 200px">MAC ID：</label>
                             <label class="labelsty" id="MACID"></label>
						</div>

						<div class='form-group'>
                            <label for="InBoundDate">InBound Date：</label>
                            <label class="labelsty" id="date-popup"></label>
							<label for="Insur_Date"  style="margin-left: 200px">Insurance Date：</label>
                            <label class="labelsty" id="date-popup1"></label>
						</div>
						<div class='form-group'>
						    <label for="Creator" >Creator：</label>
                            <label class="labelsty" id="Creator"></label>
						    <label  style="margin-left: 200px">Create Date：</label>
                            <label class="labelsty" id="date-popup2"></label>
						</div>
                        <div style="margin-top:80px">
						    <div class='form-group'>
							    <label style="">Note</label>
						    </div>
						    <div>	
							    <textarea id = 'note' style="margin-top: -40px; margin-left: 95px;margin-bottom: 10px;width: 795px; height: 100px" placeholder="Input Notes"></textarea> 
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

        Search();

    });

    function Search() {
        var key = $('#hidPageSize').val();
        //var key = 100000;

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
                    $('#ctg').html(json[0].Category);
                    $('#assetname').html(json[0].AssetName);
                    $('#Fin_AssetNO').html(json[0].FIN_AssetNO);
                    $('#IT_AssetNO').html(json[0].IT_AssetNO);
                    $('#MACID').html(json[0].MacAddress);
                    $('#InBoundDate').html(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#date-popup1').html(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#serialno').html(json[0].SerialNO);
                    $('#Creator').html(json[0].Creator);
                    $('#date-popup2').html(new Date(parseInt(json[0].CreateDate)).toLocaleString());
                    $('#note').val(json[0].Note);
                }

            }
        });
    }


</script>
</body>
</html>
