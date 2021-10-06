import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';



class RestauranteProductosCrearController {

  late BuildContext context; 
  Function? refresh; 

  TextEditingController nombreController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();

  // ProductosProvider _productosProvider = new ProductossProvider();

  Future? init(BuildContext context,Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    precioController.text = '0.00';
    // _productosProvider.init(context);
  }

  void crearProducto() async { 
    String nombre = nombreController.text; 
    String descripcion = descripcionController.text;
    String precio = descripcionController.text;

    if(nombre.isEmpty || descripcion.isEmpty || precio.isEmpty) {
      MySnackbar.show(context,'Debe ingresar todos los campos');
      return; 
    }
  
  }





}