<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="statuses.aspx.cs" Inherits="DescargaFacturas.catalogs.statuses" Title="CCFN - ESTATUS" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script type="text/javascript">
		function onRequestStart(sender, args) {
			if (args.get_eventTarget().indexOf("ExportToExcelButton") >= 0)
				args.set_enableAjax(false);
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
		</AjaxSettings>
		<ClientEvents OnRequestStart="onRequestStart" />
	</telerik:RadAjaxManager>
	<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All" />
	<br /><br />
	<table align="center">
		<tr>
			<td class="header_title1">
				<label style="font-size: medium"><b>CATALOGOS > ESTATUS</b></label><br /><br />
			</td>
		</tr>
		<tr>
			<td>
				<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
				<telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="dsStatuses" AllowFilteringByColumn="True" AllowPaging="False" AllowSorting="True" CellSpacing="0" GridLines="None" FilterMenu-EnableImageSprites="false">
					<ExportSettings HideStructureColumns="true" Excel-Format="ExcelML" ExportOnlyData="true" FileName="CCFNEstatus" IgnorePaging="true" />
					<MasterTableView DataSourceID="dsStatuses" AutoGenerateColumns="False" DataKeyNames="StatusId" CommandItemDisplay="Top">
						<CommandItemSettings ShowRefreshButton="true" ShowExportToExcelButton="true" RefreshText="Refrescar" ShowAddNewRecordButton="false" />
						<Columns>
							<telerik:GridBoundColumn DataField="StatusId" DataType="System.Int32" ReadOnly="True" UniqueName="StatusId" Display="false" />
							<telerik:GridBoundColumn DataField="Name" HeaderText="Nombre" SortExpression="Name" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" />
						</Columns>
					</MasterTableView>
				</telerik:RadGrid>
				<asp:EntityDataSource ID="dsStatuses" runat="server" ConnectionString="name=CCFNEntities" DefaultContainerName="CCFNEntities" EntitySetName="Statuses" EntityTypeFilter="Statuses" OrderBy="it.Name" EnableFlattening="false" />
			</td>
		</tr>
	</table>
</asp:Content>