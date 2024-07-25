import 'package:flutter/material.dart';
import 'package:graduation_project_iti/widgets/login_home/app_drawer.dart';
import 'package:graduation_project_iti/widgets/player_screen/show_diolag.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final firstName = arguments?['firstName'];
    final lastName = arguments?['lastName'];
    final phoneNumber = arguments?['phoneNumber'];

    return Scaffold(
      backgroundColor: Color(0xff222421),
      appBar: AppBar(
        backgroundColor: Color(0xff1B1B1B),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ho",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            Text(
              "me",
              style: TextStyle(
                  color: Color(0xff6ABE66),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: AppDrawer(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        onLogout: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
      body: Center(
        child: Container(
          color: Colors.transparent,
          width: 800,
          height: 550,
          constraints: BoxConstraints(
            maxWidth: 600, // Limit the width of the GridView
            maxHeight: 600,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(18),
            childAspectRatio: 0.8, // Adjust aspect ratio to fit images and text better
            mainAxisSpacing: 40.0,
            crossAxisSpacing: 30.0,
            children: [
              _buildSportCard(context, 'Football', 'assets/images/football.jpeg'),
              _buildSportCard(context, 'Basketball', 'assets/images/basketball.jpeg'),
              _buildSportCard(context, 'Cricket', 'assets/images/cricket.jpeg'),
              _buildSportCard(context, 'Tennis', 'assets/images/tennis.jpeg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSportCard(BuildContext context, String sportName, String imagePath) {
    return Card(
      color: Color.fromARGB(255, 88, 156, 82),
      elevation: 4.0,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (sportName != 'Football') {
                showComingSoonDialog(context);
              } else {
                Navigator.pushNamed(context, '/football');
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You tapped on $sportName')),
              );
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            sportName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
