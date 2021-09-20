const express = require('express');
const app = express(); 
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');


/* Rutas*/
const usuarios = require('./routes/usuarioRoutes'); 


const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors());
app.disable('x-powered-by');

app.set('port',port);
//llamado a las rutas 
usuarios(app); 

server.listen(3000,'192.168.1.24'  || 'localhost', () => { 
    console.log('Aplicacion de nodejs', process.pid, 'en el puerto', port, 'iniciado');
});


//ERROR DE RUTA
app.use((err,req,res,next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
}); 

module.exports = { app: app, server: server}