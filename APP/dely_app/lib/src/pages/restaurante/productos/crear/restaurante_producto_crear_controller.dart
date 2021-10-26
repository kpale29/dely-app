import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/provider/categorias_provider.dart';
import 'package:dely_app/src/provider/productos_provider.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';



class RestauranteProductosCrearController {

  late BuildContext context; 
  Function? refresh; 

  TextEditingController nombreController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  TextEditingController precioController = new TextEditingController();

  CategoriasProvider _categoriasProvider = CategoriasProvider();

  ProductosProvider _productosProvider = ProductosProvider();

  late List<Categoria> categorias = []; 
  late String idCategoria = ''; 


  Future? init(BuildContext context,Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    precioController.text = '0.00';
    _categoriasProvider.init(context);
    _productosProvider.init(context);
    getCategorias();
  }

  void crearProducto() async { 
    String nombre = nombreController.text; 
    String descripcion = descripcionController.text;
    double precio = double.parse(precioController.text);

    if(nombre.isEmpty || descripcion.isEmpty || precio == 0) {
      MySnackbar.show(context,'Debe ingresar todos los campos');
      return; 
    }

    if(idCategoria == '') {
      MySnackbar.show(context,'Debe seleccionar alguna Categoria');
      return; 
    }

    Producto producto = Producto(
      descripcion: descripcion,
      nombre: nombre, 
      precio: precio,
      idCategoria : int.parse(idCategoria)
    ); 

    // print('Producto:${producto.toJson()}');
    // print('NOMBRE: ${nombre} DESCRIPCION: ${descripcion} PRECIO: ${precio} ${idCategoria}');

    ResponseApi? responseApi = await _productosProvider.create(producto);
    print(responseApi);
    if(responseApi != null) {
    MySnackbar.show(context,responseApi.message);
    resetValues();
    }

  }

  void resetValues(){ 
    idCategoria = '';
    descripcionController.text = '';
    nombreController.text = ''; 
    precioController.text = '0.00';
    refresh!();

  }

  void getCategorias() async {
    categorias = await _categoriasProvider.getAll();
    refresh!();
  }





}