import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/screen/payInfaq.dart';

import '../controller/constant.dart';

class infag extends StatefulWidget {
  const infag({Key? key}) : super(key: key);

  @override
  _infagState createState() => _infagState();
}

class _infagState extends State<infag> {
  final helpUser = userController();
  //User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Query data = helpUser.realtimeDb.ref().child('Infaq').child(helpUser.user!.uid).child("myInfaq");

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
         child:FirebaseAnimatedList(
          defaultChild:Center(
            child: CircularProgressIndicator(color: Colors.green,),),
          query: data,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {

            Map reportData = snapshot.value as Map;
            reportData["key"] = snapshot.key;

            if(!snapshot.exists ){
             return Center(
               child: Text("No Data", style: textFontSize,),
             );
            }
            else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child:listItem(reportData: reportData),
              );
            }
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
            elevation: 5.0,
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(10.0, 10.0),
                      topRight: Radius.elliptical(10.0, 10.0)),
                    color: Colors.green,
                  ),
                  height: 70,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: edgeInsetOnly,
                      child: Row(
                        children: [
                          Text(
                            'INFAQ NO: ${reportData['infaqNumber']}',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white),
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
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title:Text(
                      'Name: ${reportData['payerName']}'.toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetOnly,
                  child: ListTile(
                    title: Text(
                      'Amount: ${reportData['amount']}'.toUpperCase(),
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
                          'REF.ID: ${reportData['refId']}',
                          style: TextStyle(fontSize: 20),
                        ))
                ),
                Padding(
                    padding: edgeInsetOnly,
                    child: ListTile(
                      title: Text(
                        'Infaq ID:${reportData['infaqID']}',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
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
                            'Created At: ${helpUser.user?.metadata.creationTime?.toLocal()}',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        )
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
