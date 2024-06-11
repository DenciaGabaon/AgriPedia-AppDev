import 'package:flutter/material.dart';
import 'CropData.dart';
import 'AnalysisPage.dart';
import 'WeatherPage.dart';
import 'AddCrop.dart';
import 'CropManager.dart'; // Import the CropDataManager class

class MyHomePage extends StatefulWidget {
  final CropDataManager cropDataManager; // Define cropDataManager here

  const MyHomePage({Key? key, required this.cropDataManager}) : super(key: key);

  @override
  State<MyHomePage> createState() => Home();
}

class Home extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final cropList = widget.cropDataManager.getCropList();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AgriPedia'),
            const SizedBox(width: 8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            cropSummary(),
            const SizedBox(height: 15),
            taskList(),
            const SizedBox(height: 15),
            WeatherPage(),
            const SizedBox(height: 15),
            addCrop(),
          ],
        ),
      ),
    );
  }

  Widget cropSummary() {
    final cropList = widget.cropDataManager.cropList;

    if (cropList.isEmpty) {
      return Center(
        child: Container(
          width: 500,
          height: 150,
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cropList.map((crop) {
          return getCrop(crop);
        }).toList(),
      ),
    );
  }

  Widget taskList() {
    final cropList = widget.cropDataManager.cropList;
    if (cropList.isEmpty) {
      return Center(
        child: Container(
          width: 450,
          height: 150,
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
        color: Color(0xFFC1F2B0),
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
        color: Color(0xFFC1F2B0),
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
      height: 130,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(3.0)),
          Image.asset('assets/Tomato.png'),
          Text(
            crop.name,
            style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
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

  Widget weatherUI() {
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
      width: 400,
      height: 180,
      child: const Row(
        children: [
          Text('weather is unavailable'),
        ],
      ),
    );
  }

  Widget addCrop() {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCrop(cropDataManager: widget.cropDataManager),
            ),
          );
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
