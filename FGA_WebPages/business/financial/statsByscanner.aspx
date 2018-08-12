<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="statsByscanner.aspx.cs" Inherits="FGA_PLATFORM.business.financial.statsByscanner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>FGA_Cycle_Inventory</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
<link href="../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<!-- /font awesome stylesheet -->
<!-- Bootstrap stylesheet min version -->
<link href="../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet" />
<link href="../../css/style.css" rel="stylesheet" />
<!--弹消息窗样式-->
<link href="../../javascript/ymPrompt/skin/qq/ymPrompt.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="../../javascript/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />
<!-- jquery脚本库 -->
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<!--验证-->
<script src="../../javascript/ValidationCheck.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

 <style type="text/css">

.table-cont{
  max-height: 85%;
  overflow: auto;
  background: #ddd;
  margin: 2px 2px;
  box-shadow: 0 0 1px 1px #ddd;
}
thead{
  background-color: #ddd;
}
 
td{  
  text-overflow: ellipsis;  
  overflow: hidden;  
}
#btn {
     margin-top:8px;
     top:30px;
}
#locdetail {
    border-style:groove;
    border-color:lightgoldenrodyellow;
    background-color:lightgoldenrodyellow;
    width:100%;
    font-weight:bold;
    margin-top:8px;
}
.labelsty {
    color:red;
}

</style>

</head>
<body  id ="bbb" style="overflow: hidden;">
    <input type="hidden" id="hidPageSize" value='<%=pcycleno%>' />
  
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Financial=> Cycle Inventory</div>
    
    <div id="btn">
        <input type="button" id = "crt" value="Create" onclick="onCreate()" class="btn btn-blue btn-sm"  />
        <input type="button" id = "save" value="SAVE" onclick="updateData()" class="btn btn-blue btn-sm"  />
	    <input type="button" id ="stp" value="Synchronize to Plex" onclick="SynToPlex()" class="btn btn-blue btn-sm"/>
        <input type="button" id ="export" value="Export" onclick="onExport()" class="btn btn-blue btn-sm"/>
	    <input type="button" id="clear" value="Clear" onclick = "clr()" class="btn btn-blue btn-sm"/>
        <input type="button" id="chLoc" value="Change Location" onclick = "changeLoc()" class="btn btn-red btn-sm"/>

        <input type="button" id = "ulock" style="float:right;display:none" value="Unlock" onclick = "unlock()" class="btn btn-blue btn-sm"/>

        <img style="display:none" id ="imgId"src="../../images/loading.gif" alt="" />
    </div> 

    <!--Location detail information-->
    <div id="locdetail" >
        Cycle NO:<label class="labelsty" id="cn"></label>
        Cycle Loc:<label class="labelsty" id="loc"></label>
        Cycle Status:<label class="labelsty"  id="cs"></label>
        Start By:<label class="labelsty"  id="sby"></label>
        Start Date:<label class="labelsty"  id="sd"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Total Records:&nbsp;&nbsp;<label class="labelsty"  id="trcd"></label>
    </div>
  
    <div class='table-cont'  id='table-cont' style="width:100%;margin-left: 0px;" >
	    <table id="editable" class="table  table-bordered table-hover dataTables-example"> 
	        <thead>
		    <tr>
			   <%-- <th style ="background-color:black;color:white;text-align:left">
                    <input type="checkbox"  checked = "checked" onclick="onSelect(this.checked)" />
			    </th>--%>
                <th style ="background-color:black;color:white;text-align:left">Row</th>
			    <th style ="background-color:black;color:white;text-align:left">SerialNO</th>
			    <th style ="background-color:black;color:white;text-align:left">PartNO</th>
                <th style ="background-color:black;color:white;text-align:left">PartName</th>
                <th style ="background-color:black;color:white;text-align:left">Operation</th>
			    <th style ="background-color:black;color:white;text-align:left">Location</th>
			    <th style ="background-color:black;color:white;text-align:left">Quantity</th>
			    <th style ="background-color:black;color:white;text-align:left">ActualQuantity</th>
                <th style ="background-color:black;color:white;text-align:left">Opt</th>
		    </tr>
	        </thead>
	        <tbody id="tby"   style="background-color:white"></tbody>
	    </table>
    </div>
  

