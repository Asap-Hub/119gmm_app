import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/model/userModel.dart';
import 'package:gmm_app/screen/updateBranch.dart';
import 'package:gmm_app/screen/updateStatus.dart';
import 'package:gmm_app/screen/zakat.dart';
import 'package:gmm_app/screen/infag.dart';
import 'package:gmm_app/screen/landingPage.dart';
import 'package:gmm_app/screen/report.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addReport.dart';
import 'home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final drawerKey = GlobalKey<ScaffoldState>();
  int selectedItem = 0;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel logInUser = UserModel();
  final defaultUserLogo = "https://firebasestorage.googleapis.com/v0/b/gmmapp-76672.appspot.com/o/gmm_logo.png?alt=media&token=f3a08baf-b534-4546-962f-316b065205aa";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.logInUser = UserModel.fromMap(value.data());
      });
    });
    defaultUserLogo;
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          this.logInUser = UserModel.fromMap(value.data());
        });
      });
      logInUser.url;
    });
    // print("default Logo: $defaultUserLogo");
    // print(logInUser.url);

    return SafeArea(
      child: Scaffold(
        key: drawerKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("GMM APP"),
          elevation: 0.3,
          leading: Builder(builder: (BuildContext Context) {
            return IconButton(
              icon: Icon(Icons.person, size: 30),
              onPressed: () {
                drawerKey.currentState?.openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          actions: [
            PopupMenuButton<Widget>(
                itemBuilder: (BuildContext Context) => [
                      PopupMenuItem(
                        onTap: () async {
                          final url = 'http:/ghanamuslimmission.com/';
                          openBrowserURL(url: url, inApp: true);
                        },
                        child: Text("ABOUT US",
                            style:
                                TextStyle(fontSize: 18, color: Colors.green)),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          logOut(context);
                        },
                        child: Text(
                          "SIGN OUT",
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                      PopupMenuItem(
                        child: Text("Version: 1.0.1",
                            style:
                                TextStyle(fontSize: 18, color: Colors.green)),
                      ),
                    ])
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            currentIndex: selectedItem,
            selectedItemColor: Colors.white,
            unselectedFontSize: 13,
            selectedFontSize: 16,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "HOME",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment_outlined),
                label: "INFAQ",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined),
                label: "ZAKAT",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report_gmailerrorred_outlined),
                label: "REPORT",
                backgroundColor: Colors.green,
              ),
            ]),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                    logInUser.url == null ?
                    NetworkImage(defaultUserLogo):
                    NetworkImage(logInUser.url.toString()),
                    radius: 50,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: IconButton(
                          onPressed: () {
                            pickAndUploadFile();
                            Fluttertoast.showToast(msg: "Kindly Pick An Image", toastLength: Toast.LENGTH_LONG );
                          },
                          icon: Icon(Icons.edit)))
                ],
              ),
              SizedBox(height: 5),
              Divider(
                color: Colors.black,
                height: 2.0,
                thickness: 1.0,
              ),
              Card(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  shadowColor: Colors.green,
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text("Full Name: ${logInUser.firstName} "
                              "${logInUser.secondName}"),
                        ),
                        ListTile(
                          title: Text("Email: ${logInUser.email} "),
                        ),
                        ListTile(
                          title: Text("Contact: ${logInUser.number} "),
                        ),
                        ListTile(
                          title:
                              Text("Date Of Birth: ${logInUser.dateOfBirth} "),
                        ),
                        ListTile(
                          title: Text(
                              "Registration Date: ${user!.metadata.creationTime} "),
                        ),
                        ListTile(
                          title: Text(
                              "Last Visit: ${user.metadata.lastSignInTime}"),
                        ),
                      ],
                    ),
                  )),
              Divider(color: Colors.green),
              Card(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                  shadowColor: Colors.green,
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text("Fellowship: ${logInUser.group} "),
                        ),
                        ListTile(
                          title: Text("Region: ${logInUser.region} "),
                        ),
                        ListTile(
                          title: Text("District: ${logInUser.district} "),
                        ),
                        ListTile(
                          title: Text("Branch: ${logInUser.branches} "),
                        ),
                        ListTile(
                          title: Text("Home Town: ${logInUser.homeTown} "),
                        ),
                        ListTile(
                          title: Text(
                              "Residential. Address: ${logInUser.residentialAddress} "),
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => updateBranch()));
                              },
                              child: Text("update")),
                        ))
                      ],
                    ),
                  )),
              Divider(color: Colors.green),
              logInUser.maritalStatus == "Single".trim()
                  ? Card(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      shadowColor: Colors.green,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          children: [
                            logInUser.nameOfPrimarySchool != ""
                                ? ListTile(
                                    title: Text(
                                        "Primary School: ${logInUser.nameOfPrimarySchool} "),
                                  )
                                : logInUser.nameOfJuniorHighSchool != ""
                                    ? ListTile(
                                        title: Text(
                                            "Junior High School: ${logInUser.nameOfJuniorHighSchool} "),
                                      )
                                    : logInUser.nameOfSeniorHighSchool != ""
                                        ? ListTile(
                                            title: Text(
                                                "Senior High School: ${logInUser.nameOfSeniorHighSchool} "),
                                          )
                                        : logInUser.nameOfTertiary != ""
                                            ? Column(
                                              children: [
                                                ListTile(
                                                    title: Text(
                                                        "Tertiary: ${logInUser.nameOfTertiary}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Started Year: ${logInUser.startingYear}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Year To Complete: ${logInUser.completingYear}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Location: ${logInUser.locationOfCampus}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Address: ${logInUser.addressOfCampus}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Program: ${logInUser.programme}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ListTile(
                                                  title: Text(
                                                      "Department: ${logInUser.department}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                ListTile(
                                                  title: Text(
                                                      "Employee Status: ${logInUser.liveAfterSchool}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                ],
                                            )
                                            : logInUser.profession != ""
                                                ? ListTile(
                                                    title: Text(
                                                        "Profession: ${logInUser.profession} "),
                                                  )
                                                : ListTile(
                                                    title:
                                                        Text("Null: Not Set "),
                                                  ),
                            ListTile(
                              title: Text(
                                  "No. Of Dependent: ${logInUser.numberOfDependent} "),
                            ),
                            ListTile(
                              title: Text(
                                  "Marital Status: ${logInUser.maritalStatus} "),
                            ),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                updateStatus()));
                                  },
                                  child: Text("update")),
                            ))
                          ],
                        ),
                      ))
                  : Card(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      shadowColor: Colors.green,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          children: [
                            logInUser.nameOfPrimarySchool != ""
                                ? ListTile(
                                    title: Text(
                                        "Primary School: ${logInUser.nameOfPrimarySchool} "),
                                  )
                                : logInUser.nameOfJuniorHighSchool != ""
                                    ? ListTile(
                                        title: Text(
                                            "Junior High School: ${logInUser.nameOfJuniorHighSchool} "),
                                      )
                                    : logInUser.nameOfSeniorHighSchool != ""
                                        ? ListTile(
                                            title: Text(
                                                "Senior High School: ${logInUser.nameOfSeniorHighSchool} "),
                                          )
                                        : logInUser.nameOfTertiary != ""
                                            ? ListTile(
                                                title: Text(
                                                    "Tertiary: ${logInUser.nameOfTertiary}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    )),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Starting Date: ${logInUser.startingYear}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Completing Year: ${logInUser.completingYear}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : logInUser.profession != ""
                                                ? ListTile(
                                                    title: Text(
                                                        "Profession: ${logInUser.profession} "),
                                                  )
                                                : ListTile(
                                                    title:
                                                        Text("Null: Not Set "),
                                                  ),
                            ListTile(
                              title: Text(
                                  "No. Of Dependent: ${logInUser.numberOfDependent} "),
                            ),
                            ListTile(
                              title: Text(
                                  "Marital Status: ${logInUser.maritalStatus} "),
                            ),
                            ListTile(
                              title: logInUser.numberOfWive != ""
                                  ? Text(
                                      "No. Of Wive: ${logInUser.numberOfWive} ")
                                  : Text("No. Of Wive: Not Set"),
                            ),
                            ListTile(
                              title: logInUser.numberOfMaleChildren != ""
                                  ? Text(
                                      "No. Of Males: ${logInUser.numberOfMaleChildren} ")
                                  : Text("No. Of Males: Not Set"),
                            ),
                            ListTile(
                              title: logInUser.numberOfFemaleChildren != ""
                                  ? Text(
                                      "No. Of Females: ${logInUser.numberOfFemaleChildren} ")
                                  : Text("No. Of Females: Not Set"),
                            ),
                            ListTile(
                              title: logInUser.nameOfMuslimChildren != ""
                                  ? Text(
                                      "Name Of Muslims: ${logInUser.nameOfMuslimChildren} ")
                                  : Text("Name Of Muslims: Not Set"),
                            ),
                            ListTile(
                              title: logInUser.nameOfNonMuslimChildren != ""
                                  ? Text(
                                      "Name Of Non-Muslims: ${logInUser.nameOfNonMuslimChildren} ")
                                  : Text("Name Of Non-Muslims: Not Set"),
                            ),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                updateStatus()));
                                  },
                                  child: Text("update")),
                            ))
                          ],
                        ),
                      )),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    logOut(context);
                  },
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Screen.elementAt(selectedItem),
      ),
    );
  }

  List<Widget> Screen = <Widget>[home(), infag(), zakat(), report()];

  void _onItemTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => landingPage()));
  }

  Future openBrowserURL({required String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
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


      // setState(() {
      //   imageUrl = downloadUrl;
      //   print("imageUrl: ${imageUrl}");
      //   print("downloadUrl: ${downloadUrl}");
      // });
    }
    else {
      Fluttertoast.showToast(msg: "No Image Path Received");
    }

  }
}
