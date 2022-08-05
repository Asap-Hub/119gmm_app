import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmm_app/model/reportModel.dart';
import 'package:gmm_app/screen/addReport.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  _reportState createState() => _reportState();
}

class _reportState extends State<report> {

  @override
  Widget build(BuildContext context) {
    final data = FirebaseDatabase.instance.reference().child('report');
    print(data);
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addReport()));
              },
              child: Image.asset('assets/pencil.png'),
              backgroundColor: Colors.green,
            ),
            body:
            Container(
              height: double.infinity,
              child: FirebaseAnimatedList(
                query: data,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map reportData = snapshot.value as Map;
                  reportData["key"] = snapshot.key;
                  print(reportData['email']);
                  return listItem(reportData: reportData);

                },
              ),
            )
            ));
  }

  Widget listItem({required Map reportData}){
    return Container(margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
      height: 100,
        color: Colors.grey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(reportData['email'], style: TextStyle(fontSize:
        16),)
      ],
      ),
    );

  }
}
