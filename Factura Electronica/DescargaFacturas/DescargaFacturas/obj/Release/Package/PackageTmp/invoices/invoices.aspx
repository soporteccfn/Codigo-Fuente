<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="invoices.aspx.cs" Inherits="DescargaFacturas.invoices.invoices" Title="CCFN - FACTURAS" %>
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
		function OnClientClicked(sender, args) {
			var grid = $find("<%=RadGrid1.ClientID %>");
			var MasterTable = grid.get_masterTableView();
			var selectedRows = MasterTable.get_selectedItems();
			var Facturas = "";
			if (selectedRows.length > 0) {
				for (var i = 0; i < selectedRows.length; i++) {
					var row = selectedRows[i];
					var FacturaId = row.getDataKeyValue("FacturaId");
					Facturas += FacturaId + ",";
				}
				Facturas = Facturas.replace(/,\s*$/, "");
				window.location = "invoicesgetmultiple.aspx?Facturas=" + Facturas;
			}
			else alert('Debe seleccionar al menos un renglón.');
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
							<td colspan="4"><label style="font-weight:bold">Buscar factura:</label></td>
						</tr>
						<tr>
							<td><label>Serie:</label></td>
							<td>
								<telerik:RadTextBox ID="txtSerie" runat="server" />
							</td>
							<td><label>Folio:</label></td>
							<td>
								<telerik:RadTextBox ID="txtFolio" runat="server" />
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
						<tr runat="server" id="trAdmin1" visible="false">
							<td><label>Sucursal:</label></td>
							<td>
								<telerik:RadTextBox ID="txtSucursal" runat="server" />
							</td>
							<td><label>Código cliente:</label></td>
							<td>
								<telerik:RadTextBox ID="txtCodigoCliente" runat="server" />
							</td>
						</tr>
						<tr runat="server" id="trAdmin2" visible="false">
							<td><label>RFC:</label></td>
							<td>
								<telerik:RadTextBox ID="txtRFC" runat="server" />
							</td>
							<td><label>&nbsp;</label></td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="4"><telerik:RadButton ID="btnSearch" runat="server" Text="Buscar" OnClick="btnSearch_Click"></telerik:RadButton></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="true" CellSpacing="0" GridLines="None" FilterMenu-EnableImageSprites="false" AutoGenerateColumns="false"  OnNeedDataSource="RadGrid1_NeedDataSource" ClientSettings-Selecting-AllowRowSelect="true" AllowMultiRowSelection="true">
						<ExportSettings HideStructureColumns="true" Excel-Format="ExcelML" ExportOnlyData="true" FileName="CCFNFacturas" IgnorePaging="true" />
						<MasterTableView DataKeyNames="FacturaId" CommandItemDisplay="Top" NoMasterRecordsText="No hay facturas disponibles." ClientDataKeyNames="FacturaId">
							<CommandItemSettings ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" RefreshText="Refrescar" />
							<Columns>
								<telerik:GridClientSelectColumn UniqueName="colSelectInvoice" />
								<telerik:GridBoundColumn DataField="FacturaId" UniqueName="colFacturaId" Visible="false" />
								<telerik:GridBoundColumn DataField="ID" HeaderText="ID" UniqueName="colID" />
								<telerik:GridBoundColumn DataField="SUCURSAL" HeaderText="SUCURSAL" UniqueName="colSUCURSAL" />
								<telerik:GridBoundColumn DataField="SERIE" HeaderText="SERIE" UniqueName="colSERIE" />
								<telerik:GridBoundColumn DataField="FOLIO" HeaderText="FOLIO" UniqueName="colFOLIO" />
								<telerik:GridBoundColumn DataField="FECHA" HeaderText="FECHA FACTURA" UniqueName="colFECHA" DataFormatString="{0: yyyy-MM-dd}" />
								<telerik:GridBoundColumn DataField="RFC" HeaderText="RFC" UniqueName="colRFC" />
								<telerik:GridBoundColumn DataField="CODIGOCLIENTE" HeaderText="CODIGO CLIENTE" UniqueName="colCODIGOCLIENTE" />
								<telerik:GridBoundColumn DataField="RAZONSOCIAL" HeaderText="RAZON SOCIAL" UniqueName="colRAZONSOCIAL" />
								<telerik:GridBoundColumn DataField="SUBTOTAL" HeaderText="SUBTOTAL" UniqueName="colSUBTOTAL" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}" />
								<telerik:GridBoundColumn DataField="IVA" HeaderText="IVA" UniqueName="colIVA" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}" />
								<telerik:GridBoundColumn DataField="IEPS" HeaderText="IEPS" UniqueName="colIEPS" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}" />
								<telerik:GridBoundColumn DataField="TOTAL" HeaderText="TOTAL" UniqueName="colTOTAL" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:C2}" />
								<telerik:GridTemplateColumn HeaderText="PDF" UniqueName="colPDF" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<asp:ImageButton ID="openPDF" runat="server" ImageUrl="../images/pdf_icon.png" Width="16px" Height="16px"
											AlternateText="View" OnClientClick='<%# "openPDF(\"" + Eval("FacturaId") + "\"); return false;" %>'
											ImageAlign="AbsMiddle" />
									</ItemTemplate>
								</telerik:GridTemplateColumn>
								<telerik:GridTemplateColumn HeaderText="XML" UniqueName="colXML" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
									<ItemTemplate>
										<asp:ImageButton ID="openXML" runat="server" ImageUrl="../images/document16.png" Width="16px" Height="16px"
											AlternateText="View" OnClientClick='<%# "openXML(\"" + Eval("FacturaId") + "\"); return false;" %>'
											ImageAlign="AbsMiddle" />
									</ItemTemplate>
								</telerik:GridTemplateColumn>
							</Columns>
						</MasterTableView>
					</telerik:RadGrid>
					<br />
					<telerik:RadButton ID="btnMultipleDownload" runat="server" Text="Bajar facturas seleccionadas" AutoPostBack="false" OnClientClicked="OnClientClicked"></telerik:RadButton>
				</td>
			</tr>
		</table>
	</div>
</asp:Content>