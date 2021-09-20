import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/provider/usuario_provider.dart';
import 'package:flutter/material.dart';

class RegisterController{

  BuildContext? context;
  TextEditingController emailController =  TextEditingController();
  TextEditingController nameController =  TextEditingController();
  TextEditingController lastnameController =  TextEditingController();
  TextEditingController phoneController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController confirmPasswordController =  TextEditingController();
  
  UsuarioProvider userProvider = UsuarioProvider();

  Future? init(BuildContext context){
    this.context = context;
    userProvider.init(context);
  }

  void registrar()async {
    String email = emailController.text.trim(); 
    String name = nameController.text; 
    String lastname = lastnameController.text;  
    String phone = phoneController.text.trim(); 
    String password = passwordController.text.trim(); 
    String confirmPassword = confirmPasswordController.text.trim(); 

    Usuario usuario = Usuario(
      correo : email, 
      nombre: name, 
      apellido: lastname,  
      telefono: phone, 
      password :password );

    ResponseApi? responseApi = await userProvider.create(usuario);

    if(responseApi != null) {
    print('Respuesta ${responseApi.toJson()}');
    }


  }

}