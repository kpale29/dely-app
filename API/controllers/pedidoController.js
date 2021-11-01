const Pedido = require('../models/pedido')
const PedidoProducto = require('../models/pedido_producto')


module.exports = {
    async crear (req, res, next)  {
        try {
            const pedido = req.body;
            await Pedido.crear(pedido).then(
            async (data)  =>{ 
            for(const product of pedido.productos) {
                await PedidoProducto.crear(
                    data.insertId,
                    product.id, 
                    product.cantidad)
            }

            return res.status(201).json({
                success: true,
                message: `El pedido ${data.insertId} se ha creado correctamente`,
                data: data.insertId
            })
            });
        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al crear el pedido',
                error: error
            })
        }
    },

    async actualizarDespachado (req, res, next)  {
        try {
            const pedido = req.body;
            pedido.estado = 'DESPACHADO';
            await Pedido.update(pedido).then(
            async (data)  =>{ 
            return res.status(201).json({
                success: true,
                message: `El pedido ${pedido.id} se ha actualizado correctamente`,
                data: pedido.id
            })
            });
        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al actualizar el pedido',
                error: error
            })
        }
    },

    async actualizarEncamino (req, res, next)  {
        try {
            const pedido = req.body;
            pedido.estado = 'EN CAMINO';
            await Pedido.update(pedido).then(
            async (data)  =>{ 
            return res.status(201).json({
                success: true,
                message: `El pedido ${pedido.id} se ha actualizado correctamente`,
                data: pedido.id
            })
            });
        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al actualizar el pedido',
                error: error
            })
        }
    },

    async actualizarEntregado (req, res, next)  {
        try {
            const pedido = req.body;
            pedido.estado = 'ENTREGADO';
            await Pedido.update(pedido).then(
            async (data)  =>{ 
            return res.status(201).json({
                success: true,
                message: `El pedido ${pedido.id} se ha actualizado correctamente`,
                data: pedido.id
            })
            });
        }catch (error) {
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al actualizar el pedido',
                error: error
            })
        }
    },

    async getByEstado(req,res,next) {
        try { 
            const estado = req.params.estado
            const data = await Pedido.buscarPorEstado(estado);
            return res.status(201).json(data)
        } catch (error){
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al obtener Ordenes por estado',
                error: error
            })
        }
    },

    
    async getByRepartidor(req,res,next) {
        try { 
            const estado = req.params.estado
            const id_repartidor = req.params.id_repartidor
            const data = await Pedido.buscarPorRepartidor(id_repartidor,estado);
            return res.status(201).json(data)
        } catch (error){
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al obtener Ordenes por repartidor',
                error: error
            })
        }
    },

    async getByCliente(req,res,next) {
        try { 
            const estado = req.params.estado
            const id_cliente = req.params.id_cliente
            const data = await Pedido.buscarPorCliente(id_cliente,estado);
            return res.status(201).json(data)
        } catch (error){
            console.log(`Error: ${error.message}`);
            return res.status(501).json({
                success: false,
                message: 'Hubo un error al obtener Ordenes por repartidor',
                error: error
            })
        }
    }
} 