import 'package:dely_app/src/pages/register/edit/register_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RegisterEditPage extends StatefulWidget {
  RegisterEditPage({Key? key}) : super(key: key);

  @override
  _RegisterEditPageState createState() => _RegisterEditPageState();
}

class _RegisterEditPageState extends State<RegisterEditPage> {
  RegisterEditController _con = RegisterEditController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context,Refresh);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Colors.green,
      ),
        body: Stack(
      children: [
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20,bottom: 40),
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
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                   _checkBoxList(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: MaterialButton(
                        onPressed: () {
                          _con.actualizar();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text('ACTUALIZAR',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.teal.shade700),
                  ),

                ],
              ),
            ))
      ],
    ));
  }

  Widget _checkBoxList(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          
          Text('Restaurante:'),
          Checkbox(
            activeColor: Colors.green,
            value: _con.restauranteCheck,
            onChanged: (bool? value) {
            _con.restauranteCheck = value!;
            Refresh();
            },
          ),
          Text('Repartidor:'),
          Checkbox(
            activeColor: Colors.green,
            value: _con.repartidorCheck,
            onChanged: (bool? value) {
            _con.repartidorCheck = value!;
            Refresh();
            },
          ), 
        ],
      ),
    );

  }

  void Refresh() {
    setState(() {
    
    });
  }
}