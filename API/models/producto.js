const db = require('../config/config.js')

const Product = { }

Product.crear  = async (producto) => { 
    sql = `INSERT INTO PRODUCTOS(nombre, descripcion, precio, imagen1, imagen2, imagen3, id_categoria) VALUES ('${producto.nombre}','${producto.descripcion}',${producto.precio},'','','',${producto.id_categoria});`
    var results = await db.query(sql);
    if(results.affectedRows === 1 ){ 
        results = await db.query('SELECT LAST_INSERT_ID();')
    }
    return results
}

Product.getByCategoria = async (id_categoria) => {
    sql = `SELECT p.id, p.nombre, p.descripcion, p.precio, p.id_categoria
    FROM productos as p
    Inner join 
    categorias as c 
    on p.id_categoria = c.id
    where c.id = ${id_categoria};`
    let results = await db.query(sql);
    return results
}

Product.update = async (producto) =>{
    const sql = `UPDATE PRODUCTOS SET 
    nombre = ${producto.nombre}, 
    descripcion = ${producto.descripcion}, 
    id_categoria = ${producto.id_categoria} where id = ${producto.id_producto};`
    var results = await db.query(sql)
    return results

}
module.exports = Product