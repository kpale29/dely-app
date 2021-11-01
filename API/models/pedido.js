const db = require('../config/config.js')

const Pedido = { }

Pedido.crear  = async (orden) => { 
    console.log(orden)
    sql = `INSERT INTO pedidos (id_cliente, direccion, estado, hora) 
    VALUES (
        ${orden.id_cliente},
        '${orden.direccion}',
        'PAGADO',
        ${Date.now()})`
    var results = await db.query(sql);
    if(results.affectedRows === 1 ){ 
        console.log('pedido creado correctacmente id: ', results.insertId)
        return results
    }
}
Pedido.update = async (orden) =>{
    console.log(orden)
    const sql = `UPDATE pedidos 
    SET 
    id_repartidor=${orden.id_repartidor},
    estado='${orden.estado}'
    WHERE id = ${orden.id}`
    var results = await db.query(sql);
    console.log('actualizar estado: ',results)
    return results
}

Pedido.buscarPorEstado = async (estado) => {
    sql = `SELECT o.id,
    o.id_cliente,
    o.direccion,
    o.id_repartidor,
    o.estado,
    o.hora,
    JSON_OBJECT('id',u.id,'nombre',u.nombre,'apellido', u.apellido) as cliente,
    JSON_OBJECT('id',re.id,'nombre',re.nombre,'apellido', re.apellido) as repartidor,
    CONCAT('[',GROUP_CONCAT(JSON_OBJECT
    ('id', p.id, 
    'nombre',p.nombre,
    'descripcion',p.descripcion,
    'precio',p.precio,
    'cantidad', pp.cantidad,
    'id_categoria', p.id_categoria
    )),']') as productos
    FROM pedidos as o 
    inner join usuarios as u 
    on o.id_cliente = u.id
    left join usuarios as re 
    on o.id_repartidor = re.id
    inner join pedidos_productos as pp 
    on pp.id_pedido = o.id
    inner join productos as p 
    on p.id = pp.id_producto
    where o.estado = '${estado}'
    GROUP BY o.id, u.id,re.id`
    var results = await db.query(sql);
    return results
}

Pedido.buscarPorRepartidor = async (id_repartidor, estado) => {
    sql = `SELECT o.id,
    o.id_cliente,
    o.direccion,
    o.id_repartidor,
    o.estado,
    o.hora,
    JSON_OBJECT('id',u.id,'nombre',u.nombre,'apellido', u.apellido) as cliente,
    JSON_OBJECT('id',re.id,'nombre',re.nombre,'apellido', re.apellido) as repartidor,
    CONCAT('[',GROUP_CONCAT(JSON_OBJECT
    ('id', p.id, 
    'nombre',p.nombre,
    'descripcion',p.descripcion,
    'precio',p.precio,
    'cantidad', pp.cantidad,
    'id_categoria', p.id_categoria
    )),']') as productos
    FROM pedidos as o 
    inner join usuarios as u 
    on o.id_cliente = u.id
    left join usuarios as re 
    on o.id_repartidor = re.id
    inner join pedidos_productos as pp 
    on pp.id_pedido = o.id
    inner join productos as p 
    on p.id = pp.id_producto
    where o.estado = '${estado}'
    and o.id_repartidor = ${id_repartidor}
    GROUP BY o.id, u.id,re.id`
    var results = await db.query(sql);
    return results
}

Pedido.buscarPorCliente= async (id_cliente, estado) => {
    sql = `SELECT o.id,
    o.id_cliente,
    o.direccion,
    o.id_repartidor,
    o.estado,
    o.hora,
    JSON_OBJECT('id',u.id,'nombre',u.nombre,'apellido', u.apellido) as cliente,
    JSON_OBJECT('id',re.id,'nombre',re.nombre,'apellido', re.apellido) as repartidor,
    CONCAT('[',GROUP_CONCAT(JSON_OBJECT
    ('id', p.id, 
    'nombre',p.nombre,
    'descripcion',p.descripcion,
    'precio',p.precio,
    'cantidad', pp.cantidad,
    'id_categoria', p.id_categoria
    )),']') as productos
    FROM pedidos as o 
    inner join usuarios as u 
    on o.id_cliente = u.id
    left join usuarios as re 
    on o.id_repartidor = re.id
    inner join pedidos_productos as pp 
    on pp.id_pedido = o.id
    inner join productos as p 
    on p.id = pp.id_producto
    where o.estado = '${estado}'
    and o.id_cliente = ${id_cliente}
    GROUP BY o.id, u.id,re.id`
    var results = await db.query(sql);
    return results
}

Pedido.buscarPorId  = async ( id ) => {
    const sql = `SELECT * FROM pedidos WHERE id='${id}';`
    var results = await db.query(sql);
    return results
}


module.exports = Pedido;