import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClienteProductoDetalleController {
  BuildContext? context; 
  Function? refresh;
  Producto? producto;

  int counter = 1 ;
  double? productPrice; 

  SharedPref _sharedPref = SharedPref();

  List<Producto?> selectedProducts = [];

  Future? init(BuildContext context, Function refresh, Producto producto) async { 
    this.context = context;
    this.refresh = refresh;
    this.producto = producto; 
    productPrice = producto.precio;

    // _sharedPref.remove('order');

    if(await _sharedPref.read('order') != null) {

    selectedProducts = producto.fromJsonList(await _sharedPref.read('order')).toList();
    selectedProducts.forEach( (p) =>print('Producto: ${p!.toJson()}'));
    }


    refresh();
  }

  void addToBag(){
    int index = selectedProducts.indexWhere((p) => p!.id == producto!.id );

    if(index == -1){
      if(producto!.cantidad == null){
        producto!.cantidad = 1;
      }

      selectedProducts.add(producto);
    }else{ 
      selectedProducts[index]!.cantidad = counter;
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: "producto agregado");
  }

  void addItem(){
    counter++;
    productPrice = producto!.precio  * counter; 
    producto!.cantidad = counter;
    refresh!();
  }

  void removeItem(){
    if(counter > 1 ){
    counter--;
    productPrice = producto!.precio  * counter; 
    producto!.cantidad = counter;
    refresh!();
    }
  }

  
}