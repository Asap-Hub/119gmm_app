import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/screen/payInfaq.dart';

class infag extends StatefulWidget {
  const infag({Key? key}) : super(key: key);

  @override
  _infagState createState() => _infagState();
}

class _infagState extends State<infag> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final data = FirebaseDatabase.instance.reference().child('Infaq').child(user!.uid).child("myInfaq");
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/Charity.png', height: 50, width: 50),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => payInfaq()));
        },
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
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
        ));
  }
  Widget listItem({required Map reportData}) {
    User? user = FirebaseAuth.instance.currentUser;
    return Card(
      shadowColor: Colors.green,
      //elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(10.0, 10.0),
              topLeft: Radius.elliptical(10.0, 10.0),
              topRight: Radius.elliptical(10.0, 10.0),
              bottomRight: Radius.elliptical(10.0, 10.0))),
      child: Container(
        height: MediaQuery.of(context).size.height/2.0,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(10.0, 10.0),
                    topRight: Radius.elliptical(10.0, 10.0)),
                    color: Colors.green,
                ),

                height: 50,
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          'INFAQ NO: ${reportData['infaqNumber']}',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'Status: ${reportData['status']}',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
              child: Text(
                'Name: ${reportData['payerName']}'.toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5,bottom: 5),
              child: Text(
                'Amount: ${reportData['amount']}'.toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              child: Text(
                'Payer Number: ${reportData['payerNumber']}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              child: Text(
                'REF.ID: ${reportData['refId']}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
              child: Text(
                'Infaq ID:${reportData['infaqID']}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              color: Color(0xFF5d9671),
              height: 50,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10,bottom: 10),
                  child: Text(
                    'Created At: ${user?.metadata.creationTime}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
