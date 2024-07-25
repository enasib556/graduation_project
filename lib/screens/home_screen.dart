import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project_iti/widgets/login_home/app_drawer.dart';
import 'package:graduation_project_iti/widgets/login_home/show_diolag.dart';


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
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
            Text(
              "me",
              style: GoogleFonts.montserrat(
                  color: Color(0xff6ABE66),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
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
              _buildSportCard(context, 'Football', 'assets/images/football.jpg'),
              _buildSportCard(context, 'Basketball', 'assets/images/basketball.jpg'),
              _buildSportCard(context, 'Cricket', 'assets/images/cricket.jpg'),
              _buildSportCard(context, 'Tennis', 'assets/images/tennis.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSportCard(BuildContext context, String sportName, String imagePath) {
    return Card(
      color: Color(0xff222421),
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
          SizedBox(height: 20.0),
          Text(
            sportName,
            style: GoogleFonts.montserrat(  
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal
            ),
          ),
        ],
      ),
    );
  }
}
