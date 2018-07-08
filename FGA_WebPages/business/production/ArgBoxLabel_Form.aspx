<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArgBoxLabel_Form.aspx.cs" Inherits="FGA_PLATFORM.business.production.ArgBoxLabel_Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>ArgBoxLabel_BasicForm</title>
<link rel='shortcut icon' type='image/x-icon' href='images/favicon.ico' />
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
</head>
<body>

<div class="panel-body filter-wrapper" style="height:60px;position:absolute;width: 700px; margin-top:10px"> 
					<form class="form-inline" >
						<div class="form-group" style="margin-left:15px">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px"  name="query" value="ADD"   />
                        </div>	
						<div class="form-group">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px" " onclick = "querydate()" name="query" value="Query"   />
                        </div>	
						
						<div class="form-group" >	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px"  name="query" value="DELETE"   />
                        </div>	
                        <div class="form-group" >	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px"  name="export" value="SAVE" />
						</div>
                        <div class="form-group" >	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px"  name="export" value="IMPORT" />
						</div>
                        <div class="form-group" >	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px"  name="export" value="EXPORT" />
						</div>
					</form>
				</div>  
       
<div class=""style="position:absolute;margin-top:80px">
       
<ul class="nav nav-tabs">
							<li class="active"><a aria-expanded="true" href="#attribute" data-toggle="tab">Attribute</a></li>
							<li><a aria-expanded="false" href="#component" data-toggle="tab">Component</a></li>
                            <li><a aria-expanded="false" href="#type" data-toggle="tab">Encap_Type</a></li>
						</ul>
<div class="tab-content">
<div class="tab-pane active" id="attribute">
								
							<div class="table-responsive" style="height:500px;width:1200px; overflow:scroll">   
        <table id="editable" class="table table-striped table-bordered table-hover dataTables-example" > 
	     <thead>
		   <tr>
			
			<th>Part_No</th>
            <th>BoxHeight</th>
			<th>GasketThick</th>
			<th>CornerType</th>
            <th>BaseNO</th>
			<th>Creator</th>
            <th>CreateDate</th>
            
		</tr>
	</thead>
    <tbody>  </tbody>
    </table>
    </div>
								
							</div>
<div class="tab-pane" id="component">
							<div class="table-responsive" style="height:500px;width:1200px; overflow:scroll">   
        <table id="Table1" class="table table-striped table-bordered table-hover dataTables-example" > 
	     <thead>
		   <tr>
			
			<th>Part_No</th>
            <th>Component_Part</th>
			<th>Component_Type</th>
			<th>CornerType</th>
			<th>Creator</th>
            <th>CreateDate</th>
            
		</tr>
	</thead>
    <tbody>  </tbody>
    </table>
    </div>
							</div>
<div class="tab-pane" id="type">
	<div class="table-responsive" style="height:500px;width:1200px; overflow:scroll">   
        <table id="Table2" class="table table-striped table-bordered table-hover dataTables-example" > 
	     <thead>
		   <tr>
			
			<th>Part_No</th>
            <th>EdgeType</th>
			<th>Creator</th>
            <th>CreateDate</th>
            
		</tr>
	</thead>
    <tbody>  </tbody>
    </table>
    </div>
   
</div>	
</div>	
    </div>			
<!--Load JQuery-->
<script src="../../javascript/jquery-1.11.1.min.js"></script>

<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/bootstrap.min.js"></script>
<script src="../../mouldifi-v-2.0/js/plugins/metismenu/jquery.metisMenu.js"></script>
<script src="../../mouldifi-v-2.0/js/functions.js"></script>

<script type="text/javascript">

    $(function () {
        $('.tab-pane').click(function (e) {
            alert($('.tab-pane').attr("id"));
            });
    });
    $(function () {
        $('#component').click(function (e) {
            alert("22");
        });
    });
    $(function () {
        $('#type').click(function (e) {
            alert("33");
        });
    });

    function querydate() {

        alert("111111");
    }
</script>


</body>
</html>