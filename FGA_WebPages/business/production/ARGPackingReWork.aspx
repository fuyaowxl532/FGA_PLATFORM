<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ARGPackingReWork.aspx.cs" Inherits="FGA_PLATFORM.business.production.ARGPackingReWork" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ARG Packing ReWork</title>
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

<script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
<embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
</object> 
</head>
<body>
      <div > 
         <h1 style="margin-left:310px;margin-top:10px"><b>ARG-Assembly Rework</b></h1><hr />
         </div>
    <div class="panel-body filter-wrapper col-lg-6" style="height:350px;width: 400px; margin-left:50px;"> 
			
            <div >
                <div style="margin-top:15px;margin-left:30px">
					<label style="font-size:25px; ">SerialNO:</label>
					<input type="text" id = "barcode" placeholder="input" style="color: black; height:30px;width:200px; font-size:27px" />
                </div>	
                    <p  style="font-size:20px;margin-left:30px; margin-top:25px">PatrNo:<label for="male" id ="pn" style="text-align:left;padding-left:55px;color:black;"></label></p>
             
                    <p style="font-size:20px;margin-left:30px; margin-top:15px;">OperationNo:<label for="male" id ="opn" style="text-align:left;padding-left:5px;color:black;"></label></p>
               
                    <p style="font-size:20px;margin-left:30px; margin-top:15px">Location:<label for="male" id ="loc" style="text-align:left;padding-left:40px;color:black;"></label></p>
                
                    <p style="font-size:20px;margin-left:30px; margin-top:15px">Quantity:<label for="male" id ="qty" style="text-align:left;padding-left:40px;color:black;"></label></p>
             
                    <p style="font-size:20px;margin-left:30px; margin-top:15px">Status:<label for="male" id ="stt" style="text-align:left;padding-left:60px;color:black;"></label></p>
               
							
			</div>
          		
	</div>  
        


    <div class="panel-body filter-wrapper col-lg-12" style="height:350px;width: 400px; margin-left:50px;"> 
			
            <div>
                    <p style="font-size:25px;margin-left:30px; margin-top:15px"><b>New Operation Code:<label style="color:black;margin-left:5px">1300</label></b></p>
                   
							<label style="margin-top: 10px; font-size:25px;margin-left:30px;" >New Location:</label>
                            
							<label style="color:black;margin-left:5px;font-size:25px;">F430</label>

                             <div style="margin-top:10px;margin-left:30px">
					            <label style="font-size:25px; ">New Quantity:</label>
					            <input type="text" id = "Text2" placeholder="input" style="color: black; height:30px;width:150px; font-size:27px" />
                             </div>   
                            <div class="checkbox-group" style="margin-left:30px;margin-top:15px">
						<div class="checkbox checkbox-replace">
							<input type="checkbox" id ="_oldck" name="oldck" value="ocheckbox"/>
							<label for="admin">Reprint Source Label</label>
						</div>
						<div class="checkbox checkbox-replace">
							<input type="checkbox" id ="_newck" name="newck" value="ncheckbox"/>
							<label for="operator">Print New Container Label</label>
						</div>
						
					</div>
                    <input type ="button" class="btn btn-primary btn-sm" onclick ="submit()" style="background:white;color:#00b8ce; height:50px;width:150px;margin-left:100px;margin-top:20px;font-size:35px"value="Submit"   />
			</div>
          		
	</div>  

       <!--   引入jQuery -->
  <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../../javascript/common.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            //加载DA
            $('#barcode').keydown(function (e) {
                var key = e.which;
                var serialno = $('#barcode').val();

                if (key == 13) {
                    $.ajax({
                        type: "Post",
                        url: "ARGPackingReWork.aspx/GetDAContainer",
                        data: "{serialno:'" + serialno + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d != "loc_error") {
                                    var json = $.parseJSON(data.d);

                                    document.getElementById('pn').innerHTML = json[0].PartNO;
                                    document.getElementById('opn').innerHTML = json[0].OperationNo;
                                    document.getElementById('loc').innerHTML = json[0].Location;
                                    document.getElementById('qty').innerHTML = json[0].Quantity;
                                    document.getElementById('stt').innerHTML = json[0].ContainerStatus;
                                }
                                else {
                                    alert("Aleady in warehouse! Can not rework");
                                }
                            }
                            else {
                            }
                        }
                    });
                }
            });
        });

        //提交
        function submit() {
            var oqty1 = document.getElementById('qty').innerHTML;
            var nqty1 = $('#Text2').val();
            var serialno = $('#barcode').val();
            var partno = document.getElementById('pn').innerHTML;
            var ck1 = $('#_oldck').is(':checked');
            var ck2 = $('#_newck').is(':checked');
            var loc = $('#sloc').val();
            var ope = document.getElementById('opn').innerHTML;
            var print;

                $.ajax({
                    type: "Post",
                    url: "ARGPackingReWork.aspx/CompareQty",
                    data: "{serialno:'" + serialno + "',partno:'" + partno + "',location:'" + loc + "',oqty:'" + oqty1 + "',nqty:'" + nqty1 + "',ck1:" + ck1 + ",ck2:" + ck2 + ",ope:'" + ope + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d != "qty_error") {
                                if (data.d != "ope_error") {
                                    var LODOP;
                                    var json = data.d;
                                    LODOP = getLodop();
                                    label_old = json.substr(json.indexOf("Old SerialNo") + 12);

                                    print = "ZDesigner ZT230-200dpi EPL_IT";

                                    LODOP.SET_PRINTER_INDEX(print);
                                    
                                    LODOP.SEND_PRINT_RAWDATA(label_old);

                                    alert("success");

                                    //清空DA号
                                    $('#barcode').focus();
                                    $('#barcode').val("");
                                }
                                else {
                                    alert("Please check the operation!")
                                }
                            }
                            else {
                                alert("Please input the quantity smaller than the existing quantity!");
                            }
                        }
                    }
                });

        }
        </script>
</body>
</html>
