import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MyHomePage.dart';

class emailVerification extends StatefulWidget {
  const emailVerification({Key? key}) : super(key: key);

  @override
  _emailVerificationState createState() => _emailVerificationState();
}

class _emailVerificationState extends State<emailVerification> {
  bool isEmailVerified = false;
  final Auth = FirebaseAuth.instance;
  Timer? timer;

  @override void initState() {
    isEmailVerified = Auth.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
     timer = Timer.periodic(
        Duration(seconds: 3), (_) => checkEmailVerified(),
      );
    }
    super.initState();
  }
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
Future sendVerificationEmail()async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
}

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MyHomePage()
      : SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Email Verification"),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("email verification sent to ${FirebaseAuth.instance.currentUser!.email}", style: TextStyle(fontSize: 16),),
               ElevatedButton(onPressed: (){
                 sendVerificationEmail();
               }, child: Text("Send Email Again", style: TextStyle(fontSize: 14),))
                ],
              ),
            ),
          ),
        );
// Future<void> emailVerification() async {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) => Center(
//         child: CircularProgressIndicator(
//           color: Colors.green,
//         ),
//       ));
//   try {
//     if (user != null) {
//       await user?.sendEmailVerification().timeout(Duration(seconds: 5));
//       Fluttertoast.showToast(
//           msg: "Email Verification Sent", toastLength: Toast.LENGTH_SHORT);
//       print("email it was sent");
//       //Navigator.of(context).popUntil((route) => route.isFirst);
//     }
//   } on FirebaseAuthException catch (e) {
//     Fluttertoast.showToast(msg: (e.message!), toastLength: Toast.LENGTH_LONG);
//     // Navigator.of(context).pop();
//   } on SocketException catch (e) {
//     Fluttertoast.showToast(msg: e.message);
//   }
// }
}
