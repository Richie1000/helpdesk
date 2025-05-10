import 'package:flutter/material.dart';

import '../screens/forget_password_screen.dart';

class LoginForm extends StatefulWidget {
  final bool isDesktop;
  final void Function(String email, String password) onSubmit;

  const LoginForm({Key? key, required this.isDesktop, required this.onSubmit})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      widget.onSubmit(email, password); // pass values here
    }
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment:
        isDesktop ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          if (isDesktop)
            Text(
              'Log into W2S TICK',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: isDesktop ? 'Email Address' : 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 8 : 30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isDesktop ? null : Colors.white.withOpacity(0.8),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) =>
            value!.isEmpty ? 'Please enter your email/username' : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 8 : 30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: isDesktop ? null : Colors.white.withOpacity(0.8),
              prefixIcon: Icon(Icons.lock),
            ),
            validator: (value) =>
            value!.isEmpty ? 'Please enter your password' : null,
          ),
          SizedBox(height: 16),
          if (isDesktop)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Checkbox(value: false, onChanged: (_) {}),
                  Text('Remember me'),
                ]),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),

              ],
            )
          else
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ForgotPasswordScreen()));
              },
              child: Text('Forgot Password?',
                  style: TextStyle(color: Colors.white70)),
            ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isDesktop ? 8 : 30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 0 : 50,
                vertical: 16,
              ),
            ),
            child: Text(isDesktop ? 'Sign In' : 'Get Started'),
          ),
          TextButton(
            onPressed: () => widget.onSubmit(_emailController.text.trim(), _passwordController.text),
            child: Text(
              'Don\'t have an account? REQUEST AN ACCOUNT',
              style: TextStyle(color: isDesktop ? Colors.black : Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}
