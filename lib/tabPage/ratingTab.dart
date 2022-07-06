import 'package:flutter/material.dart';

class RatingTabPage extends StatefulWidget {
  // const RatingTabPage({Key? key}) : super(key: key);

  @override
  _RatingTabPageState createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text('Rating page'),
      )),
    );
  }
}
