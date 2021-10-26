import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:http/http.dart' as http;


import 'package:dely_app/src/api/environment.dart';

class ProductosProvider {
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/Productos';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi?> create(Producto producto) async { 
    
    try{
    Uri url = Uri.http(_url, '$_api/crear');
    String bodyParams = json.encode(producto);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.post(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear el producto: $e' );
      MySnackbar.show(context,'Error al crear el producto');
      
      return null;
    }
    
  }

  Future<List<Producto>> getProductos(String idCategoria) async{
    List<Producto> lista = [];
    Producto producto = Producto(descripcion: '', id: '', nombre: '',precio: 0, idCategoria: 0);
    try {
      Uri url = Uri.http(_url, '$_api/getbyCategoria/${idCategoria}');
      Map<String,String> headers = {
        'Content-type':'application/json'
      };
      final response = await http.get(url,headers: headers);

      final data = json.decode(response.body);
      lista = producto.fromJsonList(data);

      return lista.toList();
      
    } catch (e) {
      print('Error: ${e}');
      return lista;
    }
  }

}