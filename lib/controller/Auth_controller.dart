import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/userModel.dart';
import '../screen/emailVerification.dart';
import '../screen/landingPage.dart';
import '../view/progressBar.dart';

  class userController  {

  // firebase authentication
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFireStore = FirebaseFirestore.instance.collection("Users");
  UserModel logInUser = UserModel();
  final FirebaseAuth Auth = FirebaseAuth.instance;

  final defaultUserLogo = "https://firebasestorage.googleapis.com/v0/b/gmmapp-76672.appspot.com/o/gmm_logo.png?alt=media&token=f3a08baf-b534-4546-962f-316b065205aa";



  final formKey = GlobalKey<FormState>();

  TextEditingController Rest = TextEditingController();

    //Login Function
    void signIn(BuildContext context, String email, String password) async {
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context){
      //       return progressBar(message: "Please Wait...");
      //     }
      // );
      try {
          await Auth
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

    // logout Function
    Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => landingPage()));
  }
    //reset password func
    Future<void> resetPassword(BuildContext context, TextEditingController email) async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ));
      try {
        await Auth.sendPasswordResetEmail(email: email.text.trim())
            .timeout(Duration(seconds: 10));
        Fluttertoast.showToast(msg: "Password Reset Email Sent");
        Navigator.of(context).popUntil((route) => route.isFirst);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landingPage()));
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: (e.message!));
        Navigator.of(context).pop();
      } on SocketException catch(e){
        Fluttertoast.showToast(msg: e.message);
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
    Future pickAndUploadFile()async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(preferredCameraDevice: CameraDevice.rear, source: ImageSource.gallery,imageQuality: 50, maxWidth: 150);
    if(image != null){
      var snapshot = await firebaseStorage.ref().child(user!.uid).child('image/imageName').putFile(File(image.path.toString())).storage;
      var downloadUrl = await snapshot.ref().child(user!.uid).child('image/imageName').getDownloadURL();
      //
      FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
      await firebaseStore.collection("Users").doc(logInUser.uid).update({
        "url": downloadUrl,
      });
    }
    else {
      Fluttertoast.showToast(msg: "No Image Path Received");
    }

  }
}

