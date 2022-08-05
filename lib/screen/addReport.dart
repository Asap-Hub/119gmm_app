import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/model/reportModel.dart';

class addReport extends StatefulWidget {
  const addReport({Key? key}) : super(key: key);

  @override
  _addReportState createState() => _addReportState();
}

class _addReportState extends State<addReport> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController message = TextEditingController();
  double Height = 10.0;
  double cardHeight = 20.0;
  final allKey = GlobalKey<FormState>();

  //firebase initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final realtimeDb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("REPORT"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: allKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    // height: cardHeight,
                    child: Card(
                  elevation: 1.0,
                  child: Text(
                    """Please fill out the Report Form""",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
                SizedBox(
                  height: cardHeight,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: fullName,
                    decoration: InputDecoration(
                      label: Text(
                        "Full Name",
                        style: TextStyle(fontSize: 20),
                      ),
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (fullName.text.isEmpty) {
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
                    controller: email,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (email.text != user?.email) {
                        // return ("Add existing email");
                        Fluttertoast.showToast(msg: "Add existing email");
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
                    controller: contact,
                    decoration: InputDecoration(
                      label: Text("Contact"),
                      prefixIcon: Icon(Icons.dialpad),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (contact.text.isEmpty) {
                        return ("Required");
                      } else if (contact.text.length >= 11) {
                        return ("invalid Number, Contact can not be more than 10");
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
                    enableSuggestions: true,
                    minLines: 3,
                    maxLines: 100,
                    textInputAction: TextInputAction.next,
                    controller: message,
                    decoration: InputDecoration(
                      label: Text("Message"),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (message.text.isEmpty) {
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
                      sendReport();
                      Navigator.of(context).pop();
                      // Navigator.of(context).popUntil((route) => false);
                    },
                    child: Text("SUBMIT"))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void sendReport() async {
    try {
      if (allKey.currentState!.validate() && email.text == user?.email) {
        postReportToFireStore();
        Fluttertoast.showToast(
            msg:
                "Report Submitted Successful, Admins will take note of it. Thank you.");
      } else if (email.text == user?.email) {
        Fluttertoast.showToast(msg: "Invalid Email");
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
    reportModel model = reportModel();
    final db = realtimeDb.reference().child("report");
    //writing values to the FirebaseStore
    model.uid = user!.uid;
    model.email = email.text.trim();
    model.fullName = fullName.text.trim();
    model.contact = contact.text.trim();
    model.message = message.text.trim();
    model.time = DateTime.now().toString();

   db.push().set(model.toMap()).asStream();

    // await firebaseStore
    //     .collection("Report")
    //     .doc(user.uid).collection("myreport").doc(user.uid)
    //     .set(model.toMap());

    //Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
