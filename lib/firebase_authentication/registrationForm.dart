import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdm_driving/firebase_authentication/cardDetail/carDetail.dart';
import 'package:jdm_driving/firebase_authentication/loginForm.dart';
import 'package:jdm_driving/firebase_authentication/optVerification.dart';
import 'package:jdm_driving/firebase_authentication/progressBarIndicator.dart';
import 'package:jdm_driving/firebase_authentication/registrationForm.dart';
import 'package:jdm_driving/tabPage/homeTab.dart';
import 'package:jdm_driving/theme/reusableColor.dart';
import 'package:jdm_driving/theme/reusableTextStyle.dart';
enum LoginScreen{
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FORM_WIDGET
}
User? currentFirebaseUser;
class RegistrationForm extends StatefulWidget {
  static const id='registrationform';
  @override
  State<RegistrationForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<RegistrationForm> {
  // const RegistrationForm({Key? key}) : super(key: key);
  FirebaseAuth auth=FirebaseAuth.instance;
  User? currentFirebaseUser;
  final formkey=GlobalKey<FormState>();
  bool? isCheck=false;
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController cPasswordController=TextEditingController();
  TextEditingController usernammeController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController carModelController=TextEditingController();
  TextEditingController carNumberController=TextEditingController();
  TextEditingController OtpController=TextEditingController();
  var gender=0;
  LoginScreen currentState=LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  String verificationID='';

  User? user = FirebaseAuth.instance.currentUser;
  String? phone;
  String? username;
  String? email;

  CollectionReference users=FirebaseFirestore.instance.collection('DriverData');

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async
  {

    try {
      final authCred = await auth.signInWithCredential(phoneAuthCredential);

      if(authCred.user != null)
      {

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeTabPage()));
      }
    } on FirebaseAuthException catch (e) {

      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }


