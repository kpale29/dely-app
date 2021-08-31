using System;
using System.Collections.Generic;

#nullable disable

namespace Persistencia.Models
{
    public partial class Usuario
    {
        public Usuario()
        {
            PedidoIdClienteNavigations = new HashSet<Pedido>();
            PedidoIdRepartidorNavigations = new HashSet<Pedido>();
            Tienda = new HashSet<Tiendum>();
        }

        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public byte[] PasswordSalt { get; set; }
        public byte[] PasswordHash { get; set; }
        public string PNombre { get; set; }
        public string SNombre { get; set; }
        public string PApellido { get; set; }
        public string SApellido { get; set; }
        public int? TipoUsuario { get; set; }

        public virtual ICollection<Pedido> PedidoIdClienteNavigations { get; set; }
        public virtual ICollection<Pedido> PedidoIdRepartidorNavigations { get; set; }
        public virtual ICollection<Tiendum> Tienda { get; set; }
    }
}
