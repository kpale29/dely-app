const UsersController = require('../controllers/usuariosController');

module.exports = (app) => {
    //Listar Todos los usuarios
    app.get('/api/usuarios/getAll', UsersController.getAll);    
    //crear usuario para
    app.post('/api/usuarios/crear', UsersController.create);
    //LOGIN
    app.post('/api/usuarios/login', UsersController.login);
    //Listar por correo
    app.get('/api/usuarios/getByemail', UsersController.getByemail);
    //Listar repartidores por
    app.get('/api/usuarios/getRepartidores',UsersController.getRepartidores);
    app.put('/api/usuarios/updateConPassword/:restaurante/:repartidor',UsersController.updateConPassword);
    app.put('/api/usuarios/updateSinPassword/:restaurante/:repartidor',UsersController.updateSinPassword);
}

