import 'package:flutter/material.dart';
class updateStatus extends StatefulWidget {
  const updateStatus({Key? key}) : super(key: key);

  @override
  _updateStatusState createState() => _updateStatusState();
}

class _updateStatusState extends State<updateStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Form(child: SingleChildScrollView(child: Container(
        child: Text("we are here"),
      ),),),
    ));
  }
}
