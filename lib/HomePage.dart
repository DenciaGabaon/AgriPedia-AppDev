//ERROR SDK IS BELOW 26 - 04/11 - solved
//TO DO maintain navigation bar while routing to another page of home page
//another route for page 1 og home page for displaying painting sample pictures.


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';



//import 'package:permission_handler/permission_handler.dart';
//import 'package:tflite_flutter/tflite_flutter.dart'

// Lahat ng values na nagbabago ipapasok sa function, like text.
// Pwedeng naka default ang container, and then yung laman is naka function.

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => Home();
}

class CropData {
  final String name;
  final String status;
  final String condition;

  CropData({required this.name, required this.status, required this.condition});
}

class Task{

}

class Home extends State<MyHomePage> {
  List<CropData> crops = [
    CropData(name: "tomato1", status: "online", condition: "good"),
    CropData(name: "tomato2", status: "offline", condition: "bad"),
    CropData(name: "sili1", status: "online", condition: "good"),
    CropData(name: "sili2", status: "offline", condition: "bad")
    // Add more crops as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AgriPedia'),
            SvgPicture.asset(
              'assets/HomeNav.svg',
              height: 30,
            ),
            const SizedBox(width:8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          cropSummary(),
          SizedBox(height: 15),
          taskList()
        ],
      )
    );
  }

  Widget cropSummary() {
    if (crops.isEmpty) {
      return Center(
        child: Container(
          width: 500,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'No Crop Found,\nPlease Add a Crop First.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: crops.map((crop) {
          return getCrop(crop);
        }).toList(),
      ),
    );

  }

  Widget getCrop(CropData crop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 3, // Blur radius
            offset: const Offset(0, 3), // Offset in the x, y direction
          ),
        ],
      ),
      width: 130,
      height: 130,// Adjust width as needed
      margin: const EdgeInsets.all(10.0), // Adjust margin as needed
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.all(3.0)),
          Image.asset('assets/tomatoes.png'),
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
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 3, // Blur radius
                  offset: const Offset(0, 3), // Offset in the x, y direction
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

  Widget taskList(){
    if (crops.isEmpty) {
      return Center(
        child: Container(
          width: 450,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: Text(
              'Tasks Unavailable, Add A Crop First',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 390,
      height: 150,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const Center(
        child: Text(
          'Task ng ina mo',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


/*
  @override
  Widget build(BuildContext context) {
    // Code
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromRGBO(245, 245, 219, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('AgriPedia'),
            SvgPicture.asset(
              'assets/HomeNav.svg',
              height: 30,
            ),
            const SizedBox(width:8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
      children: [
        Container(
          width: 500,
          height: 150,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            children: [
              const SizedBox(width: 12),
              buildCard(),
              const SizedBox(width: 12),
              buildCard(),
              const SizedBox(width: 12),
              buildCard(),
              const SizedBox(width: 12),
              buildCard(),
              const SizedBox(width: 12)
            ],
          ),
          ),
        ),
            const SizedBox(height: 12),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                  width: 390,
                  height: 230,
                  padding: const EdgeInsets.all(10.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    buildTask(),
                    const SizedBox(height: 12),
                    buildTask(),
                    const SizedBox(height: 12),
                    buildTask(),
                    const SizedBox(height: 12),
                    buildTask(),
                    const SizedBox(height: 12)
                  ],
                ),
              ),
            ],
          ),
        const SizedBox(height: 15),
        Column(
          children: [
            Container(
              width: 380,
              height: 145,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Text('hello World'),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 190,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Add Crop',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
  Widget buildCard() => Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20.0)
    ),
    width: 125,
    height: 125,
    child: Column(
      children: [
        const Padding(padding: EdgeInsets.all(3.0)),
        Image.asset('assets/tomatoes.png'),
        const Text('Tomato Uno',
          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Status: Online'
        ),
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: const Text(
            'Good',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    )
  );

  Widget buildTask() => Container(
    width: 380,
    height: 54,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
    ),
    child: Row(
      children: [
        Image.asset('assets/tomatoes.png'),
        SizedBox(width: 12.0),
        Text("Tomato Uno needs watering!"),
      ],
    ),
  );
}*/
