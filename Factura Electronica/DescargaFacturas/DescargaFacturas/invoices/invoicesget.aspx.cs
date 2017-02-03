using System;
using System.IO;
using System.Linq;
using DescargaFacturas.BL;
using DescargaFacturas.DA;

namespace DescargaFacturas.invoices
{
	public partial class invoicesget : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				var invoiceId = int.Parse(Request["FacturaId"].ToString());
				var invoice = GeneralBL.GetInvoice(invoiceId);
				var lstParameters = ParameterBL.GetParameters();
				var filesPath = lstParameters.Where(p => p.Name.Equals("FilesPath")).FirstOrDefault().Value;
				if (Request["FileType"].ToString() == "PDF")
				{
					GeneralBL.Log((int)Constants.Actions.DESCARGA_PDF, ((Users)Session["CCFNUser"]).UserId, "", invoiceId);
					var fileInfo = new FileInfo(filesPath + invoice.RFC + "\\" + invoice.PDF);
					Response.Clear();
					Response.ClearHeaders();
					Response.ClearContent();
					Response.AddHeader("Content-Disposition", "attachment; filename=" + invoice.PDF);
					Response.AddHeader("Content-Length", fileInfo.Length.ToString());
					Response.ContentType = "text/plain";
					Response.Flush();
					Response.TransmitFile(filesPath + invoice.RFC + "\\" + invoice.PDF);
					Response.End();
				}
				else if (Request["FileType"].ToString() == "XML")
				{
					GeneralBL.Log((int)Constants.Actions.DESCARGA_XML, ((Users)Session["CCFNUser"]).UserId, "", invoiceId);
					var fileInfo = new FileInfo(filesPath + invoice.RFC + "\\" + invoice.XML);
					Response.Clear();
					Response.ClearHeaders();
					Response.ClearContent();
					Response.AddHeader("Content-Disposition", "attachment; filename=" + invoice.XML);
					Response.AddHeader("Content-Length", fileInfo.Length.ToString());
					Response.ContentType = "text/plain";
					Response.Flush();
					Response.TransmitFile(filesPath + invoice.RFC + "\\" + invoice.XML);
					Response.End();
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
	}
}