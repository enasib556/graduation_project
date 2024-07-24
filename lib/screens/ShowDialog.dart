import 'package:flutter/material.dart';


class SportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Sport'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Football is selected
            },
            child: Text('Football'),
          ),
          ElevatedButton(
            onPressed: () {
              // Show "Coming soon" dialog for any other sport
              showComingSoonDialog(context);
            },
            child: Text('Basketball'),
          ),
          ElevatedButton(
            onPressed: () {
              // Show "Coming soon" dialog for any other sport
              showComingSoonDialog(context);
            },
            child: Text('Tennis'),
          ),
          // Add more sport options as needed
        ],
      ),
    );
  }

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
}
// decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: [0.5, 2.0],
//                     colors: [Color(0xff1F211E),
//                       Color(0xff3b672a)]),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(
//
//
//                   color: Color(0xff596456), // Change the color of the border
//                   width: 2.0, )// Set the width of the border in pixels
//             ),