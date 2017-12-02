<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="DescargaFacturas.login" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CCFN - ACCESO</title>
	<!-- Icon -->
    <link rel="icon" href="images/favicon.png" type="image/x-icon">
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="css/styles1.css" rel="stylesheet" type="text/css"/>
	<link href="css/styles.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		.rbClearButton,
		.rbClearButton:hover {
			background-color: transparent !important;
			background-image: none !important;
			border: none !important;
			color: cadetblue !important; /* optional, depending on the background */
		}
 
		.rbHyperlinkButton {
			border-bottom: 1px solid #3D88D6 !important;
			color:#3D88D6 !important;
			padding: 1px !important;
		}
	</style>
	<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
		<script type="text/javascript">
			function PasswordRetrive(sender, args)
			{
				$find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("PasswordRetrieve");
			}
		</script>
	</telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
		<telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
		<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
			<AjaxSettings>
				<telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
					<UpdatedControls>
						<telerik:AjaxUpdatedControl ControlID="lblError" LoadingPanelID="RadAjaxLoadingPanel1" />
						<telerik:AjaxUpdatedControl ControlID="lblPasswordSent" LoadingPanelID="RadAjaxLoadingPanel1" />
					</UpdatedControls>
				</telerik:AjaxSetting>
			</AjaxSettings>
		</telerik:RadAjaxManager>
		<telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Metro"></telerik:RadSkinManager>
		<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
		<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All" />
		<div style="text-align: center" class="pageLayout">
			<telerik:RadPageLayout runat="server" GridType="Fluid" ShowGrid="true" HtmlTag="None">
				<telerik:LayoutRow RowType="Generic">
					<Rows>
						<telerik:LayoutRow RowType="Generic" CssClass="header">
							<Rows>
								<telerik:LayoutRow RowType="Container" WrapperHtmlTag="Div">
									<Columns>
										<telerik:LayoutColumn Span="12">
											<br />
											<img src="images/ccfn-logo.png" alt="" />
											<br /><br />
											<h1>CCFN - Descarga de Facturas <i>v1.0</i></h1>
											<br /><br />
										</telerik:LayoutColumn>
									</Columns>
								</telerik:LayoutRow>
							</Rows>
						</telerik:LayoutRow>
						<telerik:LayoutRow RowType="Generic" CssClass="content">
							<Rows>
								<telerik:LayoutRow RowType="Container" WrapperHtmlTag="Div">
									<Columns>
										<telerik:LayoutColumn Span="2" SpanXs="1" />
										<telerik:LayoutColumn Span="4" SpanXs="5" CssClass="rightborder">
											<div class="description">
												<h2>Reg&iacute;strese si a&uacute;n no tiene su cuenta</h2>
												<p>
													<br />
													<telerik:RadTextBox ID="txtCommercialName" runat="server" Label="Nombre comercial:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtCommercialName" Text="*" />
													<br /><br />
													<telerik:RadTextBox ID="txtRFC" runat="server" Label="RFC:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtRFC" Text="*" />
													<br /><br />
													<telerik:RadTextBox ID="txtEmail" runat="server" Label="Email:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtEmail" Text="*" />
													<br /><br />
													<telerik:RadTextBox ID="txtUsernameIn" runat="server" Label="Usuario:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtUsernameIn" Text="*" />
													<br /><br />
													<telerik:RadTextBox ID="txtPasswordIn" runat="server" TextMode="Password" Label="Constraseña:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtPasswordIn" Text="*" />
													<br /><br />
													<telerik:RadTextBox ID="txtPasswordConfirmIn" runat="server" TextMode="Password" Label="Repetir constraseña:" LabelWidth="110px" Width="250px" />
													<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ValidationGroup="Registration" ControlToValidate="txtPasswordConfirmIn" Text="*" />
													<br /><br />
													<telerik:RadButton ID="btnRegister" runat="server" Text="Registrarse" onclick="btnRegister_Click" Skin="MetroTouch" UseSubmitBehavior="false" ValidationGroup="Registration" />
													<br /><br />
													<telerik:RadLabel ID="lblErrorIn" runat="server" Visible="false" Font-Bold="true" ForeColor="Red"></telerik:RadLabel>
													<telerik:RadLabel ID="lblRegistered" runat="server" Visible="false" Font-Bold="true" ForeColor="Blue"></telerik:RadLabel>
												</p>
											</div>
										</telerik:LayoutColumn>
										<telerik:LayoutColumn Span="4" SpanXs="5" CssClass="rightborder">
											<div class="description">
												<h2>Ingrese con sus datos</h2>
												<br />
												<%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
												<telerik:RadTextBox ID="txtUsername" runat="server" Label="Usuario:" LabelWidth="70px" Width="185px" />
												<br /><br />
												<telerik:RadTextBox ID="txtPassword" runat="server" TextMode="Password" Label="Contraseña:" LabelWidth="70px" Width="185px"/>
												<br /><br />
												<telerik:RadButton ID="btnLogin" runat="server" Text="Ingresar" onclick="btnLogin_Click" Skin="MetroTouch" Primary="true" CausesValidation="false" />
												<br /><br />
												<telerik:RadLinkButton ID="lnkSendPassword" runat="server" Text="Olvidé mi contraseña" OnClientClicked="PasswordRetrive" CssClass="rbClearButton rbHyperlinkButton"></telerik:RadLinkButton>
												<span class="glyphicon glyphicon-question-sign" data-toggle="popover" title="Contacto" data-content="adriana.ochoa@superchivas.com.mx, paula.rodriguez@superchivas.com.mx"></span>
												<br />
												<telerik:RadLabel ID="lblError" runat="server" Visible="false" Font-Bold="true" ForeColor="Red"></telerik:RadLabel>
												<telerik:RadLabel ID="lblPasswordSent" runat="server" Visible="false" Font-Bold="true" ForeColor="Blue"></telerik:RadLabel>
											</div>
										</telerik:LayoutColumn>
										<telerik:LayoutColumn Span="2" SpanXs="1" />
									</Columns>
								</telerik:LayoutRow>
							</Rows>
						</telerik:LayoutRow>
					</Rows>
				</telerik:LayoutRow>
			</telerik:RadPageLayout>
		</div>
    </form>
</body>
<!-- jQuery 2.2.3 -->
<script src="js/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="js/bootstrap.min.js"></script>

<script>
$(document).ready(function(){
    $('[data-toggle="popover"]').popover(); 
});
</script>
</html>