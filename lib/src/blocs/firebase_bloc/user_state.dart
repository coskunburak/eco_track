// user_state.dart
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> userData;
  UserLoaded({required this.userData});
}

class UserError extends UserState {
  final String error;
  UserError({required this.error});
}
