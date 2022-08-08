import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmm_app/screen/infag.dart';
import 'package:gmm_app/screen/payInfaq.dart';
import 'package:gmm_app/screen/report.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    Container(
                      width: MediaQuery.of(context).size.width/1,
                      child: Card(
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
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1,
                      child: Card(
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
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1,
                      child: Card(
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
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("FEATURES",style: TextStyle(fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> payInfaq())),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text("INFAQ"),
                              leading: Image.asset(
                                  'assets/Charity.png', height: 50, width: 50,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: GestureDetector(
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>addReport())),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text("REPORT"),
                              leading: Image.asset(
                                'assets/pencil.png',height: 70, width: 70,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: GestureDetector(
                    onTap: ()async{
                        final url = 'http:/ghanamuslimmission.com/';
                        openBrowserURL(url: url, inApp: true);
                        Fluttertoast.showToast(msg: "Please Wait...");

                    },
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text("ABOUT US"),
                              leading: Image.asset(
                                'assets/about.png',height: 70, width: 70,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
}
