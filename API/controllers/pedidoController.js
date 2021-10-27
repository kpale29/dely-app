const Pedido = require('../models/pedido')
const PedidoProducto = require('../models/pedido_producto')


module.exports = {
    async crear (req, res, next)  {
        try {
            const pedido = req.body;
            const data = await Pedido.crear(pedido);
            const id = data[0]['LAST_INSERT_ID()']
            const newPedido = await Pedido.buscarPorId(id)
            const newId = newPedido[0].id
            for(const product of pedido.productos) {
                await PedidoProducto.crear(
                    newId,
                    product.id, 
                    product.cantidad)
            }

            return res.status(201).json({
                success: true,
                message: 'El pedido se ha creado correctamente',
                data: id
            })
        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al crear el pedido',
                error: error
            })
        }
    },

} 