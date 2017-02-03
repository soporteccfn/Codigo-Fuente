<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="DescargaFacturas.catalogs.users" Title="CCFN - USUARIOS" %>
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
	<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="True" Style="z-index: 7001" />
	<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" />
	<br /><br />
	<table align="center">
		<tr>
			<td class="header_title1">
				<label style="font-size: medium"><b>CATALOGOS > USUARIOS</b></label><br /><br />
			</td>
		</tr>
		<tr>
			<td>
				<telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="dsUsers" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="0" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowAutomaticDeletes="true" PageSize="500" OnItemInserted="RadGrid1_ItemInserted" OnItemUpdated="RadGrid1_ItemUpdated" OnItemDeleted="RadGrid1_ItemDeleted" OnDataBound="RadGrid1_DataBound" GridLines="None" FilterMenu-EnableImageSprites="false" ClientSettings-Selecting-AllowRowSelect="true" ClientSettings-EnableRowHoverStyle="true">
					<ExportSettings HideStructureColumns="true" Excel-Format="ExcelML" ExportOnlyData="true" FileName="CCFNUsuarios" IgnorePaging="true" />
					<MasterTableView DataSourceID="dsUsers" AutoGenerateColumns="False" DataKeyNames="UserId" CommandItemDisplay="Top" TableLayout="Fixed">
						<CommandItemSettings ShowRefreshButton="true" ShowExportToExcelButton="true" AddNewRecordText="Agregar registro" RefreshText="Refrescar" />
						<Columns>
							<telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" ItemStyle-Width="20px" ItemStyle-CssClass="MyImageButton" HeaderStyle-Width="50px" />
							<telerik:GridBoundColumn DataField="UserId" DataType="System.Int32" ReadOnly="True" UniqueName="colUserId" HeaderText="ID" HeaderStyle-Width="50px" AllowFiltering="false" />
							<telerik:GridTemplateColumn DataField="Name" HeaderText="Nombre / N. Comercial" SortExpression="Name" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtName" runat="server" MaxLength="64" Width="200px" Text='<%# Bind("Name") %>' />
									<asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic">
										Required!
									</asp:RequiredFieldValidator>
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Lastname" HeaderText="Apellido" SortExpression="Lastname" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblLastname" runat="server" Text='<%# Eval("Lastname") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtLastname" runat="server" MaxLength="64" Width="200px" Text='<%# Bind("Lastname") %>' />
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="RFC" HeaderText="RFC" SortExpression="RFC" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblRFC" runat="server" Text='<%# Eval("RFC") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtRFC" runat="server" MaxLength="100" Width="200px" Text='<%# Bind("RFC") %>' />
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Phone" HeaderText="Tel&eacute;fono" SortExpression="Phone" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtPhone" runat="server" MaxLength="100" Width="200px" Text='<%# Bind("Phone") %>' />
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Email" HeaderText="Correo" SortExpression="Email" ItemStyle-Width="220px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtEmail" runat="server" MaxLength="64" Width="200px" Text='<%# Bind("Email") %>' />
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Mobile" HeaderText="Celular" SortExpression="Mobile" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtMobile" runat="server" MaxLength="100" Width="200px" Text='<%# Bind("Mobile") %>' />
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Username" HeaderText="Usuario" SortExpression="Username" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="120px">
								<ItemTemplate>
									<asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtUsername" runat="server" MaxLength="100" Width="200px" Text='<%# Bind("Username") %>' />
									<asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic">
										Required!
									</asp:RequiredFieldValidator>
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="Password" HeaderText="Contrase&ntilde;a" SortExpression="Password" Display="false" ItemStyle-Width="180px" HeaderStyle-HorizontalAlign="Center">
								<ItemTemplate>
									<asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>' />
								</ItemTemplate>
								<EditItemTemplate>
									<telerik:RadTextBox ID="txtPassword" runat="server" MaxLength="100" Width="200px" Text='<%# Bind("Password") %>' TextMode="Password" />
									<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic">
										Required!
									</asp:RequiredFieldValidator>
								</EditItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridTemplateColumn DataField="ActiveFlag" HeaderText="Activo" SortExpression="ActiveFlag" UniqueName="ActiveFlag" AllowFiltering="false" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
								<ItemTemplate>
									<asp:CheckBox ID="chkActiveFlagItem" runat="server" Checked='<%# Eval("ActiveFlag") %>' Enabled="false" />
								</ItemTemplate>
								<EditItemTemplate>
									<asp:CheckBox ID="chkActiveFlagEdit" runat="server" Checked='<%# Bind("ActiveFlag") %>' />
								</EditItemTemplate>
								<InsertItemTemplate>
									<asp:CheckBox ID="chkActiveFlagInsert" runat="server" Checked="true" Enabled="false" />
								</InsertItemTemplate>
							</telerik:GridTemplateColumn>
							<telerik:GridBoundColumn DataField="UserRoles" HeaderText="ROL" ReadOnly="True" UniqueName="colUserRoles" HeaderStyle-Width="120px" ItemStyle-Width="120px" FilterControlWidth="80px" />
							<telerik:GridBoundColumn DataField="StatusName" HeaderText="ESTATUS" ReadOnly="True" UniqueName="colStatusName" HeaderStyle-Width="120px" ItemStyle-Width="120px" FilterControlWidth="80px" />
							<telerik:GridButtonColumn ConfirmText="¿En realidad desea eliminar este registro?"
								ConfirmDialogType="RadWindow" ConfirmTitle="Eliminar" ButtonType="ImageButton"
								CommandName="Delete" UniqueName="DeleteColumn" ItemStyle-Width="30px" HeaderStyle-Width="30px">
								<ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
							</telerik:GridButtonColumn>
						</Columns>
					<EditFormSettings ColumnNumber="2" CaptionDataField="UserId" CaptionFormatString="Actualizando" EditColumn-InsertText="Insertar" EditColumn-UpdateText="Actualizar" EditColumn-CancelText="Cancelar">
						<FormTableItemStyle Wrap="False"></FormTableItemStyle>
						<FormCaptionStyle CssClass="EditFormHeader"></FormCaptionStyle>
						<FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3" BackColor="White" Width="100%" />
						<FormTableStyle CellSpacing="0" CellPadding="2" Height="40px" BackColor="White" />
						<FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
						<FormTableButtonRowStyle HorizontalAlign="Right"></FormTableButtonRowStyle>
					</EditFormSettings>
					</MasterTableView>
				</telerik:RadGrid>
				<asp:EntityDataSource ID="dsUsers" runat="server" ConnectionString="name=CCFNEntities" DefaultContainerName="CCFNEntities" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntitySetName="Users" EntityTypeFilter="Users" OnInserting="dsUsers_Inserting" OnUpdating="dsUsers_Updating" OnDeleting="dsUsers_Deleting" OrderBy="it.Name, it.Lastname" EnableFlattening="false" />
			</td>
		</tr>
	</table>
</asp:Content>