import 'package:flutter/material.dart';
class NoDataWidget extends StatelessWidget {
  const NoDataWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 130),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.mood_bad, color:Colors.green, size:80),
            SizedBox(height:40),
            Text('No hay productos en esta categoria',style:TextStyle(fontSize: 20))
          ],
        ),
      ) 
    );
  }
}