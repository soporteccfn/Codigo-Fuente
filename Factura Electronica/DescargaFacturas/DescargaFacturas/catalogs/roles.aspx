<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="roles.aspx.cs" Inherits="DescargaFacturas.catalogs.roles" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>CCFN - Roles</title>
</head>
<body>
	<form id="form1" runat="server">
	<telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
	<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All" />
	<table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <div align="left">
                    <label id="lblTitle" runat="server" style="font-size:medium">Roles para: <b><asp:Label ID="lblName" runat="server" Text=""></asp:Label></b></label>
                    <hr />
                </div>
            </td>
        </tr>
	</table>
	<br />
	<table style="visibility: visible">
        <tr>
            <td>
                <asp:Label ID="lblInstruction" runat="server" AssociatedControlID="cmbRoles">Seleccione un rol:</asp:Label>
            </td>
            <td>
                <telerik:RadComboBox ID="cmbRoles" runat="server" DataSourceID="dsRolesLeft" DataTextField="Name" DataValueField="RoleId" DropDownAutoWidth="Enabled" />
            </td>
            <td>
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="../images/add_small.png" OnClick="ImageButton1_Click" />
            </td>
        </tr>
    </table>
    <br />
	<telerik:RadGrid ID="grdUserRoles" runat="server" CellSpacing="0" DataSourceID="dsUserRoles" GridLines="None" OnDeleteCommand="RadGridRoles_DeleteCommand" FilterMenu-EnableImageSprites="false">
		<MasterTableView autogeneratecolumns="False" datakeynames="RoleId" datasourceid="dsUserRoles">
			<Columns>
				<telerik:GridBoundColumn DataField="Name" HeaderText="Nombre" SortExpression="Name" UniqueName="Name" />
				 <telerik:GridButtonColumn ConfirmText="¿En realidad desea eliminar este registro?" ConfirmDialogType="RadWindow" ConfirmTitle="Confirmación" ButtonType="ImageButton" CommandName="Delete" UniqueName="DeleteColumn" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</MasterTableView>
	</telerik:RadGrid>
	<asp:SqlDataSource ID="dsUserRoles" runat="server" ConnectionString="<%$ ConnectionStrings:CCFNDB %>"
        SelectCommand="SELECT r.Name, r.RoleId
						  FROM UserRoleXREF ur
						    INNER JOIN Roles r ON ur.RoleId = r.RoleId
						  WHERE ur.UserId = @UserId AND r.ActiveFlag = 1
						  ORDER BY r.Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="UserId" QueryStringField="UserId" Type="String" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
	<asp:SqlDataSource ID="dsRolesLeft" runat="server" ConnectionString="<%$ ConnectionStrings:CCFNDB %>"
        SelectCommand="SELECT r.Name, r.RoleId
						  FROM Roles r
						  WHERE r.ActiveFlag = 1
						    AND r.RoleId NOT IN (SELECT ur.RoleId FROM UserRoleXREF ur WHERE ur.UserId = @UserId)
						  ORDER BY r.Name">
        <SelectParameters>
            <asp:QueryStringParameter Name="UserId" QueryStringField="UserId" Type="String" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
	</form>
</body>
</html>