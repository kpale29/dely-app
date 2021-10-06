import 'package:dely_app/src/models/rol.dart';
import 'package:dely_app/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class RolesPage extends StatefulWidget {
  RolesPage({Key? key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {

  RolesController _con = RolesController();

  @override
  void initState() {

    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir un rol'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _con.logout, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: 
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
          child: ListView(
            children: _con.user != null ? _con.user!.roles!.map((Rol rol) {
              return _cardRol(rol);
            }).toList() : [],
          ),
        )
      ,
    );
  }

  Widget _cardRol(Rol rol){ 
    Icon icono = Icon(Icons.help);
    switch(rol.nombre){
      case "CLIENTE" :
        icono = Icon(Icons.account_circle,size:150);
      break;
      case 'RESTAURANTE':
        icono = Icon(Icons.storefront_rounded,size:150);
      break;
      case 'REPARTIDOR':
        icono = Icon(Icons.delivery_dining_sharp,size:150);
      break;
    }
      return GestureDetector(
        onTap: (){_con.goToPage(rol.route);},
        child: Column(
          children: [
            Container(
              child: icono
            ),
            Text(rol.nombre!,style: const TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      );
    }


  void refresh() => setState(() {});

}