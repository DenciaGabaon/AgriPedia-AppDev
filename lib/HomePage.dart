//ERROR SDK IS BELOW 26 - 04/11 - solved
//TO DO maintain navigation bar while routing to another page of home page
//another route for page 1 og home page for displaying painting sample pictures.


import 'package:agripedia/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/weather.dart';

import 'package:agripedia/AddCrop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:logger/logger.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:agripedia/main.dart';

//import 'package:permission_handler/permission_handler.dart';
//import 'package:tflite_flutter/tflite_flutter.dart'

// Lahat ng values na nagbabago ipapasok sa function, like text.
// Pwedeng naka default ang container, and then yung laman is naka function.

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => Home();
}

class CropData {
  final String name;
  final String status;
  final String condition;

  CropData({required this.name, required this.status, required this.condition});
}


class Home extends State<MyHomePage> {
  // weather
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initStateWeather(){
    super.initState();
    _wf.currentWeatherByCityName("Philadelphia").then((w){
      setState(() {
        _weather = w;
      });
    });
  }

  List<CropData> crops = [
    CropData(name: "tomato1", status: "online", condition: "good"),
    CropData(name: "tomato2", status: "offline", condition: "bad"),
    CropData(name: "sili1", status: "online", condition: "good"),
    CropData(name: "sili2", status: "offline", condition: "bad")
    // Add more crops as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: Column(
          children: [
            cropSummary(),
            const SizedBox(height: 15),
            taskList(),
            const SizedBox(height: 15),
            weatherUI(),
            const SizedBox(height: 15),
            addCrop(),
          ],
        )
    );
  }

  Widget cropSummary() {
    if (crops.isEmpty) {
      return Center(
        child: Container(
          width: 500,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'No Crop Found,\nPlease Add a Crop First.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: crops.map((crop) {
          return getCrop(crop);
        }).toList(),
      ),
    );
  }

  Widget getCrop(CropData crop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 3, // Blur radius
            offset: const Offset(0, 3), // Offset in the x, y direction
          ),
        ],
      ),
      width: 130,
      height: 130,// Adjust width as needed
      margin: const EdgeInsets.all(10.0), // Adjust margin as needed
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(3.0)),
          Image.asset('assets/tomatoes.png'),
          Text(
            crop.name,
            style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text('Status: ${crop.status}'),
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 3, // Blur radius
                  offset: const Offset(0, 3), // Offset in the x, y direction
                ),
              ],
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              crop.condition,
              style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget taskList(){
    if (crops.isEmpty) {
      return Center(
        child: Container(
          width: 450,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'Tasks Unavailable, Add A Crop First',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 400,
      height: 220,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: crops.map((crop)
          {
            return Column(
              children: [
                Padding(padding: EdgeInsets.all(5.0)),
                getTask(crop),
              ],
            );
            return getTask(crop);
          }).toList(),
        ),
      ),
    );
  }

  Widget getTask(CropData crop){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 350,
      height: 70,
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(5.0)),
          Text(
            crop.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget weatherUI(){
    if (_weather == null){
      return Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 400,
        height: 180,
        child: const Row(
          children: [
            Text('weahter is unavailable'),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0,3),
          ),
        ],
      ),
      width: 400,
      height: 220,
      child: Column(
        children: [
          _locationHeader(),
        ],
      ),
    );
  }

  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "not available",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget addCrop(){
    return SizedBox(
      width: 180,
      height: 50,
      child:ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCrop()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(0, 105, 46, 1),
        ),
        child: const Text('Add Crop',
            style: TextStyle(
                color: Colors.white,//Color.fromRGBO(0, 0, 0, 1),
                fontSize: 14,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal
            )),
      ),
    );
  }
}

