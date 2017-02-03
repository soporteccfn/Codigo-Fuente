using System;
using System.Web.UI;
using DescargaFacturas.BL;
using Telerik.Web.UI;

namespace DescargaFacturas.catalogs
{
	public partial class roles : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
			var user = UserBL.GetUserById(int.Parse(Request["UserId"]));
			lblName.Text = user.Name + " " + user.Lastname;
		}

		protected void RadGridRoles_DeleteCommand(object sender, GridCommandEventArgs e)
		{
			var dataItem = (GridDataItem)e.Item;
			var role = dataItem.GetDataKeyValue("RoleId").ToString();
			UserBL.RemoveRoleFromUser(int.Parse(Request["UserId"]), int.Parse(role));
			grdUserRoles.Rebind();
			cmbRoles.DataBind();
		}

		protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
		{
			if (!string.IsNullOrEmpty(cmbRoles.SelectedValue))
			{
				UserBL.AddRoleToUser(int.Parse(Request["UserId"]), int.Parse(cmbRoles.SelectedValue));
				grdUserRoles.Rebind();
				cmbRoles.DataBind();
				ImageButton1.Visible = cmbRoles.Items.Count > 0;
			}
		}
	}
}