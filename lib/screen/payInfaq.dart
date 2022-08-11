import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/model/infaqModel.dart';

class payInfaq extends StatefulWidget {
  const payInfaq({Key? key}) : super(key: key);

  @override
  _payInfaqState createState() => _payInfaqState();
}

class _payInfaqState extends State<payInfaq> {
  final infaqNumber = TextEditingController();
  final payerName = TextEditingController();
  final payerNumber = TextEditingController();
  final amount = TextEditingController();
  final refId = TextEditingController();
  double Height = 10.0;
  double cardHeight = 20.0;

  //connecting to database
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final realtimeDb = FirebaseDatabase.instance;
  String status = "pending";
  int infaqID = 100;
  //global key
  final allKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final data = FirebaseDatabase.instance.reference().child('payInfaq');
    print(user);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Pay Infaq".toUpperCase()),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Form(
        key: allKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text("MTN Mobile Number:"),
                      Text(" 0245045867"),
                      Divider(color: Colors.red),
                      Text("MoMo Name: Asap Trading"),
                    ],),),
                  ),
                  SizedBox(height: cardHeight,),
                  Container(
                    height: 100,
                    width: 200,
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,children: [
                      Text("Vodacash Number:"),
                      Text(" 0205045867"),
                        Divider(color: Colors.red),
                        Text("MoMo Name: Asap Trading"),

                    ],),),
                  ),
                  SizedBox(height: cardHeight,),
                  GestureDetector(
                    onTap: (){
                      Clipboard.setData(ClipboardData(text:user!.uid)).then((value){
                        Fluttertoast.showToast(msg: "Copied to Clipboard");
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,bottom: 5),
                      child: Row(
                        children: [
                          Text(
                            '${user!.uid}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Icon(Icons.copy_outlined)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: infaqNumber,
                      decoration: InputDecoration(
                        label: Text("Infag Number", style: TextStyle(fontSize: 20),),
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (infaqNumber.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: cardHeight,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: payerName,
                      decoration: InputDecoration(
                        label: Text("Payer's Name"),
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (payerName.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: Height,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: payerNumber,
                      decoration: InputDecoration(
                        label: Text("Payer's Number"),
                        prefixIcon: Icon(Icons.dialpad),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (payerNumber.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: Height,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: amount,
                      decoration: InputDecoration(
                        label: Text("Enter Amount In Cedis"),
                        prefixIcon: Icon(Icons.monetization_on_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (amount.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: Height,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: refId,
                      decoration: InputDecoration(
                        label: Text("Reference ID"),
                        prefixIcon: Icon(Icons.payment_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (refId.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(height: Height,),
                  ElevatedButton(onPressed: (){
                    if(allKey.currentState!.validate()){
                      payInfaq();
                      Navigator.pop(context);
                    }
                  }, child: Text("SUBMIT"))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
  void payInfaq() async {
    try {
      if (allKey.currentState!.validate()) {
        postReportToFireStore();
        Fluttertoast.showToast(
            msg:
            "Payment Submitted Successful, Admins will review it in soon. Thank you.");
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }

  postReportToFireStore() async {
//calling firestore
    //calling user model
    //sending data to the server
    FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    infaqModel model = infaqModel();
    final db = realtimeDb.reference().child("payInfaq");
    //writing values to the FirebaseStore
    model.uid = user!.uid;
    model.infaqNumber = infaqNumber.text.trim();
    model.payerName = payerName.text.trim();
    model.payerNumber = payerNumber.text.trim();
    model.amount = amount.text.trim();
    model.refId = refId.text.trim();
    model.status =status;
    model.infagID = infaqID++;
    model.time = DateTime.now().toString();

    db.push().set(model.toMap()).asStream();
  }
}
