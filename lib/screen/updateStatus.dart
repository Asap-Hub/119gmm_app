import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmm_app/data/otherData.dart';
import 'package:gmm_app/model/userModel.dart';
import 'package:gmm_app/utils/progressBar.dart';
import 'package:intl/intl.dart';

import '../controller/Auth_controller.dart';
import '../controller/constant.dart';

class updateStatus extends StatefulWidget {
  const updateStatus({Key? key}) : super(key: key);

  @override
  _updateStatusState createState() => _updateStatusState();
}

class _updateStatusState extends State<updateStatus> {
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
  String maritalStatus = "";
  String level = "";
  String employeeStatus = "";

  //student at tertiary
  TextEditingController startingYear = TextEditingController();
  TextEditingController completingYear = TextEditingController();
  TextEditingController nameOfTertiary = TextEditingController();
  TextEditingController locationOfCampus = TextEditingController();
  TextEditingController addressOfCampus = TextEditingController();
  TextEditingController programme = TextEditingController();
  TextEditingController department = TextEditingController();

  //formkey for maritalStatus
  final maritalFormKey = GlobalKey<FormState>();
  bool value = false;

  //calculating age
  DateTime datePicker = DateTime.now();
  int age = 0;

  final helpUser = userController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maritalStatus = status["marital"]![0];
    levels;
    level = levels["level"]![0];
    eduStatus;
    employeeStatus = eduStatus["status"]![0];
    //getting user data to display
    helpUser.FirebaseFireStore.doc(helpUser.user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.helpUser.logInUser = UserModel.fromMap(value.data());
      });
    });
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
    });
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        title: Text("UPDATE STATUS"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 8, right: 5),
          child: Form(
            key: maritalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
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
                            //sub-column
                            Column(
                              children: [
                        Text("Name Of Tertiary: ${helpUser.logInUser.nameOfTertiary} ", style: textFontSize),
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
                                        label: Text("Name Of Tertiary",style: textFontSize),
                                        prefixIcon: Icon(Icons.school),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text("Name Of Tertiary: ${helpUser.logInUser.startingYear} ", style: textFontSize),
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
                                            label: Text("Started Year",style: textFontSize),
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
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text("Name Of Tertiary: ${helpUser.logInUser.completingYear} ", style: textFontSize),
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
                                            label: Text("Yeah To Complete", style: textFontSize),
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
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              children: [
                                Text("Location: ${helpUser.logInUser.locationOfCampus} ", style: textFontSize),
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
                                        label: Text("Location Of Campus", style: textFontSize),
                                        prefixIcon:
                                        Icon(Icons.add_location_alt_outlined),
                                        prefixIconColor: Colors.green,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text("Address: ${helpUser.logInUser.addressOfCampus} ", style: textFontSize),
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
                                        label: Text("Address Of Campus", style: textFontSize),
                                        prefixIcon: Icon(Icons.gps_fixed_rounded),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text("Programme: ${helpUser.logInUser.programme} ", style: textFontSize),
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
                                        label: Text("Name Of programme", style: textFontSize),
                                        prefixIcon:
                                        Icon(Icons.account_balance_rounded),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Text("Department: ${helpUser.logInUser.department} ", style: textFontSize),
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
                                        label: Text("Name Of Department", style: textFontSize),
                                        prefixIcon: Icon(Icons.workspaces_outline),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ),
                              ],
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
                                            fontSize: 16,
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
                                        Text("Employee Status: ${helpUser.logInUser.liveAfterSchool} ", style: textFontSize),
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
                            )
                          ],
                        ),
                      )
                    : level == "Primary School"
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            child: Column(
                              children: [
                                Text("Primary School: ${helpUser.logInUser.nameOfPrimarySchool} ", style: textFontSize),
                                TextFormField(
                                    validator: (value) {
                                      if (nameOfPrimarySchool.text.isEmpty) {
                                        return ("Required");
                                      }
                                    },
                                    controller: nameOfPrimarySchool,
                                    decoration: InputDecoration(
                                      label: Text("Name Of Primary School", style: textFontSize),
                                      prefixIcon: Icon(Icons.school),
                                      prefixIconColor: Colors.black,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        : level == "Junior High School"
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                child: Column(
                                  children: [
                                    Text("Junior High School: ${helpUser.logInUser.nameOfJuniorHighSchool} ", style: textFontSize),
                                    TextFormField(
                                        validator: (value) {
                                          if (nameOfJunior.text.isEmpty) {
                                            return ("Required");
                                          }
                                        },
                                        controller: nameOfJunior,
                                        decoration: InputDecoration(
                                          label: Text("Name Of Junior High School", style: textFontSize),
                                          prefixIcon: Icon(Icons.school),
                                          prefixIconColor: Colors.black,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : level == "Senior High School"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 1),
                                    child: Column(
                                      children: [
                                        Text("Senior High School: ${helpUser.logInUser.nameOfSeniorHighSchool} ", style: textFontSize),
                                        TextFormField(
                                            validator: (value) {
                                              if (nameOfSeniorSchool.text.isEmpty) {
                                                return ("Required");
                                              }
                                            },
                                            controller: nameOfSeniorSchool,
                                            decoration: InputDecoration(
                                              label: Text(
                                                  "Name Of Senior High School", style: textFontSize),
                                              prefixIcon:
                                                  Icon(Icons.school_outlined),
                                              prefixIconColor: Colors.black,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            )),
                                      ],
                                    ),
                                  )
                                : Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 1),
                                        child: Column(
                                          children: [
                                            Text("profession: ${helpUser.logInUser.profession} ", style: textFontSize),
                                            TextFormField(
                                                validator: (value) {
                                                  if (profession.text.isEmpty) {
                                                    return ("Required");
                                                  }
                                                },
                                                controller: profession,
                                                decoration: InputDecoration(
                                                  label: Text("Profession", style: textFontSize),
                                                  prefixIcon: Icon(Icons.work),
                                                  prefixIconColor: Colors.black,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: Column(
                    children: [
                      Text("No. Of Dependent: ${helpUser.logInUser.numberOfDependent} ", style: textFontSize),
                      TextFormField(
                          validator: (value) {
                            if (numberOfDependent.text.isEmpty) {
                              return ("Required");
                            }
                          },
                          controller: numberOfDependent,
                          decoration: InputDecoration(
                            label: Text("No. Of Dependent", style: textFontSize),
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
                      Text(
                        "Marital Status: ${helpUser.logInUser.maritalStatus} ", style: textFontSize
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
                                child: Column(
                                  children: [
                                    Text(
                                      "No. Of Wive: ${helpUser.logInUser.numberOfWive}", style: textFontSize
                                    ),
                                    TextFormField(
                                        validator: (value) {
                                          if (numberOfWive.text.isEmpty) {
                                            return ("Required");
                                          }
                                        },
                                        controller: numberOfWive,
                                        decoration: InputDecoration(
                                          label: Text("No. Of Wives", style: textFontSize),
                                          prefixIcon: Icon(
                                              Icons.pregnant_woman_outlined),
                                          prefixIconColor: Colors.black,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No. Of Children", style: textFontSize),
                                  SizedBox(height: 5),
                                  Flex(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Text(
                                              "No. Of Males: ${helpUser.logInUser.numberOfMaleChildren}", style: textFontSize
                                            ),
                                            TextFormField(
                                                validator: (value) {
                                                  if (numberOfMaleChildren
                                                      .text.isEmpty) {
                                                    return ("Required");
                                                  }
                                                },
                                                controller:
                                                    numberOfMaleChildren,
                                                decoration: InputDecoration(
                                                  label: Text("No. Of Males", style: textFontSize),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Text(
                                              "No. Of Females: ${helpUser.logInUser.numberOfFemaleChildren}", style: textFontSize
                                            ),
                                            TextFormField(
                                                controller:
                                                    numberOfFemaleChildren,
                                                decoration: InputDecoration(
                                                  label: Text("No. Of Females", style: textFontSize),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 20),
                              child: Column(
                                children: [
                                  Wrap(
                                    children:[
                                      Text(
                                        "Name Of Muslims: ${helpUser.logInUser.nameOfMuslimChildren}", style: textFontSize
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                      validator: (value) {
                                        if (nameOfMuslimChildren.text.isEmpty) {
                                          return ("Required");
                                        }
                                      },
                                      controller: nameOfMuslimChildren,
                                      decoration: InputDecoration(
                                        label: Text("Name Of Muslims Children", style: textFontSize),
                                        prefixIcon: Icon(
                                            Icons.drive_file_rename_outline),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 20),
                              child: Column(
                                children: [
                                  Wrap(
                                    children:[
                                      Text(
                                        "Name Of Non-Muslims: ${helpUser.logInUser.nameOfNonMuslimChildren}", style: textFontSize
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                      validator: (value) {
                                        if (nameOfNonMuslimChildren.text.isEmpty) {
                                          return ("Required");
                                        }
                                      },
                                      controller: nameOfNonMuslimChildren,
                                      decoration: InputDecoration(
                                        label: Text("Name Of Non Muslim", style: textFontSize),
                                        prefixIcon:
                                            Icon(Icons.drive_file_rename_outline),
                                        prefixIconColor: Colors.black,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                Divider(
                  color: Colors.green,
                  thickness: 1.0,
                  endIndent: 10,
                  indent: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (maritalFormKey.currentState!.validate()) {
                        updateStat();
                        Navigator.pop(context);
                        successModal(context,"Update Status", "Updated Successfully");
                      } else {
                        showException(context, "An Error Occurred");
                      }
                    },
                    child: Text("UPDATE",style: textFontSize))
              ],
            ),
          ),
        ),
      ),
    ));
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

  void updateStat() async {
    try {
        await helpUser.FirebaseFireStore.doc(helpUser.logInUser.uid).update({
          "nameOfPrimarySchool": nameOfPrimarySchool.text.trim(),
          "nameOfJuniorHighSchool": nameOfJunior.text.trim(),
          "nameOfSeniorHighSchool": nameOfSeniorSchool.text.trim(),
          "nameOfTertiary": nameOfTertiary.text.trim(),
          "profession": profession.text.trim(),
          "numberOfDependent": numberOfDependent.text.trim(),
          "maritalStatus": maritalStatus.trim(),
          "numberOfWive": numberOfWive.text.trim(),
          "numberOfMaleChildren": numberOfMaleChildren.text.trim(),
          "numberOfFemaleChildren": numberOfFemaleChildren.text.trim(),
          "nameOfMuslimChildren": nameOfMuslimChildren.text.trim(),
          "nameOfNonMuslimChildren": nameOfNonMuslimChildren.text.trim(),
//tertiary
          "startingYear": startingYear.text.trim(),
          "completingYear": completingYear.text.trim(),
          'locationOfCampus': locationOfCampus.text.trim(),
          'addressOfCampus': addressOfCampus.text.trim(),
          'programme': programme.text.trim(),
          'department': department.text.trim(),
          'value': value,
          'liveAfterSchool': employeeStatus,
        }).catchError((error) {
          showException(context,  error!.message);
        });
      }
    on SocketException catch (e) {
      showException(context,  e.message);
    }
  }
}
