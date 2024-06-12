import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quickalert/quickalert.dart';
import 'CropData.dart';
import 'CropManager.dart';
import 'package:provider/provider.dart'; // Import Provider

class AddCrop extends StatefulWidget {
  const AddCrop({Key? key}) : super(key: key);

  @override
  State<AddCrop> createState() => AddCropState();
}

class AddCropState extends State<AddCrop> {
  @override
  Widget build(BuildContext context) {
    final cropDataManager = Provider.of<CropDataManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(
              Icons.qr_code,
            ),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            print('Barcode found! ${barcode.rawValue}');
          }
          if (image != null) {
            String? deviceID = barcodes.first.rawValue;
            var logger = Logger();
            logger.d("ID: $deviceID");

            // Check if the device ID already exists in CropDataManager
            if (cropDataManager.getCropList().any((crop) => crop.devID == deviceID)) {
              logger.d("ID already scanned");
              Navigator.of(context).pop();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                title: 'Existing ID',
                text: 'ID is already used',
              );
              return;
            } else {
              DatabaseReference _database = FirebaseDatabase.instance.ref(deviceID);
              try {
                _database.onValue.listen((DatabaseEvent event) {
                  final data = event.snapshot.value;
                  if (data != null) {
                    // Create a new CropData instance with the device ID
                    CropData newCrop = CropData(
                      devID: deviceID!,
                      name: '',
                      // Set other fields as per your requirement
                      plantedDate: '',
                      status: '',
                      condition: '',
                      temperature: '',
                      humidity: '',
                      lightIntensity: '',
                      soil: '',
                    );
                    // Add the new crop to CropDataManager
                    cropDataManager.addCrop(newCrop);
                    cropDataManager.logCropData();
                    Navigator.of(context).pop();
                  } else {
                    logger.e("Error reading Realtime Database");
                    Navigator.of(context).pop();
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Invalid ID',
                      text: 'No crop was found from the scanned ID.',
                    );
                  }
                });
              } catch (e) {
                logger.e("Error reading from Realtime Database: $e");
                Navigator.of(context).pop();
              }
            }
          }
        },
      ),
    );
  }
}
