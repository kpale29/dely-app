const express = require('express');
const app = express(); 
const http = require('http');
const server = http.createServer(app);
const logger = require('morgan');
const cors = require('cors');
const multer = require('multer');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

/* Iniciar Firebase Admin */ 
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const upload = multer({
    storage: multer.memoryStorage()
})


/* Rutas*/
const usuarios = require('./routes/usuarioRoutes'); 
const categorias = require('./routes/categoriasRoutes'); 
const productos = require('./routes/productosRoutes'); 
const pedidos = require('./routes/pedidosRoutes'); 


const port = process.env.PORT || 3000;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors());
app.disable('x-powered-by');

app.set('port',port);
//llamado a las rutas 
usuarios(app); 
categorias(app);
productos(app);
pedidos(app);

server.listen(3000,'localhost'  || 'localhost', () => { 
    console.log('Aplicacion de nodejs', process.pid, 'en el puerto', port, 'iniciado');
});


//ERROR DE RUTA
app.use((err,req,res,next) => {
    console.log(err);
    res.status(err.status || 500).send(err.stack);
}); 

module.exports = { app: app, server: server}
