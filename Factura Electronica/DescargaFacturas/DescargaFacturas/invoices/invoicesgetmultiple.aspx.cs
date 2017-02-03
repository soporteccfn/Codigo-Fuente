using System;
using System.Data;
using System.IO;
using System.Linq;
using Telerik.Windows.Zip;
using DescargaFacturas.BL;
using DescargaFacturas.DA;

namespace DescargaFacturas.invoices
{
	public partial class invoicesgetmultiple : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				var lstFacturas = Request["Facturas"];
				var files = GeneralBL.GetInvoiceFiles(lstFacturas, ((Users)Session["CCFNUser"]).UserId);

				if (files.Rows.Count > 0)
				{
					var lstParameters = ParameterBL.GetParameters();
					var filesPath = lstParameters.Where(p => p.Name.Equals("FilesPath")).FirstOrDefault().Value;

					var memStream = new MemoryStream();

					using (var archive = new ZipArchive(memStream, ZipArchiveMode.Create, true, null))
					{
						foreach (DataRow row in files.Rows)
						{
							if (File.Exists(filesPath + row["RFC"] + "\\" + row["PDF"]))
								using (var entry = archive.CreateEntry(row["PDF"].ToString()))
								{
									using (var stream = new MemoryStream(File.ReadAllBytes(filesPath + row["RFC"] + "\\" + row["PDF"])))
									{
										var writer = new BinaryWriter(entry.Open());
										writer.Write(stream.ToArray());
										writer.Flush();
									}
								}

							if (File.Exists(filesPath + row["RFC"] + "\\" + row["XML"]))
								using (var entry = archive.CreateEntry(row["XML"].ToString()))
								{
									using (var stream = new MemoryStream(File.ReadAllBytes(filesPath + row["RFC"] + "\\" + row["XML"])))
									{
										var writer = new BinaryWriter(entry.Open());
										writer.Write(stream.ToArray());
										writer.Flush();
									}
								}
						}
					}

					memStream.Seek(0, SeekOrigin.Begin);
					if (memStream != null && memStream.Length > 0)
					{
						Response.Clear();
						Response.AddHeader("content-disposition", "attachment; filename=facturas.zip");
						Response.ContentType = "application/zip";
						Response.BinaryWrite(memStream.ToArray());
						Response.End();
					}
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
	}
}