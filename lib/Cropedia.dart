import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';


class CropInfo extends StatefulWidget {
  const CropInfo({Key? key}) : super(key: key);

  @override
  State<CropInfo> createState() => CropInfoState();
}


class CropInfoState extends State<CropInfo> {

  late CarouselController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = CarouselController();
    super.initState();
  }

  final List<String> images = [
    'assets/Cropedia-Tomato1.png',
    'assets/Cropedia-Tomato2.png',
    'assets/Cropedia-Tomato3.png',
  ];

  final List<String> pictures = [
    'assets/Cropedia-Sili1.png',
    'assets/Cropedia-Sili2.png',
    'assets/Cropedia-Sili3.png',
  ];

  List<Widget> reshapeImages(){
    return pictures.map((element)=> ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(element, width: 345, fit: BoxFit.cover,),
    )).toList();
  }


  List<Widget> generateImages(){
    return images.map((element)=> ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(element, width: 345, fit: BoxFit.cover,),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
        appBar: AppBar(
          toolbarHeight: 115,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
                'Crop Information',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 105, 46, 1),
                ),
              ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0), // Adjust the height as needed
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children:[
                  const SizedBox(width: 16,),
                  Container(
                    height: 31,
                    width: 194,
                    padding: const EdgeInsets.all(4),
                    alignment: Alignment.bottomLeft,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(217, 217, 217, 44)
                    ),
                    margin: const EdgeInsets.only(bottom: 15,),
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicator: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(0, 105, 46, 1),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color.fromRGBO(69, 90, 100, 1), // Corrected color definition
                      tabs: const [
                        Tab(text: 'Tomato'),
                        Tab(text: 'Siling Labuyo'),
                      ],
                      labelPadding: const EdgeInsets.symmetric(horizontal: 13),
                    ),
                  ),
                ]
              )
            )
          ),
        ),

        body: //SingleChildScrollView(
            //child: Column(
            //  children:[
                TabBarView(
                  children: [
                    // Content of Tab 1
                    SingleChildScrollView(
                      child:  Column(
                          children: [
                            const SizedBox(height: 20,),
                            Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    height: 150, width: 345,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: CarouselSlider(items: generateImages(),
                                      carouselController: controller,
                                      options: CarouselOptions(
                                        padEnds: true,
                                        enlargeCenterPage: false,
                                        autoPlay: true,
                                        //  aspectRatio: 0.85,
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                      ),),

                                  ),

                                  Positioned(
                                    bottom: 8.0,
                                    child: DotsIndicator(
                                      dotsCount: images.length,
                                      position: currentIndex,
                                      onTap: (index) {
                                        controller.animateToPage(index);
                                      },
                                      decorator: DotsDecorator(
                                        color:  const Color.fromRGBO(255, 255, 255, 59),
                                        activeColor:  const Color.fromRGBO(255, 255, 255, 59),
                                        size: const Size.square(12.0),
                                        activeSize: const Size(24.0, 12.0),
                                        activeShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),),]
                            ),

                            const SizedBox(height:20),

                            Container(
                              padding: const EdgeInsets.only(left: 35, right: 35,),
                              height: 1000,
                              width: double.infinity,
                              color: const Color.fromRGBO(0, 105, 46, 1),
                              child:  Column(
                                children: [
                                  const SizedBox(height: 20,),

                                  //ABOUT
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                      child: Text('About',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                  ),
                                  const SizedBox(height: 4,),
                                  const Text('Tomatoes (Solanum lycopersicum) are popular and versatile fruits that are often treated as vegetables in culinary contexts. They come in various shapes, sizes, and colors, from small cherry tomatoes to large beefsteak varieties. Tomatoes are rich in vitamins A and C, as well as antioxidants like lycopene, which may have health benefits.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      )),

                                  const SizedBox(height: 20,),

                                  //WHERE TO PLANT
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Where',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                  ),
                                  const SizedBox(height: 4,),
                                  const Text('Tomatoes require plenty of sunlight, so choose a location in your garden that receives at least 6-8 hours of direct sunlight per day. They also need well-drained soil with good organic matter content. Avoid planting tomatoes in areas where other members of the nightshade family (like peppers, eggplants, or potatoes) have been grown recently to reduce the risk of disease.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      )),
                                  const SizedBox(height: 20,),

                                  //WHEN TO PLANT
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('When',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                  ),
                                  const SizedBox(height: 4,),
                                  const Text('The timing for planting tomatoes depends on your location and climate. In general, tomatoes thrive in warm weather, so they are typically planted after the threat of frost has passed and the soil has warmed up. This is usually in the spring, but it can vary based on your region. You can start seeds indoors 6-8 weeks before the last frost date or purchase seedlings from a nursery to transplant into your garden.',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      )),

                                  const SizedBox(height: 20,),
                                  //HOW
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('How',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'lato',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),),
                                  ),

                                  const SizedBox(height: 4,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '1. Prepare the Soil: ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Till the soil to loosen it and add compost or aged manure to improve its texture and fertility.',
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '2. Choose Healthy Seedlings: ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'If you''re not starting from seed, select healthy tomato seedlings from a reputable nursery. Look for sturdy stems, dark green leaves, and no signs of disease or pests.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '3. Dig Planting Holes:  ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Dig holes for your tomato plants that are deep enough to bury them up to their first set of leaves. This encourages the development of a strong root system.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '4. Plant the Seedlings: ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Gently remove the seedlings from their containers and place them in the planting holes. Fill in the holes with soil, pressing gently to secure the seedlings in place.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '5. Provide Support:  ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Many tomato varieties benefit from staking or caging to support their growth and keep the fruits off the ground. Install stakes or cages at the time of planting to avoid damaging the roots later.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '6. Watering and Mulching: ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Water the newly planted seedlings thoroughly to help them establish their roots. Apply a layer of organic mulch, such as straw or shredded leaves, around the plants to retain moisture and suppress weeds.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),

                                  RichText(
                                    textAlign: TextAlign.left,
                                    text:  const TextSpan(
                                      text: '7. Maintenance: ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'As the plants grow, continue to water them regularly, especially during dry periods. Monitor for signs of pests or diseases and take appropriate action if needed. Fertilize the plants periodically according to the recommendations for your specific tomato variety.',
                                            style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),
                                ]
                              ),
                            ),
                          ]
                      ),
                    ),

                    // SILING LABUYO
                    SingleChildScrollView(
                      child:  Column(
                          children: [
                            const SizedBox(height: 20,),

                            Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    height: 150, width: 345,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: CarouselSlider(items: reshapeImages(),
                                      carouselController: controller,
                                      options: CarouselOptions(
                                        padEnds: true,
                                        enlargeCenterPage: false,
                                        autoPlay: true,
                                        //  aspectRatio: 0.85,
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                      ),),

                                  ),

                                  Positioned(
                                    bottom: 8.0,
                                    child: DotsIndicator(
                                      dotsCount: pictures.length,
                                      position: currentIndex,
                                      onTap: (index) {
                                        controller.animateToPage(index);
                                      },
                                      decorator: DotsDecorator(
                                        color:  const Color.fromRGBO(255, 255, 255, 59),
                                        activeColor:  const Color.fromRGBO(255, 255, 255, 59),
                                        size: const Size.square(12.0),
                                        activeSize: const Size(24.0, 12.0),
                                        activeShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),),]
                            ),

                            const SizedBox(height:20),

                            Container(
                              padding: const EdgeInsets.only(left: 35, right: 35,),
                              height: 870,
                              width: double.infinity,
                              color: const Color.fromRGBO(0, 105, 46, 1),
                              child:  Column(
                                  children: [
                                    const SizedBox(height: 20,),

                                    //ABOUT
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('About',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('Siling Labuyo, also known as Bird''s Eye Chili, is a small but potent chili pepper variety commonly found in the Philippines. It is known for its intense heat and is often used to add spice to Filipino dishes. Siling Labuyo plants produce small, thin peppers that start out green and turn red as they ripen.',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        )),

                                    const SizedBox(height: 20,),

                                    //WHERE TO PLANT
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Where',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('Siling Labuyo plants require plenty of sunlight to thrive, so choose a planting location that receives full sun for most of the day. They also prefer well-drained soil with good organic matter content. If you''re planting them in containers, make sure the pots have drainage holes to prevent waterlogging.',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        )),
                                    const SizedBox(height: 20,),

                                    //WHEN TO PLANT
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('When',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('Siling Labuyo thrives in warm weather, so it is best planted during the warmer months of the year. In tropical or subtropical regions like the Philippines, it can be planted year-round. However, it is typically planted in the spring or early summer when temperatures are consistently warm.',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        )),

                                    const SizedBox(height: 20,),
                                    //HOW
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('How',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'lato',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),),
                                    ),

                                    const SizedBox(height: 4,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '1. Prepare the Soil: ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Till the soil to loosen it and add compost or aged manure to improve its texture and fertility.',
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '2. Select Seedlings or Seeds:  ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'You can start Siling Labuyo plants from seeds or purchase seedlings from nurseries. If starting from seeds, sow them directly into the soil or in seed trays indoors, 6-8 weeks before the last frost date.',
                                              style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '3. Planting:  ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' If planting seedlings, dig planting holes that are slightly larger than the root balls of the seedlings. Space the plants about 12-18 inches apart to allow for proper growth. If planting seeds, sow them about 1/4 to 1/2 inch deep in the soil.',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '4. Watering: ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Water the newly planted seedlings thoroughly to help them establish their roots. Afterward, water them regularly, especially during dry periods, but avoid overwatering, as Siling Labuyo plants prefer slightly dry conditions.',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '5. Provide Support:  ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Depending on the variety and size of the plants, you may need to provide support such as stakes or cages to keep the plants upright as they grow.',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                    RichText(
                                      textAlign: TextAlign.left,
                                      text:  const TextSpan(
                                        text: '6. Maintenance: ',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Monitor the plants for pests and diseases, and take appropriate action if necessary. Fertilize the plants with a balanced fertilizer every 4-6 weeks during the growing season to promote healthy growth and fruit production.',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8,),

                                  ]
                              ),
                            ),
                          ]
                      ),
                    ),
                  ],
                ),
        ),
      );
  }
}



