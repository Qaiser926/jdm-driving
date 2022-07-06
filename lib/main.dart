// import 'package:flutter/material.dart';
// import 'package:jdm_driving/firebase_authentication/loginForm.dart';
// import 'package:jdm_driving/firebase_authentication/registrationForm.dart';
// import 'package:jdm_driving/homePage.dart';
// import 'package:jdm_driving/theme/reusableColor.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'JDM Driving',
//       theme: ThemeData(
//         useMaterial3: true,
//         primarySwatch: Colors.blue,
//       ),
//       // home: MyHomePage(),
//       home: LoginForm(),
//       debugShowCheckedModeBanner: false,
//       routes: {
//         MyHomePage.id:(context)=>MyHomePage(),
//         LoginForm.id:(context)=>LoginForm(),
//         RegistrationForm.id:(context)=>RegistrationForm(),
//       },
//     );
//
//   }
//
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jdm_driving/firebase_authentication/cardDetail/carDetail.dart';
import 'package:jdm_driving/firebase_authentication/loginForm.dart';
import 'package:jdm_driving/firebase_authentication/registrationForm.dart';
import 'package:jdm_driving/homePage.dart';
import 'package:jdm_driving/splashScreen.dart';
import 'package:jdm_driving/tabPage/homeTab.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
  jdmHome(
    child:MaterialApp(
      title: 'JDM Driving',
    theme: ThemeData(
      useMaterial3: true,
    ),
   home: SplashScreen(),
    debugShowCheckedModeBanner: false,
      routes: {
        MainPage.id:(context)=>MainPage(),
        LoginForm.id:(context)=>LoginForm(),
        RegistrationForm.id:(context)=>RegistrationForm(),
        CarDetailPage.id:(context) => CarDetailPage(),
        HomeTabPage.id:(context)=>HomeTabPage(),
        SplashScreen.id:(context)=>SplashScreen(),
      },
  )
  )
  );
}

class jdmHome extends StatefulWidget {
  final Widget? child;

  jdmHome({this.child});

  static void restartApp(
      BuildContext context
      ){
    context.findAncestorStateOfType<_jdmHomeState>()!.restartApp();
  }

  @override
  State<jdmHome> createState() => _jdmHomeState();
}

class _jdmHomeState extends State<jdmHome> {
  Key key=UniqueKey();
  void restartApp(){
    setState(() {
      key=UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    // return Container();
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

