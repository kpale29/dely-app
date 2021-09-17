import 'package:dely_app/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final LoginController _con = LoginController();
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
    return  Scaffold(
      // appBar: AppBar(
      //   title: const Text('Dely-APP'),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body:Stack(
        children:[ 
          Positioned(
            top: -20,
            left: -20,
            child: _circleLogin()),
          Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 170),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Image.asset('assets/img/dely-login-img.png',
              width: 200,
              height: 200,   
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40,vertical:20),
                decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(30)),
                child:  TextField(
                  controller: _con.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:const InputDecoration(
                  hintText: 'Correo Electronico',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.mail, color: Colors.teal ),
                )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(30)),
                child:  TextField(
                  controller: _con.passwordController,
                  obscureText: true,
                  decoration:const InputDecoration(
                  hintText: 'Contraseña',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.lock,color: Colors.teal),
                )),
              ),
              Container(
                width: double.infinity,
                margin:  const EdgeInsets.symmetric(horizontal: 50,vertical: 30),
                child: MaterialButton(
                  onPressed: (){_con.login();},
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                  child: const Text('INGRESAR',style: TextStyle(color: Colors.white)),color: Colors.teal.shade700),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Text('¿No tienes cuenta?',
                style: TextStyle(color: Colors.teal),),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: 
                  _con.getToRegisterPage
                  ,
                  child: const Text('Registrate',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),),
                ),
              ],)
            ],
                  ),
          )
        ),
      
        ])
    );
  }
}

Widget _circleLogin(){
  return Container(
  width: 200,
  height: 200,
  child: const Center(child: Text('LOGIN',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24))), 
  decoration: const BoxDecoration(
  borderRadius:BorderRadius.all(Radius.circular(100)),
  color: Colors.green,
  ),
  );
}