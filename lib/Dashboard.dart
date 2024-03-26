import 'dart:ffi';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;



class Dashboard extends StatefulWidget {
  String? id;
   Dashboard({Key? key, required this.id}) : super(key: key);
  //const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class CropStatus{

   String year;
   double sales = 0;

  CropStatus(this.year, this.sales);

}

List<CropStatus> Cropchart = [
  CropStatus('Jan', 10),
  CropStatus('Feb', 30),
  CropStatus('Mar', 50),
  CropStatus('Apr', 70),
  CropStatus('May', 20),

];




class DashboardState extends State<Dashboard> {
  final Logger logger = Logger();
  late String finalID = '';
  late TooltipBehavior _tooltipBehavior;
  String test = "nodemCU-board-tomato";
  late DatabaseReference _database;
  /*final DatabaseReference _database = FirebaseDatabase.instance.ref(
      "nodemCU-board-tomato");*/

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

  //Var to String Holder
  late String _liveData = '';
  late String _time = '';
  late String _dates = '';

  //Factors Holder
  late String _temperature = '';
  late String _temperature_raw = '';
  late String _humidity_raw = '';
  late String _humidity = '';
  late String _soil_raw = '';
  late String _soil = '';
  late String _lightIntensity_raw = '';
  late String _lightIntensity = '';

  //List holder
  late List<String> dataFactors = [];
  late List<String> dataTime = [];
  late List<String> dataDate = [];


