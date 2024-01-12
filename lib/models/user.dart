class User {
  String email = '';
  String userName = '';
  String password = '';

  User({required this.email, required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'userName': userName,
        'password': password,
      };
}
