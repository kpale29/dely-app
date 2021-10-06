const ProductosController = require('../controllers/productosController')

module.exports = (app) => { 
    app.post('/api/Productos/Crear',ProductosController.create);
}