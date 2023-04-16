import 'package:flutter/material.dart';

import 'dart:async';
import '../screen/landingPage.dart';

showProgress(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext Content) {
         Future.delayed(Duration(seconds: 2), () {
          // Dismiss the dialog
           //Navigator.of(context).pop();
        });
        return Dialog(
          backgroundColor: Color(0xFFFFFFFF),
          child: Container(
            margin: EdgeInsets.all(18.0),
            width: double.infinity,
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

ErrorPrompted(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext Content) {
        var timer = Future.delayed(Duration(seconds: 2), () {
          // Dismiss the dialog
          //Navigator.of(context).pop();
        });
        return Dialog(
          backgroundColor: Color(0xFFFFFFFF),
          child: Container(
            margin: EdgeInsets.all(18.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                SizedBox(width: 6.0),
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

showException(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext Content) {
        var timer = Future.delayed(Duration(seconds: 2), () {
          // Dismiss the dialog
          //Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber,
                  color: Colors.red,
                ),
                SizedBox(width: 10,),
                Text("Error Message"),
              ],
            ),
          ),
          actions:[
            Column(
              children: [

                SizedBox(width: 6.0),
                Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Okay", style: TextStyle(fontSize: 18),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),)
              ],
            ),
          ]
        );
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
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      } ,
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () =>Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => landingPage())),
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
