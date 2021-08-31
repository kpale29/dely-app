using System;
using System.Collections.Generic;

#nullable disable

namespace Persistencia.Models
{
    public partial class Pedido
    {
        public Pedido()
        {
            DetallePedidos = new HashSet<DetallePedido>();
        }

        public int IdPedido { get; set; }
        public DateTime? Fecha { get; set; }
        public int IdCliente { get; set; }
        public int IdTienda { get; set; }
        public decimal? Total { get; set; }
        public int? Estado { get; set; }
        public string Direccion { get; set; }
        public int IdRepartidor { get; set; }

        public virtual Usuario IdClienteNavigation { get; set; }
        public virtual Usuario IdRepartidorNavigation { get; set; }
        public virtual Tiendum IdTiendaNavigation { get; set; }
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
    }
}
