import 'package:dely_app/src/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _con = RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(top: -20, left: -20, child: _circleRegistro()),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 190),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: const Icon(Icons.person, size: 80)),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Correo Electronico",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.mail, color: Colors.teal),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.nameController,
                        decoration: const InputDecoration(
                          hintText: 'Nombre',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.person, color: Colors.teal),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.lastnameController,
                        decoration: const InputDecoration(
                          hintText: 'Apellido',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.teal),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Telefono',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.phone, color: Colors.teal),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Contraseña',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.lock, color: Colors.teal),
                        )),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextField(
                        controller: _con.confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Confirmar Contraseña',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          prefixIcon: Icon(Icons.lock_open_outlined,
                              color: Colors.teal),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: MaterialButton(
                        onPressed: () {
                          _con.registrar();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text('REGISTRARSE',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.teal.shade700),
                  ),
                ],
              ),
            ))
      ],
    ));
  }
}

Widget _circleRegistro() {
  return Container(
    width: 200,
    height: 200,
    child: const Center(
        child: Text('REGISTRO',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22))),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      color: Colors.green,
    ),
  );
}
