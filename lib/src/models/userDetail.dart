class UserDetail {
  final String email;
  final String name;
  final String surname;

  UserDetail({
    required this.email,
    required this.name,
    required this.surname,
  });

  factory UserDetail.fromMap(Map<String, dynamic> data) {
    return UserDetail(
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'surname': surname,
    };
  }
}
