import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String? id;
    String nombre;
    String apellido;
    String correo;
    String telefono;
    String password;
    String? tokenSesion;
    String? imagen;

    Usuario({
      this.id,
      required this.nombre,
      required this.apellido,
      required this.correo,
      required this.telefono,
      required this.password,
      this.tokenSesion,
      this.imagen,
    });


    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        telefono: json["telefono"],
        password: json["password"],
        tokenSesion: json["token_sesion"],
        imagen: json["imagen"],
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
    };
}
