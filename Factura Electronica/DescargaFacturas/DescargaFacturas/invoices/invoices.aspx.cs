using System;
using System.Web.UI;
using DescargaFacturas.BL;
using Telerik.Web.UI;
using DescargaFacturas.DA;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace DescargaFacturas.invoices
{
    public partial class invoices : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["CCFNUser"] == null) Response.Redirect("~/login.aspx");
                if (!IsPostBack)
                {
                    var lstRoles = (List<Roles>)Session["CCFNRoles"];
                    var rolesCSV = "";
                    lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
                    rolesCSV = rolesCSV.TrimEnd(',', ' ');
                    trAdmin1.Visible = trAdmin2.Visible = rolesCSV.Contains("ADMINISTRADOR");
                    GetDataSourceInvoices();
                    RadGrid1.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            GetDataSourceInvoices();
        }

        protected void GetDataSourceInvoices()
        {
            var lstRoles = (List<Roles>)Session["CCFNRoles"];
            var rolesCSV = "";
            lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
            rolesCSV = rolesCSV.TrimEnd(',', ' ');
            RadGrid1.DataSource = GeneralBL.GetInvoices(rolesCSV.Contains("ADMINISTRADOR"), ((Users)Session["CCFNUser"]).RFC, txtSerie.Text, txtFolio.Text, dteDesde.SelectedDate, dteHasta.SelectedDate, ((Users)Session["CCFNUser"]).UserId, txtSucursal.Text, txtCodigoCliente.Text, txtRFC.Text);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetDataSourceInvoices();
            RadGrid1.DataBind();
        }

        protected void chkRecibos_Click(object sender, EventArgs e)
        {
            if ( (bool) chkRecibos.Checked)
            {
                var lstRoles = (List<Roles>)Session["CCFNRoles"];
                var rolesCSV = "";
                lstRoles.ForEach(rol => rolesCSV += (rol.Name + ", "));
                rolesCSV = rolesCSV.TrimEnd(',', ' ');
                RadGrid1.DataSource = GeneralBL.GetInvoicesRecibos(rolesCSV.Contains("ADMINISTRADOR"), ((Users)Session["CCFNUser"]).RFC, txtSerie.Text, txtFolio.Text, dteDesde.SelectedDate, dteHasta.SelectedDate, ((Users)Session["CCFNUser"]).UserId, txtSucursal.Text, txtCodigoCliente.Text, txtRFC.Text);
            }
            else
            {
                GetDataSourceInvoices();
            }
            RadGrid1.DataBind();
            //Response.Write("<script language='javascript'>alert('"+ chkRecibos.Checked + "');</script>");
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                var dataItem = (GridDataItem)e.Item;
                var lstParameters = ParameterBL.GetParameters();
                var filesPath = lstParameters.Where(p => p.Name.Equals("FilesPath")).FirstOrDefault().Value;
                if (!File.Exists(filesPath + dataItem["colPDFFILE"].Text))
                    dataItem["colPDF"].Controls.Clear();
                if (!File.Exists(filesPath + dataItem["colXMLFILE"].Text))
                    dataItem["colXML"].Controls.Clear();
            }
        }
    }
}