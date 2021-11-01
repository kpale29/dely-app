import 'dart:convert';

import 'package:dely_app/src/models/rol.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String? id;
    String? nombre;
    String? apellido;
    String? correo;
    String? telefono;
    String? password;
    String? tokenSesion;
    String? imagen;
    List<Rol>? roles = [];

    Usuario({
      this.id,
      required this.nombre,
      required this.apellido,
      required this.correo,
      required this.telefono,
      this.password,
      this.tokenSesion,
      this.imagen,
      this.roles,
    });

    List<Usuario> fromJsonList( List<dynamic> jsonList) {
    List<Usuario> toList = [];
      for (var element in jsonList) {
        Usuario usuario =  Usuario.fromJson(element);  
        toList.add(usuario);
      }
      return toList;
    }


    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"] is int ? json["id"].toString() : json["id"] ,
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        telefono: json["telefono"],
        password: json["password"],
        tokenSesion: json["token_sesion"],
        imagen: json["imagen"],
        roles: json["roles"] == null ? [] : List<Rol>.from(json['roles'].map((model)=> Rol.fromJson(model))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "telefono": telefono,
        "password": password,
        "token_sesion": tokenSesion,
        "imagen": imagen,        
        "roles": roles,        
    };
}
