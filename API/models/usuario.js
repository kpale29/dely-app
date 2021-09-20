const db = require('../config/config.js');


const Usuario = {};

Usuario.getAll = async () => {
    
    const sql = `SELECT * FROM USUARIOS;`; 


    return results = await db.query(sql)
}


Usuario.create = async (usuario) => {
    const sql = `INSERT INTO USUARIOS(correo, nombre,apellido,telefono,imagen,password,creado,modificado) values ('${usuario.correo}',
    '${usuario.nombre}',
    '${usuario.apellido}',
    ${usuario.telefono},
    '${usuario.imagen}',
    '${usuario.password}',
    NOW(),
    NOW());`;
    var results = await db.query(sql);
    if(results.affectedRows === 1){
        results = await db.query('SELECT LAST_INSERT_ID();');
    };
    return results;

}

module.exports = Usuario;