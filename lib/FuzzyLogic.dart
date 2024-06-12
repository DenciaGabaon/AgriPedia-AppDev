// import 'CropData.dart';
// import 'package:logger/logger.dart';
//
// class FuzzyLogic {
//   CropData cropData;
//   final Logger logger = Logger();
//   double temperature = 0.0;
//   double soil = 0.0;
//   double light = 0.0;
//   double humidity = 0.0;
//
//   FuzzyLogic(this.cropData);
//
//   String evaluateCropData() {
//     double temperature = double.tryParse(cropData.temperature) ?? 0.0;
//     double soil = double.tryParse(cropData.soil) ?? 0.0;
//     double light = double.tryParse(cropData.lightIntensity) ?? 0.0;
//     double humidity = double.tryParse(cropData.humidity) ?? 0.0;
//
//     // check if the values are retrieved
//
//     print("Fuzzy temp: ${cropData.temperature}");
//     print("Fuzzy water: ${cropData.soil}");
//     print("Fuzzy light: ${cropData.lightIntensity}");
//     print("Fuzzy humidity: ${cropData.humidity}");
//
//     // if (temperature < 60) {
//     //   cropData.condition = 'good';
//     //   return '${cropData.name} needs heating';
//     // }
//     // return 'Nothing to do for now';
//   }
//
//   String getCondition(){
//     double temperature = double.tryParse(cropData.temperature) ?? 0.0;
//     double soil = double.tryParse(cropData.soil) ?? 0.0;
//     double light = double.tryParse(cropData.lightIntensity) ?? 0.0;
//     double humidity = double.tryParse(cropData.humidity) ?? 0.0;
//
//
//   }
//
//   String getFactors(String factor, soil, temperature, light, humidity){
//     if (factor == 'soil_moisture'){
//       if (soil < 30){
//         return 'low';
//       }else if (30 <= soil && soil <= 50){
//         return 'below_average';
//       }else if (50 <= soil && soil <= 70){
//         return 'average';
//       }else if (70 <= soil && soil <=90){
//         return 'above_average';
//       }else{
//         return 'high';
//       }
//     }else if (factor == 'temperature'){
//       if (temperature < 20){
//         return 'low';
//       }else if (30 <= temperature && temperature <= 40){
//         return 'below_average';
//       }else if (40 <= temperature && temperature <= 70){
//         return 'average';
//       }else if (70 <= temperature && temperature <= 80){
//         return 'above_average';
//     }else{
//         return 'high';
//       }
//   }else if (factor == 'light'){
//       if (light < 50){
//         return 'low';
//       }else if (50 <= light && light <=100){
//         return 'average';
//       }else{
//         return 'high';
//       }
//     }
//     return '';
// }
//
//
//   }
