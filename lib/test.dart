import 'dart:math';

import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Firebase Database
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // for date formatting
import 'dart:convert';



class FirebaseDataScreen extends StatefulWidget {
  const FirebaseDataScreen({super.key});

  @override
  _FirebaseDataScreenState createState() => _FirebaseDataScreenState();
}

class _FirebaseDataScreenState extends State<FirebaseDataScreen> {
  final Logger logger = Logger();
  String finalID = 'nodemCU-board-tomato';



  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

  //String dateTimePath = '$formattedDate/$formattedTime';
  String _liveData = '';
  String _dates = '';
  String _temperature = '';
  String _temperature_raw = '';
  String _humidity_raw = '';
  String _humidity = '';
  String _soil_raw = '';
  String _soil = '';
  String _lightIntensity_raw = '';
  String _lightIntensity = '';
  List<String> dataVertical = [];
  late  List<String> dataTime = [];

  late String latestTime_raw = '';
  late String latestTime= '';
  late String finalTime = '';
  bool loading = true;




  /* @override
  void initState() {

    super.initState();

     Setup listener for changes in Firebase database

      setState(() {
        dataVertical = _liveData.split(',');
        _temperature_raw = dataVertical[0];
        if (_temperature_raw.length >= 30) {
          _temperature = _temperature_raw.substring(29).replaceAll(RegExp('}'), '');
          //print(substring); // Outputs: 'ing'
        } else {
          logger.d("t: $_temperature_raw");
        }

        _humidity_raw = dataVertical[2];
        if (_humidity_raw.length >= 34) {
          _humidity = _humidity_raw.substring(33).replaceAll(RegExp('}'), '');
          //print(substring); // Outputs: 'ing'
        } else {
          logger.d("h: $_humidity_raw");
        }

        _lightIntensity_raw = dataVertical[1];
        if (_lightIntensity_raw.length >= 41) {
          _lightIntensity = _lightIntensity_raw .substring(40).replaceAll(RegExp('}'), '');
          //print(substring); // Outputs: 'ing'
        } else {
          logger.d("l: $_lightIntensity_raw");
        }

        _soil_raw = dataVertical[3];
        if (_soil_raw.length >= 30) {
          _soil = _soil_raw.substring(29).replaceAll(RegExp('}'), '');
          //print(substring); // Outputs: 'ing'
        } else {
          logger.d("s: $_soil_raw");
        }

        loading = false;
      });
  }*/

  @override
  void initState() {
    super.initState();
    DatabaseReference _database = FirebaseDatabase.instance.ref(
        finalID);
    //DatabaseReference _database = FirebaseDatabase.instance.ref(
     //   "nodemCU-board-potato");
    //retrieve all the time in database - DONE
    //identify the latest time
    // get the identified time and connect it to the current date
    //if current time has the same time in realtime database, then display.
    //else, the displayed dashboard should remain the same with the current time.

    //if(formattedDate != databasedate){}



    _database.child('2024-2-16').onValue.listen((event) {
      setState(() {
        var data = event.snapshot.value;
        if(data != null && data is Map) {
          // Assuming there's only one entry in the map
          //var timeStamp = data.keys; // Extracting the time stamp
         // var timeStamp = data.values.toList();
         // _dates = timeStamp.toString();
          var timeStamps = data.keys.toList(); // Extracting the time stamps
          logger.d("Data: $data");
          logger.d("TS var: $timeStamps");
          timeStamps.sort();
          logger.d("Sorted var: $timeStamps");
          _dates = timeStamps.join(', ');
          logger.d("_dates string: $_dates");
          dataTime = _dates.split(',').map((_dates) => _dates.trim()).toList();
          logger.d("DT list: $dataTime");
          latestTime = dataTime.last;
          logger.d("LT: $latestTime");
          //finalTime = "2024-2-16/$latestTime";

          _database.child("2024-2-16/$latestTime").onValue.listen((event) {
            _liveData = (event.snapshot.value ?? 'No data available').toString();
            logger.d("FT: 2024-2-16/$latestTime");
            logger.d("LD: $_liveData");
            if (_liveData == 'No data available'){
              setState(() {
                loading = false;
              });
            }
            else{
              Retrievedata(_liveData);
            }
          });


          //loading = false;
        } else {
          _dates = 'No data available';
        }
      });
      logger.d("finalt: $finalTime");
    });



    //"2024-2-16/$latestTime"
    //"2024-2-16/23:59:20"




   /* _database.child('2024-2-16').onValue.listen((event) {
      _liveData = (event.snapshot.value ?? 'No data available').toString();
      logger.d(_liveData);
      Retrievedata(_liveData);
    });*/
  }

