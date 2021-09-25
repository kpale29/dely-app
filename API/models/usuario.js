const db = require('../config/config.js');
const crypto = require('crypto')


const Usuario = {};

Usuario.getAll = async () => {
    
    const sql = `SELECT * FROM USUARIOS;`; 


    return results = await db.query(sql)
}


Usuario.create = async (usuario) => {

    const myPasswrdoHashed = crypto.createHash('md5').update(usuario.password).digest('hex');
    usuario.password=myPasswrdoHashed;
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

Usuario.buscarPorId  = async (id, callback) => {
    const sql = `SELECT id, correo,apellido,imagen, telefono, password, token_sesion FROM usuarios WHERE id='${id}';`
    var results = await db.query(sql).then(usuario =>{ callback(null,usuario)});
    return results
}

Usuario.buscarPorCorreo = async(email)=> { 
    const sql = `SELECT id, nombre,correo,apellido,imagen, telefono, password, token_sesion FROM usuarios WHERE correo="${email}";`
    var results = await db.query(sql)
    return results
}

Usuario.siPasswordConcuerda = (userPassword, hash)=>{
    const myPasswrdoHashed = crypto.createHash('md5').update(userPassword).digest('hex');
    return (myPasswrdoHashed === hash) ? true :  false
}


module.exports = Usuario;