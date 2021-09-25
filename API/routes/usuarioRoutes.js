const UsersController = require('../controllers/usuariosController');

module.exports = (app) => {
    //Listar Todos los usuarios
    app.get('/api/usuarios/getAll', UsersController.getAll);    
    //crear usuario para
    app.post('/api/usuarios/crear', UsersController.create);
    //LOGIN
    app.post('/api/usuarios/login', UsersController.login);

}

