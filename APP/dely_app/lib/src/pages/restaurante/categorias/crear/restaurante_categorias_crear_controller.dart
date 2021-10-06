import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/provider/categorias_provider.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class RestauranteCategoriasCrearController {

  late BuildContext context; 
  Function? refresh; 

  TextEditingController nombreController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();

  CategoriasProvider _categoriasProvider = new CategoriasProvider();

  Future? init(BuildContext context,Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _categoriasProvider.init(context);
  }

  void crearCategoria() async { 
    String nombre = nombreController.text; 
    String descripcion = descripcionController.text;

    if(nombre.isEmpty || descripcion.isEmpty) {
      MySnackbar.show(context,'Debe ingresar todos los campos');
      return; 
    }

    Categoria categoria = Categoria(
    descripcion: descripcion, 
    nombre: nombre);

    ResponseApi? responseApi = await _categoriasProvider.create(categoria);

    MySnackbar.show(context,responseApi?.message);

    
    if(responseApi !=null) {
      if(responseApi.succes){
        nombreController.text = '';
        descripcionController.text = '';
      }
    }


    // print('Nombre: ${nombre} , Descripcion: ${descripcion}');
  
  }





}