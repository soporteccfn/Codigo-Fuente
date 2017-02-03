using System;
using System.Web.UI;
using DescargaFacturas.BL;
using Telerik.Web.UI;
using DescargaFacturas.DA;
using System.Collections.Generic;
using System.IO;

namespace DescargaFacturas.invoices
{
	public partial class invoices : Page
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
					trAdmin1.Visible = trAdmin2.Visible = rolesCSV.Contains("ADMINISTRADOR");
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
			RadGrid1.DataSource = GeneralBL.GetInvoices(rolesCSV.Contains("ADMINISTRADOR"), ((Users)Session["CCFNUser"]).RFC, txtSerie.Text, txtFolio.Text, dteDesde.SelectedDate, dteHasta.SelectedDate, ((Users)Session["CCFNUser"]).UserId, txtSucursal.Text, txtCodigoCliente.Text, txtRFC.Text);
		}

		protected void btnSearch_Click(object sender, EventArgs e)
		{
			GetDataSourceInvoices();
			RadGrid1.DataBind();
		}
	}
}