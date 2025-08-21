// user_state.dart
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Map<String, dynamic> userData;

  UserLoaded({required this.userData});

  List<Object> get props => [userData];
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}

class UserDeleted extends UserState {
  @override
  List<Object> get props => [];
}

class UserInfoUpdated extends UserState {
  @override
  List<Object> get props => [];
}

class UserPasswordUpdated extends UserState {
  @override
  List<Object> get props => [];
}
