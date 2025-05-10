import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../service/auth_service.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _message;



  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _message = null;
      });

      try {
        final authService = context.read<AuthService>(); // Only works if AuthService is globally provided
        await authService.sendPasswordResetEmail(_emailController.text.trim());

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Check your email for the reset link')),
          );
        }
      } catch (e) {
        setState(() {
          _message = 'Error: ${e.toString()}';
        });
      } finally {
        if (mounted) {
          setState(() => _loading = false);
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is ForgotPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Check your email for the password reset link.')),
          );
          await Future.delayed(Duration(seconds: 1));
          if (mounted) Navigator.pop(context);
        } else if (state is AuthFailureState) {
          setState(() {
            _loading = false;
            _message = state.message;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Forgot Password')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter your email to receive a reset link.'),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your email' : null,
                  ),
                  SizedBox(height: 16),
                  if (_loading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _resetPassword,
                      child: Text('Send Reset Link'),
                    ),
                  if (_message != null) ...[
                    SizedBox(height: 16),
                    Text(
                      _message!,
                      style: TextStyle(
                        color: _message!.contains('sent') ? Colors.green : Colors.red,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
