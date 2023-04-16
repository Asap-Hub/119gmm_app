import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/controller/Auth_controller.dart';
import 'package:gmm_app/data/otherData.dart';
import 'package:gmm_app/data/region.dart';
import 'package:gmm_app/model/userModel.dart';
import 'package:gmm_app/utils/progressBar.dart';
import 'package:intl/intl.dart';

import 'landingPage.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  _registrationState createState() => _registrationState();
}

class _registrationState extends State<registration> {
  int currentStep = 0;
  final helpUser = userController();
  List<GlobalKey<FormState>> formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  //global keys
  final StepperKey = GlobalKey<FormState>();

  //final personalFormKey = GlobalKey<FormState>();
  //final maritalFormKey = GlobalKey<FormState>();
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
  TextEditingController branches = TextEditingController();
  String region = "";
  bool isChosen = true;
  String district = "";
  String group = "";
  String typeJob = "";
  String employeeStatus = "";
  DateTime Date = DateTime.now();

  //marital status text editing controller
  TextEditingController profession = TextEditingController();
  TextEditingController nameOfPrimarySchool = TextEditingController();
  TextEditingController nameOfJunior = TextEditingController();
  TextEditingController nameOfSeniorSchool = TextEditingController();
  TextEditingController numberOfDependent = TextEditingController();
  TextEditingController nameOfMuslimChildren = TextEditingController();
  TextEditingController nameOfNonMuslimChildren = TextEditingController();
  TextEditingController numberOfWive = TextEditingController();
  TextEditingController numberOfMaleChildren = TextEditingController();
  TextEditingController numberOfFemaleChildren = TextEditingController();

  //student details
  TextEditingController startingYear = TextEditingController();
  TextEditingController completingYear = TextEditingController();
  TextEditingController nameOfTertiary = TextEditingController();
  TextEditingController locationOfCampus = TextEditingController();
  TextEditingController addressOfCampus = TextEditingController();
  TextEditingController programme = TextEditingController();
  TextEditingController department = TextEditingController();
  String maritalStatus = "";
  String level = "";

  //checkbox value
  bool value = false;

  //public type section
  TextEditingController publicDepartment = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController yearsInPosition = TextEditingController();
  TextEditingController publicAddress = TextEditingController();
  TextEditingController publicLocation = TextEditingController();

