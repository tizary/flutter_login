class UserInfo {
  String email;
  String firstName;
  String lastName;
  String date;
  String sex;
  bool confirm;

  UserInfo(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.date,
      required this.sex,
      required this.confirm});

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'date': date,
        'sex': sex,
        'confirm': confirm
      };

  factory UserInfo.fromMap(Map<String, Object?> userMap) {
    return UserInfo(
      email: userMap['email'] as String,
      firstName: userMap['firstName'] as String,
      lastName: userMap['lastName'] as String,
      date: userMap['date'] as String,
      sex: userMap['sex'] as String,
      confirm: userMap['confirm'] as bool,
    );
  }
}
