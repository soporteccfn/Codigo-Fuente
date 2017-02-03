<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="viewlogs.aspx.cs" Inherits="DescargaFacturas.logs.viewlogs" Title="CCFN - HISTORIAL" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<script type="text/javascript">
		function onRequestStart(sender, args) {
			if (args.get_eventTarget().indexOf("ExportToExcelButton") >= 0)
				args.set_enableAjax(false);
		}
		function openPDF(FacturaId) {
			window.location = "invoicesget.aspx?FacturaId=" + FacturaId + "&FileType=PDF";
		}
		function openXML(FacturaId) {
			window.location = "invoicesget.aspx?FacturaId=" + FacturaId + "&FileType=XML";
		}
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
	<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
		<AjaxSettings>
			<telerik:AjaxSetting AjaxControlID="RadGrid1">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
			<telerik:AjaxSetting AjaxControlID="btnSearch">
				<UpdatedControls>
					<telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
				</UpdatedControls>
			</telerik:AjaxSetting>
		</AjaxSettings>
		<ClientEvents OnRequestStart="onRequestStart" />
	</telerik:RadAjaxManager>
	<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All" />
	<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="True" Style="z-index: 7001" />
	<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
	<br /><br />
	<div align="center">
		<table align="center">
			<tr>
				<td class="header_title1">
					<label style="font-size: medium"><b>FACTURAS > LISTADO DE FACTURAS</b></label><br /><br />
				</td>
			</tr>
			<tr>
				<td>
					<table border="0" cellpadding="5" cellspacing="0">
						<tr>
							<td colspan="4"><label style="font-weight:bold">Buscar en historial:</label></td>
						</tr>
						<tr>
							<td><label>RFC:</label></td>
							<td>
								<telerik:RadTextBox ID="txtRFC" runat="server" />
							</td>
							<td><label>Nombre del cliente:</label></td>
							<td>
								<telerik:RadTextBox ID="txtNombre" runat="server" />
							</td>
						</tr>
						<tr>
							<td><label>Folio de factura:</label></td>
							<td>
								<telerik:RadTextBox ID="txtFolio" runat="server" />
							</td>
							<td><label>Acci&oacute;n efectuada:</label></td>
							<td>
								<telerik:RadComboBox ID="cmbActionId" runat="server" DataSourceID="dsActions" DataTextField="Name" DataValueField="ActionId" AppendDataBoundItems="true" DropDownAutoWidth="Enabled">
									<Items>
										<telerik:RadComboBoxItem Value="0" Text="TODAS" />
									</Items>
								</telerik:RadComboBox>
								<asp:SqlDataSource ID="dsActions" runat="server" ConnectionString="<%$ ConnectionStrings:CCFNDB %>" SelectCommand="SELECT a.Name, a.ActionId FROM Actions a ORDER BY 1" />
							</td>
						</tr>
						<tr>
							<td><label>Con fecha desde:</label></td>
							<td>
								<telerik:RadDatePicker ID="dteDesde" runat="server" DateInput-DisplayDateFormat="yyyy-MM-dd" Calendar-ShowRowHeaders="false" />
							</td>
							<td><label>Con fecha hasta:</label></td>
							<td>
								<telerik:RadDatePicker ID="dteHasta" runat="server" DateInput-DisplayDateFormat="yyyy-MM-dd" Calendar-ShowRowHeaders="false" />
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td colspan="4"><telerik:RadButton ID="btnSearch" runat="server" Text="Buscar" OnClick="btnSearch_Click"></telerik:RadButton></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="false" AllowPaging="true" AllowSorting="true" CellSpacing="0" GridLines="None" FilterMenu-EnableImageSprites="false" AutoGenerateColumns="false"  OnNeedDataSource="RadGrid1_NeedDataSource" ClientSettings-Selecting-AllowRowSelect="true" Width="800px" PageSize="25">
						<ExportSettings HideStructureColumns="true" Excel-Format="ExcelML" ExportOnlyData="true" FileName="CCFNHistorial" IgnorePaging="true" />
						<MasterTableView DataKeyNames="LogId" CommandItemDisplay="Top" NoMasterRecordsText="No hay facturas disponibles.">
							<CommandItemSettings ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" RefreshText="Refrescar" />
							<Columns>
								<telerik:GridBoundColumn DataField="ACTIONNAME" HeaderText="TIPO DE CONSULTA" UniqueName="colACTIONNAME" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
								<telerik:GridBoundColumn DataField="PERFORMEDBYNAME" HeaderText="CONSULTADO POR" UniqueName="colPERFORMEDBYNAME" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
								<telerik:GridBoundColumn DataField="PERFORMED" HeaderText="FECHA DE CONSULTA" UniqueName="colPERFORMED" DataFormatString="{0: yyyy-MM-dd HH:mm:ss}" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
								<telerik:GridBoundColumn DataField="RFC" HeaderText="RFC" UniqueName="colRFC" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
								<telerik:GridBoundColumn DataField="FOLIO" HeaderText="FOLIO DE FACTURA" UniqueName="colFOLIO" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" />
								<telerik:GridBoundColumn DataField="FECHAFACTURA" HeaderText="FECHA DE FACTURA" UniqueName="colFECHAFACTURA" DataFormatString="{0: yyyy-MM-dd}" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
								<telerik:GridBoundColumn DataField="SEARCHTEXT" HeaderText="TEXTO BUSCADO" UniqueName="colSEARCHTEXT" HeaderStyle-Wrap="false" ItemStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" />
							</Columns>
						</MasterTableView>
					</telerik:RadGrid>
				</td>
			</tr>
		</table>
	</div>
</asp:Content>