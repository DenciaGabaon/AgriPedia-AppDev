import 'package:agripedia/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCrop extends StatefulWidget {
  const SelectCrop({Key? key}) : super(key: key);

  @override
  State<SelectCrop> createState() => SelectCropState();
}

class SelectCropState extends State<SelectCrop>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Agripedia'),
            SvgPicture.asset(
              'assets/HomeNav.svg',
              height: 30,
            ),
            const SizedBox(width: 8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name your Crop',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 30,
              ),
            ),
            TextField(
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
                fontStyle: FontStyle.normal,
                fontSize: 30,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'MM/DD/YYYY',
                border: OutlineInputBorder(),
              ),
            ),
          SizedBox(height: 20),
          SizedBox(
            width: 180,
            height: 50,
            child:ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
              child: const Text('Add Crop',
                  style: TextStyle(
                      color: Colors.white,//Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal
                  )),
            ),
    ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}