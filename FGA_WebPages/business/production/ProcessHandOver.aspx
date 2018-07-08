<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessHandOver.aspx.cs" Inherits="FGA_PLATFORM.business.production.ProcessHandOver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ProcessHandOver</title>
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

<script src="../../javascript/jquery-1.11.1.min.js"></script>

    
</head>
<body>

    <div class="col-lg-12">
        
        <div class ="panel " style="width:1000px;height: 150px;background-color: #00b8ce; ">
            <div class="panel-body"  > 
                <form class="form-inline">
                    <div class="col-md-12 col-lg-12">
                        
                            <div class="form-group">
                            <label class="form-label"  id = "_org "  for= "org" >Organization:</label>
                            <input type="text" id = "_orgtxt"  name ="orgtxt" style="color: black"  />
                        </div>
                        <div class="form-group">
                            <label class="form-label" id = "_opt" for= "opt" >Operation:</label>
                            <input type="text" id = "_opetxt" name ="opttxt" style="color: black" />
                        </div>
                        <div class="form-group">
                            <label class="form-label" id = "_tst" for= "tst" >Transcation:</label>
                            <select id ="sid" class=" select2 " style="width:135px;height:27px" >
                                <option value="IM1301">IM1301</option>
                                <option value="IM1302">IM1302</option>
                            </select>
                        </div>
                       
                   </div>
      
            <div class="col-lg-12 col-md-12">
                <div class="form-group">
                    <label id = "_batch" for= "batch" class="form-label">BatchNO:</label>
                    <input type="text" id = "_batchno" name ="batchno" style="color: black" />
                </div>
                <div class="form-group">
                    <label id = "_tloc" for= "date" class="form-label" >To_Loc:</label>
                    <input type="text" id ="tlocation" name="tloc" style="color: black"/>
                    
                </div>
                <div class="form-group">
                    <label id = "_dt" for= "date" class="form-label">Date:</label>
                    <input type="text" id ="_dttxt" name="dttxt"  style="color: black" />
                    
                </div>
            <div class="form-group">
             <input class="  btn-default  " style="margin-top:30px; margin-left:50px" id = "bcrt" type="button"  name="create" value="Create" onclick="_create()" />
             <input class="  btn-default  " id = "rmv"  type="button"  name="remove" value="Remove" onclick="remove()" />
             <input class="  btn-default  " type="button"  name="clear"  value="Clear" onclick = "clr()" />
             <input class="  btn-default  " type="button"  name="sub"    value="Submit" onclick="transferToAudit()" />
                </div>
            </div>
        
           </form>
         </div>
                </div>
      </div>
        
            <div class="col-lg-12">
                <div >
                    <div class="table-responsive">
                <table class="table table-bordered  table-striped " id="editable"> 
	               <thead>
		            <tr>
                        <th>*</th>
			            <th>No</th>
			            <th>SerialNO</th>
                        <th>To_Location</th>
			            <th>PartNO</th>
                        <th>Operation</th>
			            <th>Location</th>
			            <th>Quantity</th>
			            <th>Status</th>
		            </tr>
	            </thead>
	            <tbody></tbody>
	        </table>
         </div>
                    </div>
                </div>

    	<script type="text/javascript" >
    	    var serialNO = "0";

    	    function inRow() {
    	        var table = document.getElementById("editable");
    	        var nextIndex = table.rows.length;
    	        var nextRow = table.insertRow(nextIndex);
    	        nextRow.insertCell(0).innerHTML = '<input type="checkbox" name = "cb1" />';
    	        nextRow.insertCell(1).innerHTML = nextIndex;
    	        nextRow.insertCell(2).innerHTML = null;
    	        nextRow.insertCell(3).innerHTML = null;
    	        nextRow.insertCell(4).innerHTML = null;
    	        nextRow.insertCell(5).innerHTML = null;
    	        nextRow.insertCell(6).innerHTML = null;
    	        nextRow.insertCell(7).innerHTML = null;
    	        nextRow.insertCell(8).innerHTML = null;
    	        $("#editable tr").last().find("td").eq(2).html('<input type="text" onkeydown="return enterSerialNO(event)" style="border:none;width:100%;height:100%" size = "5"/>');
    	        $("#editable tr").last().find("td").eq(3).html('<input type="text" onkeydown="return setlocation(event)" style="border:none;width:100%;height:100%" size = "5"/>');
    	        $("#editable tr").last().find("td").eq(2).find("input").focus();
    	    }

    	    function _create() {

    	        serialNO = "0";
    	        var tt = $('#sid').val();

    	        //初始化基本信息【组织、从工序、到工序、从库位、到库位、用户名、时间】
    	        //先判断当前用户组织、工序、事物类型的控制权限
    	        $.ajax({
    	            type: "Post",
    	            url: "ProcessHandOver.aspx/InitPage",
    	            data: "{data:'" + tt + "'}",
    	            contentType: "application/json; charset=utf-8",
    	            dataType: "json",
    	            async: false,
    	            success: function (data) {
    	                if (data.d != "") {

    	                    var json = $.parseJSON(data.d);
    	                    var myDate = new Date();
    	                    $('#_orgtxt').val(json[0].ORGANIZATION);
    	                    $('#_opetxt').val(json[0].OPERATION);
                            $('#_batchno').val(json[0].BATCHNO);
                            $('#tlocation').val(json[0].WORKCENTER);

    	                    $('#_dttxt').val(myDate.toLocaleDateString());

    	                    $('#_orgtxt').attr("readonly", "readonly");//设为只读
    	                    $('#_opetxt').attr("readonly", "readonly");
    	                    $('#sid').attr("disabled", "disabled");
    	                    $('#_batchno').attr("readonly", "readonly");
    	                    $('#_dttxt').attr("readonly", "readonly");

    	                    //$('input:text').removeAttr("readonly");//取消只读的设置

    	                    //增加一行
    	                    inRow();

    	                    //按钮失效
    	                    $("#bcrt").attr("disabled", true);

    	                }
    	                else {
    	                    alert("You do not have permission!");
    	                    return;
    	                }
    	            }
    	        });
    	    }

    	    function remove() {
    	        var data = [];
    	        var table  = document.getElementById("editable");
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
    	                    var csn = $("#editable tr").eq(tds[1].innerHTML -count).find("td").eq(2).find("input").val();

    	                    serialNO = serialNO.replace(csn, '');

    	                    $("#editable tr").eq(tds[1].innerHTML - count).remove();
    	                    count++;
    	                }

    	            }
    	        }

    	        //删除后重新赋值行号
    	        if (count > 0)
    	        {
    	            for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
    	                table.rows[i].cells[1].innerHTML = i;
    	            }
    	        }
    	    }

    	    function c1(obj) {
    	        obj.style.backgroundColor = 'yellow'; //把点到的那一行变希望的颜色;
    	        //alert(obj.parentNode.parentNode.rowIndex);获取当前行号
    	        serialNOtr = $("#editable tr").eq(obj.parentNode.parentNode.rowIndex).find("td").eq(1).find("input").val();
    	    }

            //获取扫描到的DA信息
            //交接IM1301、IM1302(InProcess/Finish)状态中不能重复扫描

    	    function enterSerialNO(event) {
    	        if (event.which == 13) {
    	           
    	            var table = document.getElementById("editable");
    	            var curindex = document.getElementById("editable").rows.length;
    	            var sn = $("#editable tr").eq(curindex - 1).find("td").eq(2).find("input").val();

    	            //获取表头To_Loc字段信息
                    var org   = $('#_orgtxt').val();
                    var tl    = $('#tlocation').val();
                    var opt   = $('#_opetxt').val();
                    var trans = $('#sid').val();

                    if (serialNO.indexOf(sn) <= 0) {

    	                //赋值信息
    	                $.ajax({
    	                    type: "Post",
    	                    url: "ProcessHandOver.aspx/GetDAContainer",
                            data: "{data:'" + sn + "',opt:'" + opt + "',trans:'" + trans + "',org:'" + org + "'}",
    	                    contentType: "application/json; charset=utf-8",
    	                    dataType: "json",
    	                    async: false,
    	                    success: function (data) {
    	                        if (data.d != "") {

                                    if (data.d != "0") {

                                        if (data.d != "1") {

                                            if (data.d != "2") {

                                                    var jdata = JSON.parse(data.d);
                                                    table.rows[curindex - 1].cells[3].innerHTML = '<input type="text" value = "' + tl + '" onkeydown="return setDetailAndRow(event)" style="border:none;width:100%;height:100%" size = "5"/>';
                                                    table.rows[curindex - 1].cells[4].innerHTML = jdata[0].PartNO;
                                                    table.rows[curindex - 1].cells[5].innerHTML = jdata[0].OperationNo;
                                                    table.rows[curindex - 1].cells[6].innerHTML = jdata[0].Location;
                                                    table.rows[curindex - 1].cells[7].innerHTML = jdata[0].Quantity;
                                                    table.rows[curindex - 1].cells[8].innerHTML = jdata[0].ContainerStatus;

                                                    if (tl != "" && tl != null) {
                                                        inRow();
                                                    }
                                                    else {
                                                        //光标跳到TOLOCATION字段
                                                        $("#editable tr").last().find("td").eq(3).find("input").focus();

                                                        //获取当前界面已扫面的DA号
                                                        serialNO = serialNO + "." + sn;
                                                    }
                                            }
                                            else {
                                                alert("This SerialNO location is wrong " + sn);
                                                $("#editable tr").last().find("td").eq(2).find("input").val("");
                                                return;
                                            }
                                        }
                                        else
                                        {
                                            alert("operation is wrong: " + jdata[0].OperationNo);
                                            $("#editable tr").last().find("td").eq(2).find("input").val("");
                                            return;
                                        }

                                    }
                                    else
                                    {
                                        alert("This SerialNO has been transfered.Status is 'In Progress': " + sn);
                                        $("#editable tr").last().find("td").eq(2).find("input").val("");
                                        return;
                                    }
    	                        }
    	                        else {
    	                            alert("SerialNO is wrong: " + sn);
    	                            $("#editable tr").last().find("td").eq(2).find("input").val("");
    	                            return;
    	                        }
    	                    }
    	                });
    	               
    	            }
    	            else {
    	                alert(sn + " is repeat!");
    	                $("#editable tr").last().find("td").eq(2).find("input").val("");
    	                return;
    	            }
                   
    	        }
    	    }

    	    //数据提交
    	    function transferToAudit() {
    	        if (confirm("Are you sure submit data?")) {
    	            var data = [];
    	            var t = document.getElementById("editable");
    	            var bn = $("#_batchno").val();
    	            var org = $("#_orgtxt").val();
                    var tt  = $("#sid").val();

    	            for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
    	                var row = {};
    	                var aq = null;
    	                row.PartNO = t.rows[i].cells[4].innerHTML;
    	                if (row.PartNO != "") {
    	                    row.rn = t.rows[i].cells[1].innerHTML;
    	                    row.SerialNO = $("#editable tr").eq(i).find("td").eq(2).find("input").val();
    	                    row.OperationNo = t.rows[i].cells[5].innerHTML;
    	                    row.Location = t.rows[i].cells[6].innerHTML;
    	                    row.Quantity = t.rows[i].cells[7].innerHTML;
    	                    row.TLoc = $("#editable tr").eq(i).find("td").eq(3).find("input").val();
    	                    row.ContainerStatus = "In Progress";
    	                    row.BatchNO = bn;

    	                    if (row.PartNO != "" && row.PartNO != null)
    	                    {
    	                        data.push(row);
    	                    }
    	                }
    	            }
    	            var jsondata = JSON.stringify(data);
    	            if (jsondata == "[]") {
    	                alert("There have not data to submit!");
    	                return;
    	            }
    	            else {
    	                $.ajax({
    	                    type: "post",
    	                    url: "ProcessHandOver.aspx/transferToAudit",
    	                    data: "{data:'" + jsondata + "',org:'" + org + "',transaction:'" + tt + "'}",
    	                    contentType: "application/json; charset=utf-8",
    	                    dataType: "json",
    	                    async: true,
    	                    success: function (data) {
    	                        if (data.d == "1") {
    	                            alert("success");
    	                            //清空界面数据
    	                            window.location.reload();//刷新当前页面.
    	                        }
    	                        else
    	                            alert("transfer routing is wrong!" + '\n' + data.d);
    	                    }
    	                });
    	            }
    	        }
    	    }


    	    function setlocation(event) {
    	        if (event.which == 13) {
                    //获取最后一行的DA
    	            //var sn = $("#editable tr").last().find("td").eq(2).find("input").val();
    	            //if (sn != "" && sn_ != null)
    	            //{
    	                //获取表头To_Loc字段信息
    	                var tl = $('#tlocation').val();
    	                if (tl == "" || tl == null) {
    	                    inRow();
    	                }
    	                else {
    	                    //光标跳到TOLOCATION字段
    	                    $("#editable tr").last().find("td").eq(2).find("input").focus();
    	                }
    	            //}
    	        }
    	    }

    	    //界面保存
    	    function updateData() {
    	        var data = [];
    	        var t = document.getElementById("editable");

    	        for (var i = 1; i < document.getElementById("editable").rows.length; i++) {
    	            var row = {};
    	            var aq = null;
    	            aq = $("#editable tr").eq(i).find("td").eq(5).find("input").val();
    	            row.PartNO = t.rows[i].cells[2].innerHTML;
    	            if (aq != "" && row.PartNO != "") {
    	                row.SerialNO = $("#editable tr").eq(i).find("td").eq(1).find("input").val();
    	                row.ActualQuantity = aq;
    	                row.AreaCode = $("#editable tr").eq(i).find("td").eq(6).find("input").val();

    	                data.push(row);
    	            }

    	        }
    	        var jsondata = JSON.stringify(data);
    	        $.ajax({
    	            type: "post",
    	            url: "statsByscanner.aspx/updateData2",
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

    	    function del(obj) {
    	        javascript: alert('Do you want to delete it?');
    	        var table = obj.parentNode.parentNode.parentNode;
    	        table.deleteRow(obj.parentNode.parentNode.parentNode.rowIndex);
    	    }

    	    //清空界面数据
    	    function clr() {
    	        //if (confirm("Are you sure clear all data?")) {

    	            //$("#editable tr:not(:first)").remove();

    	            //$('#_orgtxt').val("");
    	            //$('#_opetxt').val("");
    	            //$('#_batchno').val("");
    	            //$('#_dttxt').val("");

    	            //$('#_orgtxt').attr("readonly");//设为可编辑
    	            //$('#_opetxt').attr("readonly");
    	            //$('#_batchno').attr("readonly");
    	            //$('#_dttxt').attr("readonly");
    	            //按钮失效
    	            //$("#bcrt").attr("disabled", false);
    	            window.location.reload();//刷新当前页面.
                //}
    	    }

    	    //在关闭页面时弹出确认提示窗口
    	    $(window).bind('beforeunload', function () {
    	        return 'Changes you made may not be saved';
    	    });

	</script> 
</body>
</html>
