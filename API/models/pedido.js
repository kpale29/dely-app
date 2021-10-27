const db = require('../config/config.js')

const Pedido = { }

Pedido.crear  = async (orden) => { 
    sql = `INSERT INTO pedidos (id_cliente, direccion, estado, hora) 
    VALUES (
        ${orden.id_cliente},
        '${orden.direccion}',
        'PAGADO',
        ${Date.now()})`
    var results = await db.query(sql);
    
    if(results.affectedRows === 1 ){ 
        results = await db.query('SELECT LAST_INSERT_ID();')
    }
    return results
}

Pedido.buscarPorId  = async ( id ) => {
    const sql = `SELECT * FROM pedidos WHERE id='${id}';`
    var results = await db.query(sql);
    return results
}


module.exports = Pedido;