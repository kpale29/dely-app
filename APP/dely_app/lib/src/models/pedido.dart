import 'dart:convert';

import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/models/usuario.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {

  String? id;
  String? idCliente;
  String? idRepartidor;
  String? direccion;
  String? estado;
  int? hora;
  List<Producto> productos = [];
  List<Pedido> pedidos =  <Pedido>[];
  Usuario? cliente;
  Usuario? repartidor;

    Pedido({
      this.id,
      required this.idCliente,
      required this.idRepartidor,
      required this.direccion,
      this.estado,
      required this.hora,
      required this.productos,
      this.repartidor,
      this.cliente
    });


    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        idCliente: json["id_cliente"] is int ? json["id_cliente"].toString() : json["id_cliente"],
        idRepartidor: json["id_repartidor"]  is int ? json["id_repartidor"].toString() : json["id_repartidor"],
        direccion: json["direccion"],
        estado: json["estado"],
        hora: json["hora"] is String ? int.parse(json["hora"]) : json["hora"],
        productos:  json["productos"] != null ?
        json["productos"] is String ?  printFromJson(json["productos"]) 
        // : []
        //   json["productos"] is String ?  List<Producto>.from(json["productos"].map((model)=> productoFromJson(model))) 
          : List<Producto>.from(json["productos"].map((model)=> Producto.fromJson(model))) ?? [] 
        : [],
        cliente: json['cliente'] is String ? usuarioFromJson(json['cliente']) : Usuario.fromJson(json['cliente']?? {}),
        repartidor: json['repartidor'] is String ? usuarioFromJson(json['repartidor']) : Usuario.fromJson(json['repartidor']?? {})  
    );

    List<Pedido> fromJsonList( List<dynamic> jsonList) {
    List<Pedido> toList = [];
      for (var element in jsonList) {
        Pedido categoria =  Pedido.fromJson(element);  
        toList.add(categoria);
      }
      return toList;
    }


    Map<String, dynamic> toJson() => {
        "id": id,
        "id_cliente": idCliente,
        "id_repartidor": idRepartidor,
        "direccion": direccion,
        "estado": estado,
        "hora": hora,
        'productos': productos,
        'cliente': cliente,
        'repartidor': repartidor,
    };
}
