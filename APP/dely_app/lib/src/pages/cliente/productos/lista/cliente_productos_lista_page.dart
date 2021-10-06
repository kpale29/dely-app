import 'package:dely_app/src/pages/cliente/productos/lista/cliente_productos_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class ClienteProductosListaPage extends StatefulWidget {
  ClienteProductosListaPage({Key? key}) : super(key: key);

  @override
  _ClienteProductosListaPageState createState() => _ClienteProductosListaPageState();
}

class _ClienteProductosListaPageState extends State<ClienteProductosListaPage> {
  final ClienteProductosListaController _con =  ClienteProductosListaController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp){
      _con.init(context,Refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cliente'),
      ),
      drawer: _drawer(),
      body: Center(child: ElevatedButton(
        onPressed: (){
            _con.logout();
        },
        child: Text('Cerrar Sesion')
      ),)
    );
  }


  Widget _drawer(){ 
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
        DrawerHeader(
          decoration:BoxDecoration(color: Colors.green),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
            Text('${_con.user?.nombre ?? ''} ${_con.user?.apellido ?? ''}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white, 
              fontWeight: FontWeight.bold
            ),
            maxLines: 1,),
            Text('${_con.user?.correo ?? ''}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontStyle: FontStyle.italic
            ),
            maxLines: 1,),
            Text('${_con.user?.telefono ?? ''}',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontStyle: FontStyle.italic
            ),
            maxLines: 1,),
            SizedBox(height: 10,),
            Icon(Icons.account_circle, color: Colors.white,size: 70),
          ])
        ),
        ListTile(
          title: Text('Editar perfil'),
          trailing: Icon(Icons.edit_outlined,),
        ),
        ListTile(
          title: Text('Mis Pedidos'),
          trailing: Icon(Icons.shopping_cart_outlined,),
        ),
        
        ListTile(
          onTap: _con.goToPage,
          title: Text('Seleccionar rol'),
          trailing: Icon(Icons.person_outline,),
        ) ,
        ListTile(
          onTap: _con.logout,
          title: Text('Cerrar sesion'),
          trailing: Icon(Icons.power_settings_new,),
        )
      ],
      )
    );
  }
  
  void Refresh()=> setState(() {});

  
}