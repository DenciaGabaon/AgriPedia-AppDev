import 'dart:typed_data';
import 'package:agripedia/AnalysisPage.dart';
import 'package:agripedia/main.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:agripedia/NavigationBar.dart';


class AddCrop extends StatefulWidget {
  const AddCrop({super.key});

  @override
  State<AddCrop> createState() => AddCropState();
}

class AddCropState extends State<AddCrop> {



  @override
  Widget build(BuildContext context) {
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

            AnalysisState.addCropData(deviceID!);
            Navigator.of(context).pop();


           /* Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => MyNavigation(), // Navigate to MyNavigation first
            )).then((_) {
              // After navigating to MyNavigation, call setIndex
              MyNavigation().setIndex(context, 1);
            });*/
            //NavigationBar.setIndex(1);



            //_passer(deviceID!);


            //  connectToHardware(Deviceid!);
            /*showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  //pass id to connectToHardwareDBASE function
                  //insdide the function, return all the retrieved data
                  //from the id using streambuilder to add it ti list that
                  // will hold all the data that will be displayed.
                  title: Text(
                    barcodes.first.rawValue ?? "",
                  ),
                  content: Image(
                    image: MemoryImage(image),
                  ),
                );
              },
            );*/
          }
        },
      ),
    );
  }
}

 /* void _passer(String deviceID) async {
    var logger = Logger();
    logger.d("$deviceID");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Analysis(deviceID: deviceID),
    ));
  }
}*/



// Function to connect to hardware using the scanned data
  void connectToHardware(String deviceId) {
    // Add your logic here to connect to the hardware device
    // You can use the deviceId to identify and connect to the corresponding hardware
  }



