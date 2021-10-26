const ProductosController = require('../controllers/productosController')

module.exports = (app) => { 
    app.post('/api/Productos/Crear',ProductosController.create);
    app.get('/api/Productos/getByCategoria/:id_categoria',ProductosController.getByCategoria);
}