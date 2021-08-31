using System;
using System.Collections.Generic;

#nullable disable

namespace Persistencia.Models
{
    public partial class Producto
    {
        public Producto()
        {
            DetallePedidos = new HashSet<DetallePedido>();
        }

        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public decimal? Precio { get; set; }
        public string Imagen { get; set; }
        public int IdTienda { get; set; }

        public virtual Tiendum IdTiendaNavigation { get; set; }
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
    }
}
