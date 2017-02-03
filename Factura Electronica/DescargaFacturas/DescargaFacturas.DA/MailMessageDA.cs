using System;

namespace DescargaFacturas.DA
{
	public class MailMessageDA
	{
		public Array ToAddresses { get; set; }
		public string Subject { get; set; }
		public string Body { get; set; }
	}
}