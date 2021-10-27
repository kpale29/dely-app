const PedidosController = require('../controllers/pedidoController');

module.exports = (app) => {
    // Crear un Pedido
    app.post('/api/Pedidos/Crear',PedidosController.crear);
};
