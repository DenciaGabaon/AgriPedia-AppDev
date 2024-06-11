// crop_data.dart
import 'dart:convert';

class CropData {
  String devID;
  String name;
  String plantedDate;
  String status;
  String condition;
  String temperature;
  String humidity;
  String lightIntensity;
  String soil;

  CropData({
    required this.devID,
    required this.name,
    required this.plantedDate,
    required this.status,
    required this.condition,
    required this.temperature,
    required this.humidity,
    required this.lightIntensity,
    required this.soil,
  });

  // Convert a CropData object into a map.
  Map<String, dynamic> toMap() {
    return {
      'devID': devID,
      'name': name,
      'plantedDate': plantedDate,
      'status': status,
      'temperature': temperature,
      'humidity': humidity,
      'lightIntensity': lightIntensity,
      'soil': soil,
    };
  }

  // Convert a map into a CropData object.
  factory CropData.fromMap(Map<String, dynamic> map) {
    return CropData(
      devID: map['devID'],
      name: map['name'],
      plantedDate: map['plantedDate'],
      status: map['status'],
      condition: map['condition'],
      temperature: map['temperature'],
      humidity: map['humidity'],
      lightIntensity: map['lightIntensity'],
      soil: map['soil'],
    );
  }

  // Convert a CropData object into a JSON string.
  String toJson() => jsonEncode(toMap());

  // Convert a JSON string into a CropData object.
  factory CropData.fromJson(String source) => CropData.fromMap(jsonDecode(source));
}
