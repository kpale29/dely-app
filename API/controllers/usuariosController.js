const { create } = require('../models/usuario');
const Usuario = require('../models/usuario');

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

    async create(req,res,next) {
        try {
            const user = req.body; 
            const data = await Usuario.create(user);
            return res.status(201).json({
                success: true,
                message: 'El nuevo usuario se inserto correctamente',
                data: data[0]['LAST_INSERT_ID()']
            });  
        } catch (error) {
            console.log(`Error: ${(error)}`);
            return res.status(501).json({ 
                succes: false,
                message: 'Hubo un error con el registro del usuario',
                error: error
            });
        }
    }
}