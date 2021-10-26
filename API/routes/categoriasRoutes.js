const CategoriasController = require('../controllers/categoriasController');

module.exports = (app) => {
    // Crear una categoria
    app.post('/api/Categorias/Crear',CategoriasController.crear);
    // Obtener categorias
    app.get('/api/Categorias/getAll',CategoriasController.getAll);

};
