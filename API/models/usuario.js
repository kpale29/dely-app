const db = require('../config/config.js');
const Rol = require('../models/rol');
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
        console.log(results)
        return results;
    };
    return false;
}

Usuario.actualizarToken = async (id,token) => {
    console.log(token)
    const sql = `UPDATE USUARIOS SET token_sesion = \'${token}\' WHERE id = ${id}`; 
    var results = await db.query(sql)
    return results 
}

Usuario.buscarPorId  = async (id, callback) => {
    const sql = `SELECT id, correo,apellido,imagen, telefono, password, token_sesion FROM usuarios WHERE id='${id}';`
    var results = await db.query(sql).then(usuario =>{ callback(null,usuario)});
    return results
}

Usuario.buscarPorCorreo = async(email)=> { 
    const sql = `SELECT U.id, U.nombre, U.correo, U.apellido,U.imagen, U.telefono, U.password, U.token_sesion, CONCAT('[',GROUP_CONCAT(JSON_OBJECT( 'id', R.id, 'nombre',R.nombre, 'imagen',R.imagen, 'route',R.route )),']') AS roles FROM usuarios AS U INNER JOIN roles_usuarios AS RU ON RU.id_usuario = U.id INNER JOIN roles as R ON R.id = RU.id_rol WHERE correo='${email}' group by U.id;`
    var results = await db.query(sql)
    return results
}

Usuario.buscarRepartidores = async ()=> { 
    const sql = `SELECT U.id, U.nombre, U.correo, U.apellido, U.imagen, U.telefono, U.password, U.token_sesion
    FROM usuarios AS U 
    INNER JOIN roles_usuarios AS RU 
    ON RU.id_usuario = U.id 
    INNER JOIN roles as R ON R.id = RU.id_rol  
    where R.id = 3;`
    var results = await db.query(sql)
    return results
}

Usuario.actualizarConPassword = async (usuario)=>{
    const myPasswrdoHashed = crypto.createHash('md5').update(usuario.password).digest('hex');

    const sql = `UPDATE USUARIOS SET 
        password = '${myPasswrdoHashed}',
        nombre = '${usuario.nombre}',
        apellido = '${usuario.apellido}'
        WHERE id = ${usuario.id};`
    var results = await db.query(sql)
    return results
}

Usuario.ifRolExist = async (id_usuario, id_rol) =>{
    const sql = `SELECT * FROM roles_usuarios where id_usuario = ${id_usuario} and id_rol = ${id_rol}`
    var results = await db.query(sql)
    if (results.length > 0) {
        return true
    }
    return false
}

Usuario.updateRestauranteTrue = async (id_usuario) => {
    await Usuario.ifRolExist(id_usuario,2).then(async (respuesta) => {
        if(respuesta === false){
            console.log("Restaurante no esta, creando")
            await Rol.crear(id_usuario, 2);
            return;
        }
        console.log("Restaurante si esta,nada por hacer")
    
    });
    
}

Usuario.updateRestauranteFalse = async (id_usuario) => {
    await Usuario.ifRolExist(id_usuario,2).then(async (respuesta)=>{
        if(respuesta === true){
            await Rol.delete(id_usuario, 2);
            console.log("Restaurante si esta, eliminando")
            return;
        }
        console.log("Restaurante no esta, nada por hacer")
    });
}

Usuario.updateRepartidorTrue = async (id_usuario) => {
    await Usuario.ifRolExist(id_usuario,3).then(async (respuesta)=>{

        if(respuesta === false){
            console.log("Repartidor no esta, creando")
            await Rol.crear(id_usuario, 3);
            return;
        }
        console.log("Repartidor si esta, nada por hacer")
    });

}

Usuario.updateRepartidorFalse = async (id_usuario) => {
    await Usuario.ifRolExist(id_usuario,3).then( async (respuesta)=>{
        if(respuesta === true){
            console.log("Repartidor si esta, borrando")
            await Rol.delete(id_usuario, 3);
            return;        
        }
        console.log("Repartidor no esta, nada por hacer")
    });
}




Usuario.actualizarSinPassword = async (usuario)=>{

    const sql = `UPDATE USUARIOS SET 
        nombre = '${usuario.nombre}',
        apellido = '${usuario.apellido}'
        WHERE id = ${usuario.id};`
    var results = await db.query(sql)
    return results
}

Usuario.siPasswordConcuerda = (userPassword, hash)=>{
    const myPasswrdoHashed = crypto.createHash('md5').update(userPassword).digest('hex');
    return (myPasswrdoHashed === hash) ? true :  false
}


module.exports = Usuario;