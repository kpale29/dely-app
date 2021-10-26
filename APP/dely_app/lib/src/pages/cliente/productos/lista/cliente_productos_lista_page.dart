import 'package:dely_app/src/models/categoria.dart';
import 'package:dely_app/src/models/producto.dart';
import 'package:dely_app/src/pages/cliente/productos/lista/cliente_productos_lista_controller.dart';
import 'package:dely_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

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
    return DefaultTabController(
      length: _con.categorias.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170), 
          child: AppBar(
            backgroundColor: Colors.green,
            title: Text('Cliente'),
            actions: [_shoppingBag()],
            flexibleSpace: Column(children: [
              SizedBox(height: 120,),
              _textFieldSearch()
            ],
            ),
            bottom: TabBar(
            isScrollable: true,
            tabs: List<Widget>.generate(_con.categorias.length, (index) {
              return Tab(
                child: Text(_con.categorias[index].nombre),
                );
            })
        ),
          ),
        ),
        drawer: _drawer(),
        
        body:TabBarView(children: _con.categorias.map((Categoria categoria) {
          return FutureBuilder(
            future: _con.getProductos((categoria.id).toString()),
            builder: (context, AsyncSnapshot<List<Producto>> snapshot) {

              if(snapshot.hasData){
                if(snapshot.data!.length > 0){
                  return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7
                ), 
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: ( _ , index){
                  return _cardProducto(snapshot.data![index]);
                });
                }else{
                  return NoDataWidget();
                }
              }else{
                  return NoDataWidget();
              }

              
            }
            );
        }).toList(),
        )
      ),
    );
  }

  Widget _cardProducto( Producto producto) { 
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

    return GestureDetector(
      onTap: (){_con.openBottomSheet(producto);},
      child: Container(
        height:250,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Positioned(
                top: -1.0,
                right: -1.0,
                child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: Colors.green, 
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(20))
                ),
                child: Icon(Icons.add,color: Colors.white)
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  margin: EdgeInsets.only(top: 25),
                  padding: EdgeInsets.all(20),
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child:  Image.network('https://foodish-api.herokuapp.com/images/${comida}/${comida}${rnd}.jpg',fit: BoxFit.cover),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:20),
                  child: Text(producto.nombre,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 15)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:20,),
                child: Text('Q ${producto.precio}',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                ),
              ],)
            ]
          )
        )
      ),
    );
  }

  Widget _textFieldSearch(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(Icons.search, color: Colors.white),
          hintStyle: TextStyle(fontSize: 17,color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white) ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.white) ),
          contentPadding: EdgeInsets.all(15),
        ),
        
      ),
    );
  }

  Widget _shoppingBag(){
    return Stack(
      children:[
      Container(
        margin: EdgeInsets.only(right:15,top:15),
        child: Icon(Icons.shopping_bag_outlined,
        color: Colors.white,
        ),
      ),
      Positioned(
        right:16,
        top:15,
        child: Container( 
          width: 9,
          height: 9,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30))
          )
         ),
        )
      ] 
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