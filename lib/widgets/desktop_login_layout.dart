import 'package:flutter/material.dart';
import 'login_form.dart';

class DesktopLoginLayout extends StatelessWidget {
  final void Function(String email, String password) onSubmit;

  const DesktopLoginLayout({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.black87,
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('W2S TICK',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Ticket Management System',
                          style: TextStyle(color: Colors.white70, fontSize: 16)),
                      SizedBox(height: 16),
                      Text(
                        'A powerful, yet easy-to-use application for managing Tickets.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: LoginForm(isDesktop: true, onSubmit: onSubmit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
