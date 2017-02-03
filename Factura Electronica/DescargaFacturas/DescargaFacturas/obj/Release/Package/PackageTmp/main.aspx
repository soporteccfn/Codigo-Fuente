<%@ Page Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="DescargaFacturas.main" Title="CCFN - INICIO" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
	<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="True" Style="z-index: 7001" />
	<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
	<br />
	<div align="center">
		<center>
			<telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="true" CellSpacing="0" GridLines="None" FilterMenu-EnableImageSprites="false" AutoGenerateColumns="false"  OnNeedDataSource="RadGrid1_NeedDataSource" ClientSettings-Selecting-AllowRowSelect="true" Width="800px" OnItemCommand="RadGrid1_ItemCommand">
				<ExportSettings HideStructureColumns="true" Excel-Format="ExcelML" ExportOnlyData="true" FileName="CCFNUsuariosPendientes" IgnorePaging="true" />
				<MasterTableView DataKeyNames="UserId" CommandItemDisplay="Top" NoMasterRecordsText="No hay usuarios pendientes por aprobar.">
					<CommandItemSettings ShowRefreshButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" RefreshText="Refrescar" />
					<Columns>
						<telerik:GridBoundColumn DataField="Name" HeaderText="NOMBRE COMERCIAL" UniqueName="colNAME" />
						<telerik:GridBoundColumn DataField="RFC" HeaderText="RFC" UniqueName="colRFC" />
						<telerik:GridBoundColumn DataField="EMAIL" HeaderText="EMAIL" UniqueName="colEMAIL" />
						<telerik:GridBoundColumn DataField="Username" HeaderText="USUARIO" UniqueName="colUSERNAME" />
						<telerik:GridBoundColumn DataField="UserRoles" HeaderText="ROL" UniqueName="colUSERROLES" />
						<telerik:GridBoundColumn DataField="StatusName" HeaderText="ESTATUS" UniqueName="colSTATUSNAME" />
						<telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmTitle="Aprobar" ButtonType="ImageButton" CommandName="Approve" UniqueName="colAPPROVE" ImageUrl="images/check.png" ItemStyle-HorizontalAlign="Center" ConfirmTextFormatString="¿En realidad desea aprobar este cliente? ({0})" ConfirmTextFields="Name" />
						<telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmTitle="Rechazar" ButtonType="ImageButton" CommandName="Reject" UniqueName="colREJECT" ImageUrl="images/icon_cancel.png" ItemStyle-HorizontalAlign="Center" ConfirmTextFormatString="¿En realidad desea rechazar este cliente? ({0})" ConfirmTextFields="Name" />
					</Columns>
				</MasterTableView>
			</telerik:RadGrid>
		</center>
	</div>
</asp:Content>