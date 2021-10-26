import 'dart:math';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/pages/cliente/productos/detalle/cliente_producto_detall_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class ClienteProductoDetallePage extends StatefulWidget {

  Producto producto;

  ClienteProductoDetallePage({Key? key, required this.producto}) : super(key: key);

  @override
  _ClienteProductoDetallePageState createState() => _ClienteProductoDetallePageState();
}

class _ClienteProductoDetallePageState extends State<ClienteProductoDetallePage> {

  ClienteProductoDetalleController _con  = ClienteProductoDetalleController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) { 
      _con.init(context, refresh, widget.producto);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(  
        children: [
        _imageRandomWidget(),
        _textName(),
        ],
      )
    );
  }

  Widget _imageRandomWidget (){
    int rnd = 1 + Random().nextInt(10);
    int food = 1 + Random().nextInt(10);

    String comida = 'burger';

    switch (food)
    {
      case 1: 
        comida = 'biryani';
      break; 
      case 2: 
        comida = 'burger';
      break; 
      case 3: 
        comida = 'butter-chicken';
      break; 
      case 4: 
        comida = 'dessert';
      break; 
      case 5: 
        comida = 'dosa';
      break; 
      case 6: 
        comida = 'idly';
      break; 
      case 7: 
        comida = 'pasta';
      break; 
      case 8: 
        comida = 'pizza';
      break; 
      case 9: 
        comida = 'rice';
      break; 
      case 10: 
        comida = 'samosa';
      break; 
    }
    return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child:  Image.network('https://foodish-api.herokuapp.com/images/${comida}/${comida}${rnd}.jpg',fit: BoxFit.cover),
              );
  }

  Widget _textName() {
    return Container(
    alignment:  Alignment.centerLeft,
    margin: EdgeInsets.only(),
    child: 
    Text(_con.producto.nombre, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
    );
  }
  void refresh() { 
    setState(() {

    });
  }

}