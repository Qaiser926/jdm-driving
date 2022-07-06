import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  static const id='hometabpage';
  // const HomeTabPage({Key? key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text('Home page'),
      )),
    );
  }
}
