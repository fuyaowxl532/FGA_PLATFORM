<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDICtrlCenter.aspx.cs" Inherits="FGA_PLATFORM.business.production.EDICtrlCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>EDI Control Center</title>
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<!-- /site favicon -->

<!-- Entypo font stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<!-- /entypo font stylesheet -->

<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->

<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<!-- /bootstrap stylesheet min version -->     

<!-- Mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<!-- /mouldifi core stylesheet -->
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  

</head>
<body>
      <input type="button"  name="export" style="background:white;color:#00b8ce" value="RELEASE" onclick=" releaseData()" />		   

<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>

<script src="../../javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

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
