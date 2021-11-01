import 'dart:convert';

import 'package:dely_app/src/api/environment.dart';
import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PedidosProvider {

  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/Pedidos';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi?> create(Pedido pedido)async{
    try{
      Uri url = Uri.http(_url, '$_api/crear');
    String bodyParams = json.encode(pedido);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.post(url,headers: headers, body: bodyParams);
    final data = json.decode(response.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear el pedido: $e' );
      MySnackbar.show(context!,'Error al crear el pedido');
      return null;
    }
  }

  Future<ResponseApi?> actualizarDespachado(Pedido pedido)async{
    try{
      Uri url = Uri.http(_url, '$_api/actualizarDespachado');
    String bodyParams = json.encode(pedido);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.put(url,headers: headers, body: bodyParams);
    final data = json.decode(response.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear el pedido: $e' );
      MySnackbar.show(context,'Error al actualizar');
      return null;
    }
  }

  Future<ResponseApi?> actualizarEnCamino(Pedido pedido)async{
    try{
      Uri url = Uri.http(_url, '$_api/actualizarEncamino');
    String bodyParams = json.encode(pedido);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.put(url,headers: headers, body: bodyParams);
    final data = json.decode(response.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear el pedido: $e' );
      MySnackbar.show(context,'Error al actualizar');
      return null;
    }
  }

  Future<ResponseApi?> actualizarEntregado(Pedido pedido)async{
    try{
      Uri url = Uri.http(_url, '$_api/actualizarEntregado');
    String bodyParams = json.encode(pedido);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.put(url,headers: headers, body: bodyParams);
    final data = json.decode(response.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear el pedido: $e' );
      MySnackbar.show(context,'Error al actualizar');
      return null;
    }
  }

  Future<List<Pedido>> getByEstado(String estado) async{
    List<Pedido> lista = [];
    Pedido pedido = Pedido(direccion: '', hora: null, idCliente: '', idRepartidor: '', productos: []);
    try {
      Uri url = Uri.http(_url, '$_api/ByEstado/$estado');
      Map<String,String> headers = {
        'Content-type':'application/json'
      };
      final response = await http.get(url,headers: headers);

      final data = json.decode(response.body);
      lista = pedido.fromJsonList(data);

      return lista.toList();
      
    } catch (e) {
      print('Error: ${e}');
      return lista;
    }
  }

  Future<List<Pedido>> getByRepartidor(String  id_repartidor,String estado) async{
    List<Pedido> lista = [];
    Pedido pedido = Pedido(direccion: '', hora: null, idCliente: '', idRepartidor: '', productos: []);
    try {
      Uri url = Uri.http(_url, '$_api/ByRepartidor/${id_repartidor}/$estado');
      Map<String,String> headers = {
        'Content-type':'application/json'
      };
      final response = await http.get(url,headers: headers);

      final data = json.decode(response.body);
      lista = pedido.fromJsonList(data);

      return lista.toList();
      
    } catch (e) {
      print('Error: ${e}');
      return lista;
    }
  }

  Future<List<Pedido>> getByCliente(String  id_cliente,String estado) async{
    List<Pedido> lista = [];
    Pedido pedido = Pedido(direccion: '', hora: null, idCliente: '', idRepartidor: '', productos: []);
    try {
      Uri url = Uri.http(_url, '$_api/ByCliente/${id_cliente}/$estado');
      Map<String,String> headers = {
        'Content-type':'application/json'
      };
      final response = await http.get(url,headers: headers);

      final data = json.decode(response.body);
      lista = pedido.fromJsonList(data);

      return lista.toList();
      
    } catch (e) {
      print('Error: ${e}');
      return lista;
    }
  }

}