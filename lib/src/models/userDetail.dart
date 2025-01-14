class UserDetail {
  final String email;
  final String password;
  final String name;
  final String surname;

  UserDetail({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
  });

  factory UserDetail.fromMap(Map<String, dynamic> data) {
    return UserDetail(
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'surname': surname,
    };
  }
}
