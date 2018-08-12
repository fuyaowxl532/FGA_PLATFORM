<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetPolicy.aspx.cs" Inherits="FGA_PLATFORM.business.ITAsset.AssetPolicy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IT Asset Policy</title>
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
<link href="../../mouldifi-v-2.0/css/plugins/select2/select2.css" rel="stylesheet"/>
<!-- jquery脚本库-->
<script src="../../javascript/jquery-3.1.0.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<script src="../../javascript/ymPrompt/ymPrompt.js" type="text/javascript"></script>
<script src="../../javascript/common.js" type="text/javascript"></script>
<script src="../../javascript/My97DatePicker/WdatePicker.js"></script>
<!--验证-->
<script src="../../javascript/ValidationCheck.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.min.js"></script>
<script src="../../mouldifi-v-2.0/js/tableExport.js"></script>
<script src="../../mouldifi-v-2.0/js/jquery.base64.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
    <div id="note">
      <article>
        <h1><label for="item" style="font-weight:bold;margin-left:32%">Computer Use Policy</label></h1>
        <br/><a href="" style="font-weight:bold">Purpose目的</a>To provide specific requirements to protect information technology resources and the information stored on those resources<br/>为了提供详细的要求，以保护信息技术资源以及所储存在这些资源上的信息。<br/>
        <a href="" style="font-weight:bold">Scope范围</a>Any computer system network, service, application, program or device owned, managed, serviced, maintained by or provided by FGA<br/>福耀所拥有、管理、服务、维护或提供的电脑系统网络、服务、应用、程序及设备。<br/>
        <a href="" style="font-weight:bold">Responsibility责任</a>The System Administrator is responsible for ensuring conformance to these requirements. All employees are responsible for following them. <br/>系统管理者负责确保本文要求与操作一致。全部员工必须按照要求执行。</p>
        <p><a href="" style="font-weight:bold">Instructions	操作说明</a><br/>
        <label for="user" style="font-weight:bold">User Accounts用户帐号</label><br/>
        To ensure the overall security of the environment and the information within the environment, all user accounts will be listed as standard, unless there is a valid business reason to have an administrator account. In that case, prior authorization from management must be obtained.
        <br/>保证总体环境和在环境下信息的安全。除正当商务原因需要被设为管理员帐户外，其他用户帐号一律设为标准帐户。申请被设为管理员帐号需要预先获得管理层的许可。</p>
        <p> <label for="password" style="font-weight:bold">Passwords密码</label><br/>
        Internal: All user accounts must have at least 8 characters and contain at least 3 of the following: lower case letters, upper case letters, numbers, punctuation, “special” characters (e.g. !@#$%^&*(){}<>?, etc.) and cannot contain your name. The password will be required to be changed every 60-90 days, and the same password as the last 8 passwords associated with the user account cannot be used. Failure to change the password within the 10 day window will result in the account being locked out, and it will need to be unlocked by an administrator. Passwords should not be shared, written down or stored on-line without encryption. 
        <br/>内部：所有帐号必须包含至少8个字符和至少3个以下内容：小写字母、大写字母、数字、标点符号、“特殊”字符（如 !@#$%^&*(){}<>? 等），不可包含用户姓名。密码必须每60-90日更换一次，不可更换为最近8个使用过的密码。若不能按要求的10日时限内更换密码，账号将被禁用，需要由管理员解除封禁。
        </p>

        <p><label for="Customer" style="font-weight:bold">Customer客户</label><br/>
        All customer system user names and passwords should be stored in the Customer System Authentication list, located in Plex.<br/>
        客户系统的用户名和密码需要储存在PLEX里的客户系统验证清单上。</p>

        <p><label for="software" style="font-weight:bold">Software软件</label><br/>
        All software on company PCs will be installed and maintained by an administrator. Personal software on company PCs is strictly prohibited.<br/>
        管理员安装并维护公司内所有个人电脑内的软件。公司电脑严禁安装私人软件。</p>

        <p><label for="application" style="font-weight:bold">Application Usage应用程序的使用</label><br/>
        Instant Messaging (IM) and file sharing applications on company PCs are prohibited unless a valid business reason exists for the use of the software. Internet content that could be considered inappropriate in a professional environment is prohibited.<br/>
        除正当商务需求外，公司电脑禁止安装即时聊天（IM）和文件共享应用。禁止浏览与工作环境无关不符的互联网内容。</p>

        <p><label for="Risk" style="font-weight:bold">Risk Management风险管理</label><br/>
        Any computer threat on a company PC should be reported to management immediately. Further use of that PC is prohibited until the issue is resolved. Employees must use caution when opening e-mail attachments from unknown senders.
        Employees should notify management immediately if any equipment (I.e., printers, laptops) is not running properly, has error messages, paper jams, odd noises, or any other problems arise.<br/>
        发现任何对电脑有伤害的事件，必须立即报告给管理人员。事件消除前，不得继续使用电脑。员工应在打开陌生邮件的附件前多加留意。如果发现任何设备（例如打印机、笔记本电脑）不能正常运作、提示错误信息、卡纸、发出异响或其他问题，员工应立即汇报给管理人员。<p>

        <p><label for="Lost" style="font-weight:bold">Lost, Stolen or Damaged Device Containing Company Data储存公司数据的设备遗失、被窃、损坏</label><br/>
        If any device that contains company data is lost, stolen or damaged the issue needs to be reported to management immediately. This policy includes personal devices that have access to company e-mail.<br/>
        如果储存公司数据的设备发生遗失、被窃或者损坏，此类问题应立即报告给管理人员。此要求亦包括可以访问公司电子邮箱的个人设备。</p>

        <p><label for="External" style="font-weight:bold">External Hardware外部硬件</label><br/>
        Prior authorization must be obtained before any devices (i.e., flash drives, digital cameras, media players, etc.) can be connected (via USB, wireless, Ethernet cable, etc.) to any company computer or network.<br/>
        使用任何外部设备（如U盘、数字相机、媒体播放器等）连接（通过 USB、无线网、Ethernet线等）公司任何电脑和网络之前，必须获得许可。</p>

        <p><label for="General" style="font-weight:bold">General总则</label><br/>
        For security and network maintenance purposes, authorized individuals may monitor equipment, systems and network traffic at any time.
        Employees should exercise special care if they leave their computers unattended, i.e., close any open programs, lock the computer, etc.
        Confidential data can only be used on machines with encryption capability. 
        Employees who need to access the network from home must get approval from management in order to obtain authentication.</p>

        <p>See the System Administrator if you have any questions about these requirements or need assistance. <br/>
        为了安全和网络维护的考虑，许可人员需监管相关设备、系统、网络流量。
        职员在不能照看电脑的情况下应施行特别措施，如关闭任何开启的程序、锁闭电脑等。
        保密数据只能在具备加密能力的机器上使用。
        职员如需在家连接公司网络，许事先获得管理人员的许可。
        如有对本文要求有任何问题或需要帮助，请联系系统管理员。</p>

        <p><label for="Acknowledgement" style="font-weight:bold">Acknowledgement and Agreement声明和协议</label><br/>
        I understand that it is my responsibility to safeguard and maintain company information, technology, and equipment, and I will comply with the requirements in this document. I further understand that any employee found to have violated this policy may be subject to disciplinary action, up to and including termination of employment.<br/>
        我明确我的职责是保护和维护公司信息、设备和技术，我将履行本文所提及的要求。我明确任何违反本要求的职员将被追责，或至解除雇佣关系。</p>

    </article>
    </div>
    <div id="btn">
         <button title ="Agree"   class="btn btn-primary" id ="btnagree"  onclick ="Agree()" style="margin-left:40%;margin-bottom:5px; width:120px">Agree</button>
    </div>

<!-- Input Mask-->
<script src="../../mouldifi-v-2.0/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Select2-->
<script src="../../mouldifi-v-2.0/js/plugins/select2/select2.full.min.js"></script>
<!--Bootstrap ColorPicker-->
<script src="../../mouldifi-v-2.0/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!--Bootstrap DatePicker-->
<script src="../../mouldifi-v-2.0/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.12.12/xlsx.full.min.js"></script>
<script src="../../javascript/artDialog/dialog-min.js" type="text/javascript"></script>
<link href="../../javascript/artDialog/ui-dialog.css" rel="stylesheet" />
<script src="../../javascript/JSPager.js"></script>
<script src="../../javascript/DateOperate.js"></script>

<script type="text/javascript">

    function Agree() {
        $.ajax({
                type: "Post",
                url: "AssetPolicy.aspx/agreePolicy",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d == "1") {
                          window.parent.ymPrompt.doHandler("agree", true);
                    }
                    else {
                        alert("Error!");
                    }
                }
                });
    }

</script>

</body>
</html>
