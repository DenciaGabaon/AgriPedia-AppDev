//ERROR SDK IS BELOW 26 - 04/11 - solved
//TO DO maintain navigation bar while routing to another page of home page
//another route for page 1 og home page for displaying painting sample pictures.


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';



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
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromRGBO(245, 245, 219, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AgriPedia'),
            SvgPicture.asset(
              'assets/HomeNav.svg',
              height: 30,
            ),
            const SizedBox(width:8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        /*title: const Text('AgriPedia'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,*/
      ),
      /*body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Align(
            alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20.0),
            ),
            width: 500,
            height: 165,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: 125,
                  height: 150,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              ],
            )
            ),
          ),
        ),
      ),*/
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        children: [
          const SizedBox(width: 12),
          buildCard(),
          const SizedBox(width: 12),
          buildCard(),
          const SizedBox(width: 12),
          buildCard(),
          const SizedBox(width: 12),
          buildCard(),
          const SizedBox(width: 12)
        ],
      ),
      ),
    );
  }
  Widget buildCard() => Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20.0)
    ),
    width: 125,
    height: 125,
    child: Column(
      children: [
        const Padding(padding: EdgeInsets.all(3.0)),
        Image.asset('assets/tomatoes.png'),
        const Text(
          'Tomato Tornado',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Status: Online'
        ),
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20.0)
          ),
        ),
      ],
    )
  );
}