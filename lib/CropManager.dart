import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:firebase_database/firebase_database.dart';
import 'CropData.dart';

class CropDataManager extends ChangeNotifier {
  List<CropData> cropList = [];
  final Logger logger = Logger();

  // CropDataManager() {
  //   _init();
  // }
  //
  // Future<void> _init() async {
  //   await loadCrops();
  //   //_initializeFirebaseListeners();
  // }

  void _initializeFirebaseListeners() {
    for (var crop in cropList) {
      String cropID = crop.devID;
      DatabaseReference cropDatabaseRef = FirebaseDatabase.instance.ref(cropID);
      cropDatabaseRef.onValue.listen((event) {
        var date = event.snapshot.value;
        logger.d("date: $date");
        if (date != null && date is Map) {
          var dateRaw = date.keys.toList();
          dateRaw.sort();
          String latestDate = dateRaw.last;

          cropDatabaseRef.child(latestDate).onValue.listen((event) {
            var timeRaw = event.snapshot.value;
            if (timeRaw != null && timeRaw is Map) {
              var timeStamps = timeRaw.keys.toList();
              timeStamps.sort();
              String latestTime = timeStamps.last;

              cropDatabaseRef.child('$latestDate/$latestTime').onValue.listen((event) {
                var liveData = event.snapshot.value.toString();
                if (liveData != 'No data available' && liveData != '') {
                  logger.d("ld: $liveData");
                  _updateCropDataFromLiveData(cropID, latestDate, latestTime, liveData);
                }
              });
            }
          });
        }
      });
    }
  }

  void _updateCropDataFromLiveData(String cropID, String date, String time, String liveData) {
    try {
      liveData = liveData.replaceAll(RegExp(r'[\{\}]'), ''); // Remove curly braces
      List<String> keyValuePairs = liveData.split(',');
      Map<String, String> dataMap = {};

      for (String pair in keyValuePairs) {
        List<String> keyValue = pair.split(':');
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        dataMap[key] = value;
      }

      String temperature = dataMap['temp'] ?? 'N/A';
      String humidity = dataMap['humidity'] ?? 'N/A';
      String lightIntensity = dataMap['light_intensity'] ?? 'N/A';
      String soil = dataMap['soil'] ?? 'N/A';

      updateCropData(
        cropID,
        temperature: temperature,
        humidity: humidity,
        lightIntensity: lightIntensity,
        soil: soil,
      );

      logger.d("Updated CropData for $cropID: ${findCropByID(cropID).toJson()}");
    } catch (e) {
      logger.e("Error parsing live data: $e");
    }
  }

  CropData findCropByID(String devID) {
    return cropList.firstWhere(
          (crop) => crop.devID == devID,
      orElse: () => CropData(
        devID: '',
        name: '',
        plantedDate: '',
        temperature: '',
        humidity: '',
        lightIntensity: '',
        soil: '',
      ),
    );
  }

  void updateCropData(String devID, {String? name, String? plantedDate, String? status, String? condition, String? temperature, String? humidity, String? lightIntensity, String? soil}) {
    final cropToUpdate = findCropByID(devID);
    if (cropToUpdate.devID.isNotEmpty) {
      cropToUpdate.name = name ?? cropToUpdate.name;
      cropToUpdate.plantedDate = plantedDate ?? cropToUpdate.plantedDate;
      cropToUpdate.temperature = temperature ?? cropToUpdate.temperature;
      cropToUpdate.humidity = humidity ?? cropToUpdate.humidity;
      cropToUpdate.lightIntensity = lightIntensity ?? cropToUpdate.lightIntensity;
      cropToUpdate.soil = soil ?? cropToUpdate.soil;
      saveCrops();
      notifyListeners();
    }
  }

  void addCrop(CropData crop, {bool notify = true}) {
    if (!cropList.any((element) => element.devID == crop.devID)) {
      cropList.add(crop);
      logger.d('Added crop: ${crop.toJson()}');
      saveCrops();
      if (notify) notifyListeners();
    } else {
      logger.w('Crop with ID ${crop.devID} already exists.');
    }
  }

  List<CropData> getCropList() {
    return cropList;
  }

  void removeCrop(String cropId) {
    cropList.removeWhere((crop) => crop.devID == cropId);
    saveCrops();
    notifyListeners();
    logger.d('Removed crop with ID: $cropId');
  }

  Future<void> loadCrops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cropsData = prefs.getStringList('crops');
    if (cropsData != null) {
      cropList = cropsData.map((json) => CropData.fromJson(json)).toList();
      logger.d('Loaded crops from SharedPreferences: $cropsData');
    } else {
      cropList = [];
      logger.d('No crops found in SharedPreferences.');
    }
    notifyListeners();
    _initializeFirebaseListeners(); // Wait for crops to be loaded before initializing Firebase listeners
  }


  Future<void> saveCrops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cropsData = cropList.map((crop) => crop.toJson()).toList();
    await prefs.setStringList('crops', cropsData);
    logger.d('Saved crops to SharedPreferences: $cropsData');
  }

  Future<void> clearCrops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    cropList = [];
    notifyListeners();
    logger.d('Cleared all crops from SharedPreferences and memory.');
  }

  void logCropData() {
    var allCropData = StringBuffer();
    for (var crop in cropList) {
      allCropData.writeln(crop.toString());
    }
    logger.d(allCropData.toString());
  }
}
