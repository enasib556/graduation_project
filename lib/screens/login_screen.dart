import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  bool _isLoading = false;
  String? _generatedOTP;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void _checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = preferences.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
      if (result != null) {
        String firstName = result.displayName!.split(" ")[0];
        String lastName = result.displayName!.split(" ")[1];
        _saveLoginState();
        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'firstName': firstName, 'lastName': lastName});
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<void> _saveLoginState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isLoggedIn', true);
  }

  void _generateOTP() {
    setState(() {
      _generatedOTP = (Random().nextInt(9000) + 1000).toString();
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your OTP"),
        content: Text(_generatedOTP!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _verifyOTP() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      if (otpController.text == _generatedOTP) {
        _saveLoginState();
        Navigator.pushReplacementNamed(context, '/home', arguments: {'phoneNumber': phoneController.text});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect OTP")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222421),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 20),
              child: Row(
                children: [
                  Text("Sports",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  Text(
                    "APP",
                    style: TextStyle(
                        color: Color(0xff6ABE66),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Welcome everyone!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: phoneController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff71CB6A))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff71CB6A)),
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.phone, color: Colors.white),
                  hintText: "Phone Number",
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color(0xff313830),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: otpController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff71CB6A)),
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff71CB6A)),
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  hintText: "OTP Number",
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color(0xff313830),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: _generateOTP,
                    child: Text("Generate OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 230,
                  height: 50,
                  child: _isLoading
                      ? CircleAvatar(
                          backgroundColor: Color(0xff222421),
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            backgroundColor: Color(0xff6ABE66),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _verifyOTP,
                          child: Text("Verify OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: 230,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Color(0xff6ABE66),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _googleSignIn,
                    child: Text("Google Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

