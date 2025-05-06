import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import '../service/auth_service.dart';

/// --- EVENTS ---

abstract class AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String adminToken;

  RegisterUserEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.adminToken,
  });
}

class SignInUserEvent extends AuthEvent {
  final String email;
  final String password;

  SignInUserEvent({required this.email, required this.password});
}

class SignOutUserEvent extends AuthEvent {}

/// --- STATES ---

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final LoggedUser user;
  AuthSuccessState(this.user);
}

class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState(this.message);
}

/// --- BLOC ---

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitialState()) {
    on<RegisterUserEvent>(_onRegister);
    on<SignInUserEvent>(_onSignIn);
    on<SignOutUserEvent>(_onSignOut);
  }

  Future<void> _onRegister(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await authService.register(
        email: event.email,
        password: event.password,
        name: event.name,
        adminToken: event.adminToken,
      );
      emit(AuthSuccessState(user));
    } catch (e) {
      emit(AuthFailureState(e.toString()));
    }
  }

  Future<void> _onSignIn(SignInUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final user = await authService.signInWithEmailPassword(event.email, event.password);
    if (user != null) {
      emit(AuthSuccessState(user));
    } else {
      emit(AuthFailureState('Sign-in failed. Please check your credentials.'));
    }
  }

  Future<void> _onSignOut(SignOutUserEvent event, Emitter<AuthState> emit) async {
    await authService.signOut();
    emit(AuthInitialState());
  }
}
