const db = require('../config/config.js')

const PedidoProducto = { }

PedidoProducto.crear  = async (id_pedido,id_producto,cantidad) => {
    sql = `INSERT INTO pedidos_productos (id_pedido, id_producto, cantidad) VALUES (${id_pedido},${id_producto},${cantidad});`
    var results = await db.query(sql);
    if(results.affectedRows === 1 ){ 
        results = await db.query('SELECT LAST_INSERT_ID();')
    }
    return results
}

module.exports = PedidoProducto;