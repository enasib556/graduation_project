import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController otpController;
  final VoidCallback onGenerateOTP;
  final VoidCallback onVerifyOTP;
  final bool isLoading;

  const LoginForm({
    required this.phoneController,
    required this.otpController,
    required this.onGenerateOTP,
    required this.onVerifyOTP,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPhoneNumberField(),
        SizedBox(height: 25),
        _buildOTPField(),
        SizedBox(height: 10),
        _buildGenerateOTPButton(),
        SizedBox(height: 10),
        _buildVerifyOTPButton(),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    return Container(
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
    );
  }

  Widget _buildOTPField() {
    return Container(
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
    );
  }

  Widget _buildGenerateOTPButton() {
    return Align(
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
            onPressed: onGenerateOTP,
            child: Text("Generate OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyOTPButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: 230,
          height: 50,
          child: isLoading
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
                  onPressed: onVerifyOTP,
                  child: Text("Verify OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
        ),
      ),
    );
  }
}