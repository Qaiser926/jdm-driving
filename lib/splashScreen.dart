import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jdm_driving/firebase_authentication/loginForm.dart';
import 'package:jdm_driving/homePage.dart';
import 'package:jdm_driving/tabPage/homeTab.dart';
import 'package:jdm_driving/theme/reusableColor.dart';


class SplashScreen extends StatefulWidget {
  static const id='splashscreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  FirebaseAuth auth=FirebaseAuth.instance;
  User? currentFirebaseUser;
  timerClass(){
    Timer(Duration(seconds: 4), ()async{
      // Navigator.pushNamed(context, MyHomePage.id);
      if(await auth.currentUser!=null){
        currentFirebaseUser=auth.currentUser;
        Navigator.pushNamed(context, MainPage.id);
      }else {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, LoginForm.id, (route) => false);
        Navigator.pushNamed(context, LoginForm.id);
      }
      });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timerClass();
  }



  // const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(child: Image.asset('images/jdmlogo.png',
                  width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.35,)),
              SizedBox(height: MediaQuery.of(context).size.height*0.3,),
            ZoomIn(child:   SpinKitThreeInOut(
              // color: JColor.secondaryColor,
              size: MediaQuery.of(context).size.height*0.045,
              // color: Colors.blue,
              // size: 50.0,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index.isEven ? JColor.mainColor : JColor.secondaryColor,
                  ),
                );
              },

              controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            ),)

            ],
          ),
        ),
      ),
    );
  }
}
