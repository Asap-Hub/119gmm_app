import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/model/zakatModel.dart';

class payZakat extends StatefulWidget {
  const payZakat({Key? key}) : super(key: key);

  @override
  _payZakatState createState() => _payZakatState();
}

class _payZakatState extends State<payZakat> {
  final zakatNumber = TextEditingController();
  final payerName = TextEditingController();
  final payerNumber = TextEditingController();
  final amount = TextEditingController();
  final zakatID = TextEditingController();
  final tranID = TextEditingController();
  double Height = 10.0;
  double cardHeight = 10.0;

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
    final data = FirebaseDatabase.instance.reference().child('payZakat');
    print(user);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Pay Zakat".toUpperCase()),
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
                    width: double.infinity,
                    child: Card(
                      color: Colors.green,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("""Kindly Adhere to the Instructions -:)""", style: TextStyle(fontSize: 17, color: Colors.white),)),
                    ),),),
                  SizedBox(height: 5,),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("MTN Mobile Number:",
                              style: TextStyle(fontSize: 16)),
                          Text(" 0555857384", style: TextStyle(fontSize: 16)),
                          Divider(
                            color: Colors.green,
                            thickness: 1.5,
                          ),
                          Text("MoMo Name: Ghana Muslim Mission",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vodacash Number:",
                              style: TextStyle(fontSize: 16)),
                          Text(
                            "0509705450",
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(
                            color: Colors.green,
                            thickness: 1.5,
                          ),
                          Text("Vodacash Name: Ghana Muslim Mission",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Kindly enter the exact number chosen for payment in the box bellow", style: TextStyle(fontSize: 15)),
                    ),),
                  ),
                  SizedBox(height: 5.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: zakatNumber,
                      decoration: InputDecoration(
                        label: Text(
                          "Zakat Number",
                          style: TextStyle(fontSize: 20),
                        ),
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (zakatNumber.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                  ),
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
                        if (payerNumber.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
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
                        if (payerNumber.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
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
                        if (amount.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(child: Card(
                          elevation: 2.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("""Kindly tap on the clipboard icon to copy Unique zakatId and use it for payment.""", style: TextStyle(fontSize: 15),),
                          ),),),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: user!.uid))
                                .then((value) {
                              Fluttertoast.showToast(msg: "Copied to Clipboard");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child:  Wrap(children: [
                                  Text(
                                    '${user!.uid}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                              Icon(Icons.copy_outlined)
                                ]),

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: zakatID,
                      decoration: InputDecoration(
                        label: Text("Zakat ID"),
                        prefixIcon: Icon(Icons.print),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (zakatID.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Minimize the app and make payment and Use your transaction ID to fill the next TextField", style: TextStyle(fontSize: 15)),
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: tranID,
                      decoration: InputDecoration(
                        label: Text("Transaction ID"),
                        prefixIcon: Icon(Icons.payment_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (tranID.value.text.isEmpty) {
                          return ("Required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (allKey.currentState!.validate() &&
                            zakatID.value.text == user!.uid ) {
                          payZakat();
                          Navigator.pop(context);
                        }
                      },
                      child: Text("SUBMIT"))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void payZakat() async {
    try {
      if (zakatNumber.value.text.trim() == "0555857384" ||
          zakatNumber.value.text.trim() == "0509705450") {
        postReportToFireStore();
        Fluttertoast.showToast(
            msg:
                "Payment Submitted Successful, Admin will review it soon. Thank you.");
      } else if (zakatNumber.value.text.trim() != "0555857384" ||
          zakatNumber.value.text.trim() != "0509705450") {
        Fluttertoast.showToast(
            msg: "Kindly input correct Zakat Account Number.");
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }

  postReportToFireStore() async {
    //calling firestore
    //calling user model
    //sending data to the server
    User? user = _auth.currentUser;
    zakatModel model = zakatModel();
    final db = realtimeDb.reference().child("Zakat").child(user!.uid).child("myZakat");
    //writing values to the FirebaseStore
    model.uid = user.uid;
    model.zakatNumber = zakatNumber.text.trim();
    model.payerName = payerName.text.trim();
    model.payerNumber = payerNumber.text.trim();
    model.amount = amount.text.trim();
    model.zakatID = zakatID.text.trim();
    model.tranID = tranID.text.trim();
    model.status = status;
    model.time = DateTime.now().toString();

    db.push().set(model.toMap()).asStream();
  }
}
