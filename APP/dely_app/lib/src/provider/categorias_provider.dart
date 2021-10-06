
import 'dart:convert';

import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'package:dely_app/src/api/environment.dart';

class CategoriasProvider {
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/categorias';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi?> create(Categoria categoria) async { 
    
    try{
    Uri url = Uri.http(_url, '$_api/crear');
    String bodyParams = json.encode(categoria);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.post(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear categoria: $e' );
      return null;
    }
    
  }

}