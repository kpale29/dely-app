import 'package:dely_app/src/pages/login/login_page.dart';
import 'package:dely_app/src/pages/register/register_page.dart';
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
      },
      theme: ThemeData(primaryColor: Colors.teal.shade700),
    );
  }
}