  //private type section
  TextEditingController nameOfCompany = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController privateLocation = TextEditingController();
  TextEditingController privateAddress = TextEditingController();
  TextEditingController contact = TextEditingController();

//calculating age
  DateTime datePicker = DateTime.now();
  int age = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Regions;
    fellowship;
    region = Regions["region"]![0];
    district = Regions[region]![0];
    //education status
    eduStatus;
    employeeStatus = eduStatus["status"]![0];
    //fellowship data
    group = fellowship["groups"]![0];
    //marital status
    status;
    maritalStatus = status["marital"]![0];
    //levels
    levels;
    level = levels["level"]![0];
    typeOfJob;
    typeJob = typeOfJob["worker"]![0];
  }

  @override
  Widget build(BuildContext context) {
    //print(dateOfBirth);
    // print(branches);
    // print(group);
    //print(datePicker);
    //print(age);
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
            key: StepperKey,
            elevation: 1.0,
            steps: getSteps(),
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              setState(() {
                if (formKey[currentStep].currentState!.validate() ) {
                  if (isLastStep) {
                    // currentStep = currentStep + 1;
                           signUp(email.text.trim().toString(),
                              password.text.trim().toString());
                          Fluttertoast.showToast(
                              msg: "Please Wait...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER);
                          Fluttertoast.showToast(
                              msg: "Account Created Successfully",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => landingPage()),
                              (route) => route.isFirst);
                    //  print("am here");

                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                }
              });
            },
            onStepCancel: () {
              currentStep == 0
                  ? null
                  : () => setState(() {
                        currentStep -= 1;
                      });
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: Text(
                              "BACK",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            isLastStep ? "SUBMIT" : "NEXT",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
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
          title: Text("LOGS", style: TextStyle(fontSize: 14)),
          isActive: currentStep >= 0,
          content: Form(
            key: formKey[0],
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
                    validator: (value) {
                      if (email.value.text.isEmpty) {
                        return ("Required");
                      } else if (!email.text.trim().contains("@")) {
                        return ("Valid Email");
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
                    validator: (value) {
                      if (password.value.text.isEmpty) {
                        return ("Required");
                      }
                      else if(password.text.trim().length <6){
                        return ("Min. Password: 6 characters");
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
                    validator: (value) {
                      if (confirmPassword.value.text.isEmpty) {
                        return ("Required");
                      }
                      else if(confirmPassword.text.trim().length <6){
                        return ("Min. Password: 6 characters");
                      }
                      else if (confirmPassword.value.text.trim() !=
                          password.value.text.trim()) {
                        return ("password mismatch");

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
                    validator: (value) {
                      if (number.value.text.length < 10) {
                        return ("Phone number can not be less than 10");
                      } else if (number.value.text.isEmpty) {
                        return ("please Provide a valid number");
                      }
                    },
                  ),
                ),
                Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text("PERSONAL", style: TextStyle(fontSize: 14)),
          isActive: currentStep >= 1,
          content: Form(
            key: formKey[1],
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
                    validator: (value) {
                      if (firstName.text.isEmpty) {
                        return ("Required");
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
                    validator: (value) {
                      if (otherName.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      birthDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                          validator: (value) {
                            if (dateOfBirth.text.isEmpty) {
                              return ("Required");
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
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: DecoratedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(

                         age < 15 ? "Age < 15, Are not permitted to create Account" : "Age: ${age}", style: TextStyle(fontSize: 17 ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(124, 252, 0, 0.57),
                              blurRadius: 0.1)
                        ],
                      )
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      validator: (value) {
                        if (branches.text.isEmpty) {
                          return ("Required");
                        }
                      },
                      textInputAction: TextInputAction.next,
                      controller: branches,
                      decoration: InputDecoration(
                        label: Text("Branch"),
                        prefixIcon: Icon(Icons.tour_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      validator: (value) {
                        if (homeTown.text.isEmpty) {
                          return ("Required");
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
                      validator: (value) {
                        if (residentialAddress.text.isEmpty) {
                          return ("Required");
                        }
                      },
                      textInputAction: TextInputAction.done,
                      controller: residentialAddress,
                      decoration: InputDecoration(
                        label: Text("Digital Address"),
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
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        ),
        Step(
          title: Text(
            "STATUS",
            style: TextStyle(fontSize: 14),
          ),
          isActive: currentStep >= 2,
          content: Form(
            key: formKey[2],
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text("Level", style: TextStyle(fontSize: 16)),
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
                            value: level,
                            onChanged: (value) {
                              setState(() {
                                level = value!;
                              });
                            },
                            items: levels["level"]
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
                level == "Tertiary"
                    ? Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TextFormField(
                                  validator: (value) {
                                    if (nameOfTertiary.text.isEmpty) {
                                      return ("Required");
                                    }
                                  },
                                  controller: nameOfTertiary,
                                  decoration: InputDecoration(
                                    label: Text("Name Of Tertiary"),
                                    prefixIcon: Icon(Icons.school),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TextFormField(
                                  validator: (value) {
                                    if (locationOfCampus.text.isEmpty) {
                                      return ("Required");
                                    }
                                  },
                                  controller: locationOfCampus,
                                  decoration: InputDecoration(
                                    label: Text("Location Of Campus"),
                                    prefixIcon:
                                        Icon(Icons.add_location_alt_outlined),
                                    prefixIconColor: Colors.green,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TextFormField(
                                  validator: (value) {
                                    if (addressOfCampus.text.isEmpty) {
                                      return ("Required");
                                    }
                                  },
                                  controller: addressOfCampus,
                                  decoration: InputDecoration(
                                    label: Text("Address Of Campus"),
                                    prefixIcon: Icon(Icons.gps_fixed_rounded),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TextFormField(
                                  validator: (value) {
                                    if (programme.text.isEmpty) {
                                      return ("Required");
                                    }
                                  },
                                  controller: programme,
                                  decoration: InputDecoration(
                                    label: Text("Name Of programme"),
                                    prefixIcon:
                                        Icon(Icons.account_balance_rounded),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: TextFormField(
                                  validator: (value) {
                                    if (department.text.isEmpty) {
                                      return ("Required");
                                    }
                                  },
                                  controller: department,
                                  decoration: InputDecoration(
                                    label: Text("Name Of Department"),
                                    prefixIcon: Icon(Icons.workspaces_outline),
                                    prefixIconColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: GestureDetector(
                                onTap: () {
                                  starting(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      validator: (value) {
                                        if (startingYear.text.isEmpty) {
                                          return ("Required");
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          value = startingYear.toString();
                                        });
                                      },
                                      onSaved: (value) {
                                        value = startingYear.toString();
                                      },
                                      controller: startingYear,
                                      decoration: InputDecoration(
                                        label: Text("Started Year"),
                                        prefixIcon:
                                            Icon(Icons.not_started_outlined),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 1),
                              child: GestureDetector(
                                onTap: () {
                                  completing(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                      validator: (value) {
                                        if (completingYear.text.isEmpty) {
                                          return ("Required");
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          value = completingYear.toString();
                                        });
                                      },
                                      onSaved: (value) {
                                        value = completingYear.toString();
                                      },
                                      controller: completingYear,
                                      decoration: InputDecoration(
                                        label: Text("Yeah To Complete"),
                                        prefixIcon: Icon(Icons.schedule_sharp),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Completed ?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      Checkbox(
                                        value: this.value,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.value = value!;
                                            print(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  value == true
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 20),
                                          child: Column(
                                            children: [
                                              Text("Employee Status",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              SizedBox(height: 5),
                                              DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black38,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Color.fromRGBO(
                                                            124, 252, 0, 0.57),
                                                        blurRadius: 0.1)
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: DropdownButton<String>(
                                                    value: employeeStatus,
                                                    isExpanded: true,
                                                    items: eduStatus["status"]
                                                        ?.map((e) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              child: Text(e),
                                                              value: e,
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        employeeStatus = value!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : level == "Primary School"
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            child: TextFormField(
                                validator: (value) {
                                  if (nameOfPrimarySchool.text.isEmpty) {
                                    return ("Required");
                                  }
                                },
                                controller: nameOfPrimarySchool,
                                decoration: InputDecoration(
                                  label: Text("Name Of Primary School"),
                                  prefixIcon: Icon(Icons.school),
                                  prefixIconColor: Colors.black,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )),
                          )
                        : level == "Junior High School"
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                child: TextFormField(
                                    validator: (value) {
                                      if (nameOfJunior.text.isEmpty) {
                                        return ("Required");
                                      }
                                    },
                                    controller: nameOfJunior,
                                    decoration: InputDecoration(
                                      label: Text("Name Of Junior High School"),
                                      prefixIcon: Icon(Icons.school),
                                      prefixIconColor: Colors.black,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              )
                            : level == "Senior High School"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 1),
                                    child: TextFormField(
                                        validator: (value) {
                                          if (nameOfSeniorSchool.text.isEmpty) {
                                            return ("Required");
                                          }
                                        },
                                        controller: nameOfSeniorSchool,
                                        decoration: InputDecoration(
                                          label: Text(
                                              "Name Of Senior High School"),
                                          prefixIcon:
                                              Icon(Icons.school_outlined),
                                          prefixIconColor: Colors.black,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        )),
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 20),
                                        child: Column(
                                          children: [
                                            Text("Job Type",
                                                style: TextStyle(fontSize: 16)),
                                            SizedBox(height: 5),
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black38,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          124, 252, 0, 0.57),
                                                      blurRadius: 0.1)
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: DropdownButton<String>(
                                                  value: typeJob,
                                                  isExpanded: true,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      typeJob = value!;
                                                    });
                                                  },
                                                  items: typeOfJob["worker"]
                                                      ?.map((e) =>
                                                          DropdownMenuItem<
                                                              String>(
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
                                      typeJob == "Public"
                                          ? Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (profession
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller: profession,
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text(
                                                              "Profession"),
                                                          prefixIcon:
                                                              Icon(Icons.work),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (publicDepartment
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            publicDepartment,
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text(
                                                              "Department"),
                                                          prefixIcon: Icon(Icons
                                                              .workspaces_outline),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (position
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller: position,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("position"),
                                                          prefixIcon: Icon(
                                                              Icons.height),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (yearsInPosition
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            yearsInPosition,
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text(
                                                              "Experience In Years"),
                                                          prefixIcon: Icon(Icons
                                                              .calendar_today_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (publicAddress
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            publicAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("Address"),
                                                          prefixIcon: Icon(Icons
                                                              .email_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (publicLocation
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            publicLocation,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("Location"),
                                                          prefixIcon: Icon(Icons
                                                              .gps_fixed_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (nameOfCompany
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            nameOfCompany,
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text(
                                                              "Name Of Company/ Organization"),
                                                          prefixIcon: Icon(Icons
                                                              .workspaces_outline),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (role
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller: role,
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text("Role"),
                                                          prefixIcon: Icon(Icons
                                                              .anchor_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (privateAddress
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            privateAddress,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("Address"),
                                                          prefixIcon: Icon(Icons
                                                              .email_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (privateLocation
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller:
                                                            privateLocation,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("Location"),
                                                          prefixIcon: Icon(Icons
                                                              .gps_fixed_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 1),
                                                    child: TextFormField(
                                                        validator: (value) {
                                                          if (contact
                                                              .text.isEmpty) {
                                                            return ("Required");
                                                          }
                                                        },
                                                        controller: contact,
                                                        decoration:
                                                            InputDecoration(
                                                          label:
                                                              Text("Contact"),
                                                          prefixIcon: Icon(Icons
                                                              .contact_phone_outlined),
                                                          prefixIconColor:
                                                              Colors.black,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Dependent",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextFormField(
                          validator: (value) {
                            if (numberOfDependent.text.isEmpty) {
                              return ("Required");
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
                    ],
                  ),
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
                                    validator: (value) {
                                      if (numberOfWive.text.isEmpty) {
                                        return ("Required");
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
                                            validator: (value) {
                                              if (numberOfMaleChildren
                                                  .text.isEmpty) {
                                                return ("Required");
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
                                            controller: numberOfFemaleChildren,
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
                                  validator: (value) {
                                    if (nameOfMuslimChildren.text.isEmpty) {
                                      return ("Required");
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
                                  validator: (value) {
                                    if (nameOfNonMuslimChildren.text.isEmpty) {
                                      return ("Required");
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
  birthDate(context) async {
    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          dateOfBirth.text = DateFormat('yyyy-MM-dd').format(picked);
          age = datePicker.year - picked.year;
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

//starting date
  starting(BuildContext context) async {
    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          startingYear.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    } else {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(2019, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          startingYear.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    }
  }

  //completing date
  completing(BuildContext context) async {
    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(1900, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          completingYear.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    } else {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: datePicker,
          firstDate: DateTime(2019, 8),
          lastDate: DateTime(2100));
      if (picked != null && picked != datePicker)
        setState(() {
          completingYear.text = DateFormat('yyyy-MM-dd').format(picked);
        });
    }
  }

  void signUp(String email, String password) async {
    try {
      if (formKey[currentStep].currentState!.validate()) {
      await helpUser.Auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFireStore(),
        showProgress(context, "Please Wait!..."),
              })
          .catchError((e) {
        showException(context, e!.message);
      });
    }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already') {
        showException(context, "The Account Already Exist");
      }
    } on SocketException catch (e) {
     showException(context, e.message);
    }
  }

  postDetailsToFireStore() async {
    UserModel userModel = UserModel();
    //writing values to the FirebaseStore
    userModel.email = helpUser.user!.email;
    userModel.uid = helpUser.user!.uid;
    userModel.number = number.text.trim();
    userModel.firstName = firstName.text.trim();
    userModel.secondName = otherName.text.trim();
    userModel.dateOfBirth = dateOfBirth.text.trim();
    userModel.region = region.trim();
    userModel.district = district.trim();
    userModel.branches = branches.text.trim();
    userModel.homeTown = homeTown.text.trim();
    userModel.department = department.text.trim();
    userModel.addressOfCampus = addressOfCampus.text.trim();
    userModel.locationOfCampus = locationOfCampus.text.trim();
    userModel.programme = programme.text.trim();

    userModel.residentialAddress = residentialAddress.text.trim();
    userModel.group = group.trim();
    userModel.profession = profession.text.trim();
    userModel.numberOfDependent = numberOfDependent.text.trim();
    userModel.maritalStatus = maritalStatus.trim();
    userModel.numberOfWive = numberOfWive.text.trim();
    userModel.numberOfMaleChildren = numberOfMaleChildren.text.trim();
    userModel.numberOfFemaleChildren = numberOfFemaleChildren.text.trim();
    userModel.nameOfMuslimChildren = nameOfMuslimChildren.text.trim();
    userModel.nameOfNonMuslimChildren = nameOfNonMuslimChildren.text.trim();
    userModel.nameOfPrimarySchool = nameOfPrimarySchool.text.trim();
    userModel.nameOfJuniorHighSchool = nameOfJunior.text.trim();
    userModel.nameOfSeniorHighSchool = nameOfSeniorSchool.text.trim();
    userModel.nameOfTertiary = nameOfTertiary.text.trim();
    userModel.startingYear = startingYear.text.trim();
    userModel.completingYear = completingYear.text.trim();
    userModel.url = "";
    //live after school
    userModel.value = value;
    userModel.liveAfterSchool = employeeStatus.trim();
    //job
    userModel.publicDepartment = publicDepartment.text.trim();
    userModel.position = position.text.trim();
    userModel.yearsInPosition = yearsInPosition.text.trim();
    userModel.publicAddress = publicAddress.text.trim();
    userModel.publicLocation = publicLocation.text.trim();
    userModel.nameOfCompany = nameOfCompany.text.trim();
    userModel.role = role.text.trim();
    userModel.privateLocation = privateLocation.text.trim();
    userModel.privateAddress = privateAddress.text.trim();
    userModel.contact = contact.text.trim();

    await helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
        .set(userModel.toMap());
    //Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
