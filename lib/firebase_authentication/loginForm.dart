import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdm_driving/firebase_authentication/progressBarIndicator.dart';
import 'package:jdm_driving/firebase_authentication/registrationForm.dart';
import 'package:jdm_driving/splashScreen.dart';
import 'package:jdm_driving/tabPage/homeTab.dart';
import 'package:jdm_driving/theme/reusableColor.dart';
import 'package:jdm_driving/theme/reusableTextStyle.dart';

class LoginForm extends StatefulWidget {
  static const id='loginform';
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // const LoginForm({Key? key}) : super(key: key);
  final formkey=GlobalKey<FormState>();
  bool? _isCheck=false;
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;
  User? currentFirebaseUser;
  DriverLogin() async{
    showDialog(barrierDismissible: false,context: context, builder: (v){
      return ProgressBar(message: 'Processing, Please wait . . .',);
    });
    final User? firebaseUser=(
        await auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        ).catchError((error){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Error'+error.toString());
        })

    ).user;
    if(firebaseUser!=null){
      currentFirebaseUser=firebaseUser;
      Fluttertoast.showToast(msg: 'Login Succefully');
      Navigator.pushNamed(context, SplashScreen.id);
      // storeDataFirestore();
    }else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "You have not an account");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JColor.mainColor,

      // appBar: AppBar(
      //   backgroundColor: JColor.mainColor,
      //   // title: Text('JDM Driving',style: TextStyle(color: Colors.white),),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.13,
            // child:
          ),
          _header(),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.05,
            // child:
          ),
          Expanded(
            child: Form(
              key: formkey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height*0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(60),
                    topRight:Radius.circular(60),),

                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.13,),
                      // _CustomReusableTextField(hint: 'Phone No',lable: 'Phone No',contrler: phoneController),
                      _CustomReusableTextField(hint: 'Email',lable: 'Email',contrler:emailController ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      _CustomReusableTextField(hint: 'Password',lable: 'Password',contrler: passwordController,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top: 20,left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _isCheck,
                                    onChanged: (value) {
                                      setState(() {
                                        _isCheck = value;
                                      });
                                    },
                                    activeColor: JColor.mainColor,
                                    // checkColor: JColor.mainColor,
                                  ),
                                  Text(''),
                                ],
                              ),
                            ),
                            Text('Forget Password'),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("I don't have account ",style: TextStyle(fontSize: 14,),),
                                InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, RegistrationForm.id);
                                    },
                                    child: Text("SINGUP",style: TextStyle(decoration: TextDecoration.underline,fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blue),)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            child: FloatingActionButton(
                              splashColor: Colors.white,
                              backgroundColor: JColor.mainColor,
                              onPressed: (){
                                if(formkey.currentState!.validate()){
                                  DriverLogin();
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('good you are right')));
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Any thing enter you , you not enter any thing')));
                                }
                              },child: Icon(Icons.arrow_forward_outlined,size: 25,),),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
                // child: Card(
                //   child: Column(
                //     children: [
                //
                //     ],
                //   ),
                // color: Colors.white,
                // ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton:
    );
  }

  Container _header(){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text('LOGIN',style:GoogleFonts.adamina(textStyle:  JTextStyle.mainheadingStyle1,)),
          SizedBox(height: 30,),
          Text(
            'Welcome to JDM Driving',style: TextStyle(color: Colors.white,fontSize: 17),
          ),

        ],
      ),
    );
  }
}


class _CustomReusableTextField extends StatelessWidget {
  String? hint;
  String lable;
  TextEditingController contrler;
  // Function validate;
  _CustomReusableTextField({this.hint,required this.lable,required this.contrler});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "can't be empty";
          }
          return null;
        },
        controller: contrler,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          focusColor: JColor.mainColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: JColor.mainColor)
          ),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),
          ),
          hintText:hint,
          label: Text(lable),
          labelStyle: TextStyle(color: JColor.mainColor),

        ),
      ),
    );
  }
}
