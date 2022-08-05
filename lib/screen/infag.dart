import 'package:flutter/material.dart';
import 'package:gmm_app/screen/payInfaq.dart';

class infag extends StatefulWidget {
  const infag({Key? key}) : super(key: key);

  @override
  _infagState createState() => _infagState();
}

class _infagState extends State<infag> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(automaticallyImplyLeading: false,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset('assets/Charity.png', height: 50, width: 50),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => payInfaq()));
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Card(
                elevation: 2.0,
                child: ListTile(
                  title: Text("PAY INFAQ"),
                  leading: Image.asset('assets/Charity.png',
                      height: 100, width: 100),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.green,
            thickness: 1.0,
          ),
          Card(
            margin: EdgeInsets.all(5.0),
            child: Text("INFAQ PAYMENT RECORDS"),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 10,
            child: Card(
                elevation: 2.0,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text("PAY INFAG"),
                      leading: Image.asset('assets/Charity.png',
                          height: 100, width: 100),
                    ),
                    ListTile(
                      title: Text("PAY INFAG"),
                      leading: Image.asset('assets/Charity.png',
                          height: 100, width: 100),
                    ),
                    ListTile(
                      title: Text("PAY INFAG"),
                      leading: Image.asset('assets/Charity.png',
                          height: 100, width: 100),
                    ),
                  ],
                )),
          ),
        ],
      ),
    ));
  }
}
