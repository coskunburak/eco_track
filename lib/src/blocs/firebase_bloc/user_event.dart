abstract class UserEvent {}

class LoadUser extends UserEvent {
  final String uid;
  LoadUser({required this.uid});
}
