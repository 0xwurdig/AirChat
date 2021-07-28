import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcomeScreen.dart';
import 'counterState.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import './app_theme.dart';
import 'models/user.dart';
import 'size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool registered = false;
  Controller controller = Get.put(Controller());
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    // final prefs = await SharedPreferences.getInstance();
    User user = new User();

    user.name = "Miriam";
    user.seatNo = "B6";
    user.bio = "asdsadiawubdoaiwbddiawjdsbdawdwnedknawndawd";
    user.company = "AgoraIO";
    user.designation = "Intern";
    controller.add(user);
    setState(() {
      registered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Lounge',
              theme: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                primaryColor: MyTheme.kPrimaryColor,
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: WelcmScreen(),
            );
          },
        );
      },
    );
  }
}
