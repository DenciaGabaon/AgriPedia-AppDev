import 'package:agripedia/AnalysisPage.dart';
import 'package:agripedia/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'test.dart';
import 'HomePage.dart';
import 'Cropedia.dart';



class MyNavigation extends StatefulWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  State<MyNavigation> createState() => NavigationBar();

  /*void setIndex(BuildContext context, int newIndex) {
    NavigationBar state = context.findAncestorStateOfType<NavigationBar>()!;
    state.setState(() {
      state.Myindex = newIndex;
    });
  }*/
}

class NavigationBar extends State<MyNavigation>{
    int Myindex = 0;
  List<Widget> widgetList = const [
    MyHomePage(),
    Analysis(),
    CropInfo(),
    FirebaseDataScreen(),
  ];

  /*  void setIndex(int newIndex) {
      setState(() {
        Myindex = newIndex;
      });
    }*/
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //backgroundColor: Colors.white,//Color.fromRGBO(245, 245, 219, 1),
      body: widgetList[Myindex],
      bottomNavigationBar :  BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: Myindex,
        //type: BottomNavigationBarType.fixed,
        items:   [
          BottomNavigationBarItem(
              icon: SizedBox(
                width: 35, // Adjust the width as needed
                height: 31, // Adjust the height as needed
                child: SvgPicture.asset('assets/Home-grey.svg'),
              ),//SvgPicture.asset('assets/Home-grey.svg',),//Image.asset('assets/Home-grey.png'),
              activeIcon: SizedBox(
                width: 35, // Adjust the width as needed
                height: 31, // Adjust the height as needed
                child: SvgPicture.asset('assets/Home-green.svg'),
              ),//SvgPicture.asset('assets/Home-green.svg',),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/Analysis-grey.svg', ),
              activeIcon: SvgPicture.asset('assets/Analysis-green.svg',),
              label: 'Analysis'),
          BottomNavigationBarItem(
                 icon:  SvgPicture.asset('assets/Cropedia-grey.svg', ),
                 activeIcon: SvgPicture.asset('assets/Cropedia-Green.svg', ),
                 label: 'Cropedia'),
          BottomNavigationBarItem(
              icon:  SvgPicture.asset('assets/Cropedia-grey.svg', ),
              activeIcon: SvgPicture.asset('assets/Cropedia-Green.svg', ),
              label: 'test'),
        ],
        onTap: (index) {
          setState(() {
            Myindex = index;
          }
          );
        },

        selectedItemColor: const Color.fromRGBO(0, 105, 46, 1),
        unselectedItemColor: const Color.fromRGBO(175, 183, 187, 1),

        selectedLabelStyle: const TextStyle(
          fontSize: 12, // Set the font size for the selected label
          fontFamily: 'Lato',
          fontWeight: FontWeight.w400,
        //  color: Color.fromRGBO(0, 105, 46, 1),// Set your desired font family for the selected label
        ),
        unselectedLabelStyle: const TextStyle(
            fontSize: 12, // Set the font size for the selected label
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          //  color: Color.fromRGBO(175, 183, 187, 1),// Set your desired font family for the unselected label
        ),
      ),

    );
  }
}