  late String latestTime_raw = '';
  late String latestTime= '';
  late String latestDate = '';
  late String finalTime = '';
  bool loading = true;


  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        borderColor: Colors.red,
        borderWidth: 5,
        color: Colors.lightBlue
    );
    if (widget.id != null) {
      // If ID is passed, no need to show loading
      logger.d(widget.id);
      setState(() {
         finalID = widget.id!;
      });
      //retrieve all the time in database - DONE
      //identify the latest time
      // get the identified time and connect it to the current date
      //if current time has the same time in realtime database, then display.
      //else, the displayed dashboard should remain the same with the current time.


      if (finalID.isNotEmpty) {
        logger.d("finalid: $finalID");

         _database = FirebaseDatabase.instance.ref(finalID);

        //RETRIEVING DATE
         _database.onValue.listen((event) {
             var date = event.snapshot.value;
             if(date != null && date is Map) {

               setState(() {
               var date_raw = date.keys.toList(); // Extracting the time stamps
               logger.d("Data: $date");
               logger.d("TS var: $date_raw");
               date_raw.sort();
               logger.d("Sorted var: $date_raw");
               _dates = date_raw.join(', ');
               logger.d("_dates string: $_dates");
               dataDate = _dates.split(',').map((_dates) => _dates.trim()).toList();
               logger.d("DD list: $dataDate");
               latestDate = dataDate.last;
               logger.d("LD: $latestDate");

               //RETRIEVING TIME & FACTORS
               _database.child(latestDate).onValue.listen((event) {
                 setState(() {
                   var time_raw = event.snapshot.value;
                   if(time_raw != null && time_raw is Map) {

                     var timeStamps = time_raw.keys.toList(); // Extracting the time stamps
                     logger.d("Data: $time_raw");
                     logger.d("TS var: $timeStamps");
                     timeStamps.sort();
                     logger.d("Sorted var: $timeStamps");
                     _time = timeStamps.join(', ');
                     logger.d("_dates string: $_dates");
                     dataTime = _time.split(',').map((_time) => _time.trim()).toList();
                     logger.d("DT list: $dataTime");
                     latestTime = dataTime.last;
                     logger.d("LT: $latestTime");
                     //finalTime = "2024-2-16/$latestTime";

                     _database.child('$latestDate/$latestTime').onValue.listen((event) {
                       _liveData = (event.snapshot.value ?? 'No data available').toString();
                       logger.d("LIVE DATA: $_liveData");
                       if (_liveData == 'No data available' || _liveData == ''){
                         setState(() {
                           loading = false;
                         });
                       }
                       else{
                         Retrievedata(_liveData);
                       }
                     });


                   } else {
                     //make a page that says there are no data retrieved
                     setState(() {
                       loading = false;
                     });
                     _time = 'No data available';
                   }
                 });
               });


               });
             } else {
               //make a page that says there are no data retrieved
               setState(() {
                 loading = false;
               });
               _dates = 'No data available';
             }
           });






          //"2024-2-16/23:59:20"

          //logger.d("FT2: $finalTime");
         //"2024-2-16/$latestTime"

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
      dataFactors = liveData.split(',');
      _temperature_raw = dataFactors[0];
      if (_temperature_raw.length >= 30) {
        _temperature = _temperature_raw.substring(29).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("t: $_temperature_raw");
      }

      _humidity_raw = dataFactors[2];
      if (_humidity_raw.length >= 34) {
        _humidity = _humidity_raw.substring(33).replaceAll(RegExp('}'), '');
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("h: $_humidity_raw");
      }

      _lightIntensity_raw = dataFactors[1];
      if (_lightIntensity_raw.length >= 41) {
        _lightIntensity =  double.parse(_lightIntensity_raw.substring(40).replaceAll(RegExp('}'), '')).toStringAsFixed(1);;
        //print(substring); // Outputs: 'ing'
      } else {
        logger.d("l: $_lightIntensity_raw");
      }

      _soil_raw = dataFactors[3];
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

    /*if(loading == true){
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
    }*/

    logger.d("length: ${dataFactors.length}");

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

                    Text('$finalID', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 15,
                    ),
                      textAlign: TextAlign.left,
                    ),
                    Text('$latestDate', style: TextStyle(
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
                 SizedBox(height: 13,),
                 StatsOutput(),
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

        //  if (_soil != null) {
    if (loading == false){
      return Container(

        child:
         _soil != ''
            ? Text(
          _soil,
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo data\n', style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.redAccent,
        ),),
      );
    }else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
}

  Widget TempOutput(){

    if (loading == false){
      return Container(

        child:
        _temperature != ''
            ? Text(
          '$_temperature°C',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo data\n', style: TextStyle(
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
    if (loading == false){
      return Container(

        child:
        _lightIntensity != ''
            ? Text(
          '$_lightIntensity lux',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo data\n', style: TextStyle(
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

    if (loading == false){
      return Container(

        child:
        _humidity != ''
            ? Text(
          '$_humidity',
          style: TextStyle( fontSize: 35,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(38, 50, 56, 1),),
        )
            : Text('\nNo data\n', style: TextStyle(
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


  Widget StatsOutput(){
      return Container(
        height: 220,
        width: 350,
          /*decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            //color: Colors.white,
            color: Color.fromRGBO(230, 230, 230, 1),
          ),*/
          child: SfCartesianChart(
             plotAreaBackgroundColor: Colors.transparent,
             borderColor: Colors.transparent,
             borderWidth: 0,
             plotAreaBorderWidth: 0,
                    // Initialize category axis
                      primaryXAxis: CategoryAxis(
                        axisLine: AxisLine(width: 0),
                        labelPlacement: LabelPlacement.onTicks,
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        majorGridLines: MajorGridLines(width: 0),
                        majorTickLines: MajorTickLines(width: 0),
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),),
                      primaryYAxis: NumericAxis(
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 1),
                        majorTickLines: MajorTickLines(width: 0),
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        minimum: 10,
                        maximum: 100,
                        interval: 20,
                      ),

                      series: <CartesianSeries<CropStatus, String>>[
                        SplineSeries(
                          color: Color.fromRGBO(0, 105, 46, 1),
                            width: 4,
                            dataSource: Cropchart,
                            xValueMapper: (CropStatus status, _) => status.year,
                            yValueMapper: (CropStatus status, _) => status.sales,),
                        SplineSeries(
                          dataSource: Cropchart,
                          xValueMapper: (CropStatus status, _) => status.year,
                          yValueMapper: (CropStatus status, _) => status.sales,
                          onCreateShader: (ShaderDetails details){
                            return ui.Gradient.linear(details.rect.topCenter,
                                details.rect.bottomCenter, const <Color>[
                                  Color.fromRGBO(0, 105, 46, 1),
                                  Color.fromRGBO(0, 105, 46, 1),
                            ],<double>[
                              0.4,
                              0.10,]);
                            }
                       /*   gradient: LinearGradient(colors: [
                            Color.fromRGBO(0, 105, 46, 1).withAlpha(150),
                            Color.fromRGBO(0, 105, 46, 1).withAlpha(10),
                          ]*/
                          )

                      ],

                     tooltipBehavior: _tooltipBehavior,
                  )
      );
    }

    /*return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Half Yearly Sales Analysis'),
        legend: Legend(isVisible: true,),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: data,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales,
            name: 'Sales',
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    ),*/
}




