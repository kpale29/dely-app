const db = require('../config/config.js');

const Rol = {};


Rol.crear =  async  (id_usuario,id_rol) => {
    const sql = `INSERT INTO roles_usuarios (id_usuario,id_rol) VALUES (${id_usuario},${id_rol});`
    var results = await db.query(sql);
}

Rol.delete =  async  (id_usuario,id_rol) => {
    const sql = `DELETE FROM roles_usuarios WHERE id_usuario = ${id_usuario} and id_rol = ${id_rol};`
    var results = await db.query(sql);

}

module.exports = Rol;