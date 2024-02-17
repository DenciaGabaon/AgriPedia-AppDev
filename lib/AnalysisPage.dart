import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//1. After Add Crop, ipapasa yung nakihang ID dito sa AnalysisPage.
//2. Then, yung irretrieve yung info galing sa database gamit yung ID
//3. declare variable na mag hohold sa na retrieve na ID (ID muna).
//4. display ID sa container. yung container is where you can edit the name. and
   //add planted date.
//5. if container/ button is clicked, then pass the ID sa dashboard.

//==============DASHBOARD PART================//
//1.  pag ka pasa ng ID, ilagay sa vriable lahat ng sensors using set state
//    after i retrieve.
//2.  then

//GOAL: to connect app to database using QR

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => AnalysisState();
}

class AnalysisState extends State<Analysis> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/Logo-appbar.svg',
              height: 30,
            ),
            const SizedBox(width:8),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(246, 245, 245, 1),
      ),//const Color.fromRGBO(245, 245, 219, 1),
      body: SafeArea(
        child: Text('asdasd'),
      ),
    );
  }

  }
