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
              title: Text("Email Verification".toUpperCase()),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("""Email verification sent to ${FirebaseAuth.instance.currentUser!.email}""", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text("""Check Spam box too if you can't find the email in your mail Inbox""", style: TextStyle(fontSize: 16),),
                 ElevatedButton(onPressed: (){
                   sendVerificationEmail();
                   }, child: Text("Send Email Again", style: TextStyle(fontSize: 14),))
                  ],
                ),
              ),
            ),
          ),
        );
}
