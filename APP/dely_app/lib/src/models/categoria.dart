import 'dart:convert';
import 'package:flutter/material.dart';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
    String? id; 
    String nombre;
    String descripcion;

    Categoria({
        this.id,
        required this.nombre,
        required this.descripcion,
    });

    List<Categoria> fromJsonList( List<dynamic> jsonList) {
    List<Categoria> toList = [];
      for (var element in jsonList) {
        Categoria categoria =  Categoria.fromJson(element);  
        toList.add(categoria);
      }
      return toList;
    }


    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"].toString(),
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id" : id,
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
