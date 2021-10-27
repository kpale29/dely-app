import 'package:dely_app/src/pages/restaurante/ordenes/lista/restaurante_ordenes_lista_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestauranteOrdenesListaPage extends StatefulWidget {
  RestauranteOrdenesListaPage({Key? key}) : super(key: key);

  @override
  _RestauranteOrdenesListaPageState createState() => _RestauranteOrdenesListaPageState();
}

class _RestauranteOrdenesListaPageState extends State<RestauranteOrdenesListaPage> {
  RestauranteOrdenesListaController _con = RestauranteOrdenesListaController();

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
      length: _con.categorias.length,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Restaurante'),
        bottom: TabBar(
            isScrollable: true,
            tabs: List<Widget>.generate(_con.categorias.length, (index) {
              return Tab(
                child: Text(_con.categorias[index]),
                );
            })
        ),
      ),
      drawer: _drawer(),
      body: TabBarView(children: _con.categorias.map((String categoria) {
        return Container();
          // return FutureBuilder(
          //   future: _con.getProductos((categoria.id).toString()),
          //   builder: (context, AsyncSnapshot<List<Producto>> snapshot) {

          //     if(snapshot.hasData){
          //       if(snapshot.data!.length > 0){
          //         return GridView.builder(
          //       padding: EdgeInsets.symmetric(horizontal:10,vertical: 10),
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         childAspectRatio: 0.7
          //       ), 
          //       itemCount: snapshot.data?.length ?? 0,
          //       itemBuilder: ( _ , index){
          //         return _cardProducto(snapshot.data![index]);
          //       });
          //       }else{
          //         return NoDataWidget();
          //       }
          //     }else{
          //         return NoDataWidget();
          //     }

          //   }
          //   );
        }).toList(),
        )
    ));
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
          onTap: _con.goToCategoriasCrear,
          title: Text('Crear Categoria'),
          trailing: Icon(Icons.list_alt,),
        ),
        ListTile(
          onTap: _con.goToProductosCrear,
          title: Text('Crear Producto'),
          trailing: Icon(Icons.local_pizza,),
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