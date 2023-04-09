import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/model/userModel.dart';
import 'package:gmm_app/screen/updateBranch.dart';
import 'package:gmm_app/screen/updateStatus.dart';
import 'package:gmm_app/screen/zakat.dart';
import 'package:gmm_app/screen/infag.dart';
import 'package:gmm_app/screen/landingPage.dart';
import 'package:gmm_app/screen/report.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final helpUser =  new userController();
  final drawerKey = GlobalKey<ScaffoldState>();
  int selectedItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.helpUser.logInUser = UserModel.fromMap(value.data());
      });
    });
    helpUser.defaultUserLogo;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
          .get()
          .then((value) {
        setState(() {
          this.helpUser.logInUser = UserModel.fromMap(value.data());
        });
      });
      helpUser.logInUser.url;
    });

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
                    helpUser.logInUser.url == null ?
                    NetworkImage(helpUser.defaultUserLogo):
                    NetworkImage(helpUser.logInUser.url.toString()),
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
                          title: Text("Full Name: ${helpUser.logInUser.firstName} "
                              "${helpUser.logInUser.secondName}"),
                        ),
                        ListTile(
                          title: Text("Email: ${helpUser.logInUser.email} "),
                        ),
                        ListTile(
                          title: Text("Contact: ${helpUser.logInUser.number} "),
                        ),
                        ListTile(
                          title:
                              Text("Date Of Birth: ${helpUser.logInUser.dateOfBirth} "),
                        ),
                        ListTile(
                          title: Text(
                              "Registration Date: ${helpUser.user!.metadata.creationTime} "),
                        ),
                        ListTile(
                          title: Text(
                              "Last Visit: ${helpUser.user!.metadata.lastSignInTime}"),
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
                          title: Text("Fellowship: ${helpUser.logInUser.group} "),
                        ),
                        ListTile(
                          title: Text("Region: ${helpUser.logInUser.region} "),
                        ),
                        ListTile(
                          title: Text("District: ${helpUser.logInUser.district} "),
                        ),
                        ListTile(
                          title: Text("Branch: ${helpUser.logInUser.branches} "),
                        ),
                        ListTile(
                          title: Text("Home Town: ${helpUser.logInUser.homeTown} "),
                        ),
                        ListTile(
                          title: Text(
                              "Residential. Address: ${helpUser.logInUser.residentialAddress} "),
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
              helpUser.logInUser.maritalStatus == "Single".trim()
                  ? Card(
                      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                      shadowColor: Colors.green,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Wrap(
                          children: [
                            helpUser.logInUser.nameOfPrimarySchool != ""
                                ? ListTile(
                                    title: Text(
                                        "Primary School: ${helpUser.logInUser.nameOfPrimarySchool} "),
                                  )
                                : helpUser.logInUser.nameOfJuniorHighSchool != ""
                                    ? ListTile(
                                        title: Text(
                                            "Junior High School: ${helpUser.logInUser.nameOfJuniorHighSchool} "),
                                      )
                                    : helpUser.logInUser.nameOfSeniorHighSchool != ""
                                        ? ListTile(
                                            title: Text(
                                                "Senior High School: ${helpUser.logInUser.nameOfSeniorHighSchool} "),
                                          )
                                        : helpUser.logInUser.nameOfTertiary != ""
                                            ? Column(
                                              children: [
                                                ListTile(
                                                    title: Text(
                                                        "Tertiary: ${helpUser.logInUser.nameOfTertiary}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Started Year: ${helpUser.logInUser.startingYear}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Year To Complete: ${helpUser.logInUser.completingYear}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Location: ${helpUser.logInUser.locationOfCampus}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Address: ${helpUser.logInUser.addressOfCampus}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                SizedBox(height: 5,),
                                                ListTile(
                                                    title: Text(
                                                        "Program: ${helpUser.logInUser.programme}",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ListTile(
                                                  title: Text(
                                                      "Department: ${helpUser.logInUser.department}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                ListTile(
                                                  title: Text(
                                                      "Employee Status: ${helpUser.logInUser.liveAfterSchool}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                ],
                                            )
                                            : helpUser.logInUser.profession != ""
                                                ? ListTile(
                                                    title: Text(
                                                        "Profession: ${helpUser.logInUser.profession} "),
                                                  )
                                                : ListTile(
                                                    title:
                                                        Text("Null: Not Set "),
                                                  ),
                            ListTile(
                              title: Text(
                                  "No. Of Dependent: ${helpUser.logInUser.numberOfDependent} "),
                            ),
                            ListTile(
                              title: Text(
                                  "Marital Status: ${helpUser.logInUser.maritalStatus} "),
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
                            helpUser.logInUser.nameOfPrimarySchool != ""
                                ? ListTile(
                                    title: Text(
                                        "Primary School: ${helpUser.logInUser.nameOfPrimarySchool} "),
                                  )
                                : helpUser.logInUser.nameOfJuniorHighSchool != ""
                                    ? ListTile(
                                        title: Text(
                                            "Junior High School: ${helpUser.logInUser.nameOfJuniorHighSchool} "),
                                      )
                                    : helpUser.logInUser.nameOfSeniorHighSchool != ""
                                        ? ListTile(
                                            title: Text(
                                                "Senior High School: ${helpUser.logInUser.nameOfSeniorHighSchool} "),
                                          )
                                        : helpUser.logInUser.nameOfTertiary != ""
                                            ? ListTile(
                                                title: Text(
                                                    "Tertiary: ${helpUser.logInUser.nameOfTertiary}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    )),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Starting Date: ${helpUser.logInUser.startingYear}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Completing Year: ${helpUser.logInUser.completingYear}",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : helpUser.logInUser.profession != ""
                                                ? ListTile(
                                                    title: Text(
                                                        "Profession: ${helpUser.logInUser.profession} "),
                                                  )
                                                : ListTile(
                                                    title:
                                                        Text("Null: Not Set "),
                                                  ),
                            ListTile(
                              title: Text(
                                  "No. Of Dependent: ${helpUser.logInUser.numberOfDependent} "),
                            ),
                            ListTile(
                              title: Text(
                                  "Marital Status: ${helpUser.logInUser.maritalStatus} "),
                            ),
                            ListTile(
                              title: helpUser.logInUser.numberOfWive != ""
                                  ? Text(
                                      "No. Of Wive: ${helpUser.logInUser.numberOfWive} ")
                                  : Text("No. Of Wive: Not Set"),
                            ),
                            ListTile(
                              title: helpUser.logInUser.numberOfMaleChildren != ""
                                  ? Text(
                                      "No. Of Males: ${helpUser.logInUser.numberOfMaleChildren} ")
                                  : Text("No. Of Males: Not Set"),
                            ),
                            ListTile(
                              title: helpUser.logInUser.numberOfFemaleChildren != ""
                                  ? Text(
                                      "No. Of Females: ${helpUser.logInUser.numberOfFemaleChildren} ")
                                  : Text("No. Of Females: Not Set"),
                            ),
                            ListTile(
                              title: helpUser.logInUser.nameOfMuslimChildren != ""
                                  ? Text(
                                      "Name Of Muslims: ${helpUser.logInUser.nameOfMuslimChildren} ")
                                  : Text("Name Of Muslims: Not Set"),
                            ),
                            ListTile(
                              title: helpUser.logInUser.nameOfNonMuslimChildren != ""
                                  ? Text(
                                      "Name Of Non-Muslims: ${helpUser.logInUser.nameOfNonMuslimChildren} ")
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
    await helpUser.Auth.signOut();
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

    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(preferredCameraDevice: CameraDevice.rear, source: ImageSource.gallery,imageQuality: 50, maxWidth: 150);
    if(image != null){
      var snapshot = await helpUser.firebaseStorage.ref().child(helpUser.user!.uid).child('image/imageName').putFile(File(image.path.toString())).storage;
      var downloadUrl = await snapshot.ref().child(helpUser.user!.uid).child('image/imageName').getDownloadURL();
      //

      await helpUser.FirebaseFireStore.doc(helpUser.logInUser.uid).update({
        "url": downloadUrl,
      });
    }
    else {
      Fluttertoast.showToast(msg: "No Image Path Received");
    }

  }
}
