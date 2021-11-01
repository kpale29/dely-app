import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/pages/cliente/ordenes/detalle/cliente_ordenes_detalle_page.dart';
import 'package:dely_app/src/pages/delivery/ordenes/detalle/delivery_ordenes_detalle_page.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/detalle/restaurante_ordenes_detalle_controller.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/detalle/restaurante_ordenes_detalle_page.dart';
import 'package:dely_app/src/provider/pedidos_provider.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClienteOrdenesListaController{
  Usuario? user; 
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  Function? refresh; 

  List<String> estado = ['PAGADO','DESPACHADO','EN CAMINO','ENTREGADO'];
  final PedidosProvider _pedidosProvider = PedidosProvider();
  
  bool isUpdate = false;

  Future? init(BuildContext? context,Function refresh)async {
    this.context = context;
    this.refresh = refresh;
    user = Usuario.fromJson(await _sharedPref.read('user'));
    _pedidosProvider.init(context!);
    refresh();
  }

  logout(){
    _sharedPref.logout(context!);
  }

  Future<List<Pedido>> getPedidos(String estado) async { 
    if(user != null)
    {return await _pedidosProvider.getByCliente(user!.id as String, estado);}
    return [];
  }

  void goToPage(){
    if(user != null){
      if(user!.roles != null){
        if(user!.roles!.length > 1){
          Navigator.pushNamedAndRemoveUntil(context!,'roles',(route) => false);
      }else{
          Navigator.pushNamedAndRemoveUntil(context!,user!.roles![0].route,(route) => false);
      }
      }
    }
  }

  void goToCategoriasCrear(){ 
    Navigator.pushNamed(context!, 'Delivery/categorias/crear');
  }
  void goToProductosCrear(){ 
    Navigator.pushNamed(context!, 'restaurante/productos/crear');
  }
  void openBottomSheet(Pedido pedido) async{
    var resultado = await showMaterialModalBottomSheet(
      context: context!, 
      builder: (context)=>ClienteOrdenesDetallePage(pedido: pedido));
    if (resultado != null) {
      isUpdate = true;
    }
  if(isUpdate){
    refresh!();
  }
  }


}