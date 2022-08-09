import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/screen/passwordRest.dart';
import 'package:gmm_app/screen/registration.dart';
import 'package:gmm_app/widget/progressBar.dart';

import 'emailVerification.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                        child: Text(
                          "GHANA MUSLIM MISSION",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/gmm_logo.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: email,
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
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a Valid Email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            label: Text("Password"),
                            prefixIcon: Icon(Icons.password_outlined),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regexp = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is Required");
                            }
                            if (!regexp.hasMatch(value)) {
                              return ("Enter a valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            password.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      //login button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                               Fluttertoast.showToast(msg: "Please Wait...");
                                // Center(child: Container(
                                //     height: 50,
                                //     width: 50,
                                //     child: Card(child: CircularProgressIndicator(color: Colors.green,))));
                                signIn(email.text.trim(), password.text.trim());
                              },
                              child: Text("LOGIN",
                                  style: TextStyle(fontSize: 20))),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => registration()));
                              },
                              child: Text("SIGN UP",
                                  style: TextStyle(fontSize: 20))),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => passwordReset()));
                          },
                          child: Text("Forgot Password",
                              style: TextStyle(fontSize: 18)))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Login Function
  void signIn(String email, String password) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context){
    //       return progressBar(message: "Please Wait...");
    //     }
    // );
    try {
      if (formKey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return progressBar(message: "Please Wait...");
                      }),
                  Fluttertoast.showToast(msg: "Login Successful", fontSize: 16),
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => emailVerification()),
        (route) => route.isFirst),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message, fontSize: 16);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "User Not Found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Enter Correct Password");
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.message);
    }
  }
}