  formValidate()async{
    if(phoneController.text.isEmpty){
      // ye b otp k liye kia ta niche code
      // await auth.verifyPhoneNumber(
      //
      //     phoneNumber: "+91${phoneController.text}",
      //     verificationCompleted: (phoneAuthCredential) async{
      //
      //
      //     },
      //     verificationFailed: (verificationFailed){
      //       print(verificationFailed);
      //     },
      //
      //     codeSent: (verificationID, resendingToken) async{
      //       setState(() {
      //
      //         currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
      //         this.verificationID = verificationID;
      //       });
      //     },
      //     codeAutoRetrievalTimeout: (verificationID) async{
      //
      //     }
      // );
      Fluttertoast.showToast(msg: 'Enter Phone');
    }else if(!emailController.text.contains('@')){
      Fluttertoast.showToast(msg: 'Please Enter correct email');
    }else if(phoneController.text.isEmpty){
    Fluttertoast.showToast(msg: 'Enter password');
    if(passwordController.text.length<6){
      Fluttertoast.showToast(msg: 'Your password is too week');
    }
    }else if(usernammeController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Enter username');
    }else if(cPasswordController.text!=passwordController.text){
      Fluttertoast.showToast(msg: 'Enter match password');

    }else if(carModelController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Enter Car Model');
    }else if(carNumberController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Enter Car Number');
    } else{
    saveDriverInfo();
    }
  }
  storeDataFirestore() async{
    await users.doc().set({
      'uid': user!.uid,
      'name':usernammeController.text.trim(),
      'email':emailController.text.trim(),
      'phone':phoneController.text.trim(),
      'carnumber':carNumberController.text.trim(),
      'carmodel':carModelController.text.trim()
    }).then((value) {
      Navigator.pushNamed(context, LoginForm.id);
      // ye code otp k liye kia he
      // AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: OtpController.text);
      // signInWithPhoneAuthCred(phoneAuthCredential);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVarification(phone: phoneController.text,),));
    });
  }
  saveDriverInfo() async{
    showDialog(barrierDismissible: false,context: context, builder: (v){
      return ProgressBar(message: 'Processing, Please wait . . .',);
    });
    final User? firebaseUser=(
        await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).catchError((error){
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Error'+error.toString());
    })

    ).user;
    if(firebaseUser!=null){
      currentFirebaseUser=firebaseUser;
      storeDataFirestore();
    }else{
      Fluttertoast.showToast(msg: "don't store your data");
    }
  }
  // ye niche code b otp k liye he
  // showMobilePhoneWidget(context){
  //   _CustomReusableTextField(
  //     hint: 'Phone No',lable: 'Phone No',contrler: phoneController,input: TextInputType.phone);
  // }
  // showOtpFormWidget(context){
  //   _CustomReusableTextField(
  //       hint: 'Enter OTP',lable: 'Enter OTP',contrler: OtpController,input: TextInputType.phone);
  // }

 //
 //  saveDriverInfo() async{
 //    showDialog(barrierDismissible: false,context: context, builder: (v){
 //      return ProgressBar(message: 'Processing, Please wait . . .',);
 //    });
 // final User? firebaseUser=(
 //     await auth.createUserWithEmailAndPassword(
 //         email: emailController.text.trim(),
 //         password: passwordController.text.trim()
 //     ).catchError((error){
 //       Navigator.pop(context);
 //       Fluttertoast.showToast(msg: 'Error'+error.toString());
 //     })
 //
 // ).user;
 // if(firebaseUser !=null){
 //   Map driverMap={
 //     'id':firebaseUser.uid,
 //     'username':usernammeController.text.trim(),
 //     'email':emailController.text.trim(),
 //     'phone':phoneController.text.trim(),
 //   };
 //   DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child('Driver');
 //   databaseReference.child(firebaseUser.uid).set(driverMap);
 //
 //   currentFirebaseUser=firebaseUser;
 //   Fluttertoast.showToast(msg: 'Account has been created');
 //   Navigator.pushNamed(context, CarDetailPage.id);
 //
 // }else{
 //   Navigator.pop(context);
 //   Fluttertoast.showToast(msg: "Account has not been created");
 // }
 //  }
  // TextEditingController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JColor.mainColor,

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
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      _CustomReusableTextField(hint: 'Username',lable: 'Username',contrler: usernammeController,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(

                        hint: 'Email Adress',lable: 'Email Address',contrler: emailController,),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(
                        hint: 'Phone No',lable: 'Phone No',contrler: phoneController,input: TextInputType.phone),
                     // ye niche line code otp k liye kia ta
                      // currentState==LoginScreen.SHOW_MOBILE_ENTER_WIDGET?showMobilePhoneWidget(context):showOtpFormWidget(context),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(
                          hint: 'Car Number',lable: 'Car Number',contrler: phoneController,input: TextInputType.number),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(
                          hint: 'Car Model',lable: 'Car Model',contrler: phoneController,input: TextInputType.text),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(

                        hint: 'Password',lable: 'Password',contrler: passwordController,),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(
                        hint: 'Confirm Password',lable: 'Confirm Password',contrler: cPasswordController,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Row(
                          children: [
                            Text('Gender:',style: TextStyle(fontWeight: FontWeight.w600),),
                           Row(
                             children: [
                             Radio(value: 1, groupValue: isCheck, onChanged: (value){
                               setState(() {
                                 isCheck!=value;
                               });
                             }),
                               Text('Male'),
                             ],
                           ),
                            Row(
                              children: [
                                Radio(value: 2, groupValue: isCheck, onChanged: (value){
                                  setState(() {
                                    isCheck!=value;
                                  });
                                }),
                                Text('Female'),
                              ],
                            ),
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
                                Text("I have an account ",style: TextStyle(fontSize: 14,),),
                                InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, LoginForm.id);
                                    },
                                    child: Text("LOGIN",style: TextStyle(decoration: TextDecoration.underline,fontSize: 15,fontWeight: FontWeight.w500,color: Colors.blue),)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                            child: FloatingActionButton(
                              splashColor: Colors.white,
                              backgroundColor: JColor.mainColor,
                              onPressed: (){
                                formValidate();
                                // if(formkey.currentState!.validate()){
                                //   // showDialog(barrierDismissible: true,context: context, builder: (v){
                                //   //   return ProgressBar(message: 'Processing, Please Wait . . .');
                                //   // });
                                // Navigator.pushNamed(context, CarDetailPage.id);
                                //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('good you are right')));
                                // }else{
                                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Any thing enter you , you not enter any thing')));
                                // }
                              },child: Icon(Icons.arrow_forward_outlined,size: 25,),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
          Text('SIGNUP',style:GoogleFonts.adamina(textStyle:  JTextStyle.mainheadingStyle1,)),
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
  TextInputType? input;
  // final String? Function(String?)? validate;
  TextEditingController contrler;
  // Function validate;
  _CustomReusableTextField({this.hint,required this.lable,required this.contrler,this.input});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        // validator: validate,
        keyboardType: input,
        controller: contrler,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(

          hintStyle: TextStyle(color: Colors.grey),
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
