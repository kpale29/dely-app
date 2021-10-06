import 'dart:convert';
import 'package:flutter/material.dart';

Categoria categoriaFromJson(String str) => Categoria.fromJson(json.decode(str));

String categoriaToJson(Categoria data) => json.encode(data.toJson());

class Categoria {
    String nombre;
    String descripcion;
    Categoria({
        required this.nombre,
        required this.descripcion,
    });


    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
