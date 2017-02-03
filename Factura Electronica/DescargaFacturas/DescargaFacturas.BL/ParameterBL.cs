using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DescargaFacturas.DA;

namespace DescargaFacturas.BL
{
	public class ParameterBL
	{
		public static List<SysParameters> GetParameters()
		{
			using (var db = new CCFNEntities())
				return db.SysParameters.ToList(); 
		}

		public static void SaveParameters(List<SysParameters> lstParameters)
		{
			using (var conn = SQL.GetConnection())
				lstParameters.ForEach(p => SQL.RunQuery("UPDATE SysParameters SET Value = @p1 WHERE Name = @p2", new ArrayList() { p.Value, p.Name }, conn, null));
		}
	}
}