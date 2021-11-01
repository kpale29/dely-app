import 'package:flutter/material.dart';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClienteOrdenesCrearController {
  late BuildContext context; 
  late Function refresh;

  Producto producto = new Producto(descripcion: '', idCategoria: 0, nombre: '', precio: 0);

  SharedPref _sharedPref = SharedPref();

  List<Producto?> selectedProducts = [];
  double total = 0.00;

  Future? init(BuildContext context, Function refresh) async { 
    this.context = context;
    this.refresh = refresh;
    if(await _sharedPref.read('order') != null) {

    selectedProducts = producto.fromJsonList(await _sharedPref.read('order')).toList();
    // selectedProducts.forEach( (p) =>print('Producto: ${p!.toJson()}'));
    }
    getTotal();
    refresh();
  }

  void getTotal(){
    total = 0.00;
    selectedProducts.forEach((p){
      if(p != null){
      total = total + (p.cantidad! * (p.precio.toDouble()));
      }
    });
    refresh();

  }

  void addItem(Producto producto){
    int index = selectedProducts.indexWhere((p) => p!.id == producto!.id );
    selectedProducts[index]!.cantidad = selectedProducts[index]!.cantidad! + 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Producto producto){
    if(producto.cantidad! > 1) {
    int index = selectedProducts.indexWhere((p) => p!.id == producto!.id );
    selectedProducts[index]!.cantidad = selectedProducts[index]!.cantidad! - 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
    }
  }

  void deleteItem(Producto producto){
    selectedProducts.removeWhere((p) => p!.id == producto!.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void goToOrderDireccionPage(){
    if(selectedProducts.length > 0) {
          Navigator.pushNamed(context!,'clientes/ordenes/direccion');
    }else{
    MySnackbar.show(context,'No tiene productos en la bolsa');
    }

  }
}