<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="http://oss.sheetjs.com/js-xlsx/xlsx.full.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script type="text/javascript" >

    var tm;
    var audio = document.createElement("audio");
    var count;

    //定时与服务器通信 10min
    window.setInterval(showalert, 600000);   
    function showalert()   
    {   
        $.ajax({
                    type: "post",
                    url: "statsByscanner.aspx/checkConnect",
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                        }
                        else
                              alert("Internal Server Error"+'\n'+"Please login again!");
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                          alert("Internal Server Error"+'\n'+"Please login again!");
                    }
                });   
    }  

    var isSave = "1";
    $(document).ready(function () {

        $("#save").attr("disabled", "true");
        var cn = $('#hidPageSize').val();
        if (cn != "") {
            onSet(cn);
        }
    });

    window.onload = function(){
        var tableCont = document.querySelector('#table-cont')
        /**
        * scroll handle
        * @param {event} e -- scroll event
        */
        function scrollHandle (e){
        console.log(this)
        var scrollTop = this.scrollTop;
        this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
        }

        tableCont.addEventListener('scroll',scrollHandle)
    }

    var serialNO = null;

    function onCreate() {

        window.parent.showDialog('select a cycle location', 'business/financial/SelectLocation.aspx', 400, 600, function (res) {
            if (res != "" && res != "close") {
                count = 0;
                //新增CycleNO
                $.ajax({
                    type: "post",
                    url: "statsByscanner.aspx/createCycleNO",
                    data: "{location:'" + res.trim() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {

                            var json = $.parseJSON(data.d);
                            var mydate = new Date();

                            $('#cn').html(json[0].CycleNO);
                            $('#cs').html("In Process");
                            $('#loc').html(res.trim());
                            $('#sby').html(json[0].StartBy);
                            $('#sd').html(mydate.toLocaleString());
                            $('#trcd').html("0");
                        }
                        else
                            alert("fail");
                    }
                });

                inRow();

                //按钮失效
                $("#crt").attr("disabled", "true");
            }
        });
    }

    function changeLoc() {

        var trcd = $('#trcd').html().trim();
        if (trcd != "") { 
                window.parent.showDialog('select a cycle location', 'business/financial/SelectLocation.aspx', 400, 600, function (res) {
                if (res != "" && res != "close") {
                    var CycleNO = $('#cn').html().trim();
                    var loc = res.trim();
                    if (trcd == "0") {

                         $('#loc').html(loc);
                    }
                    else {
                        $.ajax({
                            type: "post",
                            url: "statsByscanner.aspx/ChangeLoc",
                            data: "{CycleNO:'" + CycleNO + "',Location:'" + loc + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            success: function (data) {
                                if (data.d == "1") {
                                    $('#loc').html(loc);
                                }
                                else
                                    alert("fail");
                            }
                        });
                    }
                }
            });
        }
    }

	function inRow() {
	     
	    var slct = $("#tby").html();
	    var table = document.getElementById("editable");
        var curindex = document.getElementById("editable").rows.length;

        //<td><input type="checkbox" checked = "checked" name = "cb1" /></td>
	    slct = slct + '<tr>' +
                        '<td> ' + curindex + '</td> ' +
                        '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;"><input type = "text" autofocus = "autofocus" onkeydown = "setDetailAndRow(event)" style = "width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;" /></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;" onkeyup = "setSaveStatus(this)"><input type="text" onclick = "c1(this)"  style="width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;"/></td> ' +
                        '<td><button class="btn btn-default" type="button" onclick="del(this)"> <i class="icon-trash"></i> </button></td>' +
            '</tr>';

	    $("#tby").html(slct);

	    $("#editable tr").last().find("td").eq(1).find("input").focus();
	}
	   
    function c1(obj) {

	    obj.style.backgroundColor = 'yellow'; //把点到的那一行变希望的颜色;
	    serialNOtr = $("#editable tr").eq(obj.parentNode.parentNode.rowIndex).find("td").eq(1).find("input").val();
	}

	function setDetailAndRow(event)
    {
        //界面记录不超过200
        if (event.which == 13) {

            if (count <= 200) {
                var table = document.getElementById("editable");
                var curindex = document.getElementById("editable").rows.length;
                var sn = $('#editable tr:last').find('td').eq(1).find('input').val();
                //界面DA不重复
                $.ajax({
                    type: "post",
                    url: "statsByscanner.aspx/validate",
                    data: "{sn:'" + sn + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        var json = data.d;
                        if (json != '') {

                            json = $.parseJSON(json);
                            var str = "CycleNO: " + json[0].CycleNO + '\n' +
                                "Cycle Loc: " + json[0].Location + '\n' +
                                "StartBy: " + json[0].Creator + '\n' +
                                "CreateDate: " + new Date(parseInt(json[0].Createtime)).toLocaleString()
                                ;
                            alert("This SerialNO has been scanned by: " + '\n' + str);
                            table.deleteRow(curindex - 1);
                            //新增一行
                            inRow();
                        }
                        else {
                            getDataBySerialNO();
                        }
                    }

                });
            }
            else {
                alert("Over 200 records on current page！"+'\n'+"Please synchronize to plex then create new one.");
            }
          
	    }
	}

	function getDataBySerialNO() {
	      
	    var table = document.getElementById("editable");
	    var curindex = document.getElementById("editable").rows.length;
        var sn = $('#editable tr:last').find('td').eq(1).find('input').val();
        var CycleNO = $('#cn').html().trim();
        var tloc = $('#loc').html().trim();
	       
	    $.ajax({
	        type: "Post",
	        url: "statsByscanner.aspx/getDataBySerialNO",
	        data: "{data:'" + sn + "',CycleNO:'" + CycleNO + "',targetLoc:'" + tloc + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: false,
	        success: function (data) {
                if (data.d != "") {

                    var json = $.parseJSON(data.d);
                    if (json.PartNO != "" && json.PartNO != null) {
                        table.rows[curindex - 1].cells[1].innerHTML = sn;
                        table.rows[curindex - 1].cells[2].innerHTML = json.PartNO;
                        table.rows[curindex - 1].cells[3].innerHTML = json.PartName;
                        table.rows[curindex - 1].cells[4].innerHTML = json.OperationCode;
                        table.rows[curindex - 1].cells[5].innerHTML = json.Location;
                        table.rows[curindex - 1].cells[6].innerHTML = json.Quantity;

                        //新增一行
                        inRow();
                        //自动保存
                        //saveData();
                        serialNO = serialNO + sn;
                        count = count +1;

                        $('#trcd').html(count);
                    }
                    else {
                         //错误锁定界面
                        lock();
                        
                        audio.src = "alarm.mp3";
                        audio.play();
                        $('#ulock').show();
                        table.rows[curindex - 1].cells[1].innerHTML = sn;
                    }
	            }
	            else {
	                alert("Saved failure");
	                table.deleteRow(curindex - 1);
	                //新增一行
                    inRow();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                  alert("Internal Server Error"+'\n'+"Please login again!");
            }

	    });
	     
	}

	//扫描后自动保存数据
    //禁用，直接在获取Container信息时保存
    //update by IT-WXL 20180503
    function saveData() {

        var CycleNO = $('#cn').html().trim();
        var tloc    = $('#loc').html().trim();
        var data = [];
	    var t       = document.getElementById("editable");
	    var trseq   = document.getElementById("editable").rows.length;

	    var row = {};
	    var aq = null;
	    row.SerialNO = t.rows[trseq - 2].cells[1].innerHTML;
        row.PartNO = t.rows[trseq - 2].cells[2].innerHTML;
        row.PartName = t.rows[trseq - 2].cells[3].innerHTML;
        row.OperationCode =  t.rows[trseq - 2].cells[4].innerHTML;
        row.Location = t.rows[trseq - 2].cells[5].innerHTML;
        row.TargetLocation =tloc ;
	    row.Quantity = t.rows[trseq - 2].cells[6].innerHTML;
	    aq = $("#editable tr").eq(trseq - 2).find("td").eq(7).find("input").val();

	    row.ActualQty = (aq == "" ? row.Quantity : aq);

	    if (row.SerialNO != "" && row.PartNO != "" && row.Quantity != "")
	        data.push(row);
	    else
	        return;

	    var jsondata = JSON.stringify(data);
	    $.ajax({
	        type: "post",
	        url: "statsByscanner.aspx/SaveData",
	        data: "{data:'" + jsondata + "',CycleNO:'" + CycleNO + "'}",
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        async: true,
	        success: function (data) {
	            if (data.d == "1") {
	            }
	            else
                    alert("save fail");
                    t.deleteRow(trseq - 1);
	                //新增一行
                    inRow();
	        }
	    });
    }

	//同步到Plex
    //界面数据全部同步
    function SynToPlex() {

        if (isSave == "1") {
            var loc = $('#loc').html().trim();
            var submit = "These containers will be moved to " + loc;
            //Submit confirm
            if (confirm(submit)) {

            var CycleNO = $('#cn').html().trim();

            var t = document.getElementById("editable");
            var trseq = document.getElementById("editable").rows.length;

            if (trseq > 1) {

                var data = [];

                for (var i = 1; i < trseq - 1; i++) {

                    var row = {};
                    row.serialNO = t.rows[i].cells[1].innerHTML;
                    row.PartNO   = t.rows[i].cells[2].innerHTML;
                    row.Location = "FGA-INV";
                    row.Quantity = t.rows[i].cells[6].innerHTML;
                    var aq = $("#editable tr").eq(i).find("td").eq(7).find("input").val();
                    if (aq == "") {
                        row.ActualQty = t.rows[i].cells[6].innerHTML;
                    }
                    else {
                        row.ActualQty =  parseFloat(aq).toString();
                    }

                    if (row.PartNO != "") {
                        data.push(row);
                    }

                }

                if (data.length > 0) {

                    $('#imgId').show();
                    var jsondata = JSON.stringify(data);
                    $.ajax({
                        type: "post",
                        url: "statsByscanner.aspx/SynToPlex",
                        data: "{data:'" + jsondata + "',toloc:'" + loc + "',CycleNO:'" + CycleNO + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d != "" && data.d != "loc error") {
                                alert(data.d);
                                //同步成功
                                $('#imgId').hide();
                                $("#editable tr:not(:first)").remove();
                                jQuery("#crt").removeAttr("disabled");
                                $('#cs').html("Completed");
                                count = 0;
                            }
                        }
                    });
                }
                else {
                    alert("You have not select record!");
                }
            }
            else {
                alert("no data!");
            }
            }
        }
        else {
            alert("Please save actual quantity before send data to plex!");
        }
	}

	//界面实际数保存
	function updateData() {
	    var data = [];
	    var t = document.getElementById("editable");
        var CycleNO = $('#cn').html().trim();

	    for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
	        var row = {};
	        var aq = $("#editable tr").eq(i).find("td").eq(7).find("input").val();
	        row.PartNO = t.rows[i].cells[2].innerHTML;
	        if (aq != "" && row.PartNO !="")
            {
                row.CycleNO  = CycleNO;
	            row.SerialNO = t.rows[i].cells[1].innerHTML;
	            row.ActualQty =  parseFloat(aq).toString();

	            data.push(row);
	        } 
        }
        if (data.length > 0) {
            var jsondata = JSON.stringify(data);
	        $.ajax({
	            type: "post",
	            url: "statsByscanner.aspx/updateData",
	            data: "{data:'" + jsondata + "'}",
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            async: true,
	            success: function (data) {
	                if (data.d == "1") {
                        alert("success");
                        $("#save").attr("disabled", "true");
	                }
	                else
	                    alert("fail");
	            },
                error: function (jqXHR, textStatus, errorThrown) {
                      alert("Internal Server Error"+'\n'+"Please login again!");
                }
	        });
        }

        isSave = "1";
	}

    //编辑当前实际数行
    function setSaveStatus(obj) {

        isSave = "0";
        jQuery("#save").removeAttr("disabled");

        var currTd = $(obj); 
        var tdtext = currTd.html(); 
        var vl = $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(7).find("input").val();

        if (vl != "") {

            var aa = parseFloat(vl).toString();

            if (aa == "NaN") {
                alert("Not a valid number!")
                $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(7).find("input").attr("value", "");
            }
            else {
                 $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(7).find("input").attr("value", aa);
            }
        }
    }

    //初始化
    function onSet(cn) {

        isSave = "1";
        //按钮失效
        $("#crt").attr("disabled", "true");

        //CycleInventory_H
        $.ajax({
            type: "post",
            url: "statsByscanner.aspx/SearchHead",
            data:  "{cycleno:'" + cn + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    json = $.parseJSON(json);

                    $('#cn').html(json[0].CycleNO);
                    $('#cs').html("In Process");
                    $('#loc').html(json[0].Location);
                    $('#sby').html(json[0].StartBy);
                    $('#sd').html(new Date(parseInt(json[0].StartDate)).toLocaleString());
                }

            }
        });
        //CycleInventory_Detail
        $.ajax({
            type: "post",
            url: "statsByscanner.aspx/SearchDetail",
            data:  "{cycleno:'" + cn + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                var json = data.d;
                if (json != '') {
                    json = $.parseJSON(json);
                    var slct = "";
                    count = json.length;
                    $('#trcd').html(json.length);
	                for (var i = 0; i < json.length; i++) {

                        //<td><input type="checkbox" checked = "checked" name = "cb1" /></td>
                        slct = slct + '<tr>' +
                            '<td>' + (i+1) + '</td> ' +
                            '<td>' + json[i].SerialNO + '</td> ' +
                            '<td>' + json[i].PartNO + '</td> ' +
                            '<td>' + json[i].PartName + '</td> ' +
                            '<td>' + json[i].OperationCode + '</td> ' +
                            '<td>' + json[i].Location + '</td> ' +
                            '<td>' + json[i].Quantity + '</td> ' +
                            '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;"  onkeyup = "setSaveStatus(this)" ><input type="text" onclick = "c1(this)" value = ' + json[i].ActualQty + ' style="width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;"/></td>' +
                            '<td><button class="btn btn-default" type="button" onclick="del(this)"> <i class="icon-trash"></i> </button></td>' +
                            '</tr>';
                    }

                    //<td><input type="checkbox" checked = "checked" name = "cb1" /></td>
                    slct = slct + '<tr>' +
                    '<td>' + (json.length + 1) + '</td> ' +
                    '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;" onkeydown = "setDetailAndRow(event)"><input type = "text" autofocus = "autofocus" style = "width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;" /></td> ' +
                    '<td></td> ' +
                    '<td></td> ' +
                    '<td></td> ' +
                    '<td></td> ' +
                    '<td></td> ' +
                    '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;" onkeyup = "setSaveStatus(this)" ><input type="text" onclick = "c1(this)"  style="width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;"/></td> ' +
                    '<td><button class="btn btn-default" type="button" onclick="del(this)"> <i class="icon-trash"></i> </button></td>' +
                        '</tr>';

                     $("#tby").html(slct);
                }
            }
        });
        
    }

	function del(obj) {
        javascript: alert('Do you want to delete this record?');
        var table = document.getElementById("editable");
        var cn = $('#cn').html().trim();
        var sn = table.rows[obj.parentNode.parentNode.rowIndex].cells[1].innerHTML;
        var pn = table.rows[obj.parentNode.parentNode.rowIndex].cells[2].innerHTML;

        //set dr =1
        $.ajax({
            type: "post",
            url: "statsByscanner.aspx/delRecord",
            data:  "{cycleno:'" + cn + "',serialno:'" + sn + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function (data) {
                var json = data.d;
                if (json == "1") {

                    table.deleteRow(obj.parentNode.parentNode.rowIndex);
                    //在后台将该CycleNO下面的DA号禁用
                    $("#editable tr").last().find("td").eq(1).find("input").focus();

                    if(count > 1 && pn !="")
                        count = count - 1;

                    $('#trcd').html(count);
                }
            }
        });
	}

    //导出
    function onExport() {

        $('#editable').tableExport({ type: 'excel', tableName: 'Cycle Inventory', escape: 'false' })
    }

    function lock() {

        var i = true;
        //界面按钮失效
        $("#del").attr("disabled", "true");
        $("#stp").attr("disabled", "true");
        $("#export").attr("disabled", "true");
        $("#clear").attr("disabled", "true");

        tm = setInterval(function () {
            if (i) {
                document.getElementById('locdetail').style.background = "red";
                i = !i;
            } else {
                document.getElementById('locdetail').style.background = "#FFF";
                i = !i;
            }
        }, 500);
    }

    function unlock() {

        audio.pause();
        for (var i = 1; i <= tm; i++) {
            clearInterval(i);
        }

        document.getElementById('locdetail').style.background = "lightgoldenrodyellow";
        $("#del").removeAttr("disabled");
        $("#stp").removeAttr("disabled");
        $("#export").removeAttr("disabled");
        $("#clear").removeAttr("disabled");
        $("#ulock").hide();

        inRow();
    }

    ////全选，反选
    //function onSelect(status) {
    //    $("input[name='cb1']").each(function(i,n){
    //        n.checked = status;
    //    });
    //}

    //清空界面数据
    function clr() {

        if (confirm("")) {
                $("#editable tr:not(:first)").remove();
                jQuery("#crt").removeAttr("disabled");
                count = 0;
        } 
	}

	//在关闭页面时弹出确认提示窗口
	$(window).bind('beforeunload', function () {
	    return 'Changes you made may not be saved';
	});

	</script> 
	</body>
</html>
