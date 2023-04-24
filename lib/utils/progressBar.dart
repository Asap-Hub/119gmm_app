import 'package:flutter/material.dart';
import 'package:gmm_app/controller/constant.dart';

import 'dart:async';
import '../screen/landingPage.dart';

showProgress(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext Content) {
        Future.delayed(Duration(seconds: 1), () {
          // Dismiss the dialog
          //Navigator.of(context).pop();
        });
        return Dialog(
          backgroundColor: Color(0xFFFFFFFF),
          child: Container(
            margin: EdgeInsets.all(18.0),
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                SizedBox(width: 6.0),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      });
}

successModal(BuildContext context,String title, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // var timer = Future.delayed(Duration(seconds: 2), () {
        //   // Dismiss the dialog
        //   //Navigator.of(context).pop();
        // });
        return AlertDialog(
          title: Center(child: Text(title.toUpperCase(), style: textFontSize,)),
          content: Flex(
            direction:Axis.horizontal,
            children:[
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ]
          ),
          backgroundColor: Color(0xFFFFFFFF),
          actions:[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Okay",
                  style: TextStyle(fontSize: 18),
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
              ),
            )
          ]
        );
      });
}

showException(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext Content) {
        return AlertDialog(
            backgroundColor: Color(0xFFFFFFFF),
            title: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Error Message", style: textFontSize,),
                ],
              ),
            ),
            actions: [
              Column(
                children: [
                  SizedBox(width: 6.0),
                  Text(
                    message,
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Okay",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                  )
                ],
              ),
            ]);
      });
}

void showAlert({
  required BuildContext context,
  required String title,
  required String message,
}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext content) {
        var timer = Future.delayed(Duration(seconds: 2), () {
          // Dismiss the dialog
          //Navigator.of(context).pop();
        });
        return Center(
          child: AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(title, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            content: Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => landingPage())),
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )),
                ],
              )
            ],
          ),
        );
      });
}
