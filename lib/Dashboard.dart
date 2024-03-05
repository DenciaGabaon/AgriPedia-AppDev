import 'dart:ffi';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';



class Dashboard extends StatefulWidget {
  String? id;
   Dashboard({Key? key, required this.id}) : super(key: key);
  //const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}




class DashboardState extends State<Dashboard> {
  final Logger logger = Logger();
  late String finalID = '';
  String test = 'nodemCU-board-tomato';
  late DatabaseReference _database;
  /*final DatabaseReference _database = FirebaseDatabase.instance.ref(
      "nodemCU-board-tomato");*/

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

  late String _liveData = '';
  late String _temperature = '';
  late String _temperature_raw = '';
  late String _humidity_raw = '';
  late String _humidity = '';
  late String _soil_raw = '';
  late String _soil = '';
  late String _lightIntensity_raw = '';
  late String _lightIntensity = '';
  late List<String> dataVertical = [];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // If ID is passed, no need to show loading
      logger.d(widget.id);
      setState(() {
         finalID = widget.id!;
      });

      if (finalID.isNotEmpty) {
        logger.d(finalID);
        logger.d(test);
         _database = FirebaseDatabase.instance.ref(test);
         _database.child('2024-2-16/20:49:59').onValue.listen((event) {
          _liveData = (event.snapshot.value ?? 'No data available').toString();
          logger.d(_liveData);
          if (_liveData == 'No data available'){
            setState(() {
              loading = false;
            });
          }
          else{
            Retrievedata(_liveData);
          }
        });
        /*_database = FirebaseDatabase.instance.ref(
            finalID);
         DatabaseReference _database = FirebaseDatabase.instance.ref(
             "nodemCU-board-tomato");

        _database.child('2024-2-16/20:49:59').onValue.listen((event) {
          _liveData = (event.snapshot.value).toString();
          //logger.d("ss: $_liveData");
          if(_liveData != null){
              logger.d("ss null: $_liveData");
              Retrievedata(_liveData);
          }else {
            logger.d("ss: $_liveData");
          }
          });*/

      }else{
        logger.d("null ang iyong final id beh");
      }
   }
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
        _lightIntensity =  double.parse(_lightIntensity_raw.substring(40).replaceAll(RegExp('}'), '')).toStringAsFixed(1);;
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







  /*@override
  void initState() {
    super.initState();
    // Setup listener for changes in Firebase database
    _database.child('2024-2-16/20:49:59').onValue.listen((event) {
      setState(() {
        _liveData = (event.snapshot.value ?? 'No data available').toString();
      });
    });
  }*/



  @override
  Widget build(BuildContext context) {


  //List<String> dataVertical = _liveData.split(',');

  //_temperature = dataVertical[0].substring(29).replaceAll(RegExp('}'), '');
  //_humidity = dataVertical[2].substring(33).replaceAll(RegExp('}'), '');
  //_lightIntensity = double.parse(dataVertical[1].substring(40).replaceAll(RegExp('}'), '')).toStringAsFixed(1);;
  //String _light = raw_lightIntensity.toStringAsFixed(1);
  //_soil = dataVertical[3].substring(29).replaceAll(RegExp('}'), '');


  /*if (isLoading == false){
    logger.d("length: ${dataVertical.length}");

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
    }*/

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

    logger.d("length: ${dataVertical.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/Logo-appbar.svg',
              height: 30,
            ),
            const SizedBox(width:8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(246, 245, 245, 1),
      ),//const Color.fromRGBO(245, 245, 219, 1),
      body: SafeArea(// SafeArea yung visible part ng screen.
        child: Container(
          width: double.infinity,
          color: const Color.fromRGBO(246, 245, 245, 1),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child:  Column(
            children: [
              Container(
                alignment: Alignment(-0.8, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dashboard', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                      fontSize: 25,
                    ),
                      textAlign: TextAlign.left,
                    ),

                    Text('Tomato Tornado', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 15,
                    ),
                      textAlign: TextAlign.left,
                    ),
                    Text('06-11-02', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 12,
                    ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(187, 222, 251, 100),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(30, 136, 229, 1),
                              ),
                              child: Image.asset(
                                'assets/Analysis-water.png',
                                height: 50,
                                width: 44,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              WaterOutput(),
                              Text(
                                'Water',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox( width: 13,),
                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(224, 22, 22, .15),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(224, 22, 22, 1),
                                ),
                                child: Image.asset('assets/Analysis-temp.png',
                                    height: 50, width: 44),),
                            )),

                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                TempOutput(),
                                Text('Temperature', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox( height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(224, 185, 52, 160),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(253, 192, 55, 1),
                                ),
                                child: Image.asset('assets/Analysis-sun.png',
                                    height: 50, width: 44),),
                            )),
                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                lightOutput(),
                                Text('light', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                  SizedBox( width: 13,),
                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(212, 252, 121, 100),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(0, 105, 46, 1),
                                ),
                                child: Image.asset('assets/Analysis-humid.png',
                                    height: 50, width: 44),),
                            )),
                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                HumidityOutput(),
                                Text('Humidity', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  /*}else {
    // Handle loading state or if soil value is null
    return Center(
      child: CircularProgressIndicator(),
    );
  }*/

  }

  Widget WaterOutput(){

          if (_soil != null) {
            return Container(

              child:
              _soil != null
                  ? Text(
                '$_soil',
                style: TextStyle( fontSize: 35,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(38, 50, 56, 1),),
              )
                  : Text('\nNo crop detected\n', style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.redAccent,
              ),),
            );
        }else {
            // Handle loading state or if soil value is null
            return Center(
              child: CircularProgressIndicator(),
            );
          }
}

  Widget TempOutput(){

    if (_temperature != null) {
      return Container(

        child:
        _temperature != null
            ? Text(
          '$_temperature°C',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo crop detected\n', style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent,
        ),),
      );
    } else {
      // Handle loading state or if soil value is null
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }



  Widget lightOutput(){
    if (_lightIntensity != null) {
      return Container(

        child:
        _lightIntensity != null
            ? Text(
          '$_lightIntensity lux',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo crop detected\n', style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent,
        ),),
      );
    } else {
      // Handle loading state or if soil value is null
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }



  Widget HumidityOutput(){

    if (_humidity != null) {
      return Container(

        child:
        _humidity != null
            ? Text(
          '$_humidity',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo crop detected\n', style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent,
        ),),
      );
    } else {
      // Handle loading state or if soil value is null
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}


