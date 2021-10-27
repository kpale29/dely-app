import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/provider/pedidos_provider.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClienteOrdenesDireccionController {
  
  late BuildContext context; 
  late Function refresh;
  late Usuario usuario;

  TextEditingController direccionController =  TextEditingController();

  Producto producto = new Producto(descripcion: '', idCategoria: 0, nombre: '', precio: 0);

  SharedPref _sharedPref = SharedPref();

  List<Producto> selectedProducts = [];

  final PedidosProvider _pedidosProvider = PedidosProvider();

  Future? init(BuildContext context, Function refresh) async { 
    this.context = context;
    this.refresh = refresh;

    _pedidosProvider.init(context);

    refresh();
  }

  void createOrden()async{
    usuario = Usuario.fromJson(await _sharedPref.read('user'));
    selectedProducts = producto.fromJsonList(await _sharedPref.read('order')).toList();
    
    Pedido pedido = new Pedido(
      idCliente:  usuario.id, 
      direccion: direccionController.text, 
      hora: null, 
      idRepartidor: null, 
      productos: selectedProducts,
    );
    print(pedido);
    ResponseApi? responseApi = await _pedidosProvider.create(pedido);

    if (responseApi != null){
      print('respuesta: ${responseApi}');
      MySnackbar.show(context, responseApi.message.toString());

    }


  }



}