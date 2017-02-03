using System;
using System.Linq;
using System.Net.Mail;
using System.Net;
using DescargaFacturas.DA;

namespace DescargaFacturas.BL
{
	public class EmailBL
	{
		public static void SendEmails(MailMessageDA message)
		{
			var lstParameters = ParameterBL.GetParameters();
			var sendEmails = lstParameters.Where(p => p.Name.Equals("SendEmails")).FirstOrDefault().Value;
			if (sendEmails.Equals("S"))
				foreach (string to in message.ToAddresses)
					SendEachEmail(to, message.Subject, message.Body);
		}

		public static void SendEachEmail(string toAddress, string subject, string body)
		{
			if (!string.IsNullOrEmpty(toAddress))
			{
				var lstParameters = ParameterBL.GetParameters();
				var emailFrom = lstParameters.Where(p => p.Name.Equals("EmailFrom")).FirstOrDefault().Value;
				var emailFromName = lstParameters.Where(p => p.Name.Equals("EmailFromName")).FirstOrDefault().Value;
				var emailIP = lstParameters.Where(p => p.Name.Equals("EmailIP")).FirstOrDefault().Value;
				var emailPort = lstParameters.Where(p => p.Name.Equals("EmailPort")).FirstOrDefault().Value;
				var emailSSL = lstParameters.Where(p => p.Name.Equals("EmailSSL")).FirstOrDefault().Value;
				var emailPassword = lstParameters.Where(p => p.Name.Equals("EmailPassword")).FirstOrDefault().Value;
				using (var client = new SmtpClient())
				{
					var fromAddress = new MailAddress(emailFrom, emailFromName);
					var message = new MailMessage(fromAddress.Address, toAddress)
					{
						IsBodyHtml = true,
						Subject = subject,
						Body = body,
						From = fromAddress
					};
					client.Host = emailIP;
					client.Port = int.Parse(emailPort);
					client.EnableSsl = emailSSL.Equals("Y");
					client.DeliveryMethod = SmtpDeliveryMethod.Network;
					client.UseDefaultCredentials = false;
					client.Credentials = new NetworkCredential(fromAddress.Address, emailPassword);
					try
					{
						client.Send(message);
					}
					catch (Exception ex)
					{
						System.Diagnostics.Debug.WriteLine("ERR: " + ex.Message);
					}
				}
			}
		}
	}
}