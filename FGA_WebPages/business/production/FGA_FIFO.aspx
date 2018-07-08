<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FGA_FIFO.aspx.cs" Inherits="FGA_PLATFORM.business.production.FGA_FIFO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>FIFO</title>
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/plugins/datepicker/bootstrap-datepicker.css" rel="stylesheet"/>
<script src="../../javascript/jquery-1.11.1.min.js"></script>
    
</head>
<body>

    <div class ="panel " style="width:1000px;height: 50px;background-color: #00b8ce; ">
        <div style="padding-top:20px">
                <label id = "_lsn "  for= "org" >SerialNO:</label>
                <input type="text" id = "_sn" name ="serialno" onkeydown="return setSerialNO(event)" style="color: black" />

                <label id = "_lct"  for= "org" >Location:</label>
                <select id="sellocation" name="sltworkcenter">
                </select>

                <input class="  btn-default  " type="button"  name="remove"  value="Remove" onclick = "remove()" />
                <input class="  btn-default  " type="button"  name="sub"    value="Submit" onclick="transferToPLEX()" />
         </div>         
    </div>
        
            <div class="col-lg-10">
                    <div class="table-responsive">
                <table class="table table-bordered  table-striped " id="editable"> 
	               <thead>
		            <tr>
                        <th>*</th>
			            <th>No</th>
			            <th>SerialNO</th>
			            <th>PartNO</th>
			            <th>Location</th>
			            <th>Quantity</th>
			            <th>Status</th>
		            </tr>
	               </thead>
	               <tbody></tbody>
	            </table>
          </div>
                </div>

    	<script type="text/javascript" >

    	    var DAS = "";            //获取当前已存入数据库的DA"\'\'0\'\'";  
    	    var serialNO_R = "";     //获取界面已扫描的物料

    	    $(function () {
    	        InitLocation();
    	        InitSerialNO();

    	    })

    	    //根据用户初始化location
    	    function InitLocation() {
    	        var slct = "";
    	        $.ajax({
    	            type: "Post",
    	            url: "FGA_FIFO.aspx/InitLocation",
    	            data: "",
    	            contentType: "application/json; charset=utf-8",
    	            dataType: "json",
    	            async: false,
    	            success: function (data) {
    	                if (data.d != "") {

    	                    var json = $.parseJSON(data.d);
    	                    for (var i = 0; i < json.length; i++) {
    	                        slct += '<option value=' + json[i].Location + '>' + json[i].Location + '</option>';
    	                    }
    	                    $("#sellocation").html(slct);
    	                }
    	            }
    	        });
    	    }

    	    //获取当天已发料的SerialNO
    	    function InitSerialNO() {
    	        $.ajax({
    	            type: "Post",
    	            url: "FGA_FIFO.aspx/InitSerialNO",
    	            data: "",
    	            contentType: "application/json; charset=utf-8",
    	            dataType: "json",
    	            async: false,
    	            success: function (data) {
    	                if (data.d != "") {
    	                    DAS = data.d;
    	                }
    	            }
    	        });
    	    }

    	    //获取扫描到的DA信息
    	    function setSerialNO(event) {
    	        if (event.which == 13) {

    	            var sn = $('#_sn').val();
    	            var sns = sn + "*" + DAS + serialNO_R;
    	            if (serialNO_R.indexOf(sn) <= 0) {
    	                //赋值信息
    	                $.ajax({
    	                    type: "Post",
    	                    url: "FGA_FIFO.aspx/setSerialNO",
    	                    data: "{data:'" + sns + "'}",
    	                    contentType: "application/json; charset=utf-8",
    	                    dataType: "json",
    	                    async: false,
    	                    success: function (data) {
    	                        if (data.d != "") {

    	                            if (data.d.indexOf("0") == 0) {
    	                                alert("violating the FIFO principle!"+'\n'+data.d);
    	                            }
    	                            else {
    	                                var jdata = JSON.parse(data.d);
    	                                if (jdata.ContainerStatus == "OK") {
    	                                    var table = document.getElementById("editable");
    	                                    var nextIndex = table.rows.length;
    	                                    var nextRow = table.insertRow(nextIndex);
    	                                    nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
    	                                    nextRow.insertCell(1).innerHTML = nextIndex;
    	                                    nextRow.insertCell(2).innerHTML = jdata.SerialNO;
    	                                    nextRow.insertCell(3).innerHTML = jdata.PartNO;
    	                                    nextRow.insertCell(4).innerHTML = jdata.Location;
    	                                    nextRow.insertCell(5).innerHTML = jdata.Quantity;
    	                                    nextRow.insertCell(6).innerHTML = jdata.ContainerStatus;
    	                                }
    	                                else {
    	                                    alert("Status is wrong: " + jdata.ContainerStatus)
    	                                    $('#_sn').val("");
    	                                    $('#_sn').focus();
    	                                }
    	                            }
    	                          

    	                            //光标定位在SerialNO
    	                            $('#_sn').val("");
    	                            $('#_sn').focus();

    	                            //获取当前界面已扫面的DA号
    	                            //serialNO_R = serialNO_R + ',' + '\'' + '\'' + sn + '\'' + '\'';
    	                            serialNO_R = serialNO_R + sn;
    	                        }
    	                        else {
    	                            alert("SerialNO is wrong: " + sn);
    	                            $('#_sn').val("");
    	                            $('#_sn').focus();
    	                            return;
    	                        }
    	                    }
    	                });
    	            }
    	            else {
    	                $('#_sn').val("");
    	                $('#_sn').focus();
    	                return;
    	            }
    	        }
    	    }

    	    //数据提交
    	    function transferToPLEX() {
    	        if (confirm("Are you sure submit data?")) {
    	            var data = [];
    	            var t = document.getElementById("editable");
    	            var _loc = $("#sellocation").val();

    	            for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
    	                var row = {};
    	                row.SerialNO = t.rows[i].cells[2].innerHTML;
    	                row.Location = t.rows[i].cells[4].innerHTML;
    	                row.TLoc = _loc;
    	                data.push(row);
    	            }
    	            var jsondata = JSON.stringify(data);
    	            if (jsondata == "[]") {
    	                alert("There have not data to submit!");
    	                return;
    	            }
    	            else {
    	                $.ajax({
    	                    type: "post",
    	                    url: "FGA_FIFO.aspx/transferToPLEX",
    	                    data: "{data:'" + jsondata + "'}",
    	                    contentType: "application/json; charset=utf-8",
    	                    dataType: "json",
    	                    async: true,
    	                    success: function (data) {
    	                        if (data.d == "1") {
    	                            alert("success");
    	                            serialNO_R = "";
    	                            InitSerialNO();
    	                            //清空界面数据
    	                            $("#editable tr:not(:first)").remove();
    	                        }
    	                    }
    	                });
    	            }
    	        }
    	    }

    	    function remove() {
    	        var data = [];
    	        var table = document.getElementById("editable");
    	        var inputs = table.getElementsByTagName("input");
    	        var count = 0;

    	        for (var i = 0; i < inputs.length; i++) {
    	            var row = {};

    	            if (inputs[i].type == "checkbox") {
    	                if (inputs[i].checked && inputs[i].name == "cb1") {
    	                    var checkedRow = inputs[i];
    	                    var tr = checkedRow.parentNode.parentNode;
    	                    var tds = tr.cells;

    	                    //清除后需要将全局变量serialNO中的DA号清除
    	                    var csn = table.rows[tds[1].innerHTML - count].cells[2].innerHTML;
    	                    serialNO_R = serialNO_R.replace(csn, '');
    	                    $("#editable tr").eq(tds[1].innerHTML - count).remove();
    	                    count++;
    	                }
    	            }
    	        }

    	        //删除后重新赋值行号
    	        if (count > 0) {
    	            for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
    	                table.rows[i].cells[1].innerHTML = i;
    	            }
    	        }
    	    }

	</script> 
</body>
</html>
