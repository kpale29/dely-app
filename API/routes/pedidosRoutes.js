const PedidosController = require('../controllers/pedidoController');

module.exports = (app) => {
    // Crear un Pedido
    app.post('/api/Pedidos/Crear',PedidosController.crear);
    // Obtener pedidos por estado
    app.get('/api/Pedidos/ByEstado/:estado',PedidosController.getByEstado)
    app.get('/api/Pedidos/ByRepartidor/:id_repartidor/:estado',PedidosController.getByRepartidor)
    app.get('/api/Pedidos/ByCliente/:id_cliente/:estado',PedidosController.getByCliente)
    app.put('/api/Pedidos/actualizarDespachado',PedidosController.actualizarDespachado);
    app.put('/api/Pedidos/actualizarEncamino',PedidosController.actualizarEncamino);
    app.put('/api/Pedidos/actualizarEntregado',PedidosController.actualizarEntregado);
};
