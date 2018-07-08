<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HondaInsequence.aspx.cs" Inherits="FGA_PLATFORM.business.production.HondaInsequence" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

     <script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
     <script type="text/javascript" language="javascript" src="../../javascript/LodopFuncs.js"></script>
     <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0"> 
     <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="../Lodop/install_lodop.exe"></embed>
     </object> 
      
    <script type="text/javascript">
        $(document).ready(function () {
            $("#prtML").mouseover(function () {
                $(".us").show("slow");
                $("#prtML").mouseout(function () {
                    $(".us").hide("slow");
                });
            });
        })
    </script>

    <style>

    .us{display:none;width:200px;height:40px;
            padding:5px;position:relative;top:0px;left:50px;
            background-color:yellow;}
    body{
        line-height: 25px;
    }

    #search-box,#Text1,#Text2,#Text5{
        font-size: 30px;
        padding: 0px;
        line-height: 3px;
    }

    #Text5{
        font-size: 20px;
        padding: 0px;
        line-height: 2px;
    }

    #Text3{
        font-size: 30px;
        padding: 0px;
        margin-left: 0px;
    }

    #input1{
        font-size: 10px;
        padding: 5px;
        line-height: 5px;
    }
    #load_id {
    background-color:red;
    height:100px;
    width:400px;
    padding:10px;
    margin-left: 0px;
    margin-bottom: 40px
	}

    #da_number {
    background-color:green;
    height:145px;
    width:600px;
    float:right;
    text-align:left;
    padding:10px; 
    margin-top: -220px;
	}


	#currtid {
    background-color:yellow;
    height:100px;
    width:400px;
    text-align:left;
    padding:10px; 
    margin-left: 0px;
    margin-top: -50px;
    margin-bottom: 30px;
	}

	#currtno {
    background-color:#FF00FF;
    height:200px;
    width:200px;
    text-align:left;
    font-size: 20px;
    padding:10px; 
    margin-left: 450px;
    margin-top: -160px;
	}

	#part_number {
    background-color:blue;
    height:200px;
    width:400px;
    padding:10px;
    margin-left: 0px;
    margin-bottom: 80px
    }


    #PartDetail {
    background-color:green;
    height:200px;
    width:600px;
    float:right;
    text-align:left;
    padding:10px; 
    margin-top: 100px;
	}

	#section {
    background-color:black;
    color:white;
    clear:both;
    text-align:center;
    padding:10px;
    margin-top: -50px;

	}

    #warning{
    background-color:lightblue;
    color:red;
    text-align:center;
    height:50px;
    width:500px;
    float:left;
    margin-left: 450px;
    margin-top: -130px;
    margin-bottom:20px;   
    font-size:20px;
    }
    
