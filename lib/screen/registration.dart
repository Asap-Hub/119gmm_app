import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/data/otherData.dart';
import 'package:gmm_app/data/region.dart';
import 'package:gmm_app/data/userModel.dart';
import 'package:gmm_app/widget/progressBar.dart';
import 'package:intl/intl.dart';

import 'landingPage.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  int currentStep = 0;
  final formKey = GlobalKey<FormState>();

  //credentials text editing controller
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController number = TextEditingController();

  //personal text editing controller
  TextEditingController firstName = TextEditingController();
  TextEditingController otherName = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController homeTown = TextEditingController();
  TextEditingController residentialAddress = TextEditingController();
  String region = "";
  bool isChosen = true;
  String district = "";
  String branches = "";
  String group = "";

  //marital text editing controller
  TextEditingController profession = TextEditingController();
  TextEditingController numberOfDependent = TextEditingController();
  TextEditingController nameOfMuslimChildren = TextEditingController();
  TextEditingController nameOfNonMuslimChildren = TextEditingController();
  TextEditingController numberOfWive = TextEditingController();
  TextEditingController numberOfMaleChildren = TextEditingController();
  TextEditingController numberOfFemalChildren = TextEditingController();
  String maritalStatus = "";

  //global keys
  final credentialFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();
  final maritalFormKey = GlobalKey<FormState>();

