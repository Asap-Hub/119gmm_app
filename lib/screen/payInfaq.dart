import 'package:flutter/material.dart';

class payInfaq extends StatefulWidget {
  const payInfaq({Key? key}) : super(key: key);

  @override
  _payInfaqState createState() => _payInfaqState();
}

class _payInfaqState extends State<payInfaq> {
  final momoNumber = TextEditingController();
  final payerName = TextEditingController();
  final payerNumber = TextEditingController();
  final amount = TextEditingController();
  final paymentReference = TextEditingController();
  double Height = 10.0;
  double cardHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Pay Infaq"),
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("MTN Mobile Number:"),
                    Text(" 0245045867"),
                    Divider(color: Colors.red),
                    Text("MoMo Name: Asap Trading"),
                  ],),),
                ),
                SizedBox(height: cardHeight,),
                Container(
                  height: 100,
                  width: 200,
                  child: Card(
                    elevation: 2.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text("Vodacash Number:"),
                    Text(" 0205045867"),
                      Divider(color: Colors.red),
                      Text("MoMo Name: Asap Trading"),

                  ],),),
                ),
                SizedBox(height: cardHeight,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: momoNumber,
                    decoration: InputDecoration(
                      label: Text("Infag Number", style: TextStyle(fontSize: 20),),
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (momoNumber.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                SizedBox(height: cardHeight,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: payerName,
                    decoration: InputDecoration(
                      label: Text("Payer's Name"),
                      prefixIcon: Icon(Icons.drive_file_rename_outline),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (payerName.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                SizedBox(height: Height,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: payerNumber,
                    decoration: InputDecoration(
                      label: Text("Payer's Number"),
                      prefixIcon: Icon(Icons.dialpad),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (payerNumber.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                SizedBox(height: Height,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: amount,
                    decoration: InputDecoration(
                      label: Text("Enter Amount In Cedis"),
                      prefixIcon: Icon(Icons.monetization_on_outlined),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (amount.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                SizedBox(height: Height,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: paymentReference,
                    decoration: InputDecoration(
                      label: Text("Reference ID"),
                      prefixIcon: Icon(Icons.payment_outlined),
                      prefixIconColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (paymentReference.text.isEmpty) {
                        return ("Required");
                      }
                    },
                  ),
                ),
                SizedBox(height: Height,),
                ElevatedButton(onPressed: (){
                  print("am yet to submit");
                }, child: Text("SUBMIT"))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
