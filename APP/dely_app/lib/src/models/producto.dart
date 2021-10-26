
import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(json.decode(str));

String productoToJson(Producto data) => json.encode(data.toJson());

class Producto {

    String? id;
    late String nombre;
    late String descripcion;
    late double precio;
    late int idCategoria;
    late int? cantidad;

    Producto({
      this.id,
      required this.nombre,
      required  this.descripcion,
      required  this.precio,
      required  this.idCategoria,
        this.cantidad,
    });

    
    List<Producto> fromJsonList( List<dynamic> jsonList) {
    List<Producto> toList = [];
      for (var element in jsonList) {
        Producto categoria =  Producto.fromJson(element);  
        toList.add(categoria);
      }
      return toList;
    }

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        precio:  json['price'] is String ? double.parse(json["precio"]) : isInteger(json["precio"]) ? json["precio"].toDouble() : json["precio"],
        idCategoria: json["id_categoria"] is String ? int.parse(json["id_categoria"]) : json["id_categoria"],
        cantidad: json["cantidad"] 
    );

    static bool isInteger(num value) =>  value is int || value == value.roundToDouble();
    

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "precio": precio,
        "id_categoria": idCategoria,
        "cantidad": cantidad,
    };
}
