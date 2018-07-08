<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FGA_PartTransfer.aspx.cs" Inherits="FGA_PLATFORM.business.production.FGA_PartTransfer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>FGA_PartTransfer</title>
<link href="../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../css/style/mystyle.css" rel="stylesheet" />
<!-- Font awesome stylesheet -->
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
  
    <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> Inter-Plant Transfer=> Inter-Plant Shipper</div>
    
    <div id="btn">
        <input type="button" id = "crt" value="Create" onclick="onCreate()" class="btn btn-blue btn-sm"  />
        <input type="button" id = "save" value="SAVE" onclick="updateData()" class="btn btn-blue btn-sm"  />
	    <input type="button" id ="stp" value="Sumbit" onclick="onSumbit()" class="btn btn-blue btn-sm"/>
    </div> 

    <!--Location detail information-->
    <div id="locdetail" >
        Shipper NO:<label class="labelsty" id="sn"></label>
        From Location:<label class="labelsty" id="floc"></label>
        To Location:<label class="labelsty"  id="tloc"></label>
        Status:<label class="labelsty"  id="cs"></label>
        Start By:<label class="labelsty"  id="sby"></label>
        Start Date:<label class="labelsty"  id="sd"></label>
    </div>
  
    <div class='table-cont'  id='table-cont' style="width:100%;margin-left: 0px;" >
	    <table id="editable" class="table  table-bordered table-hover dataTables-example"> 
	        <thead>
		    <tr>
			    <th style ="background-color:black;color:white;text-align:left">
                    <input type="checkbox"  checked = "checked" onclick="onSelect(this.checked)" />
			    </th>
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

    //var tm;
    //var audio = document.createElement("audio");
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

            count = 0;
            //新增CycleNO
            $.ajax({
                type: "post",
                url: "FGA_PartTransfer.aspx/createShipperNO",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d != "") {

                        alert(data.d);
                        //var json = $.parseJSON(data.d);
                        //var mydate = new Date();

                        //$('#cn').html(json[0].CycleNO);
                        //$('#cs').html("In Process");
                        //$('#loc').html(res.trim());
                        //$('#sby').html(json[0].StartBy);
                        //$('#sd').html(mydate.toLocaleString());
                    }
                    else
                        alert("fail");
                }
            });

            //inRow();

            ////按钮失效
            //$("#crt").attr("disabled", "true");
    }

	function inRow() {
	     
	    var slct = $("#tby").html();
	    var table = document.getElementById("editable");
        var curindex = document.getElementById("editable").rows.length;

	    slct = slct + '<tr><td><input type="checkbox" checked = "checked" name = "cb1" /></td>' +
                        '<td> ' + curindex + '</td> ' +
                        '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;"><input type = "text" autofocus = "autofocus" onkeydown = "setDetailAndRow(event)" style = "width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;" /></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td></td> ' +
                        '<td style="margin:0px;padding:0px;border:1px inset #ABABAB;" onkeyup = "setSaveStatus(this)"><input type="text" onclick = "c1(this)"  style="width:100%;height:100%;padding:1px 3px 1px 3px; border:none;margin:0px;"/></td> ' +
                        '<td><button title="Remove" class="btn btn-red btn-outline" type="button"  onclick="javascript:userCommand();">Remove</button></td>' +
            '</tr>';

	    $("#tby").html(slct);

	    $("#editable tr").last().find("td").eq(2).find("input").focus();
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
                var sn = $('#editable tr:last').find('td').eq(2).find('input').val();
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
        var sn = $('#editable tr:last').find('td').eq(2).find('input').val();
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
                        table.rows[curindex - 1].cells[2].innerHTML = sn;
                        table.rows[curindex - 1].cells[3].innerHTML = json.PartNO;
                        table.rows[curindex - 1].cells[4].innerHTML = json.PartName;
                        table.rows[curindex - 1].cells[5].innerHTML = json.OperationCode;
                        table.rows[curindex - 1].cells[6].innerHTML = json.Location;
                        table.rows[curindex - 1].cells[7].innerHTML = json.Quantity;

                        //新增一行
                        inRow();
                        //自动保存
                        //saveData();
                        serialNO = serialNO + sn;
                        count++;
                    }
                    else {
                         //错误锁定界面
                        lock();
                        
                        audio.src = "alarm.mp3";
                        audio.play();
                        $('#ulock').show();
                        table.rows[curindex - 1].cells[2].innerHTML = sn;
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

	//提交
    function SynToPlex() {

        if (isSave == "1") {
            var loc = $('#loc').html().trim();
            var submit = "These containers will be moved to " + loc;
            //Submit confirm
            if (confirm(submit)) {

            var CycleNO = $('#cn').html().trim();
          
            var trseq = document.getElementById("editable").rows.length;

            if (trseq > 1) {

                var data = [];
                var inputs = document.getElementById("editable").getElementsByTagName("input");
              
                for (var i = 0; i < inputs.length; i++) {
                    var row = {};

                    if (inputs[i].type == "checkbox") {
                        if (inputs[i].checked && inputs[i].name == "cb1") {
                            var checkedRow = inputs[i];
                            var currRow = checkedRow.parentNode.parentNode.rowIndex;
                            var tr = checkedRow.parentNode.parentNode;
                            var tds = tr.cells;

                            row.serialNO = tds[2].innerHTML;
                            row.PartNO = tds[3].innerHTML;
                            row.Location = "FGA-INV"
                            row.Quantity = tds[7].innerHTML;
                            var aq = $("#editable tr").eq(currRow).find("td").eq(8).find("input").val();
                            if (aq == "") {
                                row.ActualQty = tds[7].innerHTML;
                            }
                            else {
                                row.ActualQty =  parseFloat(aq).toString();
                            }

                            if (row.PartNO != "") {
                                data.push(row);
                            }
                        }
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

    //编辑当前实际数行
    function setSaveStatus(obj) {

        isSave = "0";
        jQuery("#save").removeAttr("disabled");

        var currTd = $(obj); 
        var tdtext = currTd.html(); 
        var vl = $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(8).find("input").val();

        if (vl != "") {

            var aa = parseFloat(vl).toString();

            if (aa == "NaN") {
                alert("Not a valid number!")
                $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(8).find("input").attr("value", "");
            }
            else {
                 $("#editable tr").eq(obj.parentNode.rowIndex).find("td").eq(8).find("input").attr("value", aa);
            }
        }
    }

	function del(obj) {
	    javascript: alert('Do you want to delete it?');
	    var table = obj.parentNode.parentNode.parentNode;
	    table.deleteRow(obj.parentNode.parentNode.parentNode.rowIndex);
	}

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
