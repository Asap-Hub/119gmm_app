import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/screen/registration.dart';
import 'package:gmm_app/widget/progressBar.dart';

import 'MyHomePage.dart';

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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {},
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
    if (formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
      showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
      return progressBar(message: "Please Wait...");
      }
      ),
                Fluttertoast.showToast(msg: "Login Successful", fontSize: 16),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message, fontSize: 16);
      }).timeout(Duration(seconds: 5));
    }
  }
}
