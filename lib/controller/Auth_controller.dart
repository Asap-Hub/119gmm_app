import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/userModel.dart';
import '../screen/emailVerification.dart';
import '../screen/landingPage.dart';
import '../utils/progressBar.dart';

class userController {
  // firebase authentication
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFireStore = FirebaseFirestore.instance.collection("Users");

  UserModel logInUser = UserModel();
  final FirebaseAuth Auth = FirebaseAuth.instance;
  final realtimeDb = FirebaseDatabase.instance;
  FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  TextEditingController Rest = TextEditingController();

  //Login Function
  signIn(BuildContext context, String email, String password) async {
    try {
      Auth.currentUser!.emailVerified == true ? showProgress(context, "Logging In..."):
      showProgress(context, "Please Wait!...");

    await Auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => emailVerification()),
                    (route) => route.isFirst),
              })
          .catchError((e) {
        showException(context, e!.message);
        // Fluttertoast.showToast(msg: e!.message, fontSize: 16);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showException(context, "User Not Found");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Enter Correct Password");
      }
    } on SocketException catch (e) {
      showException(context, e.toString());
    }
  }

  // logout Function
  Future<void> logOut(BuildContext context) async {
    await Auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => landingPage()));
  }

  //reset password func
  Future<void> resetPassword(
      BuildContext context, TextEditingController email) async {
    showProgress(context, "Please Wait!...");
    try {
      await Auth.sendPasswordResetEmail(email: email.text.trim())
          .timeout(Duration(seconds: 6));
      showException(context, "Password Reset Email Sent");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      showException(context, e.message!);
    } on SocketException catch (e) {
      showException(context, e.message);
    }
  }

  //open browser func
  Future<void> openBrowserURL({required String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  //pick image func
  Future pickAndUploadFile() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
        preferredCameraDevice: CameraDevice.rear,
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150);
    if (image != null) {
      var snapshot = await firebaseStorage
          .ref()
          .child(user!.uid)
          .child('image/imageName')
          .putFile(File(image.path.toString()))
          .storage;
      var downloadUrl = await snapshot
          .ref()
          .child(user!.uid)
          .child('image/imageName')
          .getDownloadURL();
      //
      FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
      await firebaseStore.collection("Users").doc(logInUser.uid).update({
        "url": downloadUrl,
      });
    } else {
      Fluttertoast.showToast(msg: "No Image Path Received");
    }
  }
}
