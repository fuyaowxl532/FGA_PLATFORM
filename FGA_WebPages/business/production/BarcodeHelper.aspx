<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BarcodeHelper.aspx.cs" Inherits="FGA_PLATFORM.business.production.BarcodeHelper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>BarcodeHelper</title>
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <script src="../../javascript/jquery-migrate-1.2.1.min.js"></script>
    <script src="../../javascript/jquery.jqprint-0.3.js"></script>
    <script src="../../javascript/jquery.qrcode.min.js"></script>
    <script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
    <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
    </object> 
</head>
<body>
    <div>
    </br>
    Tool_No:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" id ="TNo"/>
    &nbsp&nbsp&nbsp Shift_First_Character: &nbsp&nbsp&nbsp&nbsp&nbsp<input type="text" id ="SFC"/></br></br>
    Custmoer_Part:<input type="text" id ="CP"/>
    &nbsp&nbsp&nbsp Custmoer_Part_Revision:<input type="text" id ="CPR"/> </br></br></br></br></br>
    <input type="button" name="prtLabel" value="prtLabel" onclick="createLabel()"/>
    <input type="button" name="reset" value="reset" onclick="print()"/>

    <input type="button" name="pp" value="pp" onclick="printzpl()"/>
    </div>
    </p>
    </p>
    </p>
    <div id ="qrcode"></div>

    <script>
        function createLabel() {
            $("#qrcode").html("");
            var data = [];
            var row = {};
            row.ToolNO                  = $("#TNo").val();
            row.Shift_First_Charactor   = $("#SFC").val();
            row.Customer_Part           = $("#CP").val();
            row.Customer_Part_Revision  = $("#CPR").val();

            data.push(row);

            var jsondata = JSON.stringify(data);
            $.ajax({
                type: "post",
                url: "BarcodeHelper.aspx/crtLable",
                data: "{data:'" + jsondata + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                }
            });
        }
        function reset() {
            document.getElementById("TNo").value = "";
            document.getElementById("SFC").value = "";
            document.getElementById("CP").value = "";
            document.getElementById("CPR").value = "";
            $("#qrcode").jqprint();
        }

        function print() {
            $.ajax({
                type: "Post",
                url: "BarcodeHelper.aspx/GetDALabel",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {

                        var LODOP;
                        var _label;
                        LODOP = getLodop();
                        LODOP.SET_PRINTER_INDEX(-1);
                        LODOP.SEND_PRINT_RAWDATA(data.d);
                    }
                }
            });
           
        }

        function toUtf8(str) {    
            var out, i, len, c;    
            out = "";    
            len = str.length;
            for (i = 0; i < len; i++) {
                c = str.charCodeAt(i);
                if ((c >= 0x0001) && (c <= 0x007F)) {
                    out += str.charAt(i);
                } else if (c > 0x07FF) {
                    out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                    out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
                    out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                } else {
                    out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
                    out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
                }
            }
            return out;
        }

        function printzpl() {
            var LODOP;
            var zpl = "^XA^FO5,5^GB780,1170,3^FS" + //方框
                      "^FO195,5^GB0,1170,3^FS" +        //横线
                      "^FO395,5^GB0,1170,3^FS" +        //横线
                      "^FO595,5^GB0,1170,3^FS" +        //横线
                      "^FO95,470^A0B,50,50^FDDelivery Batch^FS" +        //固定文本(Delivey Batch)
                      "^FO292,900^A0B,45,45^FDHonda Lot:^FS" +           //固定文本(Honda Lot)
                      "^FO420,1070^A0B,20,20^FDBatch#(T)^FS" +           //固定文本(Batch#(T))
                      "^FO625,1039^A0B,20,20^FDLot#SPLR(1T)^FS" +        //固定文本(lOT#splr(1T))
                      "^FO292,150^A0B,40,40^FD"+"E31703011501"+"^FS^" +   //LOT NO
                      "^FO420,745^A0B,40,40^FD"+"373058"+"^FS^" +        //BATCH NO
                      "^FO625,700^A0B,40,40^FD"+"DA937028"+"^FS^" +      //DA NO
                      "^FO495,688^BCB,85,N,N,N^FD" + "T373058" + "^FS" +        //BATCH BARCODE
                      "^FO675,650^BCB,85,N,N,N^FD" + "1TDA937028" + "^FS" +     //DA BARCODE
                      "^XZ";

            LODOP = getLodop();
            LODOP.SET_PRINTER_INDEX(-1);
            LODOP.SEND_PRINT_RAWDATA(zpl);
        }


    </script>
</body>
</html>
