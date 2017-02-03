using System;
using System.Web.UI;
using DescargaFacturas.BL;
using Telerik.Web.UI;
using DescargaFacturas.DA;
using System.Collections.Generic;
using System.IO;

namespace DescargaFacturas.logs
{
	public partial class viewlogs : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
				if (!IsPostBack)
				{
					GetDataSourceInvoices();
					RadGrid1.DataBind();
				}
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
		}

		protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
		{
			GetDataSourceInvoices();
		}

		protected void GetDataSourceInvoices()
		{
			var lstRoles = (List<Roles>)Session["CCFNRoles"];
			var rolesCSV = "";
			lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
			rolesCSV = rolesCSV.TrimEnd(',', ' ');
			RadGrid1.DataSource = GeneralBL.GetLog(txtRFC.Text, txtNombre.Text, txtFolio.Text, cmbActionId.SelectedValue, dteDesde.SelectedDate, dteHasta.SelectedDate);
		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			GetDataSourceInvoices();
			RadGrid1.DataBind();
		}
	}
}