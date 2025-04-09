// ck ment: This screen allows the user to enter the OTP they received via email

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  late String _email;
  bool _verifying = false;

  // ck ment: Verifies OTP with the Laravel backend
  void _verifyOtp() async {
    setState(() {
      _verifying = true;
    });

    String otp = _otpController.text.trim();
    String result = await ApiService.verifyOtp(_email, otp);

    setState(() {
      _verifying = false;
    });

    if (result == 'verified') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login successful! Welcome.')));

      // You can navigate to a dashboard or home page here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid or expired OTP. Try again.')),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ck ment: Retrieve email passed from login screen
    _email = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Enter the 6-digit OTP sent to $_email'),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _verifying
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _verifyOtp,
                  child: Text('Verify OTP'),
                ),
          ],
        ),
      ),
    );
  }
}
