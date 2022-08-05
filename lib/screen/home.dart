import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmm_app/screen/infag.dart';
import 'package:gmm_app/screen/report.dart';

import 'addReport.dart';
import 'dues.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late Widget selectedItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // if you need this
                      ),
                      elevation: 1.0,
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Upcoming National Congregation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Image.asset(
                              'assets/gmm_logo.png',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Coming Soon",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // if you need this
                      ),
                      elevation: 1.0,
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Upcoming National Congregation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Image.asset(
                              'assets/gmm_logo.png',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Coming Soon",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // if you need this
                      ),
                      elevation: 1.0,
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Upcoming National Congregation",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Image.asset(
                              'assets/gmm_logo.png',
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              "Coming Soon",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //end of cards
            Divider(
              color: Colors.green,
              height: 1.0,
              thickness: 2.0,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height/2,
                    child: ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> addReport()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius. circular(20),),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  ListTile(
                                title: Text("Report"),
                              leading: Image.asset(
                                'assets/pencil.png',
                                color: Colors.green,
                              ),
                            )
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            /**   Navigator.push(context, MaterialPageRoute(builder: (context)=> addReport()));
                    },
                    child: Image.asset('assets/pencil.png'),backgroundColor: Colors.white,**/
          ],
        ),
      ),
    ));
  }

  List<Widget> Screen = <Widget>[home(), infag(), dues(), report()];

  void _onItemTapped(Widget index) {
    setState(() {
      selectedItem = index;
      print(selectedItem);
    });
  }
}
