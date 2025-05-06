import 'package:flutter/material.dart';
import 'login_form.dart';

class MobileLoginLayout extends StatelessWidget {
  final void Function(String email, String password) onSubmit;

  const MobileLoginLayout({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFff6e7f), Color(0xFFbfe9ff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Spacer(),
          Image.asset('assets/images/we2stars.png', height: 100),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LoginForm(isDesktop: false, onSubmit: onSubmit),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
