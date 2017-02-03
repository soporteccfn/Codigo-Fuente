<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="parameters.aspx.cs" Inherits="DescargaFacturas.catalogs.parameters" Title="CCFN - Parámetros" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
	<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
	<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All" />
	<center>
		<br /><br />
		<table class="center">
			<tr>
				<td class="header_title1">
					<label style="font-size: medium"><b>CATALOGOS > PAR&Aacute;METROS</b></label><br /><br />
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="2" cellspacing="0" style="margin: auto; " width="100%">
						<tr valign="middle">
							<td align="left">
								Mensaje de registro exitoso:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtRegistrationSuccessMessage" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Ruta de los archivos:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtFilesPath" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Enviar correos:
							</td>
							<td align="left">
								<telerik:RadComboBox ID="cmbSendEmails" runat="server">
									<Items>
										<telerik:RadComboBoxItem Text="SI" Value="S" />
										<telerik:RadComboBoxItem Text="NO" Value="N" />
									</Items>
								</telerik:RadComboBox>
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Dirección de correo:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtEmailFrom" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Nombre desplegado en correo:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtEmailFromName" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Servidor de correo:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtEmailIP" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Puerto del servidor:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtEmailPort" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Usa SSL:
							</td>
							<td align="left">
								<telerik:RadComboBox ID="cmbSSL" runat="server">
									<Items>
										<telerik:RadComboBoxItem Text="SI" Value="S" />
										<telerik:RadComboBoxItem Text="NO" Value="N" />
									</Items>
								</telerik:RadComboBox>
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Contraseña de la cuenta<br />
								de correo:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtEmailPassword" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Título del correo de<br />
								recuperación de contraseña:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtForgotPasswordSubject" runat="server" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Texto del correo de<br />
								recuperación de contraseña<br />
								{Password} se sustituirá por<br />
								la contraseña del usuario:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtForgotPasswordBody" runat="server" TextMode="MultiLine" Rows="3" Columns="30" />
							</td>
						</tr>
						<tr valign="middle">
							<td align="left">
								Mensaje una vez enviada<br />
								la contraseña:
							</td>
							<td align="left">
								<telerik:RadTextBox ID="txtPasswordSentText" runat="server" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<telerik:RadButton ID="btnSave" runat="server" Text="Guardar" OnClick="btnSave_Click" SingleClick="true" SingleClickText="Guardando..."></telerik:RadButton>
				</td>
			</tr>
		</table>
	</center>
</asp:Content>