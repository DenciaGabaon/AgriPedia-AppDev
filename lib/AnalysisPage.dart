import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'CropData.dart';
import 'CropManager.dart';
import 'Dashboard.dart';
import 'package:logger/logger.dart';

String name = ''; // Initialize variables to hold the edited values
String date = '';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => AnalysisState();
}

class AnalysisState extends State<Analysis> {
  var logger = Logger();

  Future<void> _saveCrops(CropDataManager cropDataManager) async {
    await cropDataManager.saveCrops();
  }

  @override
  Widget build(BuildContext context) {
    final cropDataManager = context.watch<CropDataManager>(); // Access CropDataManager from context
    final crops = cropDataManager.getCropList();
    Size screenSize = MediaQuery.of(context).size;

    logger.d(screenSize.height);

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Align(
              alignment: const Alignment(-0.8, 0.0),
              child: Text(
                'Live Analysis',
                style: TextStyle(
                  color: const Color.fromRGBO(38, 50, 56, 1),
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  fontSize: 25,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              child: crops.isEmpty
                  ? Column(
                children: [
                  SizedBox(height: screenSize.height / 3),
                  Center(
                    child: SizedBox(
                      width: 260,
                      child: Text(
                        'Connect to hardware using Add Crop button from Home page',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Center(
                    child: Column(
                      children: crops.map((crop) {
                        return Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(5.0)),
                            CropList(crop, cropDataManager),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CropList(CropData crop, CropDataManager cropDataManager) {
    String? imagePath = path(crop.devID);

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 105, 46, 1),
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
      width: 365,
      height: 90,
      child: Row(
        children: [
          imagePath != null ? Image.asset(imagePath, height: 50, width: 50) : Container(),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              String scannedID = crop.devID;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard(id: scannedID)),
              );
            },
            child: Container(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 22),
                  Text(
                    crop.name == '' ? crop.devID : crop.name,
                    style: const TextStyle(
                      color: Color.fromRGBO(220, 253, 146, 1),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Planted Date: ${crop.plantedDate}',
                    style: const TextStyle(
                      color: Color.fromRGBO(220, 253, 146, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Lato',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Popupedit(context, crop.devID, cropDataManager);
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/Analysis-edit.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {


                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Popuptrash(crop.devID, cropDataManager);
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/Analysis-trash.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? path(String id) {
    String tomatopath = 'assets/Tomato.png';
    String chilipath = 'assets/Chili.png';

    if (id.toLowerCase().contains("tomato")) {
      return tomatopath;
    } else if (id.toLowerCase().contains("chili")) {
      return chilipath;
    }

    return null;
  }

  Widget Popuptrash(String id, CropDataManager cropDataManager) {
    return AlertDialog(
      title: Text('Delete Confirmation'),
      content: Text('Are you sure you want to delete this item?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              cropDataManager.removeCrop(id);
              _saveCrops(cropDataManager);
            });
            Navigator.of(context).pop(); // Close the dialog and return true
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog and return false
          },
          child: Text('No'),
        ),
      ],
    );
  }

  Widget Popupedit(BuildContext context, String id, CropDataManager cropDataManager) {
    return AlertDialog(
      title: Text('Edit Crop Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Name your Crop',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          TextField(
            onChanged: (value) {
              name = value; // Update the 'name' variable when the text changes
            },
            decoration: InputDecoration(
              hintText: 'Enter a Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Date Planted',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          TextField(
            onChanged: (value) {
              date = value; // Update the 'date' variable when the text changes
            },
            decoration: InputDecoration(
              hintText: 'MM/DD/YYYY',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              cropDataManager.updateCropData(id, name: name, plantedDate: date);
              _saveCrops(cropDataManager);
            });
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without saving
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
