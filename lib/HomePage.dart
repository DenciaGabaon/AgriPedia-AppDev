import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'CropData.dart';
import 'WeatherPage.dart';
import 'AddCrop.dart';
import 'CropManager.dart';
import 'package:provider/provider.dart';

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

  Future<void> _loadCrops() async {
    final cropDataManager = context.read<CropDataManager>();
    await cropDataManager.loadCrops();
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
      body: Container(
        color: const Color.fromRGBO(246, 245, 245, 1),
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

  Widget cropSummary(CropDataManager cropDataManager) {
    final cropList = cropDataManager.cropList;

    if (cropList.isEmpty) {
      return Center(
        child: Container(
          width: 500,
          height: 180,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.redAccent,
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
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.redAccent,
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
      padding: const EdgeInsets.all(10.0),
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
          width: 450,
          height: 220,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
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
        color: const Color(0xFFC1F2B0),
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
      width: 500,
      height: 220,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: cropList.map((crop) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.all(5.0)),
                getTask(crop),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget getCrop(CropData crop) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFC1F2B0),
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
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(3.0)),
          Image.asset('assets/Tomato.png'),
          Text(
            crop.name.isNotEmpty ? crop.name : crop.devID,
            style: crop.name.isNotEmpty
                ? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                : const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
          ),
          Text('Status: ${crop.status}'),
          Container(
            height: 20,
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
            child: Text(
              crop.condition,
              style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget getTask(CropData crop) {
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
      height: 70,
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.all(5.0)),
          Text(
            crop.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
          backgroundColor: Colors.lightGreen,
        ),
        child: const Text(
          'Add Crop',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
