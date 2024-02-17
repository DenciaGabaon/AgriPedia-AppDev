import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}


class DashboardState extends State<Dashboard> {
  get snapshot => null;

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('nodemCU-board-tomato/2024-2-16/20:29:31/soil');
  int? soilValue;



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
      body: SafeArea(// SafeArea yung visible part ng screen.
        child: Container(
          width: double.infinity,
          color: const Color.fromRGBO(246, 245, 245, 1),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child:  Column(
            children: [
              Container(
                alignment: Alignment(-0.8, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dashboard', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                      fontSize: 25,
                    ),
                      textAlign: TextAlign.left,
                    ),

                    Text('Tomato Tornado', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 15,
                    ),
                      textAlign: TextAlign.left,
                    ),
                    Text('06-11-02', style: TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      fontSize: 12,
                    ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(187, 222, 251, 100),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(30, 136, 229, 1),
                                ),
                                child: Image.asset('assets/Analysis-water.png',
                                    height: 50, width: 44),
                              ),
                            )),

                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                            soilValue != null
                              ? Text(
                                'Soil Value: $soilValue',
                                  style: TextStyle( fontSize: 35,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w900,
                                                    color: Color.fromRGBO(38, 50, 56, 1),),
                                )
                                  : CircularProgressIndicator(),
                                Text('Water', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),




                      ],
                    ),
                  ),
                  SizedBox( width: 13,),
                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(224, 22, 22, .15),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(224, 22, 22, 1),
                                ),
                                child: Image.asset('assets/Analysis-temp.png',
                                    height: 50, width: 44),),
                            )),

                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                Text('48%', style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                                Text('Water', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox( height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

            /*  StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users')
                  .snapshots(),
      )*/

                /*  StreamBuilder(
                    stream: _databaseReference.onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                        // Retrieve soil value from snapshot
                        int? soilValue = int.tryParse(snapshot.data!.snapshot.value.toString());

                        // Display the soil value in a Text widget
                        return Container(
                          height: 185,
                          width: 165,
                          color: Color.fromRGBO(246, 245, 245, 1),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 165,
                                  width: 165,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(187, 222, 251, 100),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(30, 136, 229, 1),
                                    ),
                                    child: Image.asset(
                                      'assets/Analysis-water.png',
                                      height: 50,
                                      width: 44,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                right: 0,
                                left: 0,
                                child: Column(
                                  children: [
                                    Text(
                                      'Soil Value: ${soilValue ?? 'N/A'}', // Display 'N/A' if soilValue is null
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(38, 50, 56, 1),
                                      ),
                                    ),
                                    Text(
                                      'Water',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                        color: Color.fromRGBO(38, 50, 56, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Handle loading state or if soil value is null
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),*/


                  /* Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(224, 185, 52, 160),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(253, 192, 55, 1),
                                ),
                                child: Image.asset('assets/Analysis-sun.png',
                                    height: 50, width: 44),),
                            )),
                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                Text('48%', style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                                Text('Water', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),

                      ],
                    ),
                  ),*/
                  SizedBox( width: 13,),
                  Container(
                    height: 185,
                    width: 165,
                    color: Color.fromRGBO(246, 245, 245, 1),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          child:  Container(
                            height: 165, width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(212, 252, 121, 100),
                              //color: Color.fromRGBO(221, 251, 152, 2),
                            ),
                          ),),
                        Positioned(
                            top: 0,
                            left: 0, right: 0,
                            child: Center(
                              child: Container(
                                height: 65, width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(0, 105, 46, 1),
                                ),
                                child: Image.asset('assets/Analysis-humid.png',
                                    height: 50, width: 44),),
                            )),
                        Positioned(
                            top: 80,
                            right: 0, left: 0,
                            child: Column(
                              children: [
                                Text('48%', style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                                Text('Water', style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                ),),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}
