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
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name your Tomato',
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
          ],
        ),
      ),
    );
  }
}
