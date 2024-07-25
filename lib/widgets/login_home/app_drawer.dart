
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final VoidCallback onLogout;

  AppDrawer({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff222421), // Set the background color of the entire drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff222421), // Set the color of the header
              ),
              accountName: Text(
                firstName != null && lastName != null
                    ? '$firstName $lastName'
                    : phoneNumber ?? '',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xff6ABE66),
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
            ListTile(
              tileColor: Color(0xff222421), // Set the background color of each tile
              leading: Icon(Icons.logout, color: Colors.white), // Set icon color to white
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                onLogout();
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
