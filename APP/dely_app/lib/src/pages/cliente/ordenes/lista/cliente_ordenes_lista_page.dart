import 'package:dely_app/src/models/pedido.dart';
import 'package:dely_app/src/pages/cliente/ordenes/lista/cliente_ordenes_lista_controller.dart';
import 'package:dely_app/src/pages/delivery/ordenes/lista/delivery_ordenes_lista_controller.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/lista/restaurante_ordenes_lista_controller.dart';
import 'package:dely_app/src/widgets/no_data_widget.dart';
import 'package:dely_app/src/widgets/no_data_widget_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClienteOrdenesListaPage extends StatefulWidget {
  ClienteOrdenesListaPage({Key? key}) : super(key: key);

  @override
  _ClienteOrdenesListaPageState createState() => _ClienteOrdenesListaPageState();
}

class _ClienteOrdenesListaPageState extends State<ClienteOrdenesListaPage> {
  ClienteOrdenesListaController _con = ClienteOrdenesListaController();

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
        title: Text('Mis Pedidos'),
        bottom: TabBar(
            isScrollable: true,
            tabs: List<Widget>.generate(_con.estado.length, (index) {
              return Tab(
                child: Text(_con.estado[index]),
                );
            })
        ),
      ),
      // drawer: _drawer(),
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
                      child: pedido.repartidor != null ? Text('Repartidor: ${pedido.repartidor!.nombre ?? ''} ${pedido.repartidor!.apellido ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      ) 
                      :         
                        Text('Repartidor: pendientes',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
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

  
  void Refresh()=> setState(() {});

}