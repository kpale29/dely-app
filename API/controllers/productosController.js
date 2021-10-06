const Producto = require('../models/producto')

module.exports = {

    async create (req, res, next)  {
        try {
            const producto = req.body;
            console.log(`Producto creado: ${producto}`);
            const data = await Producto.create(producto);
            const id = data[0]['LAST_INSERT_ID()']
            return res.status(201).json({
                succes: true,
                message: 'El nuevo producto se inserto correctamente',
                data: id
            })

        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                succes: false,
                message: 'Hubo un error al crear el producto',
                error: error
            })
        }


    }
}