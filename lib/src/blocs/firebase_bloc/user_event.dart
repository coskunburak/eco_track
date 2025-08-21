abstract class UserEvent {}

class LoadUser extends UserEvent {
  final String uid;
  LoadUser({required this.uid});
}

class UpdateUserInfoRequested extends UserEvent {
  final String uid;
  final Map<String, dynamic> data;

  UpdateUserInfoRequested({required this.uid,required this.data});

  @override
  List<Object> get props => [uid, data];
}

class DeleteUserRequested extends UserEvent {
  final String uid;

  DeleteUserRequested({required this.uid});

  @override
  List<Object> get props => [uid];
}

class UpdatePasswordRequested extends UserEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordRequested({required this.oldPassword, required this.newPassword});

  @override
  List<Object> get props => [oldPassword, newPassword];
}