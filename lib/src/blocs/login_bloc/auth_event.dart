// auth_event.dart
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
  });
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  ResetPasswordRequested({
    required this.email,
  });
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String surname;
  final String email;
  final String password;

  SignUpRequested({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
}
