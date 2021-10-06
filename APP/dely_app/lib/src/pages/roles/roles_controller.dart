import 'package:dely_app/src/models/usuario.dart';
import 'package:dely_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class RolesController { 

  late BuildContext context; 
  Usuario? user;
  SharedPref sharedPref =  SharedPref();
  Function? refresh;

  Future init(BuildContext context,Function? refresh) async { 
    this.context = context;
    user = Usuario.fromJson(await sharedPref.read('user'));
    refresh!();
  }

  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context,route, (route)=>false);
  }

  logout(){
    sharedPref.logout(context);
  }



}