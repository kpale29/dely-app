using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace Persistencia.Models
{
    public partial class DELYAPPContext : DbContext
    {
        public DELYAPPContext()
        {
        }

        public DELYAPPContext(DbContextOptions<DELYAPPContext> options)
            : base(options)
        {
        }

        public virtual DbSet<DetallePedido> DetallePedidos { get; set; }
        public virtual DbSet<Pedido> Pedidos { get; set; }
        public virtual DbSet<Producto> Productos { get; set; }
        public virtual DbSet<Tiendum> Tienda { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=LAPTOP-2D511882\\SQLEXPRESS;Initial Catalog=DELYAPP;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Modern_Spanish_CI_AS");

            modelBuilder.Entity<DetallePedido>(entity =>
            {
                entity.HasKey(e => e.IdDetallePedido)
                    .HasName("DETALLE_PEDIDO_PK");

                entity.ToTable("DETALLE_PEDIDO");

                entity.Property(e => e.IdDetallePedido)
                    .ValueGeneratedNever()
                    .HasColumnName("ID_DETALLE_PEDIDO");

                entity.Property(e => e.Cantidad)
                    .HasColumnType("numeric(21, 0)")
                    .HasColumnName("CANTIDAD");

                entity.Property(e => e.IdPedido).HasColumnName("ID_PEDIDO");

                entity.Property(e => e.IdProducto).HasColumnName("ID_PRODUCTO");

                entity.HasOne(d => d.IdPedidoNavigation)
                    .WithMany(p => p.DetallePedidos)
                    .HasForeignKey(d => d.IdPedido)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("DETALLE_PEDIDO_PEDIDO_FK");

                entity.HasOne(d => d.IdProductoNavigation)
                    .WithMany(p => p.DetallePedidos)
                    .HasForeignKey(d => d.IdProducto)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("DETALLE_PEDIDO_PRODUCTO_FK");
            });

            modelBuilder.Entity<Pedido>(entity =>
            {
                entity.HasKey(e => e.IdPedido)
                    .HasName("PEDIDO_PK");

                entity.ToTable("PEDIDO");

                entity.Property(e => e.IdPedido)
                    .ValueGeneratedNever()
                    .HasColumnName("ID_PEDIDO");

                entity.Property(e => e.Direccion)
                    .HasMaxLength(200)
                    .HasColumnName("DIRECCION");

                entity.Property(e => e.Estado).HasColumnName("ESTADO");

                entity.Property(e => e.Fecha)
                    .HasColumnType("datetime")
                    .HasColumnName("FECHA");

                entity.Property(e => e.IdCliente).HasColumnName("ID_CLIENTE");

                entity.Property(e => e.IdRepartidor).HasColumnName("ID_REPARTIDOR");

                entity.Property(e => e.IdTienda).HasColumnName("ID_TIENDA");

                entity.Property(e => e.Total)
                    .HasColumnType("numeric(21, 2)")
                    .HasColumnName("TOTAL");

                entity.HasOne(d => d.IdClienteNavigation)
                    .WithMany(p => p.PedidoIdClienteNavigations)
                    .HasForeignKey(d => d.IdCliente)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("PEDIDO_USUARIO_FK");

                entity.HasOne(d => d.IdRepartidorNavigation)
                    .WithMany(p => p.PedidoIdRepartidorNavigations)
                    .HasForeignKey(d => d.IdRepartidor)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("PEDIDO_USUARIO_FKv2");

                entity.HasOne(d => d.IdTiendaNavigation)
                    .WithMany(p => p.Pedidos)
                    .HasForeignKey(d => d.IdTienda)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("PEDIDO_TIENDA_FK");
            });

            modelBuilder.Entity<Producto>(entity =>
            {
                entity.HasKey(e => e.IdProducto)
                    .HasName("PRODUCTO_PK");

                entity.ToTable("PRODUCTO");

                entity.Property(e => e.IdProducto)
                    .ValueGeneratedNever()
                    .HasColumnName("ID_PRODUCTO");

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(250)
                    .HasColumnName("DESCRIPCION");

                entity.Property(e => e.IdTienda).HasColumnName("ID_TIENDA");

                entity.Property(e => e.Imagen)
                    .HasMaxLength(250)
                    .HasColumnName("IMAGEN");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(100)
                    .HasColumnName("NOMBRE");

                entity.Property(e => e.Precio)
                    .HasColumnType("numeric(21, 2)")
                    .HasColumnName("PRECIO");

                entity.HasOne(d => d.IdTiendaNavigation)
                    .WithMany(p => p.Productos)
                    .HasForeignKey(d => d.IdTienda)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("PRODUCTO_TIENDA_FK");
            });

            modelBuilder.Entity<Tiendum>(entity =>
            {
                entity.HasKey(e => e.IdTienda)
                    .HasName("TIENDA_PK");

                entity.ToTable("TIENDA");

                entity.Property(e => e.IdTienda)
                    .ValueGeneratedNever()
                    .HasColumnName("ID_TIENDA");

                entity.Property(e => e.Descripcion)
                    .HasMaxLength(160)
                    .HasColumnName("DESCRIPCION");

                entity.Property(e => e.IdUsuario).HasColumnName("ID_USUARIO");

                entity.Property(e => e.Imagen)
                    .HasMaxLength(250)
                    .HasColumnName("IMAGEN");

                entity.Property(e => e.Nombre)
                    .HasMaxLength(125)
                    .HasColumnName("NOMBRE");

                entity.HasOne(d => d.IdUsuarioNavigation)
                    .WithMany(p => p.Tienda)
                    .HasForeignKey(d => d.IdUsuario)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("TIENDA_USUARIO_FK");
            });

            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.HasKey(e => e.IdUsuario)
                    .HasName("USUARIO_PK");

                entity.ToTable("USUARIO");

                entity.Property(e => e.IdUsuario)
                    .ValueGeneratedNever()
                    .HasColumnName("ID_USUARIO");

                entity.Property(e => e.NombreUsuario)
                    .IsRequired()
                    .HasMaxLength(16)
                    .HasColumnName("NOMBRE_USUARIO");

                entity.Property(e => e.PApellido)
                    .HasMaxLength(16)
                    .HasColumnName("P_APELLIDO");

                entity.Property(e => e.PNombre)
                    .HasMaxLength(16)
                    .HasColumnName("P_NOMBRE");

                entity.Property(e => e.PasswordHash)
                    .IsRequired()
                    .HasMaxLength(1)
                    .HasColumnName("PASSWORD_HASH");

                entity.Property(e => e.PasswordSalt)
                    .IsRequired()
                    .HasMaxLength(1)
                    .HasColumnName("PASSWORD_SALT");

                entity.Property(e => e.SApellido)
                    .HasMaxLength(16)
                    .HasColumnName("S_APELLIDO");

                entity.Property(e => e.SNombre)
                    .HasMaxLength(16)
                    .HasColumnName("S_NOMBRE");

                entity.Property(e => e.TipoUsuario).HasColumnName("TIPO_USUARIO");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
