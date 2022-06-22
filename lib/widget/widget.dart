import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

