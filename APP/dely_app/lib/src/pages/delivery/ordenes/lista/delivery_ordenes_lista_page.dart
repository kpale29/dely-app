import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/pages/delivery/ordenes/lista/delivery_ordenes_lista_controller.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/lista/restaurante_ordenes_lista_controller.dart';
import 'package:dely_app/src/widgets/no_data_widget.dart';
import 'package:dely_app/src/widgets/no_data_widget_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DeliveryOrdenesListaPage extends StatefulWidget {
  DeliveryOrdenesListaPage({Key? key}) : super(key: key);

  @override
  _DeliveryOrdenesListaPageState createState() => _DeliveryOrdenesListaPageState();
}

class _DeliveryOrdenesListaPageState extends State<DeliveryOrdenesListaPage> {
  DeliveryOrdenesListaController _con = DeliveryOrdenesListaController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context,Refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.estado.length,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Delivery'),
        bottom: TabBar(
            isScrollable: true,
            tabs: List<Widget>.generate(_con.estado.length, (index) {
              return Tab(
                child: Text(_con.estado[index]),
                );
            })
        ),
      ),
      drawer: _drawer(),
      body: TabBarView(children: _con.estado.map((String estado) {
        // return _cardPedido(null);
          return FutureBuilder(
            future: _con.getPedidos((estado).toString()),
            builder: (context, AsyncSnapshot<List<Pedido>> snapshot) {

              if(snapshot.hasData){
                if(snapshot.data!.length > 0){
                  return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: ( _ , index){
                  return _cardPedido(snapshot.data![index]);
                });
                }else{
                  return NoDataWidgetPedidos();
                }
              }else{
                  return NoDataWidgetPedidos();
              }

            }
            );
        }).toList(),
        )
    ));
  }
  
  Widget _cardPedido(Pedido? pedido){
    return GestureDetector(
      onTap:  (){_con.openBottomSheet(pedido!);},
      child: Container(
        height: 155,
        margin: EdgeInsets.symmetric(horizontal:20,vertical:5),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: 30, 
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(15), 
                      topRight: Radius.circular(15)
                    )
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment:  Alignment.center,
                    child: Text('Pedido #${pedido!.id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      ),)),
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20),
                child: Column(
                  children: [
                    Container(
                      alignment:  Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical:5),
                      child: Text('Pedido 2015:05:23',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Container(
                      alignment:  Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical:5),
                      child: Text('Cliente: ${pedido.cliente!.nombre ?? ''} ${pedido.cliente!.apellido ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment:  Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical:5),
                      child: Text('Entrega en: ${pedido.direccion}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      ),
                    ),
    
                  ],
                ),
              )
            ]
          )
        ),
      ),
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
          onTap: _con.goToPerfil,
          title: Text('Editar perfil'),
          trailing: Icon(Icons.edit_outlined,),
        ),
        ListTile(
          onTap: _con.goToPage,
          title: Text('Seleccionar rol'),
          trailing: Icon(Icons.person_outline,),
        ),
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