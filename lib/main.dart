import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Text Show

var headerSection = Column(
  children: <Widget>[
    Container(
      child: Text('Program:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
     )
  ]
);


var buttonSection = Column(
   children: <Widget>[
     Row(
        children: <Widget>[
         Text('Test'),
        ]
     )
   ]
);




class MyApp extends StatelessWidget{

  @override

  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Calculate',
      home: Scaffold(
        appBar: AppBar(title: Text('Calculator By Jantapa Binheem 6035512034'),),
        body: ListView(
          children: <Widget>[
            headerSection,
            buttonSection
          ]
        ),
        )
    );
  }
}