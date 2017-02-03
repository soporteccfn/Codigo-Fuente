using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace DescargaFacturas.catalogs
{
	public partial class users : Page
	{
		private string gridMessage;

		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
		}

		private void DisplayMessage(string text)
		{
			RadGrid1.Controls.Add(new LiteralControl(string.Format("<span style='color:red'>{0}</span>", text)));
		}

		private void SetMessage(string message)
		{
			gridMessage = message;
		}

		protected void RadGrid1_DataBound(object sender, EventArgs e)
		{
			if (!string.IsNullOrEmpty(gridMessage))
				DisplayMessage(gridMessage);
		}

		protected void RadGrid1_ItemInserted(object sender, GridInsertedEventArgs e)
		{
			if (e.Exception != null)
			{
				e.ExceptionHandled = true;
				SetMessage("No se pudo crear el registro. Error: " + e.Exception.Message);
			}
			else
			{
				BL.UserBL.AddAdministrator();
				SetMessage("Registro creado!");
			}
		}

		protected void RadGrid1_ItemUpdated(object sender, GridUpdatedEventArgs e)
		{
			var item = e.Item;
			var id = item.GetDataKeyValue("UserId").ToString();

			if (e.Exception != null)
			{
				e.KeepInEditMode = true;
				e.ExceptionHandled = true;
				SetMessage("El registro con ID: # <strong>" + id + "</strong> no pudo ser actualizado. Error: " + e.Exception.Message + " TRACE: " + e.Exception.StackTrace);
			}
			else
				SetMessage("Registro actualizado!");
		}

		protected void RadGrid1_ItemDeleted(object sender, GridDeletedEventArgs e)
		{
			var dataItem = (GridDataItem)e.Item;
			var id = dataItem.GetDataKeyValue("UserId").ToString();

			if (e.Exception != null)
			{
				e.ExceptionHandled = true;
				SetMessage("El registro con ID: # <strong>" + id + "</strong> no pudo ser eliminado. Error: " + e.Exception.Message + " TRACE: " + e.Exception.StackTrace);
			}
			else
				SetMessage("Registro eliminado!");
		}

		protected void dsUsers_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			var it = e.Entity as DA.Users;
			it.Created = DateTime.Now;
			it.CreatedBy = ((DA.Users)Session["CCFNUser"]).UserId;
			it.LastUpdated = DateTime.Now;
			it.LastUpdatedBy = ((DA.Users)Session["CCFNUser"]).UserId;
			it.ActiveFlag = true;
			it.StatusId = (int)DA.Constants.Status.APROBADO;
		}

		protected void dsUsers_Updating(object sender, EntityDataSourceChangingEventArgs e)
		{
			var it = e.Entity as DA.Users;
			it.LastUpdated = DateTime.Now;
			it.LastUpdatedBy = ((DA.Users)Session["CCFNUser"]).UserId;
			if (it.ActiveFlag && it.StatusId.Equals((int)DA.Constants.Status.RECHAZADO))
			{
				it.StatusId = (int)DA.Constants.Status.PENDIENTE;
				var entry = e.Context.ObjectStateManager.GetObjectStateEntry(e.Entity);
				var original = entry.OriginalValues;
				it.Password = original.GetValue(original.GetOrdinal("Password")).ToString();
			}
		}

		protected void dsUsers_Deleting(object sender, EntityDataSourceChangingEventArgs e)
		{
			var it = e.Entity as DA.Users;
			BL.UserBL.RemoveUserRelationships(it.UserId);
		}
	}
}