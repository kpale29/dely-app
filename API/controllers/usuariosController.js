const { create } = require('../models/usuario');
const Usuario = require('../models/usuario');
const Rol = require('../models/rol');
const jwt = require('jsonwebtoken');
const Keys = require('../config/keys');


module.exports = {
    async getAll(req,res,next) {
        try {
            const data = await Usuario.getAll()
                console.log(`Usuarios: ${data}`);
            return res.status(201).json(data);
        } catch (error) {
            console.log( `Error: ${error}`); 
            return res.status(501).json({ 
                success: false,
                message: 'Error al obtener los usuarios'
            });
        }
    },

    async getByemail(req,res,next) {
        try {
            const data = await Usuario.buscarPorCorreo(req.body.correo)
            console.log(`Usuarios ${data}`);
            return res.status(201).json(data)
        } catch (error) {
            console.log(`Error en consulta: ${error}`);
            return res.status(501).json({
                success: false,
                menssage: `Error al consultar: ${error}`
            })
        } 

    },

    async create(req,res,next) {
        try {
            const user = req.body; 
            const data = await Usuario.create(user);
            const id = data[0]['LAST_INSERT_ID()']
            await Rol.crear(id, 1);
            return res.status(201).json({
                success: true,
                message: 'El nuevo usuario se inserto correctamente',
                data: id
            });  
        } catch (error) {
            console.log(`Error: ${(error)}`);
            return res.status(501).json({ 
                succes: false,
                message: 'Hubo un error con el registro del usuario',
                error: error
            });
        }
    },

    async login(req,res,next){ 
        try {
        
            const correo = req.body.correo
            const password = req.body.password
            const user = await Usuario.buscarPorCorreo(correo)
            if(user.length === 0){ 
                return res.status(401).json({
                    success: false,
                    message: 'El usuario no existe',
                }) 
            }
            userPassword = user[0].password;
            
            if (Usuario.siPasswordConcuerda(password,userPassword)){
                const token = jwt.sign({
                    id: user[0].id,
                    email: user[0].correo,
                }, Keys.secretOrKey, 
                // {
                //     expiresIn : (60*60*24)
                // }
                );
                // const token = '';
                const data = { 
                    id: user[0].id, 
                    nombre: user[0].nombre, 
                    apellido: user[0].apellido,
                    correo: user[0].correo, 
                    telefono: user[0].telefono,
                    imagen: user[0].imagen,
                    token_sesion: `JWT ${token}`,
                    roles: JSON.parse(user[0].roles)
                }

                await Usuario.actualizarToken(user[0].id, `JWT ${token}`); 

                console.log(`Usuario enviado: ${data}`)

                return res.status(201).json({
                    success: true, 
                    data: data,
                    message: 'Inicio de sesion exitoso'
                })
            }else{ 
                return res.status(401).json({
                    success: false, 
                    message: 'Contraseña incorrecta',
                })
            }

        } catch (error) {
            console.log(`Error login: ${error}`)
            return res.status(501).json({ 
                succes: false,
                message: 'Error al iniciar sesion',
                error: error
            })
        }


    }
}