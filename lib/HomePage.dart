//ERROR SDK IS BELOW 26 - 04/11 - solved
//TO DO maintain navigation bar while routing to another page of home page
//another route for page 1 og home page for displaying painting sample pictures.


import 'package:flutter/material.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:tflite_flutter/tflite_flutter.dart'

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => Home();
}

class Home extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,//Color.fromRGBO(245, 245, 219, 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Center(
            child: Text('AgrpediMolipet'),
          ),
        ),
      ),
    );
  }
}