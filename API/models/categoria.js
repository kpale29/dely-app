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

Categoria.getAll = async () => { 
    const sql = `SELECT * FROM CATEGORIAS order by nombre`
    var results = await db.query(sql)
    console.log(results)
    return results
}


module.exports = Categoria; 