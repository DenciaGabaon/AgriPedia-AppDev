import 'dart:ffi';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'CropData.dart';
import 'CropManager.dart';

class Dashboard extends StatefulWidget {
  final String id;

  const Dashboard({Key? key, required this.id}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class CropStatus {
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
  late String finalID;
  late TooltipBehavior _tooltipBehavior;
  late DatabaseReference _database;

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

  //Var to String Holder
  late String _liveData = '';
  late String _time = '';
  late String _dates = '';

  //Factors Holder
  late String _temperature = '';
  late String _humidity = '';
  late String _soil = '';
  late String _lightIntensity = '';

  //List holder
  late List<String> dataFactors = [];
  late List<String> dataTime = [];
  late List<String> dataDate = [];

  late String latestTime_raw = '';
  late String latestTime = '';
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
      color: Colors.lightBlue,
    );
    finalID = widget.id;
    logger.d("finalid: $finalID");
    _database = FirebaseDatabase.instance.ref(finalID);

    // Retrieving Date
    _database.onValue.listen((event) {
      var date = event.snapshot.value;
      if (date != null && date is Map) {
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

          // Retrieving Time & Factors
          _database.child(latestDate).onValue.listen((event) {
            setState(() {
              var time_raw = event.snapshot.value;
              if (time_raw != null && time_raw is Map) {
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

                _database.child('$latestDate/$latestTime').onValue.listen((event) {
                  _liveData = (event.snapshot.value ?? 'No data available').toString();
                  logger.d("LIVE DATA: $_liveData");
                  if (_liveData == 'No data available' || _liveData == '') {
                    setState(() {
                      loading = false;
                    });
                  } else {
                    Retrievedata(_liveData);
                  }
                });
              } else {
                setState(() {
                  loading = false;
                });
                _time = 'No data available';
              }
            });
          });
        });
      } else {
        setState(() {
          loading = false;
        });
        _dates = 'No data available';
      }
    });
  }

  Future<void> Retrievedata(String liveData) async {
    setState(() {
      try {
        // Parse the JSON-like string into a map
        liveData = liveData.replaceAll(RegExp(r'[\{\}]'), ''); // Remove curly braces
        List<String> keyValuePairs = liveData.split(',');
        Map<String, String> dataMap = {};

        for (String pair in keyValuePairs) {
          List<String> keyValue = pair.split(':');
          String key = keyValue[0].trim();
          String value = keyValue[1].trim();
          dataMap[key] = value;
        }

        // Extract values from the map
        _temperature = dataMap['temp'] ?? 'N/A';
        _humidity = dataMap['humidity'] ?? 'N/A';
        _lightIntensity = dataMap['light_intensity'] ?? 'N/A';
        _soil = dataMap['soil'] ?? 'N/A';

        final cropDataManager = context.read<CropDataManager>();

        cropDataManager.updateCropData(
          finalID,
          temperature: _temperature,
          humidity: _humidity,
          lightIntensity: _lightIntensity,
          soil: _soil,
        );

        // Log the CropData object
        logger.d("CropData: ${cropDataManager.findCropByID(finalID).toJson()}");

        // Update the loading state
        loading = false;
      } catch (e) {
        logger.e("Error parsing live data: $e");
        loading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(width: 8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color.fromRGBO(246, 245, 245, 1),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            children: [
              Container(
                alignment: const Alignment(-0.8, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Color.fromRGBO(38, 50, 56, 1),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      finalID,
                      style: const TextStyle(
                        color: Color.fromRGBO(38, 50, 56, 1),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      latestDate,
                      style: const TextStyle(
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FactorWidget(
                    title: 'Water',
                    icon: 'assets/Analysis-water.png',
                    color: const Color.fromRGBO(30, 136, 229, 1),
                    value: _soil,
                    loading: loading,
                  ),
                  const SizedBox(width: 13),
                  FactorWidget(
                    title: 'Temperature',
                    icon: 'assets/Analysis-temp.png',
                    color: const Color.fromRGBO(224, 22, 22, 1),
                    value: _temperature,
                    loading: loading,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FactorWidget(
                    title: 'Light',
                    icon: 'assets/Analysis-sun.png',
                    color: const Color.fromRGBO(253, 192, 55, 1),
                    value: _lightIntensity,
                    loading: loading,
                  ),
                  const SizedBox(width: 13),
                  FactorWidget(
                    title: 'Humidity',
                    icon: 'assets/Analysis-humid.png',
                    color: const Color.fromRGBO(0, 105, 46, 1),
                    value: _humidity,
                    loading: loading,
                  ),
                ],
              ),
              const SizedBox(height: 13),
              StatsOutput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget FactorWidget({
    required String title,
    required String icon,
    required Color color,
    required String value,
    required bool loading,
  }) {
    return Container(
      height: 185,
      width: 165,
      color: const Color.fromRGBO(246, 245, 245, 1),
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
                color: color.withOpacity(0.15),
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
                  color: color,
                ),
                child: Image.asset(
                  icon,
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
                if (loading)
                  const Center(child: CircularProgressIndicator())
                else
                  Text(
                    value != '' ? value : 'No data',
                    style: TextStyle(
                      fontSize: value != '' ? 35 : 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: const Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                Text(
                  title,
                  style: const TextStyle(
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
    );
  }

  Widget StatsOutput() {
    return Container(
      height: 220,
      width: 350,
      child: SfCartesianChart(
        plotAreaBackgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        borderWidth: 0,
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          axisLine: AxisLine(width: 0),
          labelPlacement: LabelPlacement.onTicks,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          labelStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 1),
          majorTickLines: MajorTickLines(width: 0),
          labelStyle: const TextStyle(
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
            color: const Color.fromRGBO(0, 105, 46, 1),
            width: 4,
            dataSource: Cropchart,
            xValueMapper: (CropStatus status, _) => status.year,
            yValueMapper: (CropStatus status, _) => status.sales,
          ),
          SplineSeries(
            dataSource: Cropchart,
            xValueMapper: (CropStatus status, _) => status.year,
            yValueMapper: (CropStatus status, _) => status.sales,
            onCreateShader: (ShaderDetails details) {
              return ui.Gradient.linear(
                details.rect.topCenter,
                details.rect.bottomCenter,
                const <Color>[
                  Color.fromRGBO(0, 105, 46, 1),
                  Color.fromRGBO(0, 105, 46, 1),
                ],
                <double>[
                  0.4,
                  0.10,
                ],
              );
            },
          ),
        ],
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }
}
