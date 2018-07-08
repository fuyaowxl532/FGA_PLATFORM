<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisorLockOut.aspx.cs" Inherits="FGA_PLATFORM.business.production.SupervisorLockOut" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
    <link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
    <script src="../../javascript/common.js" type="text/javascript"></script>

     <script>
         function unlocked() {
             var psd = $('#psd').val().toUpperCase();
             if (psd == "SUPER123") {
                 window.parent.ymPrompt.doHandler('ok', true);
             }
             else {
                 alert("The password is incorrect!");
             }
         }
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Password:<input type="password" id="psd"  placeholder="input" size ="15"/>

        <input type="button"  id ="ok" value="unlock" onclick="unlocked()"/>
    </div>
    </form>

    <script type="text/javascript">
    $(function (){
        $('#psd').focus();
        $('#psd').keydown(function (e) {
            var curkey = e.which;
            if (curkey == 13)
            {
                unlocked();
            }
        });
    });
   </script>
</body>
</html>
