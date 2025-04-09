// ck ment: This screen allows the user to register using email and phone number

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _registering = false;

  // ck ment: Calls the Laravel register endpoint
  void _registerUser() async {
    setState(() {
      _registering = true;
    });

    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String result = await ApiService.register(email, phone);

    setState(() {
      _registering = false;
    });

    if (result == 'registered') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Now login.')),
      );
      Navigator.pushNamed(context, '/');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registration failed.')));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ck ment: Fill the email field with prefilled email from login page
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Account')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone (with country code)',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            _registering
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _registerUser,
                  child: Text('Register'),
                ),
          ],
        ),
      ),
    );
  }
}
