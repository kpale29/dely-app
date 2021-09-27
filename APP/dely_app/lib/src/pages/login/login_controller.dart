import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/provider/usuario_provider.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginController{
  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsuarioProvider usuariosProvider = UsuarioProvider();
  final SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context) async { 
    this.context = context;
    await usuariosProvider.init(context);

    Usuario usuario = Usuario.fromJson(await _sharedPref.read('user') ?? {});
    // print('Usuario: ${usuario.toJson()}');

    if(usuario.tokenSesion != null){
      if(usuario.roles!.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);

      }else{
        Navigator.pushNamedAndRemoveUntil(context, usuario.roles![0].route, (route) => false);
      }
    }
  }

  void getToRegisterPage(){ 
    Navigator.pushNamed(context!, 'register');

  }

  void login() async { 
    String email = emailController.text.trim(); 
    String password = passwordController.text.trim(); 
    ResponseApi? responseApi = await usuariosProvider.login(email, password);
    
    if(responseApi != null){
    if(responseApi.succes){
      Usuario user = Usuario.fromJson(responseApi.data!);
      _sharedPref.save('user',user.toJson());
      if(user.roles!.length > 1){
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);

      }else{
        Navigator.pushNamedAndRemoveUntil(context!, user.roles![0].route, (route) => false);
      }

    }else{ 
    MySnackbar.show(context!, responseApi.message);
      
    }
    MySnackbar.show(context!, responseApi.message);
    }

    
  }

  }