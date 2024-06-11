import 'package:shared_preferences/shared_preferences.dart';
import 'CropData.dart';

// Save the list of CropData to shared preferences
Future<void> saveCrops(List<CropData> crops) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cropsData = crops.map((crop) => crop.toJson()).toList();
  await prefs.setStringList('crops', cropsData);
}

// Load the list of CropData from shared preferences
Future<List<CropData>> loadCrops() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cropsData = prefs.getStringList('crops');
  if (cropsData != null) {
    return cropsData.map((crop) => CropData.fromJson(crop)).toList();
  } else {
    return [];
  }
}
