import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controller/Auth_controller.dart';
import '../utils/progressBar.dart';

class passwordReset extends StatefulWidget {
  const passwordReset({Key? key}) : super(key: key);

  @override
  _passwordResetState createState() => _passwordResetState();
}

class _passwordResetState extends State<passwordReset> {
  final resetKey = GlobalKey<FormState>();
  final helpUser = userController();

  TextEditingController Rest = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    Rest.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reset Password".toUpperCase()),
          centerTitle: true,
          elevation: 0.3,
        ),
        body: Center(
          child: Form(
            key: resetKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    """Reset You Password By Entering you Signup Email"""
                        .toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:  Text("""Kindly Check Spam box, if you can't find the email in your mail Inbox""", style: TextStyle(fontSize: 16),),

                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: Rest,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      label: Text("Email"),
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      //reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a Valid Email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      Rest.text = value!;
                    },
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 20)),
                ElevatedButton.icon(
                  onPressed: () {
                    if (resetKey.currentState!.validate()) {
                      showProgress(context, "Please Wait!...");
                      helpUser.resetPassword(context,Rest);
                    }
                  },
                  label: Text(
                    "Password Reset",
                    style: TextStyle(fontSize: 16),
                  ),
                  icon: Icon(Icons.email_outlined),
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
