using System;
using System.Collections.Generic;
using System.Web.UI;
using Telerik.Web.UI;
using DescargaFacturas.BL;
using DescargaFacturas.DA;

namespace DescargaFacturas
{
	public partial class main : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
				if (!IsPostBack)
				{
					var lstRoles = (List<Roles>)Session["CCFNRoles"];
					var rolesCSV = "";
					lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
					rolesCSV = rolesCSV.TrimEnd(',', ' ');
                    if (rolesCSV.Contains("ADMINISTRADOR"))
                    {
                        GetDataSourcePendingUsers();
                        RadGrid1.DataBind();
                    }
                    else
                    {
                        Response.Redirect("invoices/invoices.aspx");
                    }
				}
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
		}

		protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
		{
			GetDataSourcePendingUsers();
		}

		protected void GetDataSourcePendingUsers()
		{
			RadGrid1.DataSource = UserBL.GetPendingUsers();
		}

		protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
		{
			try
			{
				var userId = int.Parse(((GridDataItem)e.Item).GetDataKeyValue("UserId").ToString());
				if (e.CommandName == "Approve")
					UserBL.ApproveUser(userId, ((DA.Users)Session["CCFNUser"]).UserId);
				else if (e.CommandName == "Reject")
					UserBL.RejectUser(userId, ((DA.Users)Session["CCFNUser"]).UserId);
				RadGrid1.Rebind();
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
	}
}