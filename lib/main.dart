import 'package:agripedia/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'NavigationBar.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';

Future<void> main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    Future.delayed(Duration(seconds: 5)).then((value) => {
      FlutterNativeSplash.remove()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 245, 245, 1),
      body: SafeArea( // SafeArea yung visible part ng screen.
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child:  Column(
            children: [
              const SizedBox(height: 25,),
               const Align(
                alignment: Alignment.center,
                child: Text(
                  'Identify art paintings \non which style category \nthey belong using camera \nor photos on your gallery.\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 1)
                  ),
                ),
              ),
          SizedBox(
            width: 135,
            height: 50,
            child:ElevatedButton(
                onPressed: () {
                      Navigator.pushNamed(context, '/second');
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(247, 179, 24, 1),
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
