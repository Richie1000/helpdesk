import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _email;
  bool _isAuthenticated = false;

  String? get email => _email;
  bool get isAuthenticated => _isAuthenticated;

  final String _loginUrl = '/api/v1/user/login';

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _email = data['email'];
      if (data['message'] == 'Login successful') {
        _isAuthenticated = true;
      }
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
      throw Exception('Failed to login');
    }
  }

  void logout() {
    _email = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
