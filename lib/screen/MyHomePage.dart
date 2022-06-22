import 'package:flutter/material.dart';
import 'package:gmm_app/screen/dues.dart';
import 'package:gmm_app/screen/infag.dart';
import 'package:gmm_app/screen/landingPage.dart';
import 'package:gmm_app/screen/report.dart';

import 'home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("GMM APP"),
          elevation: 0.3,
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
                label: "DUES",
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
            padding: EdgeInsets.zero,
            children: [
              // PhysicalModel(
              //   color: Colors.green,
              //   elevation: 1.2,
              //   child: Container(
              //     height: 100,
              //     child: DrawerHeader(
              //         decoration: BoxDecoration(color: Colors.green),
              //         child: Center(child: Text("Drawer Header",style: TextStyle(fontSize: 18),))),
              //   ),
              // ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        trailing: (Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.red,
                        )),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 2.0,
                thickness: 1.0,
              ),
              ListTile(
                title: Text("Profile"),
                onTap: () {
                  print("AM pressed");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 500.0, left: 90.0),
                child: ListTile(
                  title: Text(
                    "SIGN OUT",
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.green,
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => landingPage()));
                  },
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ListTile(
                  title: Text(
                    "v.1.0.0",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
        body: Screen.elementAt(selectedItem),
      ),
    );
  }

  List<Widget> Screen = <Widget>[home(),infag(), dues(), report()];
}
