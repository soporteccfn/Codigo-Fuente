using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using DescargaFacturas.BL;
using DescargaFacturas.DA;

namespace DescargaFacturas.catalogs
{
	public partial class parameters : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
			if (!IsPostBack)
			{
				try
				{
					var lstParameters = ParameterBL.GetParameters();
					txtRegistrationSuccessMessage.Text = lstParameters.Where(p => p.Name.Equals("RegistrationSuccessMessage")).FirstOrDefault().Value;
					txtFilesPath.Text = lstParameters.Where(p => p.Name.Equals("FilesPath")).FirstOrDefault().Value;
					cmbSendEmails.SelectedValue = lstParameters.Where(p => p.Name.Equals("SendEmails")).FirstOrDefault().Value;
					txtEmailFrom.Text = lstParameters.Where(p => p.Name.Equals("EmailFrom")).FirstOrDefault().Value;
					txtEmailFromName.Text = lstParameters.Where(p => p.Name.Equals("EmailFromName")).FirstOrDefault().Value;
					txtEmailIP.Text = lstParameters.Where(p => p.Name.Equals("EmailIP")).FirstOrDefault().Value;
					txtEmailPort.Text = lstParameters.Where(p => p.Name.Equals("EmailPort")).FirstOrDefault().Value;
					cmbSSL.SelectedValue = lstParameters.Where(p => p.Name.Equals("EmailSSL")).FirstOrDefault().Value;
					txtEmailPassword.Text = lstParameters.Where(p => p.Name.Equals("EmailPassword")).FirstOrDefault().Value;
					txtForgotPasswordSubject.Text = lstParameters.Where(p => p.Name.Equals("ForgotPasswordSubject")).FirstOrDefault().Value;
					txtForgotPasswordBody.Text = lstParameters.Where(p => p.Name.Equals("ForgotPasswordBody")).FirstOrDefault().Value;
					txtPasswordSentText.Text = lstParameters.Where(p => p.Name.Equals("PasswordSentText")).FirstOrDefault().Value;
				}
				catch (Exception ex)
				{
					Trace.Write(ex.Message + " " + ex.StackTrace);
				}
			}
		}

		protected void btnSave_Click(object sender, EventArgs e)
		{
			try
			{
				var lstParameters = new List<SysParameters>()
					{
						new SysParameters() { Name = "RegistrationSuccessMessage", Value = txtRegistrationSuccessMessage.Text },
						new SysParameters() { Name = "FilesPath", Value = txtFilesPath.Text },
						new SysParameters() { Name = "SendEmails", Value = cmbSendEmails.SelectedValue },
						new SysParameters() { Name = "EmailFrom", Value = txtEmailFrom.Text },
						new SysParameters() { Name = "EmailFromName", Value = txtEmailFromName.Text },
						new SysParameters() { Name = "EmailIP", Value = txtEmailIP.Text },
						new SysParameters() { Name = "EmailPort", Value = txtEmailPort.Text },
						new SysParameters() { Name = "EmailSSL", Value = cmbSSL.SelectedValue },
						new SysParameters() { Name = "EmailPassword", Value = txtEmailPassword.Text },
						new SysParameters() { Name = "ForgotPasswordSubject", Value = txtForgotPasswordSubject.Text },
						new SysParameters() { Name = "ForgotPasswordBody", Value = txtForgotPasswordBody.Text },
						new SysParameters() { Name = "PasswordSentText", Value = txtPasswordSentText.Text }
					};
				ParameterBL.SaveParameters(lstParameters);
			}
			catch (Exception ex)
			{
				Trace.Write(ex.Message + " " + ex.StackTrace);
			}
		}
	}
}