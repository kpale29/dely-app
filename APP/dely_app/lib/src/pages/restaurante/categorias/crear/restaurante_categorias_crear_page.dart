import 'package:dely_app/src/pages/restaurante/categorias/crear/restaurante_categorias_crear_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestauranteCategoriasCrearPage extends StatefulWidget {
  @override
  _RestauranteCategoriasCrearPageState createState() => _RestauranteCategoriasCrearPageState();
}

class _RestauranteCategoriasCrearPageState extends State<RestauranteCategoriasCrearPage> {
  
  RestauranteCategoriasCrearController _con = RestauranteCategoriasCrearController();
  
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
        title: Text("Crear Categoria"),
        backgroundColor: Colors.green, 
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 190),
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
                          hintText: "Nombre de la categoria",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.list_alt, color: Colors.teal),
                        )
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
                  width: double.infinity,
                  margin:  const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                  child: MaterialButton(
                  onPressed: _con.crearCategoria,
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

  void refresh() {
    setState(() {
    });
  }
}
