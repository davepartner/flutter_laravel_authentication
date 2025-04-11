// ck ment: This screen lets user input their email and requests an OTP from Laravel API

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _loading = false;

  // ck ment: Sends email to backend and handles response
  void _submitEmail() async {
    setState(() {
      _loading = true;
    });

    String email = _emailController.text.trim();

    // ck ment: Call the Laravel API via ApiService
    String result = await ApiService.requestOtp(email);

    setState(() {
      _loading = false;
    });

    if (result == 'otp_sent') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP has been sent to your email '+result)),
      );

      // ck ment: Navigate to OTP entry page with email passed as argument
      Navigator.pushNamed(context, '/otp', arguments: email);
    } else if (result == 'not_found') {
      //Add message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email not found in our database. Please register first.. ' + result,
          ),
        ),
      );

      Navigator.pushNamed(context, '/register', arguments: email);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Try again. ' + result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with Email')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _submitEmail,
                  child: Text('Request OTP'),
                ),
          ],
        ),
      ),
    );
  }
}
