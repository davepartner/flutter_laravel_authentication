// ck ment: This file contains functions to communicate with Laravel API

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://localhost:8001/api'; // adjust if hosted

  // ck ment: Send login request with email
  static Future<String> requestOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return 'otp_sent';
    } else if (response.statusCode == 404) {
      return 'not_found';
    } else {
      return 'error';
    }
  }

  // ck ment: Verify the entered OTP
  static Future<String> verifyOtp(String email, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    if (response.statusCode == 200) {
      return 'verified';
    } else {
      return 'invalid';
    }
  }

  // ck ment: Register new user
  static Future<String> register(String email, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'phone': phone}),
    );

    return response.statusCode == 200 ? 'registered' : 'error';
  }
}
