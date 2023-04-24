import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/controller/constant.dart';
import 'package:gmm_app/model/reportModel.dart';
import 'package:gmm_app/utils/progressBar.dart';

class addReport extends StatefulWidget {
  const addReport({Key? key}) : super(key: key);

  @override
  _addReportState createState() => _addReportState();
}

class _addReportState extends State<addReport> {
  TextEditingController fullName = TextEditingController();
  //TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController message = TextEditingController();
  double Height = 10.0;
  double cardHeight = 20.0;
  final allKey = GlobalKey<FormState>();

  //firebase initialization
  final helpUser = userController();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //User? user = FirebaseAuth.instance.currentUser;
  //final realtimeDb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(" ADD REPORT"),
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
                    height: 50,
                    width: double.infinity,
                    child: Card(
                      shadowColor: Colors.red,
                      //elevation: 4.0,
                      child: Center(
                        child: Text(
                          """Please fill out the Form to submit your Report""",
                          style: TextStyle(fontSize: 18),
                        ),
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
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Center(
                        child: Text(
                      "${helpUser.user!.email}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
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
                      } else if (contact.text.length >= 11 || contact.text.length <10 ) {
                        return ("invalid Number, Contact can not be more than 10 or less");
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
                    maxLines: 3,
                    maxLength: 150,
                    textInputAction: TextInputAction.next,
                    controller: message,
                    decoration: InputDecoration(
                      label: Text("Message"),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (message.text.isEmpty) {
                        return ("Text cannot be empty");
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: Height,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (allKey.currentState!.validate()) {
                        sendReport(context);
                      }
                    },
                    child: Text("SUBMIT", style: textFontSize,))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void sendReport(BuildContext context) async {
    try {
      if (allKey.currentState!.validate()) {
        postReportToFireStore();
        Navigator.of(context).pop();
        successModal(
            context,
            "Report Added",
            "Report Submitted Successful, Admins will take note of it."
                " Thank you -:)");
      }
      else{
         showException(
            context,
            "Sorry Something, went wrong");
      }
    }
    on FirebaseAuthException catch(e){
      showException(
          context,
          e.message.toString());
    }
    on SocketException catch (e) {
      showException(
          context,
          e.message.toString());
    }
  }

  postReportToFireStore() async {
    //calling firestore
    //calling user model
    //sending data to the server
    reportModel model = reportModel();
    final db = helpUser.realtimeDb.ref().child("Report").child(helpUser.user!.uid).child("MyReports");
    //writing values to the FirebaseStore
    model.uid = helpUser.user!.uid;
    model.email = helpUser.user!.email;
    model.fullName = fullName.text.trim();
    model.contact = contact.text.trim();
    model.message = message.text.trim();
    model.time = DateTime.now().toString();

    db.push().set(model.toMap()).asStream();
  }
}
