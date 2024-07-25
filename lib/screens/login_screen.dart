import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project_iti/widgets/login_home/loginform.dart';
import 'package:shared_preferences/shared_preferences.dart';// استيراد الـ Widget الخاص بالنموذج
//import 'otp_section.dart'; // استيراد الـ Widget الخاص بـ OTP

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            _buildTitleSection(),
            SizedBox(height: 10),
            _buildWelcomeText(),
            SizedBox(height: 30),
            LoginForm(
              phoneController: phoneController,
              otpController: otpController,
              onGenerateOTP: _generateOTP,
              onVerifyOTP: _verifyOTP,
              isLoading: _isLoading,
            ),
            SizedBox(height: 12),
            // OTPSection(
            //   isLoading: _isLoading,
            //   onGoogleSignIn: _googleSignIn,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 200, left: 20),
      child: Row(
        children: [
          Text("Sports",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          Text(
            "APP",
            style: GoogleFonts.montserrat(
                color: Color(0xff6ABE66),
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        "Welcome everyone!",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}