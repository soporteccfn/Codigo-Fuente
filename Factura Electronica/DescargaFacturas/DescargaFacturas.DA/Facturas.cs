//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DescargaFacturas.DA
{
    using System;
    using System.Collections.Generic;
    
    public partial class Facturas
    {
        public int FacturaId { get; set; }
        public string RFC { get; set; }
        public string PDF { get; set; }
        public string XML { get; set; }
        public string Folio { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public string Sucursal { get; set; }
        public string CodigoCliente { get; set; }
        public string RazonSocial { get; set; }
        public string ID { get; set; }
        public Nullable<decimal> Total { get; set; }
        public Nullable<decimal> Subtotal { get; set; }
        public Nullable<decimal> IVA { get; set; }
        public Nullable<decimal> IEPS { get; set; }
        public string Serie { get; set; }
    }
}