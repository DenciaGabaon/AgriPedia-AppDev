// crop_data_manager.dart
import 'CropData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CropDataManager {
  List<CropData> cropList = [];

  // Add crop to the list
  void addCrop(CropData crop) {
    cropList.add(crop);
  }

  // Remove crop from the list
  void removeCrop(String cropId) {
    cropList.removeWhere((crop) => crop.devID == cropId);
  }

  // Getter method to access cropList
  List<CropData> getCropList() {
    return cropList;
  }

  Future<List<CropData>> loadCrops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cropsData = prefs.getStringList('crops');
    if (cropsData != null) {
      return cropsData.map((json) => CropData.fromJson(json)).toList();
    } else {
      return []; // Return an empty list if no crops are stored
    }
  }

  Future<void> saveCrops(List<CropData> crops) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cropsData = crops.map((crop) => crop.toJson()).toList();
    await prefs.setStringList('crops', cropsData);
  }
}
