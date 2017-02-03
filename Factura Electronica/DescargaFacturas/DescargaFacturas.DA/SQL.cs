using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DescargaFacturas.DA
{
	public static class SQL
	{
		public static string Conn { get; set; }

		public static SqlConnection GetConnection()
		{
			try
			{
				if (string.IsNullOrEmpty(Conn))
					Conn = ConfigurationManager.ConnectionStrings["CCFNDB"].ConnectionString;
				var conn = new SqlConnection(Conn);
				if (conn.State == ConnectionState.Closed)
					conn.Open();
				return conn;
			}
			catch (Exception ex)
			{
				throw new Exception("Cannot connect to database. Error:\n\n" + ex.Message, ex.InnerException);
			}
		}

		public static DataTable RunQuery(string sQuery, ArrayList paramsQuery, SqlConnection conn, SqlTransaction trans)
		{
			var dt = new DataTable();
			try
			{
				var cmd = new SqlCommand(sQuery, conn, trans);
				int cp = 1;
				foreach (object obj in paramsQuery)
				{
					cmd.Parameters.AddWithValue("p" + cp, obj);
					cp++;
				}
				var da = new SqlDataAdapter(cmd);
				da.Fill(dt);
				cmd.Dispose();
			}
			catch
			{
				throw;
			}
			return dt;
		}

		public static DataTable BuildHeadersFromFirstRowThenRemoveFirstRow(DataTable dt)
		{
			var firstRow = dt.Rows[0];
			for (int i = 0; i < dt.Columns.Count; i++)
				if (!string.IsNullOrWhiteSpace(firstRow[i].ToString())) // handle empty cell
					dt.Columns[i].ColumnName = firstRow[i].ToString().Trim();
			dt.Rows.RemoveAt(0);
			return dt;
		}
	}
}