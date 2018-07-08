<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARGBoxLabel_Property.aspx.cs" Inherits="FGA_PLATFORM.business.production.ARGBoxLabel_Property" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Packing Slip Parameters</title>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<!-- Site favicon -->
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>

<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>

   <div id =".content">

   </div>

   <div id =".property">
       	<label>Line/Shift:</label>
		<select id = "_banzu" ></select>

        <label>LoadQty:</label>
		<select id = "_qty" ></select>
       
   </div>

   <div id =".fun">
       <input type="button"  id ="_ok" value="OK" onclick="onOk()"/>
       <input  type="button"  id ="_cancel" value="Cancel" onclick="onCancel()"/>
   </div>

    <script type="text/javascript">

        //初始化班组及打印数量
        var banzu = '<option>Init</option>';
        var qty = '<option>1</option>';

        for (var i = 0; i < 8; i++) {
            banzu = banzu + '<option>' + (i + 1) + "A" + '</option>';
        }

        for (var i = 0; i < 8; i++) {
            banzu = banzu + '<option>' + (i + 1) + "B" + '</option>';
        }

        for (var i = 0; i < 50; i++) {
            qty = qty + '<option>' + (i + 1) + '</option>';
        }

        $('#_banzu').html(banzu);
        $('#_qty').html(qty);

        //OK
        function onOk() {
            window.parent.ymPrompt.doHandler(_banzu, true);
        }

        //Cancel
        function onOk() {
            window.parent.ymPrompt.doHandler("cancel", true);
        }

    </script>

</body>
</html>
