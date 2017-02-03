using System;
using System.Collections.Generic;
using System.Web;
using Telerik.Web.UI;
using DescargaFacturas.DA;

namespace DescargaFacturas
{
	public partial class Site : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			try
			{
				if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
				if (!IsPostBack)
				{
					lblUsername.Text = ((Users)Session["CCFNUser"]).Name + " " + ((Users)Session["CCFNUser"]).Lastname;
					var lstRoles = (List<Roles>)Session["CCFNRoles"];
					var rolesCSV = "";
					lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
					lblRoles.Text = rolesCSV = rolesCSV.TrimEnd(',', ' ');

					mnuCCFN.Items.Add(new RadMenuItem("INICIO", "main.aspx"));

					var itmFacturas = new RadMenuItem("FACTURAS");
					if (rolesCSV.Contains("ADMINISTRADOR") || rolesCSV.Contains("CLIENTE")) itmFacturas.Items.Add(new RadMenuItem("Listado de facturas", "~/invoices/invoices.aspx"));
					if (itmFacturas.Items.Count > 0) mnuCCFN.Items.Add(itmFacturas);

					var itmLogs = new RadMenuItem("HISTORIAL");
					if (rolesCSV.Contains("ADMINISTRADOR")) itmLogs.Items.Add(new RadMenuItem("Visualizar historial", "~/logs/viewlogs.aspx"));
					if (itmLogs.Items.Count > 0) mnuCCFN.Items.Add(itmLogs);

					var itmCatalogos = new RadMenuItem("CATALOGOS");
					if (rolesCSV.Contains("ADMINISTRADOR")) itmCatalogos.Items.Add(new RadMenuItem("Usuarios", "~/catalogs/users.aspx"));
					if (rolesCSV.Contains("ADMINISTRADOR")) itmCatalogos.Items.Add(new RadMenuItem("Estatus", "~/catalogs/statuses.aspx"));
					if (rolesCSV.Contains("ADMINISTRADOR")) itmCatalogos.Items.Add(new RadMenuItem("Par&aacute;metros", "~/catalogs/parameters.aspx"));
					if (itmCatalogos.Items.Count > 0) mnuCCFN.Items.Add(itmCatalogos);
				}
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
		}

		protected void lnkLogout_Click(object sender, EventArgs e)
		{
			try
			{
				Session["CCFNUser"] = null;
				Session["CCFNRoles"] = null;
				Response.Redirect("~/login.aspx");
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
		}
	}
}