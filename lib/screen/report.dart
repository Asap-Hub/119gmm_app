import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/screen/addReport.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  _reportState createState() => _reportState();
}

class _reportState extends State<report> {
  // firebase instance
  final helpUser = userController();
  @override
  Widget build(BuildContext context) {
   final data  = helpUser.realtimeDb.ref().child("Report").child(helpUser.user!.uid).child("MyReports");
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addReport()));
          },
          child: Image.asset('assets/feedback.png', height: 50, width: 50),
          backgroundColor: Colors.white,
        ),
        body: Container(
          height: double.infinity,
          child:FirebaseAnimatedList(
            defaultChild: Center(child: CircularProgressIndicator(color: Colors.green,),),
                  query: data,
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
        ),
      ),
    );
  }

  Widget listItem({required Map reportData}) {
    return Flex(
      direction: Axis.horizontal,
      children:[
        Expanded(
          child: Card(
            shadowColor: Colors.black,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(10.0, 10.0),
                        topLeft: Radius.elliptical(10.0, 10.0),
                        topRight: Radius.elliptical(10.0, 10.0),
                        bottomRight: Radius.elliptical(10.0, 10.0)
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(10.0, 10.0),
                    topRight: Radius.elliptical(10.0, 10.0),
                    bottomLeft: Radius.elliptical(10.0, 10.0),
                    bottomRight: Radius.elliptical(10.0, 10.0),
                  ),
                  color: Colors.white,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: Text(
                            'Name: ${reportData['fullName']}',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold,color: Colors.black
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: Text(
                            'Email: ${reportData['email']}',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: Text(
                            'Contact: ${reportData['contact']}',
                            style: TextStyle(fontSize:22, color: Colors.black),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          title: Text(
                            'Message: ${reportData['message']}',
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Container(
                        color: Colors.green,
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            child: Wrap(
                                children:[ Text(
                                  'Created At: ${reportData['time']}',
                                  style: TextStyle(fontSize: 22, color: Colors.white),
                                ),]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]
    );
  }
}
