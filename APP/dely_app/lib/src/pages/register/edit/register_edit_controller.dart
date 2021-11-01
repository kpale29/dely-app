import 'package:dely_app/src/models/response_api.dart';
import 'package:dely_app/src/models/rol.dart';
import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/provider/usuario_provider.dart';
import 'package:dely_app/src/utils/my_snackbar.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class RegisterEditController{
  Usuario? user; 
  late BuildContext context;
  SharedPref _sharedPref = SharedPref();
  Function? refresh; 

  TextEditingController nameController =  TextEditingController();
  TextEditingController lastnameController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  TextEditingController confirmPasswordController =  TextEditingController();
  bool restauranteCheck = false;
  bool repartidorCheck = false;


  UsuarioProvider userProvider = UsuarioProvider();

Future? init(BuildContext? context,Function refresh) async {
    this.context = context!;
    this.refresh = refresh;
    user = Usuario.fromJson(await _sharedPref.read('user'));
    getDatos();
    refresh();
  }

  void actualizar()async {
    String name = nameController!.text; 
    String lastname = lastnameController!.text;  
    String password = passwordController!.text.trim(); 
    String confirmPassword = confirmPasswordController!.text.trim(); 

    Usuario usuario = Usuario(
      id: user!.id,
      correo : user!.correo, 
      telefono: user!.telefono, 
      nombre: name, 
      apellido: lastname,  
      password :password);
    
    if( name.isEmpty || lastname.isEmpty ){
      MySnackbar.show(context,'Ingresar todos los campos');
      return;
    }else{
        if(password.isEmpty){
          //se enviara sin contraseña'
          if(confirmPassword != password ){
          MySnackbar.show(context,'Las contraseñas no coinciden');
          return;
          }
          
          ResponseApi? responseApi = await userProvider.updateSinPassword(usuario,restauranteCheck,repartidorCheck);
          if(responseApi != null){
            MySnackbar.show(context,responseApi!.message);
            if(responseApi.succes) { 
              // Future.delayed(Duration(seconds: 3), (){
              // Navigator.pushReplacementNamed(context, 'clientes/productos/lista');  
              // });
            } 
          }
          
          return;
        }else{
          if(confirmPassword != password ){
          MySnackbar.show(context,'Las contraseñas no coinciden');
          return;
          }
          if(password.length < 6) { 
          MySnackbar.show(context,'La contraseña debe tener al menos 6 caracteres');
          return;
          }
          ResponseApi? responseApi = await userProvider.updateConPassword(usuario,restauranteCheck,repartidorCheck);
          if(responseApi != null){
            MySnackbar.show(context,responseApi!.message);
            if(responseApi.succes) { 
              // Future.delayed(Duration(seconds: 3), (){
              // Navigator.pushReplacementNamed(context, 'clientes/productos/lista');  
              // });
            } 
          }

        }
    }


  }

  void getDatos() {
    if(user != null){
      print(user);
      nameController.text = user!.nombre.toString();
      lastnameController.text = user!.apellido .toString();
      if(user!.roles != null){
        for(Rol rol in user!.roles!){
        print(rol.id);
        switch (rol.id) {
          case "2":
            restauranteCheck = true;
            break;
          case "3":
            repartidorCheck = true;
            break;  
          default:
        }
      }
      }
        }     
  }

}