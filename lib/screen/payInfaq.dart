import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/controller/constant.dart';
import 'package:gmm_app/model/infaqModel.dart';
import 'package:gmm_app/utils/progressBar.dart';

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
  final infaqID = TextEditingController();
  final refId = TextEditingController();
  final tranID = TextEditingController();
  double Height = 10.0;
  double cardHeight = 20.0;

  //connecting to database
  final helpUser = userController();

  String status = "pending";

  //global key
  final allKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    width: double.infinity,
                    child: Card(
                      color: Colors.green,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          """Kindly Adhere to the Instructions -:)""",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("MTN Mobile Number:", style: textFontSize),
                          Text(" 0555857384", style: textFontSize),
                          Divider(
                            color: Colors.green,
                            thickness: 1.5,
                          ),
                          Text("MoMo Name: Ghana Muslim Mission",
                              style: textFontSize),
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
                          Text("Vodacash Number:", style: textFontSize),
                          Text("0509705450", style: textFontSize),
                          Divider(
                            color: Colors.green,
                            thickness: 1.5,
                          ),
                          Text("Vodacash Name: Ghana Muslim Mission",
                              style: textFontSize),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Kindly enter the exact number chosen for payment in the box bellow",
                            style: textFontSize),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: cardHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: infaqNumber,
                      decoration: InputDecoration(
                        label: Text("Infag Number", style: textFontSize),
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
                  SizedBox(
                    height: cardHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: payerName,
                      decoration: InputDecoration(
                        label: Text("Payer's Name", style: textFontSize),
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
                        label: Text("Payer's Number", style: textFontSize),
                        prefixIcon: Icon(Icons.dialpad),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (payerNumber.text.isEmpty) {
                          return ("Required");
                        } else if (payerNumber.text.trim().length < 10) {
                          return ("Payer's No. Can Not Be Less Than 10");
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
                        label:
                            Text("Enter Amount In Cedis", style: textFontSize),
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
                  SizedBox(
                    height: Height,
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          child: Card(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  """Kindly tap on the clipboard icon to copy Unique zakatId and use it for payment.""",
                                  style: textFontSize),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                    ClipboardData(text: helpUser.user!.uid))
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg: "Copied to Clipboard", fontSize: 16);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 5),
                            child: Wrap(children: [
                              Text(
                                '${helpUser.user!.uid}',
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
                      controller: infaqID,
                      decoration: InputDecoration(
                        label: Text("Zakat ID", style: textFontSize),
                        prefixIcon: Icon(Icons.print),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (infaqID.text.isEmpty) {
                          return ("Required");
                        } else if (infaqID.text.trim() != helpUser.user!.uid) {
                          return ("Invalid InfaqID");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Height,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Minimize the app and make payment and Use your transaction ID to fill the next TextField",
                            style: textFontSize),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: refId,
                      decoration: InputDecoration(
                        label: Text("Reference ID", style: textFontSize),
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
                  SizedBox(
                    height: Height,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (allKey.currentState!.validate() &&
                            infaqID.value.text.trim() == helpUser.user!.uid) {
                          payInfaq(context);
                        }
                      },
                      child: Text("SUBMIT", style: textFontSize))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  payInfaq(BuildContext context) async {
    try {
      if (infaqNumber.text.trim() == "0555857384" ||
          infaqNumber.text.trim() == "0509705450") {
        postReportToFireStore();
        Navigator.pop(context);
        successModal(context, "Pay Infaq",
            "Payment Submitted Successful, Admin Will Review It Soon. Thank You -:)");
      } else if (infaqNumber.text.trim() != "0555857384" ||
          infaqNumber.text.trim() != "0509705450") {
        showException(context, "Kindly Input Correct Infaq Account Number.");
      }
    } on FirebaseAuthException catch (e) {
      showException(context, e.message.toString());
    } on SocketException catch (e) {
      showException(context, e.message);
    }
  }

  postReportToFireStore() async {
//calling firestore
    //calling user model
    //sending data to the server
    User? user = helpUser.Auth.currentUser;
    infaqModel model = infaqModel();
    final db = helpUser.realtimeDb
        .ref()
        .child("Infaq")
        .child(user!.uid)
        .child("myInfaq");
    //writing values to the FirebaseStore
    model.uid = user.uid;
    model.infaqNumber = infaqNumber.text.trim();
    model.payerName = payerName.text.trim();
    model.payerNumber = payerNumber.text.trim();
    model.amount = amount.text.trim();
    model.refId = refId.text.trim();
    model.status = paymentStatus;
    model.infagID = infaqID.value.text.trim();
    model.time = DateTime.now().toString();

    db.push().set(model.toMap()).asStream();
  }
}
