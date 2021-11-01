import 'dart:math';

import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/detalle/restaurante_ordenes_detalle_controller.dart';
import 'package:dely_app/src/utils/relative_time_util.dart';
import 'package:dely_app/src/widgets/no_data_widget_bag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class RestauranteOrdenesDetallePage extends StatefulWidget {
  Pedido pedido;
  RestauranteOrdenesDetallePage({Key? key, required this.pedido}) : super(key: key);

  @override
  _RestauranteOrdenesDetallePageState createState() => _RestauranteOrdenesDetallePageState();
}


class _RestauranteOrdenesDetallePageState extends State<RestauranteOrdenesDetallePage> {

  RestauranteOrdenesDetalleController _con = new RestauranteOrdenesDetalleController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh,widget.pedido);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetPedido(),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: Container(
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(children: [
          Divider(
          color: Colors.grey[400],
          endIndent: 30,
          indent: 30,
          ),
        _textSelect(),
        _deliveryData(),
        _dropDownUsuario(_con.usuarios),
        _TextClient(),
        _TextDireccion(),
        _textTotalPrice(),
        _nextButton()
      ],)
      ),
      body:
      _con.pedido != null ?
      _con.pedido!.productos.length > 0 ? 
        ListView(
          children: _con.pedido!.productos.map((Producto? producto) {
            return _cardProducto(producto!);
          }).toList(),
        )
        : NoDataWidgetBag()
        : NoDataWidgetBag()
    );
  }

  Widget _dropDownUsuario(List<Usuario> usuarios){
    if(_con.pedido != null){
    if(_con.pedido!.estado == 'PAGADO'){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal:0),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down_circle,color: Colors.green)),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text('Seleccionar Repartidor',
                    style: TextStyle(color: Colors.green,fontSize: 16)),
                  items: _dropDownItems(usuarios),
                  value: _con.idDelivery == '' ? null : _con.idDelivery,
                  onChanged: (option){
                    setState(() {
                      print(option);
                      _con.idDelivery = option.toString();
                    });
                  },
                  ),
              )
          ],)
          )
          ,
        ),
      );
      }else{
        return Container(); 
      } 
    }
      return Container(); 

  }

  Widget _deliveryData( ){
    if(_con.pedido != null){
    if(_con.pedido!.estado != 'PAGADO'){
      if(_con.pedido!.repartidor != null){
      return Container(
        alignment:  Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal:30, vertical: 10),
        child: Text('Repartidor: ${_con.pedido!.repartidor!.nombre} ${_con.pedido!.repartidor!.apellido}', style: TextStyle(
          fontWeight: FontWeight.bold 
        )));
      }
    }
    return Container();
    }else{ 
    return (Text(''));
    }
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Usuario> usuarios) {
    List<DropdownMenuItem<String>> list = [];

    usuarios.forEach((element) {
      list.add(DropdownMenuItem(
        child: Text('${element.nombre} ${element.apellido}'),
        value: element.id,
        ));
    });
    return list;
  }

  Widget _textSelect(){ 
  if(_con.pedido != null){
    if(_con.pedido!.estado == 'PAGADO'){
    return Container(
      alignment:  Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal:30),
      child: Text(
        'Asignar repartidor', 
        style: TextStyle(
          fontSize: 18,
          color: Colors.green[900],
          fontWeight: FontWeight.bold
        )
      ),
    );
    }else{ 
    return Container(
    alignment:  Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal:30),
      child: Text(
        'Repartidor asignado', 
        style: TextStyle(
          fontSize: 18,
          color: Colors.green[900],
          fontWeight: FontWeight.bold
        )
      ),
  );
  }  
  }
  return Text('');
  }

  Widget _textCliente(String mensaje){
    return Container(
      margin: EdgeInsets.only(left:30, right: 30, bottom: 8),
      child: Row(
        children: [
              Text(mensaje, 
              style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.bold),
              maxLines: 2
                ),
            ]
          ),
    );
  }

  Widget GetPedido(){
    print(_con.pedido);
    if(_con.pedido != null){
      if(_con.pedido!.id != null){
      return Text('Orden #${_con.pedido!.id}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
      }
    }
    return Text('d');
  }

  Widget _TextClient(){
    if(_con.pedido != null){
      if(_con.pedido!.cliente != null){
        return Container(
        margin: EdgeInsets.only(left:30, right: 30, bottom: 5),
        child: Row(
        children: [
              Text('Cliente: ${_con.pedido!.cliente!.nombre ?? ''} ${_con.pedido!.cliente!.apellido ?? ''}', 
              style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.bold),
              maxLines: 2
                ),
            ]
          ),
    );
      }
    }
    return Text('');  
  }
  
  Widget _TextDireccion(){ 
    if(_con.pedido != null){
      if(_con.pedido!.direccion != null){
        return Container(
        margin: EdgeInsets.only(left:30, right: 30, bottom: 5),
        child: Row(
        children: [
              Text('Entregar en: ${_con.pedido!.direccion ?? ''}', 
              style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.bold),
              maxLines: 2
                ),
            ]
          ),
    );
      }
    }
    return Text(''); 
  }

  Widget _TextFecha(){ 
    if(_con.pedido != null){
      if(_con.pedido!.hora != null){
        return Container(
        margin: EdgeInsets.only(left:30, right: 30, bottom: 5),
        child: Row(
        children: [
              Text('${RelativeTimeUtil.getRelativeTime((_con.pedido!.hora))}', 
              style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.bold),
              maxLines: 2
                ),
            ]
          ),
    );
      }
    }
    return Text(''); 
  }

  Widget _nextButton(){
    if(_con.pedido != null){
      if(_con.pedido!.estado == 'PAGADO'){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 275,
      height: 50,
      child: ElevatedButton(
        onPressed: _con.updatePedido,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text('Despachar Orden',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
      )
    );
    }
    }
    return Container(); 
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
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(producto.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height:10),
            Text('Cantidad: ${producto.cantidad}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
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
                  child:  Image.network('http://lorempixel.com/400/400/food/',fit: BoxFit.cover),
                  // child:  Image.network('https://foodish-api.herokuapp.com/images/${comida}/${comida}${rnd}.jpg',fit: BoxFit.cover),
              );
  }

  void refresh() {
    setState(() {
    });
  }

  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:30, vertical:8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
          Text('Q ${_con.total} ', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
        ],
    ));
  }
}