namespace DescargaFacturas.DA
{
	public class Constants
	{
		public enum Status : int
		{
			PENDIENTE = 1,
			APROBADO = 2,
			RECHAZADO = 3
		}

		public enum Roles : int
		{
			ADMINISTRADOR = 1,
			CLIENTE = 2
		}

		public enum Actions : int
		{
			BUSQUEDA = 1,
			DESCARGA_PDF = 2,
			DESCARGA_XML = 3,
			DESCARGA_MULTIPLE = 4
		}
	}
}