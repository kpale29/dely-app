import 'package:flutter/material.dart';
class NoDataWidgetPedidos extends StatelessWidget {
  const NoDataWidgetPedidos({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 130),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.mood_bad, color:Colors.green, size:80),
            SizedBox(height:40),
            Text('No hay pedidos por aqui',style:TextStyle(fontSize: 20))
          ],
        ),
      ) 
    );
  }
}