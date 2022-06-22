import 'package:flutter/material.dart';

class infag extends StatefulWidget {
  const infag({Key? key}) : super(key: key);

  @override
  _infagState createState() => _infagState();
}

class _infagState extends State<infag> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text("AM paying Infaq"),
      ),
    ));
  }
}
