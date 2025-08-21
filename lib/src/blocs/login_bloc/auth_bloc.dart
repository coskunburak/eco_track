// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signUp(
          name: event.name,
          surname: event.surname,
          email: event.email,
          password: event.password,
        );
        emit(SignUpSuccess());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        User? user = await _authRepository.login(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(Authenticated(user: user));
        }
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.resetPassword(email: event.email);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
