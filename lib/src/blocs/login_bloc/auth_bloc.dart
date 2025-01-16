import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  AuthBloc({required this.authRepository}) : super(UnAuthenticated(error: '')) {
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email,
            password: event.password,
            name: event.name,
            surname: event.surname);
        emit(Authenticated());
      } catch (e) {
        emit(UnAuthenticated(error: e.toString()));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(Loading());
      try {
        bool isAuthenticated = (await authRepository.signIn(
          email: event.email,
          password: event.password,
        )) as bool;
        if (isAuthenticated) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated(error: 'Giriş başarısız'));
        }
      } catch (e) {
        emit(UnAuthenticated(error: e.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.resetPassword(email: event.email);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(error: e.toString()));
      }
    });

    on<FetchUserPermissions>((event, emit) async {
      try {
        final permissions = await authRepository.getUserPermissions(event.uid);
        if (permissions != null) {
          emit(UserPermissionsLoaded(permissions));
        } else {
          emit(UnAuthenticated(error: 'Permissions not found'));
        }
      } catch (e) {
        emit(UnAuthenticated(error: e.toString()));
      }
    });
  }
}
