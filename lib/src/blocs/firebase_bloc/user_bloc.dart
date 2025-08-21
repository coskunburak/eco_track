import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final userData = await _userRepository.getUser(event.uid);
        emit(UserLoaded(userData: userData));
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });
    on<UpdateUserInfoRequested>((event, emit) async {
      try {
        emit(UserLoading());
        await userRepository.updateUserInfo(event.uid, event.data);
        await userRepository.updateEmail(event.data['email']);
        final userInfo = await _userRepository.getUser(event.uid);
        emit(UserInfoUpdated());
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });
    on<DeleteUserRequested>((event, emit) async {
      try {
        emit(UserLoading());
        await userRepository.deleteUser(event.uid);
        emit(UserDeleted());
      } catch (e) {
        emit(UserError(error: e.toString()));
      }
    });
    on<UpdatePasswordRequested>((event, emit) async {
      try {
        emit(UserLoading());
        await userRepository.updatePassword(
            event.oldPassword, event.newPassword);
        emit(UserPasswordUpdated());
      }catch (e){
        emit(UserError(error: e.toString()));
      }
    });
  }
}
