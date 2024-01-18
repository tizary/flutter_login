class User {
  String email = '';
  String userName = '';
  String password = '';
  String imageSrc = '';

  User(
      {required this.email,
      required this.userName,
      required this.password,
      required this.imageSrc});

  Map<String, dynamic> toJson() => {
        'email': email,
        'userName': userName,
        'password': password,
        'imageSrc': imageSrc,
      };

  factory User.fromMap(Map<String, dynamic> userMap) {
    return User(
      email: userMap['email'] as String,
      userName: userMap['userName'] as String,
      password: userMap['password'] as String,
      imageSrc: userMap['imageSrc'] as String,
    );
  }
}
