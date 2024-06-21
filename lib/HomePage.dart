import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'CropData.dart';
import 'WeatherPage.dart';
import 'AddCrop.dart';
import 'CropManager.dart';
import 'package:provider/provider.dart';
import 'FuzzyLogic.dart';
import 'main.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => Home();
}

class Home extends State<MyHomePage> {
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadCrops();
  }

  void _checkConditions() {
    final cropDataManager = context.read<CropDataManager>();
    final crops = cropDataManager.cropList;

    for (var crop in crops) {
      final temperature = int.tryParse(crop.temperature) ?? 0;
      final temperatureStatus = FuzzyLogic.getTemperatureStatus(temperature);

      if (temperatureStatus.contains('High')) {
        _showNotification(
          title: 'High Temperature Alert',
          body: 'The temperature for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too high!',
        );
      } else if (temperatureStatus.contains('Low')) {
        _showNotification(
          title: 'Low Temperature Alert',
          body: 'The temperature for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too low!',
        );
      }

      final humidity = int.tryParse(crop.humidity) ?? 0;
      final humidityStatus = FuzzyLogic.getHumidityStatus(humidity);

      if (humidityStatus.contains('High')) {
        _showNotification(
          title: 'High Humidity Alert',
          body: 'The humidity for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too high!',
        );
      } else if (humidityStatus.contains('Low')) {
        _showNotification(
          title: 'Low Humidity Alert',
          body: 'The humidity for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too low!',
        );
      }

      final lightIntensity = int.tryParse(crop.lightIntensity) ?? 0;
      final lightIntensityStatus = FuzzyLogic.getLightStatus(lightIntensity);

      if (lightIntensityStatus.contains('High')) {
        _showNotification(
          title: 'High Light Intensity Alert',
          body: 'The light intensity for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too high!',
        );
      } else if (lightIntensityStatus.contains('Low')) {
        _showNotification(
          title: 'Low Light Intensity Alert',
          body: 'The light intensity for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too low!',
        );
      }

      final soilMoisture = int.tryParse(crop.soil) ?? 0;
      final soilMoistureStatus = FuzzyLogic.getSoilMoistureStatus(soilMoisture);

      if (soilMoistureStatus.contains('High')) {
        _showNotification(
          title: 'High Soil Moisture Alert',
          body: 'The soil moisture for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too high!',
        );
      } else if (soilMoistureStatus.contains('Low')) {
        _showNotification(
          title: 'Low Soil Moisture Alert',
          body: 'The soil moisture for ${crop.name.isNotEmpty ? crop.name : crop.devID} is too low!',
        );
      }
    }
  }

  Future<void> _showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }


  Future<void> _loadCrops() async {
    final cropDataManager = context.read<CropDataManager>();
    await cropDataManager.loadCrops();
    _checkConditions();
  }

  @override
  Widget build(BuildContext context) {
    final cropDataManager = context.watch<CropDataManager>();
    final crops = cropDataManager.cropList;

    logger.d(crops);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      ),
      body: Center(
        child: Column(
          children: [
            cropSummary(cropDataManager),
            const SizedBox(height: 15),
            taskList(cropDataManager),
            const SizedBox(height: 15),
            const WeatherPage(),
            const SizedBox(height: 15),
            addCropButton(cropDataManager),
          ],
        ),
      ),
    );
  }

  String? path(String id) {
    String tomatopath = 'assets/Tomato.png';
    String chilipath = 'assets/Chili.png';

    if (id =="nodemCU-board-tomato") {
      return tomatopath;
    } else if (id == "nodemCU-board-chili") {
      return chilipath;
    }

    return null;
  }



  Widget cropSummary(CropDataManager cropDataManager) {
    final cropList = cropDataManager.cropList;

    if (cropList.isEmpty) {
      return Center(
        child: Container(
          width: 370,
          height: 180,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 242, 176, 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'No Crops Found.\nPlease Add a Crop First.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 370,
      height: 180,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(193, 242, 176, 1),
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
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cropList.map((crop) {
            return getCrop(crop);
          }).toList(),
        ),
      ),
    );
  }


  Widget taskList(CropDataManager cropDataManager) {
    final cropList = cropDataManager.cropList;
    if (cropList.isEmpty) {
      return Center(
        child: Container(
          width: 370,
          height: 220,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 242, 176, 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'No Tasks Available.\nAdd a Crop First.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(193, 242, 176, 1),//const Color(0xFFC1F2B0),
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
      width: 370,
      height: 220,
      padding: const EdgeInsets.all(15.0),
      child: RawScrollbar(child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: cropList.map((crop) {
            return Column(
              children: [
                getTaskTemp(crop),
                const SizedBox(height: 10),
                getTaskHumid(crop),
                const SizedBox(height: 10),
                getTaskLight(crop),
                const SizedBox(height: 10),
                getTaskSoil(crop),
                const SizedBox(height: 10),

              ],
            );
          }).toList(),
        ),
      ),),
    );
  }

  Widget getCrop(CropData crop) {
    String? imagePath = path(crop.devID);
    return Consumer<CropDataManager>(
      builder: (context, cropDataManager, _) {
        String condition = FuzzyLogic.getPlantCondition(
          rawSoilMoisture: int.tryParse(crop.soil) ?? 0,
          temperature: int.tryParse(crop.temperature) ?? 0,
          humidity: int.tryParse(crop.humidity) ?? 0,
          lightIntensity: int.tryParse(crop.lightIntensity) ?? 0,
        );
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
          width: 130,
          height: 150,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(3.0)),
              imagePath != null
                  ? Image.asset(imagePath, height: 50, width: 50)
                  : Container(),
              Text(
                crop.name.isNotEmpty ? crop.name : crop.devID,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromRGBO(38, 50, 56, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  fontFamily: 'Inter',
                ),
              ),
              Text('Condition: $condition',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(38, 50, 56, 1),
                fontFamily: 'Inter',
              ),),
              SizedBox(height: 8),
              Container(
                height: 10,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget getTaskTemp(CropData crop) {
    String? imagePath = path(crop.devID);
    return Consumer<CropDataManager>(
      builder: (context, cropDataManager, _) {
        final temperatureStatus = FuzzyLogic.getTemperatureStatus(
            int.tryParse(crop.temperature) ?? 0);
        final temperatureRecommendation = FuzzyLogic
            .getTemperatureRecommendation(int.tryParse(crop.temperature) ?? 0);

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
            height: 81,
            // Increased height to fit all the information
            padding: const EdgeInsets.all(10.0),
            // Add some padding
            child: Row(children: [
              imagePath != null
                  ? Image.asset(imagePath, height: 50, width: 50)
                  : Container(),
              SizedBox(width: 10),
              Container(
                height: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3),
                        Text(
                          crop.name.isNotEmpty ? crop.name : crop.devID,
                          style: const TextStyle(
                            color: Color.fromRGBO(38, 50, 56, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                        SizedBox(height: 3),
                        Text('Status: $temperatureStatus',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            color: Color.fromRGBO(38, 50, 56, 6),
                            fontWeight: FontWeight.normal,
                          ),),
                        Text('Task: $temperatureRecommendation',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            color: Color.fromRGBO(38, 50, 56, 6),
                          ),),
                      ],
                    ),)
              )
            ])
        );
      });
  }


  Widget getTaskHumid(CropData crop) {
    String? imagePath = path(crop.devID);
    return Consumer<CropDataManager>(
      builder: (context, cropDataManager, _) {
        final humidityStatus = FuzzyLogic.getHumidityStatus(int.tryParse(crop.humidity) ?? 0);
        final humidityRecommendation = FuzzyLogic.getHumidityRecommendation(int.tryParse(crop.humidity) ?? 0);

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
          height: 81, // Increased height to fit all the information
          padding: const EdgeInsets.all(10.0), // Add some padding
          child: Row(
            children:[
              imagePath != null ? Image.asset(imagePath, height: 50, width: 50) : Container(),
              SizedBox(width: 10,),
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3),
                Text(
                crop.name.isNotEmpty ? crop.name : crop.devID,
                style: const TextStyle(
                  color: Color.fromRGBO(38, 50, 56, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 3),
              Text('Status: $humidityStatus',
                style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10,
                color: Color.fromRGBO(38, 50, 56, 6),
                    fontWeight: FontWeight.normal
              ),),
              Text('Task: $humidityRecommendation',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color.fromRGBO(38, 50, 56, 6),
                    fontWeight: FontWeight.normal
                ),),
            ],
            ),],),
        );
      },
    );
  }


  Widget getTaskLight(CropData crop) {
    String? imagePath = path(crop.devID);
    return Consumer<CropDataManager>(
      builder: (context, cropDataManager, _) {
        final lightIntensityStatus = FuzzyLogic.getLightStatus(int.tryParse(crop.lightIntensity) ?? 0);
        final lightIntensityRecommendation = FuzzyLogic.getLightRecommendation(int.tryParse(crop.lightIntensity) ?? 0);

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
          height: 81, // Increased height to fit all the information
          padding: const EdgeInsets.all(10.0), // Add some padding
          child: Row(children:[
                imagePath != null ? Image.asset(imagePath, height: 50, width: 50) : Container(),
                SizedBox(width: 10,),
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3),
              Text(
                crop.name.isNotEmpty ? crop.name : crop.devID,
                style: const TextStyle(
                  color: Color.fromRGBO(38, 50, 56, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
                SizedBox(height: 3),
              Text('Status: $lightIntensityStatus',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color.fromRGBO(38, 50, 56, 6),
                    fontWeight: FontWeight.normal
                ),),
              Text('Task: $lightIntensityRecommendation',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color.fromRGBO(38, 50, 56, 6),
                    fontWeight: FontWeight.normal
                ),),
            ],
            ),],),
        );
      },
    );
  }


  Widget getTaskSoil(CropData crop) {
    String? imagePath = path(crop.devID);
    return Consumer<CropDataManager>(
      builder: (context, cropDataManager, _) {
        final soilMoistureStatus = FuzzyLogic.getSoilMoistureStatus(int.tryParse(crop.soil) ?? 0);
        final soilMoistureRecommendation = FuzzyLogic.getSoilMoistureRecommendation(int.tryParse(crop.soil) ?? 0);

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
          height: 81, // Increased height to fit all the information
          padding: const EdgeInsets.all(10.0), // Add some padding
          child: Row(children:[
              imagePath != null ? Image.asset(imagePath, height: 50, width: 50) : Container(),
              SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3),
                Text(
                crop.name.isNotEmpty ? crop.name : crop.devID,
                style: const TextStyle(
                  color: Color.fromRGBO(38, 50, 56, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
                SizedBox(height: 3),
              Text('status: $soilMoistureStatus',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color.fromRGBO(38, 50, 56, 6),
                    fontWeight: FontWeight.normal
                ),),
              Text('Task: $soilMoistureRecommendation',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: Color.fromRGBO(38, 50, 56, 6),
                  fontWeight: FontWeight.normal
                ),),
            ],
          ),],),
        );
      },
    );
  }


  Widget addCropButton(CropDataManager cropDataManager) {
    return SizedBox(
        width: 180,
        height: 50,
        child: ElevatedButton(
        onPressed: () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddCrop(),
        ),
      );

      if (result == true) {
        _loadCrops();
      }
    },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(0, 105, 46, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: const Text(
        'Add Crop',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
      ),
    ),
    );
  }
}
