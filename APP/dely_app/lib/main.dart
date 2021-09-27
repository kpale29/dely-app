import 'package:dely_app/src/pages/cliente/productos/lista/cliente_productos_lista_page.dart';
import 'package:dely_app/src/pages/delivery/ordenes/lista/delivery_ordenes_lista_page.dart';
import 'package:dely_app/src/pages/login/login_page.dart';
import 'package:dely_app/src/pages/register/register_page.dart';
import 'package:dely_app/src/pages/restaurante/ordenes/lista/restaurante_ordenes_lista_page.dart';
import 'package:dely_app/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dely-APP',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register' : (BuildContext context) => const RegisterPage(),
        'clientes/productos/lista' : (BuildContext context) => ClienteProductosListaPage(),
        'restaurante/ordenes/lista' : (BuildContext context) => RestauranteOrdenesListaPage(),
        'delivery/ordenes/lista' : (BuildContext context) => DeliveryOrdenesListaPage(),
        'roles' : (BuildContext context) => RolesPage(),
      },
      theme: ThemeData(primaryColor: Colors.teal.shade700),
    );
  }
}