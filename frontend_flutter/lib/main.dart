// ck ment: This is the main entry point of the Flutter app. It defines the navigation routes.

import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/otp_page.dart';
import 'pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ck ment: Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/otp': (context) => OtpPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
