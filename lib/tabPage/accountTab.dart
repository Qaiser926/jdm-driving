import 'package:flutter/material.dart';

class AccountTabPage extends StatefulWidget {
  // const AccountTabPage({Key? key}) : super(key: key);

  @override
  _AccountTabPageState createState() => _AccountTabPageState();
}

class _AccountTabPageState extends State<AccountTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        child: Text('Account page'),
      )),
    );
  }
}
