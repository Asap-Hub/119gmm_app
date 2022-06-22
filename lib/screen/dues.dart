import 'package:flutter/material.dart';

class dues extends StatefulWidget {
  const dues({Key? key}) : super(key: key);

  @override
  _duesState createState() => _duesState();
}

class _duesState extends State<dues> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(child: Text("Am Paying My Dues"),),
    ));
  }
}
