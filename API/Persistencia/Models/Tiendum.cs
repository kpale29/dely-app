using System;
using System.Collections.Generic;

#nullable disable

namespace Persistencia.Models
{
    public partial class Tiendum
    {
        public Tiendum()
        {
            Pedidos = new HashSet<Pedido>();
            Productos = new HashSet<Producto>();
        }

        public int IdTienda { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public int IdUsuario { get; set; }

        public virtual Usuario IdUsuarioNavigation { get; set; }
        public virtual ICollection<Pedido> Pedidos { get; set; }
        public virtual ICollection<Producto> Productos { get; set; }
    }
}
