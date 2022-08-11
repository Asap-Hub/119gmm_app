import 'package:flutter/material.dart';
class updateBranch extends StatefulWidget {
  const updateBranch({Key? key}) : super(key: key);

  @override
  _updateBranchState createState() => _updateBranchState();
}

class _updateBranchState extends State<updateBranch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("UPDATE STATUS"),
      centerTitle: true,
      ),
      body: Center(child: Text("am here"),),
    ));
  }
}