  Future<void> Retrievedata(String liveData)async{
    // _database.child('2024-2-16/20:49:59').onValue.listen((event) {
    //  setState(() {
    // _liveData = (event.snapshot.value ?? 'No data available').toString();
    // logger.d("ss: $_liveData");

    setState(() {
      dataVertical = liveData.split(',');
      _temperature_raw = dataVertical[0];
      if (_temperature_raw.length >= 30) {
        _temperature = _temperature_raw.substring(29).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("t: $_temperature_raw");
      }

      _humidity_raw = dataVertical[2];
      if (_humidity_raw.length >= 34) {
        _humidity = _humidity_raw.substring(33).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("h: $_humidity_raw");
      }

      _lightIntensity_raw = dataVertical[1];
      if (_lightIntensity_raw.length >= 41) {
        _lightIntensity = _lightIntensity_raw .substring(40).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("l: $_lightIntensity_raw");
      }

      _soil_raw = dataVertical[3];
      if (_soil_raw.length >= 30) {
        _soil = _soil_raw.substring(29).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("s: $_soil_raw");
      }

      //loading = false;
    });
    setState(() {
      loading = false;
    });
    //  });
    //  });
  }




  @override
  Widget build(BuildContext context) {

    // logger.d("Read successfully. Data read: $_liveData");

    //List<String> dataWidgets = [];


    /* _database.child('2024-2-16/20:49:59').onValue.listen((event) {
      _liveData = (event.snapshot.value ?? 'No data available').toString();
      logger.d("ss: $_liveData");
    }*/



    //_temperature_raw = _temperature.substring(29).replaceAll(RegExp('}'), '');
    //_humidity = '';//dataWidgets[2].substring(33).replaceAll(RegExp('}'), '');
    //_lightIntensity = '';//dataWidgets[1].substring(40).replaceAll(RegExp('}'), '');
    //_soil = '';//dataWidgets[3].substring(29).replaceAll(RegExp('}'), '');


    //logger.d("temp: $_temperature");
    //logger.d("Read successfully. Data vertical: $dataVertical");
    //logger.d("Read successfully. Data widgets: $dataWidgets");
    //  dataVertical = _liveData.split(',');
    // logger.d("Read successfully. Data vertical: $dataVertical");


    if(loading == true){
      return const Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 300),
              Text('Identifying', style: TextStyle(
                fontSize: 30, fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),),
              SizedBox(height: 35),
              /*  ClipRRect(
                child: Image( image: AssetImage('assets/loading.png'), // Use AssetImage for local images
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover, // Adjust the fit based on your requirements
                ),
              ),*/
              SizedBox(height: 35),
              SizedBox(width: 120,
                  child:  LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(66, 103, 178, 1),
                    color: Colors.grey,
                    minHeight: 10,)
              ),
              SizedBox(height: 35),
              Text('Please wait...', style: TextStyle(
                fontSize: 20, fontFamily: 'Montserrat',
                fontWeight: FontWeight.w800,
              ),),
            ],
          ),
        ),
      );
    }

    //logger.d("length: ${dataVertical.length}");

      // REMOVE THE PARENTHESIS because _liveData is in String
      //List<String> dataVertical = _dates.split(',');
      List<Widget> dataWidgets = [];

    logger.d(_dates);
    logger.d(dataTime.length);
    logger.d(latestTime);


    for (String data in dataVertical) {
        dataWidgets.add(
          Text(
            data.trim(),
            style: TextStyle(fontSize: 20.0),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Firebase RTDB Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Live Data:',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              Column (
                  children: dataWidgets
              )
            ],
          ),
        ),
      );
    }

    /*return Scaffold(
      appBar: AppBar(
        title: Text('Firebase RTDB Demo'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_humidity',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '$_lightIntensity',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '$_soil',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '$_temperature',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
            ]
        ),
      ),
    );*/
    /* }else{
      return Center(
        child: Text('Empty'),
      );
    }*/
  }
