import 'package:flutter/material.dart';
import './screens/login_screen_desktop.dart';
import './screens/login_screen_mobile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helpdesk App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLoginScreen(),
    );
  }
}

class ResponsiveLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return LoginScreenDesktop();
        } else {
          return LoginScreenMobile();
        }
      },
    );
  }
}
