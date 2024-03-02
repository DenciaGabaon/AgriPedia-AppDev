import 'package:agripedia/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agripedia/SelectCrop.dart';

class AddCrop extends StatefulWidget {
  const AddCrop({Key? key}) : super(key: key);

  @override
  State<AddCrop> createState() => AddCropState();
}

class AddCropState extends State<AddCrop>{

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Crop',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              'Select A Crop Below:',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 150,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectCrop()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5.0,
                  shadowColor: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/tomato.svg',
                      height: 80,
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Tomato',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 150,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectCrop())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5.0,
                    shadowColor: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/sili.svg',
                        height: 80,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Chili',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
