import 'package:firebase_auth/firebase_auth.dart';
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
  //FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
   final data  = FirebaseDatabase.instance.reference().child("Report").child(user!.uid).child("MyReports");
   print(user);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => addReport()));
          },
          child: Image.asset('assets/feedback.png'),
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
    return Card(
      shadowColor: Colors.green,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(10.0, 10.0),
              bottomRight: Radius.elliptical(10.0, 10.0),

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
            color: Colors.green,
          ),
          height: MediaQuery.of(context).size.height / 2.15,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'Name: ${reportData['fullName']}',
                    style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'Email: ${reportData['email']}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'Contact: ${reportData['contact']}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
                  child: Text(
                    'Message: ${reportData['message']}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Container(
                  color: Color(0xFF5d9671),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Wrap(
                        children:[ Text(
                          'Created At: ${reportData['time']}',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
    );
  }
}
