// auth_state.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  Authenticated({required this.user});
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

class SignUpSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
