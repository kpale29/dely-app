using System;
using System.Collections.Generic;

#nullable disable

namespace Persistencia.Models
{
    public partial class DetallePedido
    {
        public int IdDetallePedido { get; set; }
        public int IdProducto { get; set; }
        public decimal? Cantidad { get; set; }
        public int IdPedido { get; set; }

        public virtual Pedido IdPedidoNavigation { get; set; }
        public virtual Producto IdProductoNavigation { get; set; }
    }
}
