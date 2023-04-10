import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/screen/payInfaq.dart';
import 'package:gmm_app/screen/payZakat.dart';

import '../controller/constant.dart';

class zakat extends StatefulWidget {
  const zakat({Key? key}) : super(key: key);

  @override
  _zakatState createState() => _zakatState();
}

class _zakatState extends State<zakat> {
 // User? user = FirebaseAuth.instance.currentUser;
  final helpUser = userController();
  @override
  Widget build(BuildContext context) {
    final data = helpUser.realtimeDb.ref().child('Zakat').child(helpUser.user!.uid).child("myZakat");
    return SafeArea(
        child: Scaffold(
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/zakat.png', height: 50, width: 50),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => payZakat()));
        },
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          defaultChild: Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
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
    ));
  }

  Widget listItem({required Map reportData}) {
    return Flex(
      direction: Axis.horizontal,
      children:[
        Expanded(
          child: Card(
            shadowColor: Colors.green,
            //elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(10.0, 10.0),
                    topLeft: Radius.elliptical(10.0, 10.0),
                    topRight: Radius.elliptical(10.0, 10.0),
                    bottomRight: Radius.elliptical(10.0, 10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(10.0, 10.0),
                        topRight: Radius.elliptical(10.0, 10.0)),
                    color: Colors.green,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: edgeInsetOnly,
                      child: Row(
                        children: [
                          Text(
                            'Zakat NO: ${reportData['zakatNumber']}',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Status: ${reportData['status']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Name: ${reportData['payerName']}'.toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Amount:${reportData['amount']}'.toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Payer Number: ${reportData['payerNumber']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Ref.ID: ${reportData['transactionID']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Zakat ID:${reportData['zakatID']}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFF5d9671),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: ListTile(
                        title: Text(
                          'Created At: ${helpUser.user?.metadata.creationTime}',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}
