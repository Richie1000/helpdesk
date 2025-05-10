import 'package:flutter/material.dart';
import 'package:helpdesk/screens/home_screen.dart';
import '../widgets/desktop_login_layout.dart';
import '../widgets/mobile_login_layout.dart';
import 'home_screen_mobile.dart';
import 'home_screen_desktop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(BuildContext context, String email, String password, bool isDesktop) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(SignInUserEvent(email: email, password: password));

    // Navigate only on successful login (should be handled with BlocListener)
    // This naive navigation works only for demo purposes:
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      body: isDesktop
          ? DesktopLoginLayout(
        onSubmit: (email, password) =>
            _handleLogin(context, email, password, true),
      )
          : MobileLoginLayout(
        onSubmit: (email, password) =>
            _handleLogin(context, email, password, false),
      ),
    );
  }
}
