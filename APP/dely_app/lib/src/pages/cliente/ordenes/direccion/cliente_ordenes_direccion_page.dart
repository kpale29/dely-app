import 'package:dely_app/src/pages/cliente/ordenes/direccion/cliente_ordenes_direccion_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientesOrdenesDireccionPage extends StatefulWidget {
  ClientesOrdenesDireccionPage({Key? key}) : super(key: key);

  @override
  _ClienteOrdenesDireccionPageState createState() => _ClienteOrdenesDireccionPageState();
}

class _ClienteOrdenesDireccionPageState extends State<ClientesOrdenesDireccionPage> {
  
    ClienteOrdenesDireccionController _con  =  ClienteOrdenesDireccionController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, Refresh);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direccion de entrega"),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Column(children: [
          Divider(
          color: Colors.grey[400],
          endIndent: 30,
          indent: 30,
          ),
        _createOrderButton()
      ],)
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.25),
        child: Column(
          children: [
            Text('Ingrese su direccion de entrega',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
          Container(
                    padding: EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                          controller: _con.direccionController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                          hintText: "Direccion de entrega",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.place, color: Colors.teal),
                          ), 
                          maxLines: 3,
                          maxLength:  250,
                        ),
                  ),
          ],
          )
      )
    );
  }

  Widget _createOrderButton(){
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 275,
      height: 50,
      child: ElevatedButton(
        onPressed: _con.createOrden,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Text('Realizar Pedido',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold))
      )
    );
  }

  void Refresh() {
    setState(() {
      
    });
  }

}