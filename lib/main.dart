import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';
import 'firebase_options.dart';
import './screens/login_screen.dart'; // A unified, responsive login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  final authService = AuthService();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>.value(value: authService),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authService),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helpdesk App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen(), // One responsive screen
    );
  }
}