//calculating age
  DateTime datePicker = DateTime.now();
  int age = 0;

  // firebase authentication
  final FirebaseAuth _auth  = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Regions;
    fellowship;
    region = Regions["region"]![0];
    district = Regions[region]![0];
    branches = Regions[district]![0];
    //fellowship data
    group = fellowship["groups"]![0];
    //marital status
    status;
    maritalStatus = status["marital"]![0];
  }

  @override
  Widget build(BuildContext context) {
    //print(dateOfBirth.text.trim());
    // print(branches);
    // print(group);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          centerTitle: true,
          title: Text("REGISTRATION"),
        ),
        body: Center(
          child: Stepper(
            elevation: 1.0,
            steps: getSteps(),
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                if(!email.text.trim().contains("@")){
                  Fluttertoast.showToast(msg: "Invalid Email");
                }
                else if(password.text.trim() != confirmPassword.text.trim()){
                  Fluttertoast.showToast(msg: "Password Mismatched");
                }
                else{
                  signUp(email.text.trim().toString(), password.text.trim().toString());
                  //Fluttertoast.showToast(msg: "Email Added Successfully");
                  print("am here");
                }

              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() {
              currentStep -= 1;
            }),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            isLastStep ? "SUBMIT" : "NEXT",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: Text(
                              "BACK",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text("LOGS",style: TextStyle(fontSize: 14)),
          isActive: currentStep >= 0,
          content: Form(
            key: credentialFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: email,
                      decoration: InputDecoration(
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  validator: (value){
                        if(email.text.isEmpty){
Fluttertoast.showToast(msg: "Required");
                        }
                  },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      controller: password,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  validator: (value){
                        if(password.text.isEmpty){
                          Fluttertoast.showToast(msg: "Required");
                        }
                  },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      controller: confirmPassword,
                      decoration: InputDecoration(
                        label: Text("Confirm Password"),
                        prefixIcon: Icon(Icons.vpn_key_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    validator: (value){
                      if(confirmPassword.text.isEmpty){
                        Fluttertoast.showToast(msg: "Required");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: number,
                      decoration: InputDecoration(
                        label: Text("Contact"),
                        prefixIcon: Icon(Icons.phone_sharp),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    validator: (value){
                      if(number.text.trim().length > 10){
                        Fluttertoast.showToast(msg: "Phone number can not be more than 10");
                      }
                    },),
                ),
                Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text("PERSONAL",style: TextStyle(fontSize: 14)),
          isActive: currentStep >= 1,
          content: Form(
            key: personalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: firstName,
                      decoration: InputDecoration(
                        label: Text("First Name"),
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    validator: (value){
                      if(firstName.text.isEmpty){
                        Fluttertoast.showToast(msg: "Required");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: otherName,
                      decoration: InputDecoration(
                        label: Text("Other Name"),
                        prefixIcon:
                            Icon(Icons.drive_file_rename_outline_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    validator: (value){
                      if(otherName.text.isEmpty){
                        Fluttertoast.showToast(msg: "required");
                      }
                    },),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                          validator: (value){
                            if(dateOfBirth.text.isEmpty){
                              Fluttertoast.showToast(msg: "required");
                            }
                          },
                          textInputAction: TextInputAction.next,
                          controller: dateOfBirth,
                          onChanged: (value) {
                            setState(() {
                              value = dateOfBirth.text.toString();
                            });
                          },
                          onSaved: (value) {
                            value = dateOfBirth.text.toString();
                          },
                          decoration: InputDecoration(
                            label: Text("Date Of Birth"),
                            prefixIcon: Icon(Icons.date_range_outlined),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Select Your Region",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(124, 252, 0, 0.57),
                                blurRadius: 0.1)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            hint: Text("select region"),
                            borderRadius: BorderRadius.circular(20),
                            isExpanded: true,
                            elevation: 20,
                            value: region,
                            onChanged: (value) {
                              setState(() {
                                region = value!;
                                isChosen = true;
                                district = Regions[region]!.first;
                              });
                            },
                            items: Regions["region"]
                                ?.map(
                                  (e) => DropdownMenuItem<String>(
                                      child: Text(e), value: e),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isChosen)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Select Your District",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(124, 252, 0, 0.57),
                                  blurRadius: 0.1)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: district,
                              onChanged: (value) {
                                setState(() {
                                  district = value!;
                                  isChosen = true;
                                  branches = Regions[district]!.first;
                                });
                              },
                              items: Regions[region]
                                  ?.map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isChosen)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Select Your Branch",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(124, 252, 0, 0.57),
                                  blurRadius: 0.1)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              value: branches,
                              isExpanded: true,
                              items: Regions[district]
                                  ?.map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  branches = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      validator: (value){
                        if(homeTown.text.isEmpty){
                          Fluttertoast.showToast(msg: "Required");
                        }
                      },
                      textInputAction: TextInputAction.next,
                      controller: homeTown,
                      decoration: InputDecoration(
                        label: Text("Home Town"),
                        prefixIcon: Icon(Icons.home_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      validator: (value){
                        if(residentialAddress.text.isEmpty){
                          Fluttertoast.showToast(msg: "required");
                        }
                      },
                      textInputAction: TextInputAction.done,
                      controller: residentialAddress,
                      decoration: InputDecoration(
                        label: Text("Residential Address"),
                        prefixIcon: Icon(Icons.gps_fixed_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                    child: Column(
                      children: [
                        Text("Select Your Fellowship",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(124, 252, 0, 0.57),
                                  blurRadius: 0.1)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownButton<String>(
                              value: group,
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  group = value!;
                                });
                              },
                              items: fellowship["groups"]
                                  ?.map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    )),
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        ),
        Step(
          title: Text("STATUS",style: TextStyle(fontSize: 14),),
          isActive: currentStep >= 2,
          content: Form(
            key: maritalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                      validator: (value){
                        if(profession.text.isEmpty){
                          Fluttertoast.showToast(msg: "Required");
                        }
                      },
                      controller: profession,
                      decoration: InputDecoration(
                        label: Text("Profession"),
                        prefixIcon: Icon(Icons.password_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      validator: (value){
                        if(numberOfDependent.text.isEmpty){
                          Fluttertoast.showToast(msg: "Required");
                        }
                      },
                      controller: numberOfDependent,
                      decoration: InputDecoration(
                        label: Text("No. Of Dependent"),
                        prefixIcon: Icon(Icons.password_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text("Marital Status", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black38, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(124, 252, 0, 0.57),
                                blurRadius: 0.1)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: maritalStatus,
                            onChanged: (value) {
                              setState(() {
                                maritalStatus = value!;
                              });
                            },
                            items: status["marital"]
                                ?.map((e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                maritalStatus == "Single"
                    ? Center(
                        child: Text(""),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 10),
                              child: SizedBox(
                                width: 200,
                                child: TextFormField(
                                    validator: (value){
                                      if(numberOfWive.text.isEmpty){
                                        Fluttertoast.showToast(msg: "Required");
                                      }
                                    },
                                    controller: numberOfWive,
                                    decoration: InputDecoration(
                                      label: Text("No. Of Wives"),
                                      prefixIcon:
                                          Icon(Icons.pregnant_woman_outlined),
                                      prefixIconColor: Colors.black,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No. Of Children",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 5),
                                  Flex(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                            validator: (value){
                                              if(numberOfMaleChildren.text.isEmpty){
                                                Fluttertoast.showToast(msg: "Required");
                                              }
                                            },
                                            controller: numberOfMaleChildren,
                                            decoration: InputDecoration(
                                              label: Text("No. Of Males"),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                            controller: numberOfFemalChildren,
                                            decoration: InputDecoration(
                                              label: Text("No. Of Females"),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 20),
                              child: TextFormField(
                                  validator: (value){
                                    if(nameOfMuslimChildren.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Required");
                                    }
                                  },
                                  controller: nameOfMuslimChildren,
                                  decoration: InputDecoration(
                                    label: Text("Name Of Muslims Children"),
                                    prefixIcon:
                                        Icon(Icons.drive_file_rename_outline),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 20),
                              child: TextFormField(
                                  validator: (value){
                                    if(nameOfNonMuslimChildren.text.isEmpty){
                                      Fluttertoast.showToast(msg: "Required");
                                    }
                                  },
                                  controller: nameOfNonMuslimChildren,
                                  decoration: InputDecoration(
                                    label: Text("Name Of Non Muslim"),
                                    prefixIcon:
                                        Icon(Icons.drive_file_rename_outline),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
        )
      ];

  //for selection date
  selectDate(BuildContext context) async {
    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          dateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    } else {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(2019, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          dateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    }
  }

  void signUp(String email, String password)async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressBar(message: "Please Wait...");
        }
    );
    if(credentialFormKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailsToFireStore(),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  postDetailsToFireStore() async{
//calling firestore
  //calling user model
    //sending data to the server
    FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    //writing values to the FirebaseStore
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.number = number.text.trim();
    userModel.firstName = firstName.text.trim();
    userModel.secondName = otherName.text.trim();
    userModel.dateOfBirth = dateOfBirth.text.trim();
    userModel.region =region.trim();
    userModel.district = district.trim();
    userModel.branches = branches.trim();
    userModel.homeTown = homeTown.text.trim();
    userModel.residentialAddress = residentialAddress.text.trim();
    userModel.group = group.trim();
    userModel.profession = profession.text.trim();
    userModel.numberOfDependent = numberOfDependent.text.trim();
    userModel.maritalStatus =maritalStatus.trim().toLowerCase();
    userModel.numberOfWive = numberOfWive.text.trim();
    userModel.numberOfMaleChildren = numberOfMaleChildren.text.trim();
    userModel.numberOfFemaleChildren = numberOfFemalChildren.text.trim();
    userModel.nameOfMuslimChildren = nameOfMuslimChildren.text.trim();
    userModel.nameOfNonMuslimChildren = nameOfNonMuslimChildren.text.trim();

await firebaseStore.collection("Users").doc(user.uid).set(userModel.toMap()).timeout(Duration(seconds: 5));
Fluttertoast.showToast(msg: "Account Created Successfully");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => landingPage()), (route) =>false);

  }
}
