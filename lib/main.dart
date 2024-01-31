import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'NavigationBar.dart';
import 'package:carousel_slider/carousel_controller.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const AgriPedia());
}

class AgriPedia extends StatelessWidget {
  const AgriPedia({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ArtSense Flash Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        '/second': (context) => const MyNavigation(),
        // '/third': (context) => Camera(),
        // Define a named route for SecondScreen
      },
     // home: const MyWelcomePage(),
    );
  }
}

/*
class MyWelcomePage extends StatefulWidget {
  const MyWelcomePage({Key? key}) : super(key: key);

  @override
  State<MyWelcomePage> createState() => _MyWelcomePageState();
}



class _MyWelcomePageState extends State<MyWelcomePage> {

  @override
  void initState() {
    super.initState();

    /// whenever your initialization is completed, remove the splash screen:
    Future.delayed(Duration(seconds: 5)).then((value) => {
      FlutterNativeSplash.remove()
    });
  }

  final List<String> images = [
    'assets/popart.jpg',
    'assets/Welcome1.png',
    'assets/neoclassicism.jpg',
  ];

  List<Widget> generateImages(){
    return images.map((element)=> ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(element, fit: BoxFit.cover, width: 304, height: 433,),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, //const Color.fromRGBO(245, 245, 219, 1),
      body: SafeArea( // SafeArea yung visible part ng screen.
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            children: [
              SizedBox(height: 11,),
              Center(
                child: SizedBox(
                  width: 250,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Welcome to\n',
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ArtSense!',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                            fontSize: 40,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

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
              // ),


              SizedBox(height: 25,),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Identify art paintings \non which style category \nthey belong using camera \nor photos on your gallery.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal

                  ),
                ),
              ),
              SizedBox(
                width: 135,
                height: 50,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second'); // Navigate to the SecondScreen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(66, 103, 178, 1),
                  ),
                  child: const Text('Get Started',
                      style: TextStyle(
                          color: Colors.white,//Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/