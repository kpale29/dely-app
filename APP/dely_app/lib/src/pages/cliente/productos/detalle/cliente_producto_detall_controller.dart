import 'package:dely_app/src/models/producto.dart';
import 'package:flutter/material.dart';

class ClienteProductoDetalleController {
  late BuildContext context; 
  late Function refresh;
  late Producto producto;

  Future init(BuildContext context, Function refresh,  Producto producto) async { 
    this.context = context;
    this.refresh = refresh;
    this.producto = producto; 
  }



}