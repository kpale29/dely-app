import 'dart:math';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/pages/cliente/ordenes/crear/cliente_ordenes_crear_controller.dart';
import 'package:dely_app/src/widgets/no_data_widget.dart';
import 'package:dely_app/src/widgets/no_data_widget_bag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class ClientesOrdenesCrearPage extends StatefulWidget {
  ClientesOrdenesCrearPage({Key? key}) : super(key: key);

  @override
  _ClientesOrdenesCrearPageState createState() => _ClientesOrdenesCrearPageState();
}



class _ClientesOrdenesCrearPageState extends State<ClientesOrdenesCrearPage> {

  ClienteOrdenesCrearController _con = new ClienteOrdenesCrearController(); 
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, Refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Pedido"),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Column(children: [
          Divider(
          color: Colors.grey[400],
          endIndent: 30,
          indent: 30,
          ),
        _textTotalPrice(),
        _nextButton()
      ],)
      ),
      body: _con.selectedProducts.length > 0 ? 
        ListView(
          children: _con.selectedProducts.map((Producto? producto) {
            return _cardProducto(producto!);
          }).toList(),
        )
        : NoDataWidgetBag()
    );
  }

  Widget _nextButton(){
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 275,
      height: 50,
      child: ElevatedButton(
        onPressed: _con.goToOrderDireccionPage,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text('Continuar',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
      )
    );
  }

  Widget _cardProducto(Producto producto){
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
      child: Row(
        children:[
        Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[200]),
          width: 90,
          height:90,
          padding: EdgeInsets.all(10),
          child: _imageRandomWidget(),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(producto.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height:10),
            _addOrRemoveItem(producto),

          ],
        ),
        Spacer(),
        Column(children: [
          _textPrice(producto),
          _trashIcon(producto)
        ],)
      ]
      ),
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

  Widget _textPrice(Producto producto){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Text('Q ${producto.precio *  producto.cantidad!.toDouble()}',
        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold) 
      ),
    );
  }

  Widget _trashIcon(Producto producto){ 
    return IconButton(
      onPressed: (){_con.deleteItem(producto);},
      icon: Icon(Icons.delete, color: Colors.red)
    );
  }

  Widget _addOrRemoveItem(Producto producto){
    return Row(
              children: [
                GestureDetector(
                  onTap: (){_con.removeItem(producto);},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical:7),
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                        color: Colors.grey[200],
                      ),
                    child: Text('-'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical:7),
                  decoration:BoxDecoration(
                      color: Colors.grey[200],
                    ),
                  child: Text('${producto.cantidad}'),
                ),
                GestureDetector(
                  onTap: (){_con.addItem(producto);},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical:7),
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                        color: Colors.grey[200],
                      ),
                    child: Text('+'),
                  ),
                ),
              ]
            );
  }

  void Refresh() {
    setState(() {
      
    });
  }

  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:30, vertical:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          Text('Q ${_con.total} ', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
        ],
    ));
  }
}