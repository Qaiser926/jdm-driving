import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jdm_driving/firebase_authentication/cardDetail/carDetail.dart';
import 'package:jdm_driving/firebase_authentication/loginForm.dart';
import 'package:jdm_driving/firebase_authentication/registrationForm.dart';
import 'package:jdm_driving/theme/reusableColor.dart';
import 'package:jdm_driving/theme/reusableTextStyle.dart';

class CarDetailPage extends StatefulWidget {
  static const id='cardetialpage';
  @override
  State<CarDetailPage> createState() => _LoginFormState();
}

class _LoginFormState extends State<CarDetailPage> {
  // const CarDetailPage({Key? key}) : super(key: key);
  final formkey=GlobalKey<FormState>();
  bool? _isCheck=false;
  TextEditingController carModelController=TextEditingController();
  TextEditingController carColorController=TextEditingController();
  TextEditingController carNumberController=TextEditingController();

  List<String> carTypeList=['ubar-x','ubar-go','bike'];
  String? selected;
  var gender=0;

  saveCardInfo(){
    Map driverMap={
      'car_name':carNumberController.text.trim(),
      'car_model':carModelController.text.trim(),
      'car_number':carNumberController.text.trim(),
      'type':selected,
    };
    DatabaseReference databaseReference=FirebaseDatabase.instance.ref().child('Driver');
    databaseReference.child(currentFirebaseUser!.uid).child('car_detail').set(driverMap);

  }

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
                      _CustomReusableTextField(hint: 'Car Model',lable: 'Car Model',contrler: carModelController),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(hint: 'Car Number',lable: 'Car Number',contrler: carNumberController,),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                      _CustomReusableTextField(hint: 'Car Color',lable: 'Car Color',contrler: carColorController,),
                      SizedBox(height: MediaQuery.of(context).size.height*0.025,),


                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      DropdownButton(
                          borderRadius: BorderRadius.circular(20),
                          // dropdownColor: Colors.,
                          hint: Center(child: Text('Choose Car Type',style: TextStyle(fontSize: 18),)),
                          value: selected,
                          onChanged: (newValue){
                            setState(() {
                              selected=newValue.toString();
                            });

                          },
                          items: carTypeList.map((car){
                            return DropdownMenuItem(
                              child: Text(car),
                              value: car,
                            );
                          } ).toList()
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                              child: FloatingActionButton(
                                splashColor: Colors.white,
                                backgroundColor: JColor.mainColor,
                                onPressed: (){
                                  if(formkey.currentState!.validate()){
                                    saveCardInfo();
                                    Navigator.pushNamed(context, LoginForm.id);
                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('good you are right')));
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Any thing enter you , you not enter any thing')));
                                  }
                                },child: Icon(Icons.arrow_forward_outlined,size: 25,),),
                            ),
                          ],
                        ),
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
          Text('CAR DETAIL',style:GoogleFonts.adamina(textStyle:  JTextStyle.mainheadingStyle1,)),
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
