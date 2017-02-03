using System;
using System.Collections;
using System.Linq;
using DescargaFacturas.DA;
using System.Data;

namespace DescargaFacturas.BL
{
	using S = SQL;
	using AL = ArrayList;

	public class GeneralBL
	{
		public static DataTable GetInvoices(bool isAdmin, string RFC, string Serie, string Folio, DateTime? Desde, DateTime? Hasta, int UserId, string Sucursal, string CodigoCliente, string RFC1)
		{
			Log((int)Constants.Actions.BUSQUEDA
				, UserId,
				(Serie.Equals("") ? "" : "Serie: " + Serie + ".") + " " +
				(Folio.Equals("") ? "" : "Folio: " + Folio + ".") + " " +
				(Desde.HasValue ? "Desde: " + Desde.Value.ToString("yyyy-MM-dd") + "." : "") + " " +
				(Hasta.HasValue ? "Hasta: " + Hasta.Value.ToString("yyyy-MM-dd") + "." : "") + " " +
				(Sucursal.Equals("") ? "" : "Sucursal: " + Sucursal + ".") + " " +
				(CodigoCliente.Equals("") ? "" : "CodigoCliente: " + CodigoCliente + ".") + " " +
				(RFC1.Equals("") ? "" : "RFC: " + RFC1 + ".") + " "
				, null);
			using (var conn = S.GetConnection())
				return S.RunQuery(@"
					SELECT FacturaId, RFC, PDF, XML, REPLACE(LTRIM(REPLACE(Folio,'0',' ')),' ','0') AS Folio, Fecha, Sucursal, CodigoCliente, RazonSocial, ID, Total, Subtotal, IVA, IEPS, Serie
						FROM Facturas
						WHERE (RFC = @p1 OR @p2 = 1)
							AND (Folio LIKE @p3 OR @p4 = '')
							AND (Fecha >= @p5 OR @p6 = '')
							AND (Fecha <= @p7 OR @p8 = '')
							AND (Serie = @p9 OR @p10 = '')
							AND (Sucursal = @p11 OR @p12 = '')
							AND (CodigoCliente = @p13 OR @p14 = '')
							AND (RFC = @p15 OR @p16 = '')
						ORDER BY Folio DESC
					", new AL()
				{
					(RFC ?? "")
					, (isAdmin ? 1 : 0)
					, "%" + Folio + "%", Folio
					, (Desde.HasValue ? Desde.Value.ToString("yyyy-MM-dd") : ""), (Desde.HasValue ? Desde.Value.ToString("yyyy-MM-dd") : "")
					, (Hasta.HasValue ? Hasta.Value.ToString("yyyy-MM-dd") : ""), (Hasta.HasValue ? Hasta.Value.ToString("yyyy-MM-dd") : "")
					, Serie, Serie
					, Sucursal, Sucursal
					, CodigoCliente, CodigoCliente
					, (isAdmin ? RFC1 : RFC), (isAdmin ? RFC1 : RFC)
				}, conn, null);
		}

		public static void Log(int actionId, int userId, string searchText, int? invoiceId)
		{
			using (var db = new CCFNEntities())
			{
				db.Logs.Add(new Logs()
				{
					ActionId = actionId,
					InvoiceId = invoiceId,
					Performed = DateTime.Now,
					PerformedBy = userId,
					SearchText = searchText
				});
				db.SaveChanges();
			}
		}

		public static Facturas GetInvoice(int invoiceId)
		{
			using (var db = new CCFNEntities())
				return db.Facturas.FirstOrDefault(f => f.FacturaId == invoiceId);
		}

		public static DataTable GetInvoiceFiles(string lstFacturas, int UserId)
		{
			var ret = new DataTable();
			using (var conn = S.GetConnection())
				ret = S.RunQuery(@"
					SELECT REPLACE(LTRIM(REPLACE(Folio,'0',' ')),' ','0') AS Folio, PDF, XML, RFC
						FROM Facturas
						WHERE FacturaId IN (" + lstFacturas + @")
						ORDER BY FacturaId", new AL() {  }, conn, null);

			var lstFolios = "";
			foreach (DataRow row in ret.Rows)
				lstFolios += row["Folio"].ToString();

			Log((int)Constants.Actions.DESCARGA_MULTIPLE, UserId, lstFolios, null);

			return ret;
		}

		public static object GetLog(string RFC, string Nombre, string Folio, string ActionId, DateTime? From, DateTime? To)
		{
			using (var conn = S.GetConnection())
				return S.RunQuery(@"
					SELECT l.LogId, a.Name AS ActionName, l.PerformedByName, l.Performed, f.RFC, REPLACE(LTRIM(REPLACE(f.Folio,'0',' ')),' ','0') AS Folio, f.Fecha AS FechaFactura, l.SearchText
						FROM Logs l
							INNER JOIN Actions a ON l.ActionId = a.ActionId
							LEFT OUTER JOIN Facturas f ON l.InvoiceId = f.FacturaId
						WHERE (f.RFC LIKE @p1 OR @p2 = '')
							AND (l.PerformedByName = @p3 OR @p4 = '')
							AND (f.Folio LIKE @p5 OR @p6 = '')
							AND (l.ActionId = @p7 OR @p8 = 0)
							AND (Fecha >= @p9 OR @p10 = '')
							AND (Fecha <= @p11 OR @p12 = '')
						ORDER BY l.Performed DESC", new AL() { "%" + (RFC ?? "") + "%", (RFC ?? ""), Nombre, Nombre, "%" + Folio + "%", Folio, ActionId, ActionId, (From.HasValue ? From.Value.ToString("yyyy-MM-dd") : ""), (From.HasValue ? From.Value.ToString("yyyy-MM-dd") : ""), (To.HasValue ? To.Value.ToString("yyyy-MM-dd") : ""), (To.HasValue ? To.Value.ToString("yyyy-MM-dd") : "") }, conn, null);
		}
	}
}