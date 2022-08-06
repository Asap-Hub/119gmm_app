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
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final data = FirebaseDatabase.instance.reference();
    final dataDetails = data.child('report');
    setState(() {
      _isLoading = false;
    });
    //print(dataDetails);
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
            body: Container(
              height: double.infinity,
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.green,
                    ))
                  : FirebaseAnimatedList(
                      query: dataDetails,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map reportData = snapshot.value as Map;
                        reportData["key"] = snapshot.key;
                        //print(reportData['email']);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: listItem(reportData: reportData),
                        );
                      },
                    ),
            )));
  }

  Widget listItem({required Map reportData}) {
    return Card(
      shadowColor: Colors.green,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(10.0, 10.0),
              bottomRight: Radius.elliptical(10.0, 10.0))),
      child: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name: ${reportData['fullName']}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Email: ${reportData['email']}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Contact: ${reportData['contact']}',
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                color: Colors.grey,
                height: 5.0,
              ),
              Text(
                'Message: ${reportData['message']}',
                style: TextStyle(fontSize: 20),
              ),
              Divider(
                color: Colors.grey,
              ),
              Text(
                'Created At: ${reportData['time']}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
