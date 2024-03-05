import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'NavigationBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';




Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await readDataToFirebase('nodemCU-board-tomato/2024-2-17/00:04:28/temp');
  runApp(const AgriPedia());
}

//Working [/] - database is connected and working but without streambuilder.

/*
Future<void> readDataToFirebase(String userNum) async {
  var logger = Logger();
  DatabaseReference user = FirebaseDatabase.instance.ref(userNum);
  try {
    user.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      logger.d("Read successfully. Data read: $data");
    });
  } catch (e) {
    logger.e("Error updating to Realtime Database: $e");
  }
}*/


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
      home: const MyWelcomePage(),
    );
  }
}


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
    Future.delayed(const Duration(seconds: 5)).then((value) => {
      FlutterNativeSplash.remove()
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      body: Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/bg-gradient.png'), fit: BoxFit.cover
          ),
        ),
          child:  Column(
            children: [
              SvgPicture.asset('assets/bg-welcome.svg', height: 580, width: 550,),
            /*  Container(
                width: 500,
                height: 530,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/bg-welcome.png'), fit: BoxFit.cover
                  ),
                ),),*/
              const Text('Monitoring Crop Growth', style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
              )),

               const SizedBox(height: 25,),
               const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 293,
                  child: Text(
                    'Effortlessly track and enhance crop growth with our advanced monitoring solutions. ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                )
              ),
          const SizedBox(height: 52.5),
          SizedBox(
            width: 191,
            height: 51,
            child:ElevatedButton(
                onPressed: () {
                      Navigator.pushNamed(context, '/second');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(247, 179, 24, 1),
                ),
            child: const Text('Continue',
                style: TextStyle(
                    color: Colors.white,//Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal
                )),
             ),
            ),
            ],
          ),
        ),
    );
  }
}
