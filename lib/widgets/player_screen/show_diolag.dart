import 'package:flutter/material.dart';
void showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color:  Color(0xff96D173),
            width: 2.0,
          ),

        ),
        backgroundColor:Color(0xff364133),
        title: Center(
          child: Row(
            children: [
              Text('Coming Soon',
              style: TextStyle(
                color: Colors.white,fontSize: 30
              ),),
            ],
          ),
        ),
        content: Text('This feature is not available yet.',

        style: TextStyle(
          color: Color(0xffB3CFA7),fontSize: 25
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              width: 80,
              decoration: BoxDecoration(

                color:  Color(0xff96D173),
                borderRadius: BorderRadius.circular(30)
              ),
             
              child: Text('OK',style: TextStyle(
                color: Colors.black,fontSize: 25
              ),),
            ),
          ),
        ],
      ),
    );
  }
