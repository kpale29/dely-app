const mysql = require('mysql');
const { promisify } = require('util');
const conexion = mysql.createPool({
        host: 'localhost',
        database: 'delivery_db', 
        user: 'root', 
        password: '', 
    });

conexion.getConnection((err,connection)=> {
    if(err) {
        if(err.code === 'PROTOCOL_CONNECTION_LOST'){
            console.error('DATABASE CONNECTION WAS CLOSED');
        }
        if(err.code === 'ER_CON_COUNT_ERROR'){
            console.error('DATABASE HAS TO MANY CONNECTIONS');
        }
        if(err.code === 'ECONNREFUSED'){
            console.error('DATABASE CONNECTION WAS REFUSED');
        }
        
    }
    if(connection) {
        connection.release()
        console.log('DB is connected')
    }
    return;
})

// convertir promesas en callbacks 
conexion.query = promisify(conexion.query);
module.exports = conexion;