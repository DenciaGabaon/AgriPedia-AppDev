// import 'dart:ffi';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:logger/logger.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:ui' as ui;
//
// class FuzzyLogic extends StatefulWidget{
//   String? id;
//   FuzzyLogic({Key? key, required this.id}) : super(key: key);
//
//   @override
//   State<FuzzyLogic> createState() => FuzzyLogicState();
// }
//
// class FuzzyLogicState extends State<FuzzyLogic>{
//   final Logger logger = Logger();
//   late String finalID = '';
//   String test = "nodemCU-board-tomato";
//   late DatabaseReference _database;
//
//   late String _liveData = '';
//
//   late List<String> dataFactors = [];
//
//   late String _temperature = '';
//   late String _temperature_raw = '';
//   late String _humidity_raw = '';
//   late String _humidity = '';
//   late String _soil_raw = '';
//   late String _soil = '';
//   late String _lightIntensity_raw = '';
//   late String _lightIntensity = '';
//
//   @override
//   void initState(){
//     if (widget.id != null){
//       logger.d("fuzzy ID: ${widget.id}");
//       setState(() {
//         finalID = widget.id!;
//       });
//
//       if (finalID.isNotEmpty){
//         logger.d("fuzzy Final ID: $finalID");
//
//         _database = FirebaseDatabase.instance.ref(finalID);
//       }
//       else{
//         logger.d("FINAL ID IS NULL");
//       }
//     }
//   }
//
//   Future<void> RetrieveFuzzyData(String liveData) async{
//
//     setState(() {
//       dataFactors = liveData.split(",");
//       _temperature_raw = dataFactors[0];
//       if (_temperature_raw.length >= 30){
//         _temperature = _temperature_raw.substring(29).replaceAll(RegExp('}'), '');
//       }
//       else{
//         logger.d("fuzzyTemperature: $_temperature_raw");
//       }
//
//       _humidity_raw = dataFactors[2];
//       if (_humidity_raw.length >= 34) {
//         _humidity = _humidity_raw.substring(33).replaceAll(RegExp('}'), '');
//         //print(substring); // Outputs: 'ing'
//       } else {
//         logger.d("fuzzyHumidity: $_humidity_raw");
//       }
//
//       _lightIntensity_raw = dataFactors[1];
//       if (_lightIntensity_raw.length >= 41) {
//         _lightIntensity =  double.parse(_lightIntensity_raw.substring(40).replaceAll(RegExp('}'), '')).toStringAsFixed(1);;
//         //print(substring); // Outputs: 'ing'
//       } else {
//         logger.d("fuzzyLightIntensity: $_lightIntensity_raw");
//       }
//
//       _soil_raw = dataFactors[3];
//       if (_soil_raw.length >= 30) {
//         _soil = _soil_raw.substring(29).replaceAll(RegExp('}'), '');
//         //print(substring); // Outputs: 'ing'
//       } else {
//         logger.d("fuzzy Soil: $_soil_raw");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return
//         Container()
//   }
// }
