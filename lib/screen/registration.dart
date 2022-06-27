import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:gmm_app/data/fellowship.dart';
import 'package:gmm_app/data/region.dart';
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

  //marital text editing controller

  //global keys
  final credentialFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();
  final maritalFormKey = GlobalKey<FormState>();

//calculating age
  DateTime datePicker = DateTime.now();
  int age = 0;

  // Data
  String reg = "";
  bool isChosen = true;
  String Districts = "";
  String branches = "";
  String group = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Regions;
    fellowship;
    reg = Regions["region"]![0];
    Districts = Regions[reg]![0];
    branches = Regions[Districts]![0];
    //fellowship data
    group = fellowship["groups"]![0];
  }

  @override
  Widget build(BuildContext context) {
    print(dateOfBirth);
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
        body: Stepper(
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
              print("connected to the server");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => landingPage()));
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
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text("Credentials"),
          isActive: currentStep >= 0,
          content: Form(
            key: credentialFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
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
                      )),
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
                      )),
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
                      )),
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
                      )),
                ),
                Divider(color: Colors.black,thickness: 1.0),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text("PERSONAL"),
          isActive: currentStep >= 1,
          content: Form(
            key: personalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
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
                      )),
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
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
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
                            value: reg,
                            onChanged: (value) {
                              setState(() {
                                reg = value!;
                                isChosen = true;
                                Districts = Regions[reg]!.first;
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
                              value: Districts,
                              onChanged: (value) {
                                setState(() {
                                  Districts = value!;
                                  isChosen = true;
                                  branches = Regions[Districts]!.first;
                                });
                              },
                              items: Regions[reg]
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
                              items: Regions[Districts]
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
                Divider(color: Colors.black,thickness: 1.0,),
              ],
            ),
          ),
        ),
        Step(
          title: Text("Marital Status"),
          isActive: currentStep >= 2,
          content: Form(
            key: maritalFormKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
                  child: TextFormField(
                      controller: otherName,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        prefixIcon: Icon(Icons.password_outlined),
                        prefixIconColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
                Divider(color: Colors.black,thickness: 1.0),
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
          firstDate: DateTime(2019, 8),
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
}
