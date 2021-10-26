import 'package:flutter/material.dart';
class NoDataWidgetBag extends StatelessWidget {
  const NoDataWidgetBag({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 130),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.shopping_basket, color:Colors.green, size:80),
            SizedBox(height:40),
            Text('No hay productos en tu bolsa',style:TextStyle(fontSize: 20))
          ],
        ),
      ) 
    );
  }
}