const CategoriasController = require('../controllers/categoriasController');

module.exports = (app) => {
    // Crear una categoria
    app.post('/api/Categorias/Crear',CategoriasController.crear);
};
