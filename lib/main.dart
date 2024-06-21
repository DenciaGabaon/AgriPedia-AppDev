import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'NavigationBar.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'CropData.dart';
import 'CropManager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CropDataManager()),
      ],
      child: const AgriPedia(),
    ),
  );
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


class AgriPedia extends StatelessWidget {
  const AgriPedia({Key? key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigationBarState> navigationKey = GlobalKey<NavigationBarState>();

    return MaterialApp(
      title: 'AgriPedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: {
        '/second': (context) => MyNavigation(key: navigationKey),
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
    Future.delayed(const Duration(seconds: 5)).then((value) => {
      FlutterNativeSplash.remove()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg-gradient.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SvgPicture.asset('assets/bg-welcome.svg', height: 580, width: 550,),
            const Text(
              'Monitoring Crop Growth',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25,),
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 293,
                child: Text(
                  'Effortlessly track and enhance crop growth with our advanced monitoring solutions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 52.5),
            SizedBox(
              width: 191,
              height: 51,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(247, 179, 24, 1),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
