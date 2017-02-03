using System;
using System.Linq;
using System.Web;
using DescargaFacturas.BL;

namespace DescargaFacturas
{
	public partial class login : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			try
			{
				if (!IsPostBack)
				{
					var lstParameters = ParameterBL.GetParameters();
					var OkMessage = lstParameters.Where(p => p.Name.Equals("RegistrationSuccessMessage")).FirstOrDefault().Value;
					lblRegistered.Text = OkMessage;
				}
				Session["CCFNUser"] = null;
				Session["CCFNRoles"] = null;
				txtUsername.Focus();
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
		}

		protected void btnLogin_Click(object sender, EventArgs e)
		{
			lblError.Text = "";
			lblError.Visible = false;
			lblPasswordSent.Visible = false;
			var loginOk = false;
			try
			{
				var user = UserBL.Authenticate(txtUsername.Text, txtPassword.Text);
				if (user != null)
				{
					loginOk = true;
					Session["CCFNUser"] = user;
					Session["CCFNRoles"] = UserBL.GetRoles(user.UserId);
				}
			}
			catch (Exception ex)
			{
				Response.Write("Error: " + ex.Message);
			}
			lblError.Visible = !loginOk;
			if (!loginOk) lblError.Text = "Usuario y/o contraseña incorrectos.";
			if (loginOk) Response.Redirect("main.aspx");
		}

		protected void btnRegister_Click(object sender, EventArgs e)
		{
			lblErrorIn.Text = "";
			lblErrorIn.Visible = false;
			if (!txtPasswordIn.Text.Equals(txtPasswordConfirmIn.Text))
			{
				lblErrorIn.Visible = true;
				lblErrorIn.Text = "Las contraseñas no coinciden.";
			}
			else if (UserBL.ExistsRFC(txtRFC.Text.Replace("-", "")))
			{
				lblErrorIn.Visible = true;
				lblErrorIn.Text = "Su RFC ya se encuentra registrado.";
			}
			else if (UserBL.ExistsUsername(txtUsernameIn.Text))
			{
				lblErrorIn.Visible = true;
				lblErrorIn.Text = "El nombre de usuario ya se encuentra en uso.";
			}
			else if (!txtCommercialName.Text.Equals("") && !txtRFC.Text.Equals("") && !txtEmail.Text.Equals("") && !txtUsernameIn.Text.Equals("") && !txtPasswordIn.Text.Equals(""))
			{
				var user = new DA.Users()
				{
					Name = txtCommercialName.Text,
					Lastname = "",
					CommercialName = txtCommercialName.Text,
					Email = txtEmail.Text,
					RFC = txtRFC.Text.Replace("-", ""),
					Username = txtUsernameIn.Text,
					Password = txtPasswordIn.Text,
					StatusId = (int)DA.Constants.Status.PENDIENTE,
					Created = DateTime.Now,
					LastUpdated = DateTime.Now,
					ActiveFlag = true
				};
				UserBL.RegisterNewClient(user);
				lblRegistered.Visible = true;
				txtCommercialName.Text = txtRFC.Text = txtEmail.Text = txtUsernameIn.Text = txtPasswordIn.Text = "";
			}
		}

		protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
		{
			lblError.Text = "";
			lblError.Visible = false;
			lblPasswordSent.Visible = false;
			if (!UserBL.ExistsUsername(txtUsername.Text))
			{
				lblError.Visible = true;
				lblError.Text = "Usuario no encontrado.";
				return;
			}
			else
			{
				var user = UserBL.GetUserByUsername(txtUsername.Text);
				var lstParameters = ParameterBL.GetParameters();
				var ForgotPasswordSubject = lstParameters.Where(p => p.Name.Equals("ForgotPasswordSubject")).FirstOrDefault().Value;
				var ForgotPasswordBody = lstParameters.Where(p => p.Name.Equals("ForgotPasswordBody")).FirstOrDefault().Value.Replace("{Password}", user.Password);
				EmailBL.SendEmails(new DA.MailMessageDA() { ToAddresses = new string[] { user.Email }, Subject = ForgotPasswordSubject, Body = ForgotPasswordBody });
				var PasswordSent = lstParameters.Where(p => p.Name.Equals("PasswordSentText")).FirstOrDefault().Value;
				lblPasswordSent.Text = PasswordSent;
				lblPasswordSent.Visible = true;
			}
		}
	}
}