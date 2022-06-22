import 'package:flutter/material.dart';

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
  TextEditingController age = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController homeTown = TextEditingController();
  TextEditingController residentialAddress = TextEditingController();

  //marital text editing controller
  final credentialFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();
  final maritalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              margin: EdgeInsets.only(top: 50),
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
                )
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
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: dateOfBirth,
                      decoration: InputDecoration(
                        label: Text("Date Of Birth"),
                        prefixIcon: Icon(Icons.date_range_outlined),
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
                      controller: age,
                      decoration: InputDecoration(
                        label: Text("Age"),
                        prefixIcon: Icon(Icons.confirmation_num_outlined),
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
                      controller: region,
                      decoration: InputDecoration(
                        label: Text("Region"),
                        prefixIcon: Icon(Icons.vpn_lock_sharp),
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
                      controller: district,
                      decoration: InputDecoration(
                        label: Text("District"),
                        prefixIcon: Icon(Icons.map),
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
                      controller: branch,
                      decoration: InputDecoration(
                        label: Text("Branch"),
                        prefixIcon: Icon(Icons.turned_in_not_outlined),
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
              ],
            ),
          ),
        )
      ];
}
