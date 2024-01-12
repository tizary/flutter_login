class User {
  String email = '';
  String password = '';

  User({required this.email, required this.password});

  Map<String, String> toJson() => {
    'email': email,
    'password': password,
  };
}