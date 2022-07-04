import 'package:flutter/material.dart';

class progressBar extends StatelessWidget {
  late String message;
  progressBar({required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Color(0xFFFFFFFF),
        child: Container(
          margin: EdgeInsets.all(18.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 6.0),
              CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width: 30.0,),
              Text(
                message,
                style: TextStyle(color:Colors.black,fontSize: 16.0),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
