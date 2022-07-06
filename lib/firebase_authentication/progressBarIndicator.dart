import 'package:flutter/material.dart';
import 'package:jdm_driving/theme/reusableColor.dart';

class ProgressBar extends StatelessWidget {
  // const ProgressBar({Key? key}) : super(key: key);

  String? message;
  ProgressBar({
   this.message
});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(5)
        // ),
        child: Row(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(JColor.mainColor),

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.025,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message.toString(),
                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
