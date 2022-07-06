import 'package:flutter/material.dart';

class OtpVarification extends StatefulWidget {
final String phone;
OtpVarification({required this.phone});

  @override
  State<OtpVarification> createState() => _OtpVarificationState();
}

class _OtpVarificationState extends State<OtpVarification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              Text('Verify: ${widget.phone}', style: TextStyle(fontSize: 20),),

            ],
          ),

        ),
      ),
    );
  }
}
