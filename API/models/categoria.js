const db = require('../config/config.js')

const Categoria = {}

Categoria.create = async (categoria) => { 
    const sql = `INSERT INTO CATEGORIAS(NOMBRE, DESCRIPCION) VALUES ('${categoria.nombre}','${categoria.descripcion}');`
    var results = await db.query(sql);
    if(results.affectedRows === 1 ){ 
        results = await db.query('SELECT LAST_INSERT_ID();')
    }
    return results
}


module.exports = Categoria; 