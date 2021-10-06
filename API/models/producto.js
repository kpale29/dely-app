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

Product.update = async (producto) =>{
    const sql = `UPDATE PRODUCTOS SET 
    nombre = ${producto.nombre}, 
    descripcion = ${producto.descripcion}, 
    id_categoria = ${producto.id_categoria} where id = ${producto.id_producto};`
    var results = await db.query(sql)
    return results

}
module.exports = Product