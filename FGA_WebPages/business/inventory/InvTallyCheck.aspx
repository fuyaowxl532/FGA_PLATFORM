<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvTallyCheck.aspx.cs" Inherits="FGA_PLATFORM.business.inventory.InvTallyCheck" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content="Mouldifi - A fully responsive, HTML5 based admin theme"/>
<meta name="keywords" content="Responsive, HTML5, admin theme, business, professional, Mouldifi, web design, CSS3"/>
    <title>ARGCheckInv</title>
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
</head>
<body>
   
            <div class="panel-body filter-wrapper" style="height:95px;position:relative;width: 1250px; "> 
			<form class="form-inline" >
						<div class="form-group">
							<label class="form-label">Invoice No</label>
							<input type="text" placeholder="input"  style="color: black; height:30px;width:100px; "/>	
						</div>
						<div class="form-group" >
							<label class="form-label"style="margin-left:-25px">Part No</label>
							<input type="text" id="Text2" placeholder="input"  style="color: black; height:30px;width:100px;margin-left:-25px"/>	
						</div>	
						<div class="form-group">
							<label class="form-label"style="margin-left:-25px">Status</label>
							<input type="text" id="Text3" placeholder="input"  style="color: black; height:30px;width:100px;margin-left:-25px"/>
						</div>	
						<div class="form-group">	
							<label class="form-label"style="margin-left:-25px">Date(from)</label> 
							<div id="Div1" class="input-group date"> 
								<input type="text" id="Text4" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;margin-left:-25px"/>
								<span class="input-group-addon"><i class="fa fa-calendar" ></i></span> 
							</div>
						</div>
						<div class="form-group">	
							<label class="form-label"style="margin-left:-25px">Date(to)</label> 
							<div id="Div2" class="input-group date">
								<input type="text" id="Text5" data-format="D, dd MM yyyy"  style="color: black; height:30px;width:90px;margin-left:-25px"/> 
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
							</div>
						</div>
						<div class="form-group" style="position:relative; margin-top:-30px">	
							<input type ="button" class="btn btn-primary btn-sm" style="background:white;color:#00b8ce; width:68px" onclick="queryData()" name="search" value="Query"   />
                        </div>	
                        
                          <div class="form-group"style="position:relative; margin-left:670px; margin-top:-35px">	
							 <input type ="button"  class="btn btn-primary btn-sm" style="background:white;color:#00b8ce;width:68px;" onclick="execute()" name="execute" value="Execute" />
						</div>

						
					</form>
				
			</div>
				
			<div style="height:530px;width:1250px;overflow:scroll">

					<table id = "editable1" class=" table table-striped table-bordered table-hover" style="white-space:nowrap;" >
						<thead >
							<tr>
                                <th>#</th>
                                <th>Box NO</th>
                                <th>Serial No</th>
                                <th>Location</th>
								<th>Invoice No</th>
								<th>Part No</th>
                                <th>InBound Qty</th>
                                <th>Box Type</th>
                                <th>Shipment Date</th>
                                <th>InvCheck</th>
							</tr>
						</thead>
                        
						<tbody id ="tbody1" >
					
						</tbody>
					</table>
				</div>
					
    
</body>
</html>