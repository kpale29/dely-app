import 'dart:convert';

import 'package:dely_app/src/api/environment.dart';
import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UsuarioProvider { 

  final String _url = Environment.API_DELIVERY; 
  final String _api = '/api/usuarios';

  late BuildContext context;

  Future? init(BuildContext context){

    this.context = context;

  } 

  Future<ResponseApi?> create(Usuario usuario) async { 
    
    try{
    Uri url = Uri.http(_url, '$_api/crear');
    String bodyParams = json.encode(usuario);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.post(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al crear usuario: $e' );
      return null;
    }
    
  }

  Future<ResponseApi?> updateConPassword(Usuario usuario,bool restaurante,bool repartidor) async { 
    
    try{
    Uri url = Uri.http(_url, '$_api/updateConPassword/${restaurante}/${repartidor}');
    String bodyParams = json.encode(usuario);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.put(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al actualizar usuario: $e' );
      return null;
    }
  }

  Future<ResponseApi?> updateSinPassword(Usuario usuario,bool restaurante,bool repartidor) async { 
    
    try{
    Uri url = Uri.http(_url, '$_api/updateSinPassword/${restaurante}/${repartidor}');
    String bodyParams = json.encode(usuario);
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.put(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al actualizar usuario: $e' );
      return null;
    }
  }

  Future<List<Usuario>> getRepartidores() async { 
    try{
      Uri url = Uri.http(_url, '$_api/getRepartidores');
      Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final res = await http.get(url,headers: headers);

    final data = json.decode(res.body);
    Usuario usuario = new Usuario(apellido: '', correo: '', nombre: '', telefono: '');
    List<Usuario> usuarios = usuario.fromJsonList(data); 
    return usuarios;
    }catch(e){
      print('Error al recibir repartidores: $e' );
      return [];
    }
  }

  Future<ResponseApi?> login(String corre, String password) async{ 
    try{
    Uri url = Uri.http(_url, '$_api/login');
    String bodyParams = json.encode({
      'correo':corre, 
      'password':password
    });
    Map<String,String> headers = {
      'Content-type':'application/json'
    };
    final response = await http.post(url,headers: headers, body: bodyParams);
    
    final data = json.decode(response.body);

    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
    }catch(e){
      print('Error al iniciar sesion: $e' );
      return null;
    }
  }

}