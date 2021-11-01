import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/pages/cliente/productos/detalle/cliente_producto_detalle_page.dart';
import 'package:dely_app/src/pages/cliente/productos/lista/cliente_productos_lista_page.dart';
import 'package:dely_app/src/provider/categorias_provider.dart';
import 'package:dely_app/src/provider/pedidos_provider.dart';
import 'package:dely_app/src/provider/productos_provider.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClienteProductosListaController {
  Usuario? user; 
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  Function? refresh; 

  List<Categoria> categorias = [];
  final CategoriasProvider _categoriasProvider =  CategoriasProvider();
  final ProductosProvider _productosProvider =  ProductosProvider();

  Future? init(BuildContext? context,Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    if((await _sharedPref.read('user')) != null ){
    user = Usuario.fromJson(await _sharedPref.read('user'));
    }
    _categoriasProvider.init(context!);
    getCategorias();
    refresh();
  }

  logout(){
    _sharedPref.logout(context!);
  }

  void getCategorias() async { 
    categorias = await _categoriasProvider.getAll();
    refresh!();
  }

  void openBottomSheet(Producto producto) async {
    showMaterialModalBottomSheet(
      context: context!, 
      builder: (context)=>ClienteProductoDetallePage(producto: producto));
  }

  Future<List<Producto>> getProductos(String idCategoria) async {
    return await _productosProvider.getProductos(idCategoria);
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

  void goToOrdenesList(){
          Navigator.pushNamed(context!,'clientes/ordenes/lista');
  }

  void goToPerfil(){
          Navigator.pushNamed(context!,'register/edit');
  }

  void goToOrderCreatePage(){
          Navigator.pushNamed(context!,'clientes/ordenes/crear');
      }
  }
