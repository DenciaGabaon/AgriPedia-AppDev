import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CropInfo extends StatefulWidget {
  const CropInfo({Key? key}) : super(key: key);

  @override
  State<CropInfo> createState() => CropInfoState();
}


class CropInfoState extends State<CropInfo> {

  final List<String> images = [
    'assets/Cropedia-Tomato1.png',
    'assets/Cropedia-Tomato2.png',
    'assets/Cropedia-Tomato3.png',
  ];

  List<Widget> generateImages(){
    return images.map((element)=> ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(element, width: 311, height: 150, fit: BoxFit.fitWidth),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Color.fromRGBO(246, 245, 245, 1),
        appBar: AppBar(
          toolbarHeight: 125,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(height: 1), // Add SizedBox for spacing
              Text(
                'Crop Information',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 105, 46, 1),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0), // Adjust the height as needed
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children:[
                  SizedBox(width: 16,),
                  Container(
                    height: 31,
                    width: 194,
                    padding: EdgeInsets.all(4),
                    alignment: Alignment.bottomLeft,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(217, 217, 217, 44)
                    ),
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicator: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(0, 105, 46, 1),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Color.fromRGBO(69, 90, 100, 1), // Corrected color definition
                      tabs: const [
                        Tab(text: 'Tomato'),
                        Tab(text: 'Siling Labuyo'),
                      ],
                      labelPadding: EdgeInsets.symmetric(horizontal: 13),
                    ),
                    margin: EdgeInsets.only(bottom: 20,),
                  ),
                ]
              )
            )
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
              children:[
              //  SizedBox(height: 25,),

            /*    SizedBox( height: 150, width: 311,
                child: CarouselSlider(items: const[
                 AssetImage("assets/Cropedia-Tomato1.png"),
                AssetImage(assetName),
                AssetImage(assetName,)],

                ),),*/
                Stack(
                    children: [
                      CarouselSlider(items: generateImages(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 0.85,
                          // viewportFraction: 0.85
                        ),),
                    ]
                ),
                SizedBox(height:20),
                Container(
                  height: 900,
                  width: 410,
                  color: Color.fromRGBO(0, 105, 46, 1),
                ),
              ],
            ),
          ),
        ),
      );
  }
}



/*    TabBarView(
            children: [
              // Content of Tab 1
              ListView(
                children: List.generate(
                  20, // Number of items in the list
                      (index) => ListTile(title: Text('Item $index')),
                ),
              ),
              // Content of Tab 2
              ListView(
                children: List.generate(
                  30, // Number of items in the list
                      (index) => ListTile(title: Text('Item $index')),
                ),
              ),
            ],
          ),*/