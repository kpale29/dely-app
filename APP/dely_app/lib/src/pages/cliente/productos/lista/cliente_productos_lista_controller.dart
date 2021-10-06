import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClienteProductosListaController {
  Usuario? user; 
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  Function? refresh; 

  Future? init(BuildContext? context,Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = Usuario.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  logout(){
    _sharedPref.logout(context!);
  }

  void goToPage(){
    if(user != null){
      if(user!.roles != null){
        if(user!.roles!.length > 1){
          Navigator.pushNamedAndRemoveUntil(context!,'roles',(route) => false);
      }else{
          Navigator.pushNamedAndRemoveUntil(context!,user!.roles![0].route,(route) => false);
      }
      }
    }
  }

}