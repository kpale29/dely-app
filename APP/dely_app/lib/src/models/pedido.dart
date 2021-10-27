import 'dart:convert';

import 'package:dely_app/src/models/producto.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {

  String? id;
  String? idCliente;
  String? idRepartidor;
  String? direccion;
  String? estado;
  int? hora;
  List<Producto> productos =  <Producto>[];
  List<Pedido> pedidos =  <Pedido>[];

    Pedido({
      this.id,
      required this.idCliente,
      required this.idRepartidor,
      required this.direccion,
      this.estado,
      required this.hora,
      required this.productos,
    });


    factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        idCliente: json["id_cliente"],
        idRepartidor: json["id_repartidor"],
        direccion: json["direccion"],
        estado: json["estado"],
        hora: json["hora"] is String ? int.parse(json["hora"]) : json["hora"],
        productos: List<Producto>.from(json["productos"].map((model)=> Producto.fromJson(model))) ?? [],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_cliente": idCliente,
        "id_repartidor": idRepartidor,
        "direccion": direccion,
        "estado": estado,
        "hora": hora,
        'productos': productos,
    };
}
