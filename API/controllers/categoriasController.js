const Categoria = require('../models/categoria');

module.exports = {

    async crear(req,res,next){
        try {
            const categoria = req.body; 
            console.log(`Categoria creada: ${categoria}`)
            const data = await Categoria.create(categoria);
            const id = data[0]['LAST_INSERT_ID()']
            return res.status(201).json({
                success: true,
                message: 'La nueva categoria se inserto correctamente',
                data: id
            }); 

        } catch (error) {
            console.log(`Erro: ${error.message}`);
            return res.status(501).json({ 
                success: false,
                message: 'Hubo un error al crear la categoria',
                error: error
            })
        }
    },

    async getAll(req,res,next){
        try {
            const data = await Categoria.getAll();
            res.status(201).json(data)
        } catch (error) {
            console.log(`Error: ${error}`)
            return res.status(501).json({ 
                success: false,
                message: 'Hubo un error al obtener categorias',
                error: error
            })
        }
    }

}
