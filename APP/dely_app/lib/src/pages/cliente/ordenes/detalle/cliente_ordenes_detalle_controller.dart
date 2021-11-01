import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/provider/pedidos_provider.dart';
import 'package:dely_app/src/provider/usuario_provider.dart';
import 'package:flutter/material.dart';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClienteOrdenesDetalleController {
  BuildContext? context; 
  Function? refresh;
  Pedido? pedido;
  List<Usuario> usuarios = [];
  UsuarioProvider usuarioProvider = new UsuarioProvider(); 
  PedidosProvider pedidosProvider = new PedidosProvider(); 

  String idDelivery = '';
  Producto producto = new Producto(descripcion: '', idCategoria: 0, nombre: '', precio: 0);


  List<Producto?> selectedProducts = [];
  double total = 0.00;

  Future? init(BuildContext context, Function refresh, Pedido pedido) async { 
    this.context = context;
    this.refresh = refresh;
    this.pedido = pedido;

    pedidosProvider.init(context);
    usuarioProvider.init(context);
    
    GetRepartidor();
    getTotal();
    refresh();
  }

  void updatePedido()async{
    ResponseApi? responseApi = await pedidosProvider.actualizarEnCamino(pedido!);
    if(responseApi != null){
      Fluttertoast.showToast(msg: responseApi.message as String, toastLength: Toast.LENGTH_LONG );  
      Navigator.pop(context!,true);
    }
  }

  void updatePedidoEntregado()async{
    ResponseApi? responseApi = await pedidosProvider.actualizarEntregado(pedido!);
    if(responseApi != null){
      Fluttertoast.showToast(msg: responseApi.message as String, toastLength: Toast.LENGTH_LONG );  
      Navigator.pop(context!,true);
    }
  }

  void getTotal(){
    total = 0.00;
    pedido!.productos.forEach((p){
      if(p != null){
      total = total + (p.cantidad! * (p.precio.toDouble()));
      }
    });
    refresh!();
  }

  void GetRepartidor() async {
    usuarios = await usuarioProvider.getRepartidores();
    refresh!();
  }
}