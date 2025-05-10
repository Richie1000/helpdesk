import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../models/user.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}


class AuthService {
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<LoggedUser> register({
    required String email,
    required String password,
    required String name,
    required String adminToken,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) throw AuthException('User creation failed.');

      await _firestore.collection('users').doc(fbUser.uid).set({
        'name': name,
        'email': email,
        'score': 0,
        'type': 'user',
        'adminToken': adminToken,
      });

      return LoggedUser(
        id: fbUser.uid.hashCode,
        name: name,
        email: email,
        score: 0,
        type: 'user',
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      throw AuthException(_firebaseErrorMessage(e.code));
    } catch (_) {
      throw AuthException("Something went wrong. Try again.");
    }
  }

  Future<LoggedUser?> signInWithEmailPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final fbUser = credential.user;
      if (fbUser == null) return null;

      final doc = await _firestore.collection('users').doc(fbUser.uid).get();
      final data = doc.data();

      return LoggedUser(
        id: fbUser.uid.hashCode,
        name: data?['name'] ?? 'Unknown',
        email: email,
        score: data?['score'] ?? 0,
        type: data?['type'] ?? '',
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _firebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return 'Authentication failed.';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on fb_auth.FirebaseAuthException catch (e) {
      throw AuthException(_firebaseErrorMessage(e.code));
    } catch (_) {
      throw AuthException('Failed to send reset email. Try again.');
    }
  }

}
