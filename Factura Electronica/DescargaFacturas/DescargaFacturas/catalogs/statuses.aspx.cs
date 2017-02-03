using System;
using System.Web.UI;

namespace DescargaFacturas.catalogs
{
	public partial class statuses : Page
	{
		private string gridMessage;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
		}
	}
}