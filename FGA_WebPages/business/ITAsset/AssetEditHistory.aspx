<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetCardDetail.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetEditHistory" %>

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
						<table  id ="editable"  class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Change Date</th>
                                    <th>By</th>
                                    <th>Asset Key</th>
                                    <th>Asset</th>
                                    <th>Category</th>
                                    <th>Brand</th>
                                    <th>IT_AssetNO</th>
                                    <th>FIN_AssetNO</th>
                                    <th>SerialNO</th>
                                    <th>MacID</th>
                                    <th>Note</th>
                                    <th>Status</th>
                                    <th>AssetUser</th>
                                    <th>Issue_Date</th>
                                    <th>Return_Date</th>
                                    <th>LastAction</th>
                                </tr>
                            </thead>

                            <tbody id ="tby" style="background-color:white; font-family:Arial, Helvetica, sans-serif"">

                            </tbody>

                        </table>
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

        $.ajax({
            type: "post",
            url: "AssetEditHistory.aspx/Search",
            data: "{assetKey:'" + key + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    json = $.parseJSON(data.d);

                    $('#assetKey').html('Asset History for ' + key);
                    var slct;

                    for (var i = 0; i < json.length; i++) {

                        var updatedate;
                        var issuedate;
                        var returndate;

                        if (json[i].UpdateDate.indexOf("-") == 0)
                            updatedate = "";
                        else
                            updatedate = new Date(parseInt(json[i].UpdateDate)).toLocaleString();

                        if (json[i].Issue_Date.indexOf("-") == 0)
                            issuedate = "";
                        else
                            issuedate = new Date(parseInt(json[i].Issue_Date)).toLocaleString();

                        if (json[i].Return_Date.indexOf("-") == 0)
                            returndate = "";
                        else
                            returndate = new Date(parseInt(json[i].Return_Date)).toLocaleString();

                        if (i == 0) {
                            slct = slct + '<tr>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + updatedate + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + key + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Note + '</td> ' +
                                '<td>' + json[i].Status + '</td> ' +
                                '<td>' + json[i].AssetUser + '</td> ' +
                                '<td>' + issuedate + '</td> ' +
                                '<td>' + returndate + '</td> ' +
                                '<td>' + json[i].LastAction + '</td> ' +
                                '</tr>';
                        }
                        else {
                            var lid;
                            var rid;

                            if (json[i - 1].Issue_Date.indexOf("-") == 0)
                                lid = "";
                            else
                                lid = new Date(parseInt(json[i - 1].Issue_Date)).toLocaleString();

                            if (json[i - 1].Return_Date.indexOf("-") == 0)
                                rid = "";
                            else
                                rid = new Date(parseInt(json[i - 1].Return_Date)).toLocaleString();


                            slct = slct + '<tr>' +
                                '<td>' + (i + 1) + '</td> ' +
                                '<td>' + updatedate + '</td> ' +
                                '<td>' + json[i].UpdateBy + '</td> ' +
                                '<td>' + key + '</td> ' +
                                '<td>' + json[i].AssetName + '</td> ' +
                                '<td>' + json[i].Category + '</td> ' +
                                '<td>' + json[i].Brand + '</td> ' +
                                '<td>' + json[i].IT_AssetNO + '</td> ' +
                                '<td>' + json[i].FIN_AssetNO + '</td> ' +
                                '<td>' + json[i].SerialNO + '</td> ' +
                                '<td>' + json[i].MacAddress + '</td> ' +
                                '<td>' + json[i].Note + '</td> ';

                            if (json[i].Status == json[i - 1].Status) {
                                slct = slct + '<td>' + json[i].Status + '</td> ';
                            }
                            else {
                                slct = slct + '<td style ="color:red;font-weight:bold ">' + json[i].Status + '</td> ';
                            }
                            if (json[i].AssetUser == json[i - 1].AssetUser) {
                                slct = slct + '<td>' + json[i].AssetUser + '</td> ';
                            }
                            else {
                                slct = slct + '<td style ="color:red;font-weight:bold ">' + json[i].AssetUser + '</td> ';
                            }
                            if (lid == issuedate) {
                                slct = slct + '<td>' + issuedate + '</td> ';
                            }
                            else {
                                slct = slct + '<td style ="color:red;font-weight:bold ">' + issuedate + '</td> ';
                            }
                            if (rid == returndate) {
                                slct = slct + '<td>' + returndate + '</td> ';
                            }
                            else {
                                slct = slct + '<td style ="color:red;font-weight:bold ">' + returndate + '</td> ';
                            }
                            if (json[i].LastAction == json[i - 1].LastAction) {
                                slct = slct + '<td>' + json[i].LastAction + '</td></tr> ';
                            }
                            else {
                                slct = slct + '<td style ="color:red;font-weight:bold ">' + json[i].LastAction + '</td></tr> ';
                            }
                        }

                    }

                    $("#tby").html(slct);
                }

            }
        });
    }


</script>
</body>
</html>
