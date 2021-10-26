import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/pages/restaurante/productos/crear/restaurante_producto_crear_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';


class RestauranteProductosCrearPage extends StatefulWidget {
  @override
  _RestauranteProductosCrearPageState createState() => _RestauranteProductosCrearPageState();
}

class _RestauranteProductosCrearPageState extends State<RestauranteProductosCrearPage> {
  
  RestauranteProductosCrearController _con = RestauranteProductosCrearController();
  
  @override
  void initState() {
  super.initState();
  SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
    _con.init(context, refresh);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
        backgroundColor: Colors.green, 
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.nombreController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Nombre del producto",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.list_alt, color: Colors.teal),
                        ),
                        maxLength: 100,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                          controller: _con.descripcionController,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                          hintText: "Descripcion",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.description, color: Colors.teal),
                          ), 
                          maxLines: 3,
                          maxLength:  250,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                          controller: _con.precioController,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                          hintText: "precio",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.monetization_on, color: Colors.teal),
                          ), 
                        ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                      _cardImage(),
                      _cardImage(),
                      _cardImage(),
                    ],),
                  ),
                  _dropDownCategorias(_con.categorias),
                  Container(
                  width: double.infinity,
                  margin:  const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                  child: MaterialButton(
                  onPressed: _con.crearProducto,
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                  child: const Text('CREAR',style: TextStyle(color: Colors.white)),color: Colors.teal.shade700),
                  ),

                ],
              )
            )
            )
        ],
      )
    );
  }

  Widget _cardImage(){
    int rnd = 1 + Random().nextInt(10);
    int food = 1 + Random().nextInt(10);

    String comida = 'burger';
    switch (food){
      case 1: 
        comida = 'biryani';
      break; 
      case 2: 
        comida = 'burger';
      break; 
      case 3: 
        comida = 'butter-chicken';
      break; 
      case 4: 
        comida = 'dessert';
      break; 
      case 5: 
        comida = 'dosa';
      break; 
      case 6: 
        comida = 'idly';
      break; 
      case 7: 
        comida = 'pasta';
      break; 
      case 8: 
        comida = 'pizza';
      break; 
      case 9: 
        comida = 'rice';
      break; 
      case 10: 
        comida = 'samosa';
      break; 
    }    
    return Card(
      elevation: 3.0,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.26,
        child: Image.network('https://foodish-api.herokuapp.com/images/${comida}/${comida}${rnd}.jpg',fit: BoxFit.cover),
      ),
    );
  }

  Widget _dropDownCategorias(List<Categoria> categorias){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 33),
        child: Material(
          elevation: 2.0,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  Icon(Icons.search, color: Colors.green),
                  SizedBox(width: 15),
                  Text('Categorias',style: TextStyle(
                    color: Colors.grey, 
                    fontSize:16)
                    )
                ]
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down_circle,color: Colors.green)),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text('Seleccionar categorias',
                    style: TextStyle(color: Colors.green,fontSize: 16)),
                  items: _dropDownItems(categorias),
                  value: _con.idCategoria == '' ? null : _con.idCategoria,
                  onChanged: (option){
                    setState(() {
                      print(option);
                      _con.idCategoria = option.toString();
                    });
                  },
                  ),
              )
          ],)
          )
          ,
        ),
      );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Categoria> categorias) {
    List<DropdownMenuItem<String>> list = [];

    categorias.forEach((element) {
      list.add(DropdownMenuItem(
        child: Text(element.nombre),
        value: element.id,
        ));
    });
    return list;
  }

  void refresh() {
    setState(() {
    });
  }
}
