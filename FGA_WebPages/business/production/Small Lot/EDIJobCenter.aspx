<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EDIJobCenter.aspx.cs" Inherits="FGA_PLATFORM.business.production.EDIJobCenter" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>

<title>EDI_Release</title>
<link href="../../../css/style/crumbs.css" rel="stylesheet" type="text/css" />
<link id="pageskinstyle" href="../../../css/style/style_gray.css" rel="stylesheet" />
<link href="../../../css/style/mystyle.css" rel="stylesheet" />
<!-- Bootstrap stylesheet min version -->
<link href="../../../mouldifi-v-2.0/css/entypo.css" rel="stylesheet"/>
<link href="../../../mouldifi-v-2.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="../../../mouldifi-v-2.0/css/bootstrap.min.css" rel="stylesheet"/>
<link href="../../../mouldifi-v-2.0/css/mouldifi-core.css" rel="stylesheet"/>
<link href="../../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet">
<link href="../../../css/style.css" rel="stylesheet" />
<!-- /mouldifi core stylesheet -->
<link href="../../../mouldifi-v-2.0/css/mouldifi-forms.css" rel="stylesheet"/>
<script src="../../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   

<style type="text/css">
.file {
    position: relative;
    display: inline-block;
    background:#00BACE ;
    border: 1px solid #00BACE;
    border-radius: 2px;
    height:32px;
    padding: 4px 12px;
    overflow: hidden;
    color: #00b8ce;
    text-decoration: none;
    text-indent: 0;
    line-height: 18px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
th
  {
  background-color:black;
  color:white;
  }
</style>

</head>

<body  style="overflow: hidden;background-color:white">
     <div class="head"><i class="icon-tools"></i>&nbsp;&nbsp;Production=> SmallLot=> EDI Release</div>

    	<div class="row" style="margin-top:2px">
		 <div class="col-lg-8">
			 <div class="form-inline">
							  <div class="form-group">
								<input type="text" class="form-control"  placeholder="Ship To" id="_orderno">
							  </div>
							  <div class="form-group">
								<input type="text" class="form-control"  placeholder="Part NO" id="_partno">
							  </div>
							  <button type="submit" class="btn btn-primary" onclick="SearchData()">Search</button>
                              <button type="submit" class="btn btn-primary" onclick="releaseData()">RELEASE</button>
                              <button type="submit" class="btn btn-primary" onclick="delData()">Delete</button>
                              <a href="javascript:;" class="file" style="background-color:#00BACE;color:white;font-weight:bold;top:12px">IMPORT
                              <input type="file"  onchange="importf(this)"  name="" id="_import"/>
                </a>
			</div>

			
        </div>
	    </div>
	
		<div style="width:100%;position:absolute;height:85%;overflow:auto;margin-left: 0px;float:left;margin-top:5px;">
			
							<div class="table-responsive">
								<table id = "editable" class="table table-bordered" >
									<thead>
										<tr>
                                     	<th style ="background-color:black;color:white;text-align:left">#</th>
                                        <th style ="background-color:black;color:white;text-align:left">ROW</th>
                                        <th style ="background-color:black;color:white;text-align:left">Group</th>
			                            <th style ="background-color:black;color:white;text-align:left">Customer</th>
			                            <th style ="background-color:black;color:white;text-align:left">Ship To</th>
			                            <th style ="background-color:black;color:white;text-align:left">CstPartNo</th>
			                            <th style ="background-color:black;color:white;text-align:left">PartNo</th>
                                        <th style ="background-color:black;color:white;text-align:left">DueDate</th>
			                            <th style ="background-color:black;color:white;text-align:left">ShipDate</th>
			                            <th style ="background-color:black;color:white;text-align:left">Quantity</th>
                                        <th style ="background-color:black;color:white;text-align:left">StandardQty</th>
			                            <th style ="background-color:black;color:white;text-align:left">LotNo</th>
                                        <th style ="background-color:black;color:white;text-align:left">BatchNo</th>
                                        <th style ="background-color:black;color:white;text-align:left">JobSequence </th>
                                        <th style ="background-color:black;color:white;text-align:left">CstPartRev</th>
                                        <th style ="background-color:black;color:white;text-align:left">OrderNo</th>
                                        <th style ="background-color:black;color:white;text-align:left">RowID</th>
                                       
										</tr>
									</thead>
									<tbody id ="tby" style="background-color:white"></tbody>
								</table>
							</div>
						</div>		

<script src="../../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.12/xlsx.full.min.js"></script>
<script src="../../../javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

    //导入
    var rABS = false; //是否将文件读取为二进制字符串
    function importf(obj) {
        //导入
        if (!obj.files) { return; }
        var f = obj.files[0];
        {
            var reader = new FileReader();
            var name = f.name;
            reader.onload = function (e) {
                var data = e.target.result;
                var wb;
                if (rABS) {
                    wb = XLSX.read(data, { type: 'binary' });
                } else {
                    var arr = fixdata(data);
                    wb = XLSX.read(btoa(arr), { type: 'base64' });
                }
                //获取界面数据
                var json = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);

                if (true)
                {
                    $("#tby").html('<tr class="tr_loading"><td colspan="20"><img src="../../../images/loading.gif" alt="" />Importing...</td></tr>');

                    var jsondata = JSON.stringify(json);
                    $.ajax({
                        type: "post",
                        url: "EDIJobCenter.aspx/saveDataImport",
                        data: "{data:'" + jsondata + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        success: function (data) {
                            if (data.d == "1") {
                                SearchData();
                                alert("Success");
                            }
                            else
                                alert("fail");
                        }
                    });
                }
            }
           
            if (rABS) reader.readAsBinaryString(f);
            else reader.readAsArrayBuffer(f);
        }

        $("#_import").val("");
    }

    function fixdata(data) {
        var o = "", l = 0, w = 10240;
        for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
        o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
        return o;
    }

    //查询初始化界面需要release的信息
    function SearchData() {
        $("#editable tr:not(:first)").remove();
        $.ajax({
            type: "Post",
            url: "EDIJobCenter.aspx/SearchData",
            data: "",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d != "") {
                   var json = $.parseJSON(data.d);
                   var slct = "";

                   for (var i = 0; i < json.length; i++) {
                       slct = slct + '<tr><td><input type="checkbox" name = "cb1" /></td>' +
                           '<td> ' + (i + 1) + '</td> ';

                           if (i == 0) {
                               slct = slct + '<td style="background-color:yellow;"> ' + json[i].MasterID + '</td>';
                           }
                           else {
                               if (json[i].MasterID != json[i - 1].MasterID) {
                                   slct = slct + '<td style="background-color:yellow;"> ' + json[i].MasterID + '</td>';
                               }
                               else {
                                    slct = slct + '<td> ' + json[i].MasterID + '</td>';
                               }
                           }

                       slct = slct + '<td> ' + json[i].customer_name + '</td> ' +
                           '<td> ' + json[i].Customer_Address_Code + '</td> ' +
                           '<td> ' + json[i].Customer_Part_No + '</td> ' +
                           '<td> ' + json[i].part_no + '</td> ' +
                           '<td> ' + new Date(parseInt(json[i].Due_Date)).toLocaleString() + '</td> ' +
                           '<td> ' + new Date(parseInt(json[i].Ship_Date)).toLocaleString() + '</td> ' +
                           '<td> ' + json[i].Quantity + '</td> ' +
                           '<td> ' + json[i].Standard_Quantity + '</td> ' +
                           '<td> ' + json[i].Lot_No + '</td> ' +
                           '<td> ' + json[i].BATCH_NO + '</td> ' +
                           '<td> ' + json[i].JOB_SEQUENCE + '</td> ' +
                           '<td> ' + json[i].Customer_Part_Revision + '</td> ' +
                           '<td> ' + json[i].ORDER_NO + '</td> ' +
                           '<td> ' + json[i].EDI_RowID + '</td> ' +
                           '</tr>';

                   }

                   $("#tby").html(slct);
                }
            }
        });
    }

    //release数据
    function releaseData() {

        var data = [];
        var inputs = document.getElementById("editable").getElementsByTagName("input");
        var cell = new Array("customer_name", "Customer_Address_Code", "Customer_Part_No", "Customer_Part_Revision",
            "Part_No", "Part_Name", "Due_Date", "Ship_Date", "Quantity", "Order_No", "Lot_No", "Batch_No", "Job_Sequence", "EDI_Key",
            "EDI_Action", "EDI_Status", "Docname", "Standard_Quantity");

        for (var i = 0; i < inputs.length; i++) {
            var row = {};

            if (inputs[i].type == "checkbox") {
                if (inputs[i].checked && inputs[i].name == "cb1") {
                    var checkedRow = inputs[i];
                    var tr = checkedRow.parentNode.parentNode;
                    var tds = tr.cells;
                    //循环列
                    row.MasterID = tds[2].innerHTML;
                    row.customer_name = tds[3].innerHTML;
                    row.Customer_Address_Code = tds[4].innerHTML;
                    row.Customer_Part_No = tds[5].innerHTML;
                    row.Part_No = tds[6].innerHTML;
                    row.Due_Date = tds[7].innerHTML;
                    row.Ship_Date = tds[8].innerHTML;
                    row.Quantity = parseInt(tds[9].innerHTML);
                    row.Standard_Quantity = parseInt(tds[10].innerHTML);
                    row.Lot_No = tds[11].innerHTML;
                    row.Batch_No = tds[12].innerHTML;
                    row.Job_Sequence = parseInt(tds[13].innerHTML);
                    row.Customer_Part_Revision = tds[14].innerHTML;
                    row.Order_No = tds[15].innerHTML;
                    row.EDI_RowID = tds[16].innerHTML;

                    data.push(row);
                }
               
            }
        }

        //校验Data合法性
        var sqty  = data[0].Standard_Quantity;
        var count = 0;
        var Mid   = data[0].MasterID;

        for (var i = 0; i < data.length; i++) {
            count = count + data[i].Quantity;
            if (Mid != data[i].MasterID) {
                alert("The Group must be the same!"+"Group NO: "+Mid);
                return;
            }
        }

        if (count != sqty) {
            alert("Total quantity and Standard Quantity must be equal!"+'\n'+"Selected  Quantity is " + count +"."+'\n'+"Standard Quantity is "+sqty+".");
            return;
        }

        var jsondata = JSON.stringify(data);
        $.ajax({
            type: "post",
            url: "EDIJobCenter.aspx/releaseData",
            data: "{data:'" + jsondata + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function (data) {
                if (data.d == "1") {
                    alert("success");
                    //release成功后刷新界面
                    SearchData();

                }
                else
                    alert("fail");
            }
        });
    }
</script>
</body>
</html>


