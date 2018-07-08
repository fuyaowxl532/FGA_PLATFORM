<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainScreenCard.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.MainScreenCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Asset Detail</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme">
    <meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3">
    <link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
    <link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet">
    <link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet">
</head>
<body>

    <div id="_content">
        First Name:<input type="text" placeholder="input" id ="fn"/>*	<br/>
        Last  Name:<input type="text" placeholder="input" id ="ln"/>*	<br/>
        Department:<input type="text" placeholder="input" id ="department"/>*	<br/>
        Category*  :<select id="s1" style="width:120px" onchange="bindequipment();">
					</select>*	<br/>

        Equipment:<select id="s2" style="width:120px">
					</select>*	<br/>

        Accounting Asset NO*:<input type="text" placeholder="input" id="actno">*	<br/>
        IT Asset NO:<input type="text" placeholder="input" id="itno"/>* <br/>
        Serial NO:<input type="text" placeholder="input"  id="serialno"/>*	 <br/>
        Issue Date:<input type="text" placeholder="input" id ="issuedate"/>*	 <br/>
        IPAddress:<input type="text" placeholder="input"  id="ipads"/>	 <br/>
        MacAddress:<input type="text" placeholder="input" id="macads"/>	
    </div>

    <div id="_btn">
       <input type="button"  id ="_ok" value="OK" onclick="onSave()"/>
       <input  type="button"  id ="_cancel" value="Cancel"/>
    </div>

    <!--Load JQuery-->
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <!-- Input Mask-->
    <script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <!-- Select2-->
    <script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
    <!--Bootstrap ColorPicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!--Bootstrap DatePicker-->
    <script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

    <script  type="text/javascript">

        //绑定资产类别
        $(document).ready(function () {
            $.ajax({
                type: "Post",
                url: "ITAssetDetail.aspx/getAssetCategory",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                        var category = '<option></option>';
                        for (var i = 0; i < json.length; i++) {
                            category = category + '<option>' + json[i].value + '</option>';
                        }
                        $("#s1").html(category);
                    }
                }
            });
        });


        //绑定资产名称
        function bindequipment() {

            var category = $('#s1').val();
            $.ajax({
                type: "Post",
                url: "ITAssetDetail.aspx/getAssetName",
                data: "{category:'" + category + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    var equipment = '<option></option>';
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                       
                        for (var i = 0; i < json.length; i++) {
                            equipment = equipment + '<option>' + json[i].value + '</option>';
                        }
                    }

                    $("#s2").html(equipment);
                }
            });
        }

        //保存资产
        function onSave() {

            //获取界面信息
            var fn = $('#fn').val();
            var ln = $('#ln').val();
            var department = $('#department').val();
            var equipment = $('#s2').val();
            var ActAssetNO$=('#actno').val();
            var ITAssetNO = $('#itno').val();
            var SerialNO = $('#serialno').val();
            var IssueDate = $('#issuedate').val();
            var ipaddress = $('#ipads').val();
            var macaddress = $('#macads').val();

            var data = [];
            var row = {};

            row.USERNAME = $("#editable tr").eq(i).find("td").eq(2).find("input").val();
            row.ORGANIZATION = $("#editable tr").eq(i).find("td").eq(3).find("select").val();
            row.OPERATION = $("#editable tr").eq(i).find("td").eq(4).find("input").val();
            row.TRANSACTIONTYPE = $("#editable tr").eq(i).find("td").eq(5).find("select").val();
            row.Creater = t.rows[i].cells[6].innerHTML;
            row.CreateDate = t.rows[i].cells[7].innerHTML;

            data.push(row);

            var jsondata = JSON.stringify(data);
            $.ajax({
                type: "post",
                url: "ProcessUserCtrl.aspx/saveData",
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

    </script>
  
</body>
</html>
