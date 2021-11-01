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
        _textDescription(),
        SizedBox(height: 90 ),
        _addOrRemoveItem(),
        _buttonShoppingBag()
        ],
      )
    );
  }

  Widget _imageRandomWidget (){
    // int rnd = 1 + Random().nextInt(10);
    // int food = 1 + Random().nextInt(10);

    // String comida = 'burger';

    // switch (food)
    // {
    //   case 1: 
    //     comida = 'biryani';
    //   break; 
    //   case 2: 
    //     comida = 'burger';
    //   break; 
    //   case 3: 
    //     comida = 'butter-chicken';
    //   break; 
    //   case 4: 
    //     comida = 'dessert';
    //   break; 
    //   case 5: 
    //     comida = 'dosa';
    //   break; 
    //   case 6: 
    //     comida = 'idly';
    //   break; 
    //   case 7: 
    //     comida = 'pasta';
    //   break; 
    //   case 8: 
    //     comida = 'pizza';
    //   break; 
    //   case 9: 
    //     comida = 'rice';
    //   break; 
    //   case 10: 
    //     comida = 'samosa';
    //   break; 
    // }
    return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  // child:  Image.network('https://foodish-api.herokuapp.com/images/${comida}/${comida}${rnd}.jpg',fit: BoxFit.cover),
                  child:  Image.network('http://lorempixel.com/400/400/food/',fit: BoxFit.cover),
              );
  }

  Widget _textName() {
    return Container(
    margin: EdgeInsets.only(top: 15, left: 30),
    alignment:  Alignment.centerLeft,
    child: GetProducto(),
    );
  }
  Widget _textDescription() {
    return Container(
    margin: EdgeInsets.only(top: 15, left: 30),
    alignment:  Alignment.centerLeft,
    child: GetDescription(),
    );
  }

  Widget _addOrRemoveItem(){
    return Row(
      children: [
        IconButton(onPressed: _con.removeItem,
        icon: Icon(Icons.remove_circle_outline, color: Colors.grey, size: 40)
        ),
        SizedBox(width: 10),
        Text(_con.counter.toString(),style: TextStyle(
          fontSize: 30,
          color: Colors.grey, 
          fontWeight: FontWeight.bold)),
        IconButton(onPressed: _con.addItem,
        icon: Icon(Icons.add_circle_outline, color: Colors.grey, size: 40)
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 25),
          child: GetPrice()
        )
      ],
    );
  }
  
  Widget _buttonShoppingBag(){
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 275,
      height: 50,
      child: ElevatedButton(
        onPressed: _con.addToBag,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text('Agregar a la bolsa')
      )
    );
  }

  void refresh() { 
    setState(() {
    });
  }

  Widget GetProducto(){
    if(_con.producto != null){
      if(_con.producto!.nombre != null){
      return Text(_con.producto!.nombre, 
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
      }
    }
    return Text('');
  }
  
  Widget GetDescription(){
    if(_con.producto != null){
      if(_con.producto!.descripcion != null){
      return Text(_con.producto!.descripcion, 
        style: TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold,
          color: Colors.grey
          ));
      }
    }
    return Text('');
  }

  Widget GetPrice(){ 
    if(_con.producto != null){
      if(_con.productPrice != null){
      return Text('Q ${_con.productPrice}', 
        style: TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold,
          ));
      }
    }
    return Text('Q0.00');
  }

}