</style>
</head>
<body id ="bbb">

    <div id ="_head">
        <p id="P2"></p>
        <p id="P3"></p>
    </div>
    
	
	<div id="load_id">
		<h1>Load ID: <input type="text" id="search-box" placeholder="input" ondblclick="LoadID_HIS()"/></h1>
	</div>

	<div id="currtno">
		<h5>Current Position:</h5>	
        <div style="text-align:center">
            <input type="button" style="background-color:#FF00FF;width:200px;height:120px;font-size:120px;" id="txtAdd" onclick ="LoadPartList()"/>
        </div> 

	</div>

	<div id="da_number">
    	<h1>DA Number: <input type="text" id="Text1"  placeholder="input" /></h1>
        <h3>DA History:<br/><input type="text" style="width:530px;" id="Text5"  readonly="readonly"/></h3>
        <input type="checkbox" id = "cb1" />Reprint From Label
        <input type="button" id="prtML" value ="prtMasterLabel" onclick ="prtMasterLabel()"/>
        <div class="us">
            <h4>Print Master Label again!</h4>
        </div>
        
    </div>

    <div id="PartDetail">
         <div>
           <table border ="0" width="600" id="partlist">
	        <thead>
		        <tr>
			        <th>Customer_Part_No</th>
			        <th>PartNO</th>
			        <th>Quantity</th>
			        <th>Job_Sequence</th>
		        </tr>
	        </thead>
	        <tbody>
		
            </tbody>
	        </table>
          </div>
    </div>

	<div id="currtid">
        <div style="text-align:center">
            <h3>Total Qty:</h3>
             <p id="P1"></p>
        </div>
	</div>

	<div id="part_number">
    	<h1>Part Number: </h1>
        <h1><input type="text" id="Text2" readonly="readonly"/> </h1>
        Rev: <input type="text" id ="_rev" readonly="readonly" style="width:135px;"/> Quantity: <input type="text" id = "_qty" style ="width:100px;" readonly="readonly" />
       
       
	</div>

    <div id="warning">
        <label id="time"></label>
    </div>

    <div id="section">
    	<h1>Part Number:<input type="text" id="Text3"  placeholder="input" onkeydown="return t3kd(event)"/></h1>
    	<h1>Slot Position:<input type="text" id="Text4" placeholder="input"  onkeydown="return t4kd(event)"/></h1>
    </div>
   <!--   引入jQuery -->
    <script src="../../javascript/jquery-1.11.1.min.js"></script>
    <link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
    <script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
    <script src="../../javascript/common.js" type="text/javascript"></script>
    <script type="text/javascript">

        var tm;

        var clearFlag = 0;
        var count = 5;
        var showModal = function () {
            clearFlag = self.setInterval("autoClose()", 1000);//每过一秒调用一次autoClose方法

            $('#Text3').attr("readonly", "readonly");//设为只读
            $('#Text4').attr("readonly", "readonly");//设为只读

        }

        var autoClose = function () {
            if (count > 0) {
                $("#time").html(count + " seconds before next scan allowed");
                count--;
            } else if (count <= 0) {
                window.clearInterval(clearFlag);
                $("#time").html("");
                count = 5;
                $('#Text3').attr("readonly", false);//设为可编辑
                $('#Text4').attr("readonly", false);//设为可编辑
                $("#Text3").val("");
                $("#Text4").val("");
                $("#Text3").focus();
            }
        }

        function lock() {
            var i = true;
            //锁定后界面不能编辑
            $('#Text1').attr("readonly", "readonly");//设为只读
            $('#Text3').attr("readonly", "readonly");//设为只读
            $('#Text4').attr("readonly", "readonly");//设为只读
            tm = setInterval(function () {
                if (i) {
                    document.getElementById('bbb').style.background = "red";
                    i = !i;
                } else {
                    document.getElementById('bbb').style.background = "#FFF";
                    i = !i;
                }
            }, 500);
        }

        function unlocked() {

            ////跳出对话框Supervisor LockOut Required(审核用)
            ////密码：super123
            //window.parent.showDialog('Supervisor LockOut Required', 'business/production/SupervisorLockOut.aspx',300, 100, function (res) {
            //    if (res == window.ST_OK) {
            //        for (var i = 1; i <= tm; i++) {
            //            clearInterval(i);
            //        }

            //        document.body.style.backgroundColor = "#FFFFFF";//改变背景色  
            //        $('#P3').empty();
            //        $('#Text1').attr("readonly",false);//设为可编辑
            //        $('#Text3').attr("readonly",false);//设为可编辑
            //        $('#Text4').attr("readonly", false);//设为可编辑

            //        $('#Text3').val("");
            //        $('#Text4').val("");
            //        $('#Text3').focus();
            //    }
            //});

            for (var i = 1; i <= tm; i++) {
                clearInterval(i);
            }

            document.body.style.backgroundColor = "#FFFFFF";//改变背景色  
            $('#P3').empty();
            $('#Text1').attr("readonly", false);//设为可编辑
            $('#Text3').attr("readonly", false);//设为可编辑
            $('#Text4').attr("readonly", false);//设为可编辑
            $('#Text3').val("");
            $('#Text4').val("");
            $('#Text3').focus();

        }

        $(function () {
            $('input:text:first').focus();

            //加载DA Number的按钮事件
            $('#Text1').keyup(function (e) {
                var loadid = $('#search-box').val();
                var rev = $('#_rev').val();
                if (loadid == "" || loadid == null) {
                    alert("LoadID is Empty!");
                    $('#Text1').val("");
                    $('#search-box').focus();
                }
            });

            $('#Text1').keydown(function (e) {
                var key = e.which;
                var serialno = $('#Text1').val();
                var loadid = $('#search-box').val();
                var cpos = $('#txtAdd').val();
                if (key == 13) {
                    //验证当前DA是否已经用过
                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/ValidSerialNO",
                        data: "{serialno:'" + serialno + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d != "") {
                                alert("This DA has been created label,please reload other one!");
                                $('#Text1').val("");
                                $('#Text1').focus();
                                return;
                            }
                            else {
                                //验证DA对应的数量及顺序是否一致
                                $.ajax({
                                    type: "Post",
                                    url: "HondaInsequence.aspx/GetDAContainer",
                                    data: "{serialno:'" + serialno + "',loadid:'" + loadid + "',cpos:" + cpos + "}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    async: true,
                                    success: function (data) {
                                        if (data.d != "") {
                                            if (data.d == "qty_error") {
                                                alert("Unavailable quantity!");
                                                $('#Text1').val("");
                                                $('#Text1').focus();
                                            }
                                            if (data.d == "loc_error") {
                                                alert("Unavailable location!");
                                                $('#Text1').val("");
                                                $('#Text1').focus();
                                            }
                                            if (data.d != "qty_error" && data.d != "loc_error") {
                                                var json = $.parseJSON(data.d);
                                                $('#Text2').val(json[0].PartNO);
                                                var nserialno = json[0].SerialNO;
                                                $('#Text1').val(nserialno);

                                                if (serialno == nserialno) {
                                                    $("#cb1").prop("checked", false);
                                                }
                                                else {
                                                    $("#cb1").prop("checked", true);
                                                }

                                            }
                                        }
                                        else {
                                            alert("PartNO can't be matched!");
                                            $('#Text1').val("");
                                            $('#Text1').focus();
                                        }
                                    }
                                });

                                //加载当前position对应的REV及产品要货数量
                                $.ajax({
                                    type: "Post",
                                    url: "HondaInsequence.aspx/GetCustomerREV",
                                    data: "{loadid:'" + loadid + "',pos:'" + cpos + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    async: true,
                                    success: function (data) {
                                        if (data.d != "") {
                                            var revqty = data.d;
                                            $('#_rev').val(revqty.substr(0, revqty.indexOf("&")));
                                            $('#_qty').val(revqty.substr(revqty.indexOf("&") + 1));
                                        }
                                    }
                                });
                                $('#Text3').focus();
                            }
                        }
                    });
                }
            });

            ////加载LoadID
            //$('#search-box').dblclick(function () {

            //    window.showDialog('HondaLoadIDlist', 'HondaLoadIDlist.aspx', 850, 530, function (res) {
            //        $('#search-box').val(res);
            //    });
            //});
        });

        //加载LoadID
        function LoadID_HIS() {
            window.showDialog('HondaLoadIDlist', 'HondaLoadIDlist.aspx', 850, 530, function (res) {
                $('#search-box').val(res);
                //检查该LoadID是否有存档
                var ld = $('#search-box').val();
                if (ld != "" && ld !="close") {
                    //加载partlist
                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/GetLoadIDInfos",
                        data: "{loadid:'" + ld + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d != "") {
                                if (confirm("Loading history records?")) {
                                    var json = $.parseJSON(data.d);
                                    $('#Text1').val(json[0].SerialNO);                  //DA
                                    $('#Text5').val(json[0].SerialNO_HIS);              //DA_HIS
                                    $('#txtAdd').val(json[0].CurrPosition - 1);         //CurrPos 
                                    $('#P1').html('<h1>' + json[0].TotalPos + '</h1>'); //Total
                                    $('#Text2').val(json[0].PartNO);                    //PartNO
                                    $('#_rev').val(json[0].Rev);                        //Rev
                                    $('#_qty').val(json[0].Quantity - 1);               //Quantity
                                    $('#P2').html('<h2>CustomerName:' + json[0].CustomerName + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ShipTo:' + json[0].ShipTo + '</h2>');
                                    $('#P3').html(json[0].LockDesc);

                                    if (json[0].LockDesc != "" && json[0].LockDesc != null) {
                                        lock();
                                        $('#txtAdd').val(json[0].CurrPosition);             //CurrPos
                                        $('#_qty').val(json[0].Quantity);                   //Quantity

                                    }
                                    LoadPartList();
                                    $('#Text3').focus();
                                }
                            }
                        }
                    });
                }
            });

        }

        //加载partlist
        function LoadPartList() {

            var loadid = document.getElementById("search-box").value;
            var pos = document.getElementById("txtAdd").value;
            var errormsg = $('#P3').text();
            if (errormsg != "" && errormsg != null) {
                //解锁
                unlocked();
            }
            //加载partlist
            $.ajax({
                type: "Post",
                url: "HondaInsequence.aspx/GetPartList",
                data: "{loadid:'" + loadid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {
                        var json = $.parseJSON(data.d);
                        $("#partlist tr:not(:first)").remove();
                        for (var i = 0; i < json.length; i++) {
                            var table = document.getElementById("partlist");
                            var nextIndex = table.rows.length;
                            var nextRow = table.insertRow(nextIndex);
                            nextRow.insertCell(0).innerHTML = json[i].CustomerPart;
                            nextRow.insertCell(1).innerHTML = json[i].PartNO;
                            nextRow.insertCell(2).innerHTML = json[i].Quantity;
                            nextRow.insertCell(3).innerHTML = json[i].JobSequence;
                        }
                    }
                }
            });
        }

        //扫描modelcode事件
        function t3kd(e) {
            var key = e.which;
            if (key == 13) {
                var part1 = document.getElementById("Text2").value;       //当前DA对应的PartNO
                var modelcode = document.getElementById("Text3").value;   //扫描的MODELCODE
                var shipto = $("#P2").text();                             //扫描的MODELCODE
                var part2;
                if (part1 == "" || part1 == null) {
                    alert("Please Load DA Number!");
                    $('#Text3').val("");
                    $("#Text1").focus();
                    return;
                }

                $.ajax({
                    type: "Post",
                    url: "HondaInsequence.aspx/GetPartNO",
                    data: "{modelcode:'" + modelcode + "',shipto:'" + shipto.substr(shipto.indexOf("ShipTo:") + 7) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                            part2 = data.d;

                            if (part1 != part2) {
                                $('#P3').html("ModelCode can not be matched!");
                                $('#Text3').val("");
                                lock();
                            }
                            else {
                                $("#Text4").focus();
                            }
                        }
                        else {
                            $('#P3').html("ModelCode can not be matched!");//alert("ModelCode can not be matched!");
                            $('#Text3').val("");
                            lock();
                        }
                    }
                });
            }
        }

        //扫描position事件
        //每次扫描后保存当前页面信息，当整箱完成时，删除页面信息表，记录任务完成状态。
        function t4kd(e) {
            var key = e.which;
            if (key == 13) {
                var loadid = $('#search-box').val();
                var sn = $('#Text1').val();
                var snhistory = $('#Text5').val();
                var tqty = $('#P1').text();
                var part1 = document.getElementById("Text2").value;
                var part2 = document.getElementById("Text3").value;
                var pos = document.getElementById("Text4").value;
                var cp = document.getElementById("txtAdd").value;
                var cqty = document.getElementById("_qty").value;
                var rev = $('#_rev').val();
                var cust = $('#P2').text();
                var shipto = $('#P2').text();
                var errormsg = $('#P3').text();
                var pn = $('#Text3').val();
                if (pn == "" || pn == null) {
                    alert("Part Number is empty!");
                    $("#Text4").val("");
                    $("#Text3").focus();
                    return;
                }

                ////加载单片玻璃时间间隔
                ////Honda提出
                //if ((cp - 1) != "0" && cp == pos && (cp != "" || pos != "") && (cqty - 1) !=0)
                //{
                //    showModal();
                //}

                $("#Text3").val("");
                $("#Text4").val("");
                $("#Text3").focus();

                //扣减
                //总顺序倒序扣减&单品种倒序扣减
                var cpnext;
                var cqtynext;
                //保存当前界面的数据
                var data = [];
                var row = {};

                if (cp == pos && (cp != "" || pos != "")) {

                    row.LoadID = loadid;
                    row.SerialNO = sn;
                    row.SerialNO_HIS = snhistory;
                    row.CurrPosition = cp;
                    row.TotalPos = tqty;
                    row.PartNO = part1;
                    row.Rev = rev;
                    row.Quantity = cqty;
                    row.CustomerName = 'Honda North America';
                    row.ShipTo = shipto;
                    row.LockFlag = 'N';
                    row.LockDesc = errormsg;

                    data.push(row);

                    var jsondata = JSON.stringify(data);
                    $.ajax({
                        type: "post",
                        url: "HondaInsequence.aspx/SaveScanRecord",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == "1") {
                                cpnext = cp - 1;
                                $("#txtAdd").val(cpnext);

                                cqtynext = cqty - 1;
                                $("#_qty").val(cqtynext);
                            }
                        }
                    });
                }
                else {
                    $('#P3').html("POSITION IS WRONG!");//alert("position is wrong!")
                    lock();

                    //扫描错误保存当前界面信息
                    row.LoadID = loadid;
                    row.SerialNO = sn;
                    row.SerialNO_HIS = snhistory;
                    row.CurrPosition = cp;
                    row.TotalPos = tqty;
                    row.PartNO = part1;
                    row.Rev = rev;
                    row.Quantity = cqty;
                    row.CustomerName = 'Honda North America';
                    row.ShipTo = shipto;
                    row.LockFlag = 'Y';
                    row.LockDesc = $('#P3').text();

                    data.push(row);
                    var jsondata = JSON.stringify(data);
                    $.ajax({
                        type: "post",
                        url: "HondaInsequence.aspx/SaveScanRecord",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d == "1") {
                            }
                        }
                    });
                }

                //自动打印当前DA标签
                var label;
                var label_old;
                var user;
                var print;
                var loadid;
                if (cqtynext == 0) {

                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/CreateDALabel",
                        data: "{serialno:'" + sn + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,             //Modify by IT-WXL 05/12/2017
                        success: function (data) {
                            if (data.d != "") {

                                //按照登录名获取打印机名称
                                //前档----ZDesigner_HONDA_SORT_FRONT
                                //边窗----ZDesigner_SmallLot_Side
                                //后档----ZDesigner_HONDA_SORT_REAR
                                var LODOP;
                                var json = data.d;
                                label = json.substr(5, json.indexOf("oldsn") - 5);
                                label_old = json.substr(json.indexOf("oldsn") + 5, json.indexOf("username") - json.indexOf("oldsn") - 5);
                                user = json.substr(json.indexOf("username") + 8);
                                LODOP = getLodop();
                                if (user.indexOf("Honda") > -1) {
                                    if (user == "Honda_front") {
                                        print = "ZDesigner_HONDA_SORT_FRONT";
                                    }
                                    if (user == "Honda_side") {
                                        print = "ZDesigner_SmallLot_Side";
                                    }
                                    if (user == "Honda_rear") {
                                        print = "ZDesigner_HONDA_SORT_REAR";
                                    }
                                    LODOP.SET_PRINTER_INDEXA(print);
                                }
                                else {
                                    //LODOP.SET_PRINTER_INDEX(-1);
                                    LODOP.SET_PRINTER_INDEXA("ZDesigner ZT230-200dpi EPL_IT");
                                }

                                var pold = $("#cb1").is(":checked")

                                if (label != "") {
                                    LODOP.SEND_PRINT_RAWDATA(label);
                                }
                                if (pold && label_old != "") {
                                    LODOP.SEND_PRINT_RAWDATA(label_old);
                                }

                            }
                        }
                    });

                    //当前打印完的标签存入表[FGA_SL_DAHISTORY]
                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/SaveDALabel",
                        data: "{loadid:'" + loadid + "',serialno:'" + sn + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,             //Modify by IT-WXL 05/12/2017
                        success: function (data) {
                            if (data.d != "") {
                            }
                        }
                    });

                    //当前标签打印完，记录在DAHistory
                    $("#Text5").val(sn + "/" + snhistory);
                    $("#Text1").val("");
                    $("#Text2").val("");
                    $("#_rev").val("");
                    $("#_qty").val("");
                    $("#Text4").val("");
                    $("#Text3").val("");
                    $("#Text1").focus();
                }

                //获取master label上面的DA号
                //自动打印整箱标签
                //修改EDI_LOAD完成标志
                if (cpnext == 0) {
                    //自动打印整箱标签
                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/Get_LBNO",
                        data: "{loadid:'" + loadid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,             //Modify by IT-WXL 05/12/2017
                        success: function (data) {
                            if (data.d != "") {

                                //按照登录名获取打印机名称
                                //前档----ZDesigner_HONDA_SORT_FRONT
                                //边窗----ZDesigner_SmallLot_Side
                                //后档----ZDesigner_HONDA_SORT_REAR
                                var LODOP;
                                var json = data.d;
                                LODOP = getLodop();
                                if (user == "Honda_front") {
                                    print = "ZDesigner_HONDA_SORT_FRONT";
                                    LODOP.SET_PRINTER_INDEXA(print);
                                }
                                if (user == "Honda_side") {
                                    print = "ZDesigner_SmallLot_Side";
                                    LODOP.SET_PRINTER_INDEXA(print);
                                }
                                if (user == "Honda_rear") {
                                    print = "ZDesigner_HONDA_SORT_REAR";
                                    LODOP.SET_PRINTER_INDEXA(print);
                                }
                                if (user == "administrator") {
                                    //LODOP.SET_PRINTER_INDEX(-1);
                                    LODOP.SET_PRINTER_INDEXA("ZDesigner ZT230-200dpi EPL_IT");
                                }

                                var TL = "^XA^FO5,5^GB780,1170,3^FS" + //方框
                                    "^FO195,5^GB0,1170,3^FS" +        //横线
                                    "^FO395,5^GB0,1170,3^FS" +        //横线
                                    "^FO595,5^GB0,1170,3^FS" +        //横线
                                    "^FO95,470^A0B,50,50^FDDelivery Batch^FS" +        //固定文本(Delivey Batch)
                                    "^FO292,900^A0B,45,45^FDHonda Lot:^FS" +           //固定文本(Honda Lot)
                                    "^FO420,1070^A0B,20,20^FDBatch#(T)^FS" +           //固定文本(Batch#(T))
                                    "^FO625,1039^A0B,20,20^FDLot#SPLR(1T)^FS" +        //固定文本(lOT#splr(1T))
                                    "^FO292,150^A0B,40,40^FD" + json.substr(0, json.indexOf("&")) + "^FS" +         //LOT NO
                                    "^FO420,745^A0B,40,40^FD" + json.substr(json.indexOf("&") + 1, json.indexOf("*") - json.indexOf("&") - 1) + "^FS" +           //BATCH NO
                                    "^FO625,700^A0B,40,40^FD" + json.substr(json.indexOf("*") + 1) + "^FS" +                                                 //DA NO
                                    "^FO495,688^BCB,85,N,N,N^FDT" + json.substr(json.indexOf("&") + 1, json.indexOf("*") - json.indexOf("&") - 1) + "^FS" +    //BATCH BARCODE
                                    "^FO675,650^BCB,85,N,N,N^FD1T" + json.substr(json.indexOf("*") + 1) + "^FS" +                                            //DA BARCODE
                                    "^XZ";


                                LODOP.SEND_PRINT_RAWDATA(TL);
                                LODOP.SEND_PRINT_RAWDATA(TL);

                            }
                        }
                    });

                    //修改EDI_LOAD完成标志,清楚DA History记录
                    $.ajax({
                        type: "Post",
                        url: "HondaInsequence.aspx/UpdateLoadStatus",
                        data: "{loadid:'" + loadid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {

                                $("#Text5").val("");
                            }
                        }
                    });

                }
            }
        }

        function prtMasterLabel() {
            var cp = document.getElementById("txtAdd").value;
            var loadid = $('#search-box').val();
            var user;
            if (cp == "0") {
                //获取当前登录名
                $.ajax({
                    type: "Post",
                    url: "HondaInsequence.aspx/getUsername",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            user = data.d;
                        }
                    }
                });

                //自动打印整箱标签
                $.ajax({
                    type: "Post",
                    url: "HondaInsequence.aspx/Get_LBNO",
                    data: "{loadid:'" + loadid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {

                            //按照登录名获取打印机名称
                            //前档----ZDesigner_HONDA_SORT_FRONT
                            //边窗----ZDesigner_SmallLot_Side
                            //后档----ZDesigner_HONDA_SORT_REAR
                            var LODOP;
                            var json = data.d;
                            LODOP = getLodop();
                            if (user == "Honda_front") {
                                print = "ZDesigner_HONDA_SORT_FRONT";
                                LODOP.SET_PRINTER_INDEXA(print);
                            }
                            if (user == "Honda_side") {
                                print = "ZDesigner_SmallLot_Side";
                                LODOP.SET_PRINTER_INDEXA(print);
                            }
                            if (user == "Honda_rear") {
                                print = "ZDesigner_HONDA_SORT_REAR";
                                LODOP.SET_PRINTER_INDEXA(print);
                            }
                            if (user == "administrator") {
                                //LODOP.SET_PRINTER_INDEX(-1);
                                LODOP.SET_PRINTER_INDEXA("ZDesigner ZT230-200dpi EPL_IT");
                            }

                            var TL = "^XA^FO5,5^GB780,1170,3^FS" + //方框
                                "^FO195,5^GB0,1170,3^FS" +        //横线
                                "^FO395,5^GB0,1170,3^FS" +        //横线
                                "^FO595,5^GB0,1170,3^FS" +        //横线
                                "^FO95,470^A0B,50,50^FDDelivery Batch^FS" +        //固定文本(Delivey Batch)
                                "^FO292,900^A0B,45,45^FDHonda Lot:^FS" +           //固定文本(Honda Lot)
                                "^FO420,1070^A0B,20,20^FDBatch#(T)^FS" +           //固定文本(Batch#(T))
                                "^FO625,1039^A0B,20,20^FDLot#SPLR(1T)^FS" +        //固定文本(lOT#splr(1T))
                                "^FO292,150^A0B,40,40^FD" + json.substr(0, json.indexOf("&")) + "^FS" +         //LOT NO
                                "^FO420,745^A0B,40,40^FD" + json.substr(json.indexOf("&") + 1, json.indexOf("*") - json.indexOf("&") - 1) + "^FS" +           //BATCH NO
                                "^FO625,700^A0B,40,40^FD" + json.substr(json.indexOf("*") + 1) + "^FS" +                                                      //DA NO
                                "^FO495,688^BCB,85,N,N,N^FDT" + json.substr(json.indexOf("&") + 1, json.indexOf("*") - json.indexOf("&") - 1) + "^FS" +       //BATCH BARCODE
                                "^FO675,650^BCB,85,N,N,N^FD1T" + json.substr(json.indexOf("*") + 1) + "^FS" +                                                 //DA BARCODE
                                "^XZ";


                            LODOP.SEND_PRINT_RAWDATA(TL);
                            LODOP.SEND_PRINT_RAWDATA(TL);

                        }
                    }
                });
            }
            else {
                alert("Please load glass first!");
            }

        }
    </script>
</body>
</html>
