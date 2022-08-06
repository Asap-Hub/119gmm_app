import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gmm_app/screen/payInfaq.dart';

class infag extends StatefulWidget {
  const infag({Key? key}) : super(key: key);

  @override
  _infagState createState() => _infagState();
}

class _infagState extends State<infag> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    final data = FirebaseDatabase.instance.reference();
    final dataDetails = data.child('payInfaq');
    setState(() {
      isLoading = true;
    });
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(automaticallyImplyLeading: false,),
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
        child: isLoading != true
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
      ),

    ));
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
                'userId: ${reportData['uuid']}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                'Infaq Number: ${reportData['infaqNumber']}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Payer Name: ${reportData['payerName']}',
                style: TextStyle(fontSize: 18),
              ),
              Divider(
                color: Colors.grey,
                height: 5.0,
              ),
              Text(
                'Payer Number: ${reportData['payerNumber']}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Reference ID: ${reportData['refId']}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Status: ${reportData['status']}',
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
